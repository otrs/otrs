# --
# Kernel/Modules/AgentTicketEmailOutbound.pm - to send a new outbound message
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentTicketEmailOutbound;

use strict;
use warnings;

use Kernel::System::CheckItem;
use Kernel::System::CustomerUser;
use Kernel::System::DynamicField;
use Kernel::System::DynamicField::Backend;
use Kernel::System::State;
use Kernel::System::StandardTemplate;
use Kernel::System::StdAttachment;
use Kernel::System::SystemAddress;
use Kernel::System::TemplateGenerator;
use Kernel::System::VariableCheck qw(:all);
use Kernel::System::Web::UploadCache;
use Mail::Address;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    $Self->{Debug} = $Param{Debug} || 0;

    # check all needed objects
    for my $Needed (
        qw(TicketObject ParamObject DBObject QueueObject LayoutObject ConfigObject LogObject)
        )
    {
        if ( !$Self->{$Needed} ) {
            $Self->{LayoutObject}->FatalError( Message => "Got no $Needed!" );
        }
    }

    # some new objects
    $Self->{BackendObject}          = Kernel::System::DynamicField::Backend->new(%Param);
    $Self->{CustomerUserObject}     = Kernel::System::CustomerUser->new(%Param);
    $Self->{CheckItemObject}        = Kernel::System::CheckItem->new(%Param);
    $Self->{DynamicFieldObject}     = Kernel::System::DynamicField->new(%Param);
    $Self->{StateObject}            = Kernel::System::State->new(%Param);
    $Self->{StandardTemplateObject} = Kernel::System::StandardTemplate->new(%Param);
    $Self->{StdAttachmentObject}    = Kernel::System::StdAttachment->new(%Param);
    $Self->{SystemAddress}          = Kernel::System::SystemAddress->new(%Param);
    $Self->{UploadCacheObject}      = Kernel::System::Web::UploadCache->new(%Param);

    # get params
    for my $Param (
        qw(From To Cc Bcc Subject Body InReplyTo References ComposeStateID ArticleTypeID
        ArticleID TimeUnits Year Month Day Hour Minute FormID)
        )
    {
        my $Value = $Self->{ParamObject}->GetParam( Param => $Param );
        if ( defined $Value ) {
            $Self->{GetParam}->{$Param} = $Value;
        }
    }

    $Self->{GetParam}->{EmailTemplateID} = $Self->{ParamObject}->GetParam( Param => 'EmailTemplateID' ) || '';

    # ACL compatibility translation
    $Self->{ACLCompatGetParam}->{NextStateID} = $Self->{GetParam}->{ComposeStateID};

    # create form id
    if ( !$Self->{GetParam}->{FormID} ) {
        $Self->{GetParam}->{FormID} = $Self->{UploadCacheObject}->FormIDCreate();
    }

    # get config for frontend module
    $Self->{Config} = $Self->{ConfigObject}->Get("Ticket::Frontend::$Self->{Action}");

    # get the dynamic fields for this screen
    $Self->{DynamicField} = $Self->{DynamicFieldObject}->DynamicFieldListGet(
        Valid       => 1,
        ObjectType  => [ 'Ticket', 'Article' ],
        FieldFilter => $Self->{Config}->{DynamicField} || {},
    );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $Output;

    # get ACL restrictions
    $Self->{TicketObject}->TicketAcl(
        Data          => '-',
        TicketID      => $Self->{TicketID},
        ReturnType    => 'Action',
        ReturnSubType => '-',
        UserID        => $Self->{UserID},
    );
    my %AclAction = $Self->{TicketObject}->TicketAclActionData();

    # check if ACL restrictions exist
    if ( IsHashRefWithData( \%AclAction ) ) {

        # show error screen if ACL prohibits this action
        if ( defined $AclAction{ $Self->{Action} } && $AclAction{ $Self->{Action} } eq '0' ) {

            return $Self->{LayoutObject}->NoPermission( WithHeader => 'yes' );
        }
    }

    if ( $Self->{Subaction} eq 'SendEmail' ) {

        # challenge token check for write action
        $Self->{LayoutObject}->ChallengeTokenCheck();

        $Output = $Self->SendEmail();
    }
    elsif ( $Self->{Subaction} eq 'AJAXUpdateTemplate' ) {

        my %GetParam;
        for my $Key (
            qw(
            NewStateID NewPriorityID TimeUnits ArticleTypeID Title Body Subject NewQueueID
            Year Month Day Hour Minute NewOwnerID NewOwnerType OldOwnerID NewResponsibleID
            TypeID ServiceID SLAID Expand ReplyToArticle StandardTemplateID CreateArticle
            FormID ElementChanged
            )
            )
        {
            $GetParam{$Key} = $Self->{ParamObject}->GetParam( Param => $Key );
        }

        my %Ticket       = $Self->{TicketObject}->TicketGet( TicketID => $Self->{TicketID} );
        my $CustomerUser = $Ticket{CustomerUserID};
        my $QueueID      = $Ticket{QueueID};

        # get dynamic field values form http request
        my %DynamicFieldValues;

        # convert dynamic field values into a structure for ACLs
        my %DynamicFieldACLParameters;
        DYNAMICFIELD:
        for my $DynamicField ( sort keys %DynamicFieldValues ) {
            next DYNAMICFIELD if !$DynamicField;
            next DYNAMICFIELD if !$DynamicFieldValues{$DynamicField};

            $DynamicFieldACLParameters{ 'DynamicField_' . $DynamicField } = $DynamicFieldValues{$DynamicField};
        }

        # get list type
        my $TreeView = 0;
        if ( $Self->{ConfigObject}->Get('Ticket::Frontend::ListType') eq 'tree' ) {
            $TreeView = 1;
        }

        my $NextStates = $Self->_GetNextStates(
            %GetParam,
            CustomerUserID => $CustomerUser || '',
            QueueID => $QueueID,
        );

        # update Dynamic Fields Possible Values via AJAX
        my @DynamicFieldAJAX;

        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
            next DYNAMICFIELD if $DynamicFieldConfig->{ObjectType} ne 'Ticket';

            my $IsACLReducible = $Self->{BackendObject}->HasBehavior(
                DynamicFieldConfig => $DynamicFieldConfig,
                Behavior           => 'IsACLReducible',
            );
            next DYNAMICFIELD if !$IsACLReducible;

            my $PossibleValues = $Self->{BackendObject}->PossibleValuesGet(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            # convert possible values key => value to key => key for ACLs using a Hash slice
            my %AclData = %{$PossibleValues};
            @AclData{ keys %AclData } = keys %AclData;

            # set possible values filter from ACLs
            my $ACL = $Self->{TicketObject}->TicketAcl(
                %GetParam,
                Action        => $Self->{Action},
                TicketID      => $Self->{TicketID},
                QueueID       => $QueueID,
                ReturnType    => 'Ticket',
                ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
                Data          => \%AclData,
                UserID        => $Self->{UserID},
            );
            if ($ACL) {
                my %Filter = $Self->{TicketObject}->TicketAclData();

                # convert Filer key => key back to key => value using map
                %{$PossibleValues} = map { $_ => $PossibleValues->{$_} } keys %Filter;
            }

            my $DataValues = $Self->{BackendObject}->BuildSelectionDataGet(
                DynamicFieldConfig => $DynamicFieldConfig,
                PossibleValues     => $PossibleValues,
                Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
            ) || $PossibleValues;

            # add dynamic field to the list of fields to update
            push(
                @DynamicFieldAJAX,
                {
                    Name        => 'DynamicField_' . $DynamicFieldConfig->{Name},
                    Data        => $DataValues,
                    SelectedID  => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
                    Translation => $DynamicFieldConfig->{Config}->{TranslatableValues} || 0,
                    Max         => 100,
                }
            );
        }

        my $StandardTemplates = $Self->_GetStandardTemplates(
            %GetParam,
            QueueID => $QueueID || '',
        );

        my @TemplateAJAX;

        # update ticket body and attachments if needed.
        if ( $GetParam{ElementChanged} eq 'StandardTemplateID' ) {
            my @TicketAttachments;
            my $TemplateText;

            # remove all attachments from the Upload cache
            my $RemoveSuccess = $Self->{UploadCacheObject}->FormIDRemove(
                FormID => $GetParam{FormID},
            );
            if ( !$RemoveSuccess ) {
                $Self->{LogObject}->Log(
                    Priority => 'error',
                    Message  => "Form attachments could not be deleted!",
                );
            }

            # get the template text and set new attachments if a template is selected
            my $TemplateGenerator = Kernel::System::TemplateGenerator->new( %{$Self} );

            if ( IsPositiveInteger( $GetParam{StandardTemplateID} ) ) {

                # set template text, replace smart tags (limited as ticket is not created)
                $TemplateText = $TemplateGenerator->Template(
                    TemplateID => $GetParam{StandardTemplateID},
                    TicketID   => $Self->{TicketID},
                    UserID     => $Self->{UserID},
                );

                # create StdAttachmentObject
                my $StdAttachmentObject = Kernel::System::StdAttachment->new( %{$Self} );

                # add std. attachments to ticket
                my %AllStdAttachments = $StdAttachmentObject->StdAttachmentStandardTemplateMemberList(
                    StandardTemplateID => $GetParam{StandardTemplateID},
                );
                for my $ID ( sort keys %AllStdAttachments ) {
                    my %AttachmentsData = $StdAttachmentObject->StdAttachmentGet( ID => $ID );
                    $Self->{UploadCacheObject}->FormIDAddFile(
                        FormID      => $GetParam{FormID},
                        Disposition => 'attachment',
                        %AttachmentsData,
                    );
                }

                # send a list of attachments in the upload cache back to the client side JavaScript
                # which renders then the list of currently uploaded attachments
                @TicketAttachments = $Self->{UploadCacheObject}->FormIDGetAllFilesMeta(
                    FormID => $GetParam{FormID},
                );
            }

            # get first article of the ticket
            my %Article = $Self->{TicketObject}->ArticleFirstArticle(
                TicketID      => $Self->{TicketID},
                DynamicFields => 0,
            );

            # get the matching signature for the current user
            my $Signature = $TemplateGenerator->Signature(
                TicketID  => $Self->{TicketID},
                ArticleID => $Article{ArticleID},
                Data      => \%Article,
                UserID    => $Self->{UserID},
            );

            # append the signature to the body text
            if ( $Self->{LayoutObject}->{BrowserRichText} ) {
                $TemplateText = $TemplateText . '<br><br>' . $Signature;
            }
            else {
                $TemplateText = $TemplateText . "\n\n" . $Signature;
            }

            @TemplateAJAX = (
                {
                    Name => 'UseTemplateNote',
                    Data => '0',
                },
                {
                    Name => 'RichText',
                    Data => $TemplateText || '',
                },
                {
                    Name     => 'TicketAttachments',
                    Data     => \@TicketAttachments,
                    KeepData => 1,
                },
            );
        }

        my $JSON = $Self->{LayoutObject}->BuildSelectionJSON(
            [
                {
                    Name         => 'NewStateID',
                    Data         => $NextStates,
                    SelectedID   => $GetParam{NewStateID},
                    Translation  => 1,
                    PossibleNone => $Self->{Config}->{StateDefault} ? 0 : 1,
                    Max          => 100,
                },
                {
                    Name         => 'StandardTemplateID',
                    Data         => $StandardTemplates,
                    SelectedID   => $GetParam{StandardTemplateID},
                    PossibleNone => 1,
                    Translation  => 1,
                    Max          => 100,
                },
                @DynamicFieldAJAX,
                @TemplateAJAX,
            ],
        );

        return $Self->{LayoutObject}->Attachment(
            ContentType => 'application/json; charset=' . $Self->{LayoutObject}->{Charset},
            Content     => $JSON,
            Type        => 'inline',
            NoCache     => 1,
        );
    }
    elsif ( $Self->{Subaction} eq 'AJAXUpdate' ) {
        $Output = $Self->AjaxUpdate();
    }
    else {
        $Output = $Self->Form();
    }

    return $Output;
}

sub Form {
    my ( $Self, %Param ) = @_;

    my %Error;
    my %ACLCompatGetParam = %{ $Self->{ACLCompatGetParam} };

    # check needed stuff
    if ( !$Self->{TicketID} ) {

        return $Self->{LayoutObject}->ErrorScreen(
            Message => "Got no TicketID!",
            Comment => 'System Error!',
        );
    }

    # get ticket data
    my %Ticket = $Self->{TicketObject}->TicketGet(
        TicketID      => $Self->{TicketID},
        DynamicFields => 1,
    );

    # check permissions
    my $Access = $Self->{TicketObject}->TicketPermission(
        Type     => $Self->{Config}->{Permission},
        TicketID => $Self->{TicketID},
        UserID   => $Self->{UserID}
    );

    # error screen, don't show ticket
    if ( !$Access ) {

        return $Self->{LayoutObject}->NoPermission( WithHeader => 'yes' );
    }

    my %GetParamExtended = $Self->_GetExtendedParams();

    my %GetParam            = %{ $GetParamExtended{GetParam} };
    my @MultipleCustomer    = @{ $GetParamExtended{MultipleCustomer} };
    my @MultipleCustomerCc  = @{ $GetParamExtended{MultipleCustomerCc} };
    my @MultipleCustomerBcc = @{ $GetParamExtended{MultipleCustomerBcc} };

    # get lock state
    my $Output = '';
    if ( $Self->{Config}->{RequiredLock} ) {
        if ( !$Self->{TicketObject}->TicketLockGet( TicketID => $Self->{TicketID} ) ) {

            # set owner
            $Self->{TicketObject}->TicketOwnerSet(
                TicketID  => $Self->{TicketID},
                UserID    => $Self->{UserID},
                NewUserID => $Self->{UserID},
            );

            # set lock
            my $Lock = $Self->{TicketObject}->TicketLockSet(
                TicketID => $Self->{TicketID},
                Lock     => 'lock',
                UserID   => $Self->{UserID}
            );

            # show lock state
            if ($Lock) {
                $Self->{LayoutObject}->Block(
                    Name => 'PropertiesLock',
                    Data => { %Param, TicketID => $Self->{TicketID} },
                );
            }
        }
        else {
            my $AccessOk = $Self->{TicketObject}->OwnerCheck(
                TicketID => $Self->{TicketID},
                OwnerID  => $Self->{UserID},
            );
            if ( !$AccessOk ) {
                my $Output = $Self->{LayoutObject}->Header(
                    Type      => 'Small',
                    BodyClass => 'Popup',
                );
                $Output .= $Self->{LayoutObject}->Warning(
                    Message => $Self->{LayoutObject}->{LanguageObject}
                        ->Get('Sorry, you need to be the ticket owner to perform this action.'),
                    Comment => $Self->{LayoutObject}->{LanguageObject}->Get('Please change the owner first.'),
                );
                $Output .= $Self->{LayoutObject}->Footer(
                    Type => 'Small',
                );

                return $Output;
            }
            else {
                $Self->{LayoutObject}->Block(
                    Name => 'TicketBack',
                    Data => {
                        %Param,
                        TicketID => $Self->{TicketID},
                    },
                );
            }
        }
    }
    else {
        $Self->{LayoutObject}->Block(
            Name => 'TicketBack',
            Data => {
                %Param,
                TicketID => $Self->{TicketID},
            },
        );
    }

    # get last customer article or selected article
    my %Data;
    if ( $GetParam{ArticleID} ) {
        %Data = $Self->{TicketObject}->ArticleGet(
            ArticleID     => $GetParam{ArticleID},
            DynamicFields => 1,
        );

        # Check if article is from the same TicketID as we checked permissions for.
        if ( $Data{TicketID} ne $Self->{TicketID} ) {

            return $Self->{LayoutObject}->ErrorScreen(
                Message => "Article does not belong to ticket $Self->{TicketID}!",
            );
        }
    }
    else {
        %Data = $Self->{TicketObject}->ArticleLastCustomerArticle(
            TicketID      => $Self->{TicketID},
            DynamicFields => 1,
        );
    }

    # prepare signature
    my $TemplateGenerator = Kernel::System::TemplateGenerator->new( %{$Self} );
    $Data{Signature} = $TemplateGenerator->Signature(
        TicketID  => $Self->{TicketID},
        ArticleID => $Data{ArticleID},
        Data      => \%Data,
        UserID    => $Self->{UserID},
    );

    if ( $GetParam{EmailTemplateID} ) {

        # get template
        $Data{StdTemplate} = $TemplateGenerator->Template(
            TicketID   => $Self->{TicketID},
            ArticleID  => $Data{ArticleID},
            TemplateID => $GetParam{EmailTemplateID},
            Data       => \%Data,
            UserID     => $Self->{UserID},
        );

        # get signature
        $Data{Signature} = $TemplateGenerator->Signature(
            TicketID => $Self->{TicketID},
            Data     => \%Data,
            UserID   => $Self->{UserID},
        );
    }

    # empty the body for preparation
    $Data{Body} = '';

    # prepare body for richtext or plaintext content
    if ( $Self->{LayoutObject}->{BrowserRichText} ) {

        # add the temp
        if ( $GetParam{EmailTemplateID} ) {
            $Data{Body} = $Data{StdTemplate} . '<br/>' . $Data{Body};
        }

        $Data{Body} = $Data{Body} . $Data{Signature};
    }
    else {

        # add the temp
        if ( $GetParam{EmailTemplateID} ) {
            $Data{Body} = $Data{StdTemplate} . "\n" . $Data{Body};
        }

        $Data{Body} = $Data{Body} . $Data{Signature};

        # prepare body for plain text
        $Data{Body} =~ s/\t/ /g;
    }

    # add std. attachments to email
    if ( $GetParam{EmailTemplateID} ) {
        my %AllStdAttachments = $Self->{StdAttachmentObject}->StdAttachmentStandardTemplateMemberList(
            StandardTemplateID => $GetParam{EmailTemplateID},
        );
        for my $ID ( sort keys %AllStdAttachments ) {
            my %AttachmentsData = $Self->{StdAttachmentObject}->StdAttachmentGet( ID => $ID );
            $Self->{UploadCacheObject}->FormIDAddFile(
                FormID => $GetParam{FormID},
                %AttachmentsData,
            );
        }
    }

    # get all attachments meta data
    my @Attachments = $Self->{UploadCacheObject}->FormIDGetAllFilesMeta(
        FormID => $GetParam{FormID},
    );

    # check some values
    for my $Recipient (qw(To Cc Bcc Subject)) {
        if ( $Data{$Recipient} ) {
            delete $Data{$Recipient};
        }
    }

    # put & get attributes like sender address
    %Data = $TemplateGenerator->Attributes(
        TicketID  => $Self->{TicketID},
        ArticleID => $GetParam{ArticleID},
        Data      => \%Data,
        UserID    => $Self->{UserID},
    );

    # prepare the subject
    $Data{Subject} =~ s{ \A (?: .*? : \s*) }{}xms;

    # run compose modules
    if ( ref( $Self->{ConfigObject}->Get('Ticket::Frontend::ArticleComposeModule') ) eq 'HASH' ) {
        my %Jobs = %{ $Self->{ConfigObject}->Get('Ticket::Frontend::ArticleComposeModule') };
        for my $Job ( sort keys %Jobs ) {

            # load module
            if ( !$Self->{MainObject}->Require( $Jobs{$Job}->{Module} ) ) {

                return $Self->{LayoutObject}->FatalError();
            }
            my $Object = $Jobs{$Job}->{Module}->new(
                %{$Self},
                Debug => $Self->{Debug},
            );

            # get params
            for my $Param ( $Object->Option( %Data, %GetParam, Config => $Jobs{$Job} ) ) {
                $GetParam{$Param} = $Self->{ParamObject}->GetParam( Param => $Param );
            }

            # run module
            $Object->Run( %Data, %GetParam, Config => $Jobs{$Job} );

            # get errors
            %Error = ( %Error, $Object->Error( %GetParam, Config => $Jobs{$Job} ) );
        }
    }

    # create HTML strings for all dynamic fields
    my %DynamicFieldHTML;

    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $PossibleValuesFilter;

        my $IsACLReducible = $Self->{BackendObject}->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible',
        );

        if ($IsACLReducible) {

            # get PossibleValues
            my $PossibleValues = $Self->{BackendObject}->PossibleValuesGet(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            # check if field has PossibleValues property in its configuration
            if ( IsHashRefWithData($PossibleValues) ) {

                # convert possible values key => value to key => key for ACLs using a Hash slice
                my %AclData = %{$PossibleValues};
                @AclData{ keys %AclData } = keys %AclData;

                # set possible values filter from ACLs
                my $ACL = $Self->{TicketObject}->TicketAcl(
                    %GetParam,
                    %ACLCompatGetParam,
                    Action        => $Self->{Action},
                    TicketID      => $Self->{TicketID},
                    ReturnType    => 'Ticket',
                    ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
                    Data          => \%AclData,
                    UserID        => $Self->{UserID},
                );
                if ($ACL) {
                    my %Filter = $Self->{TicketObject}->TicketAclData();

                    # convert Filer key => key back to key => value using map
                    %{$PossibleValuesFilter} = map { $_ => $PossibleValues->{$_} }
                        keys %Filter;
                }
            }
        }

        # to store dynamic field value from database (or undefined)
        my $Value;

        # only get values for Ticket fields (all screens based on AgentTickeActionCommon
        # create a new article, then article fields will be always empty at the beginning)
        if ( $DynamicFieldConfig->{ObjectType} eq 'Ticket' ) {

            # get value stored on the database from Ticket
            $Value = $Ticket{ 'DynamicField_' . $DynamicFieldConfig->{Name} };
        }

        # get field HTML
        $DynamicFieldHTML{ $DynamicFieldConfig->{Name} } =
            $Self->{BackendObject}->EditFieldRender(
            DynamicFieldConfig   => $DynamicFieldConfig,
            PossibleValuesFilter => $PossibleValuesFilter,
            Value                => $Value,
            Mandatory =>
                $Self->{Config}->{DynamicField}->{ $DynamicFieldConfig->{Name} } == 2,
            LayoutObject    => $Self->{LayoutObject},
            ParamObject     => $Self->{ParamObject},
            AJAXUpdate      => 1,
            UpdatableFields => $Self->_GetFieldsToUpdate(),
            );
    }

    # build view ...
    # start with page ...
    $Output .= $Self->{LayoutObject}->Header(
        Value     => $Ticket{TicketNumber},
        Type      => 'Small',
        BodyClass => 'Popup',
    );

    # build references string
    my $References = defined $Data{References} ? $Data{References} . ' ' : '';
    $References .= defined $Data{MessageID} ? $Data{MessageID} : '';

    $Output .= $Self->_Mask(
        TicketNumber => $Ticket{TicketNumber},
        TicketID     => $Self->{TicketID},
        Title        => $Ticket{Title},
        QueueID      => $Ticket{QueueID},
        NextStates   => $Self->_GetNextStates(
            %GetParam,
            %ACLCompatGetParam,
        ),
        TimeUnitsRequired => (
            $Self->{ConfigObject}->Get('Ticket::Frontend::NeedAccountedTime')
            ? 'Validate_Required'
            : ''
        ),
        Errors              => \%Error,
        MultipleCustomer    => \@MultipleCustomer,
        MultipleCustomerCc  => \@MultipleCustomerCc,
        MultipleCustomerBcc => \@MultipleCustomerBcc,
        Attachments         => \@Attachments,
        %Data,
        %GetParam,
        InReplyTo        => $Data{MessageID},
        References       => $References,
        DynamicFieldHTML => \%DynamicFieldHTML,
    );
    $Output .= $Self->{LayoutObject}->Footer(
        Type => 'Small',
    );

    return $Output;
}

sub SendEmail {
    my ( $Self, %Param ) = @_;

    my %Error;
    my %ACLCompatGetParam = %{ $Self->{ACLCompatGetParam} };

    my %GetParamExtended = $Self->_GetExtendedParams();

    my %GetParam            = %{ $GetParamExtended{GetParam} };
    my @MultipleCustomer    = @{ $GetParamExtended{MultipleCustomer} };
    my @MultipleCustomerCc  = @{ $GetParamExtended{MultipleCustomerCc} };
    my @MultipleCustomerBcc = @{ $GetParamExtended{MultipleCustomerBcc} };

    my %DynamicFieldValues;

    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # extract the dynamic field value form the web request
        $DynamicFieldValues{ $DynamicFieldConfig->{Name} } =
            $Self->{BackendObject}->EditFieldValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ParamObject        => $Self->{ParamObject},
            LayoutObject       => $Self->{LayoutObject},
            );
    }

    # convert dynamic field values into a structure for ACLs
    my %DynamicFieldACLParameters;
    DYNAMICFIELD:
    for my $DynamicField ( sort keys %DynamicFieldValues ) {
        next DYNAMICFIELD if !$DynamicField;
        next DYNAMICFIELD if !$DynamicFieldValues{$DynamicField};

        $DynamicFieldACLParameters{ 'DynamicField_' . $DynamicField } = $DynamicFieldValues{$DynamicField};
    }
    $GetParam{DynamicField} = \%DynamicFieldACLParameters;

    my $QueueID = $Self->{QueueID};
    my %StateData;

    if ( $GetParam{ComposeStateID} ) {
        %StateData = $Self->{StateObject}->StateGet(
            ID => $GetParam{ComposeStateID},
        );
    }

    my $NextState = $StateData{Name};

    # check pending date
    if ( defined $StateData{TypeName} && $StateData{TypeName} =~ /^pending/i ) {
        if ( !$Self->{TimeObject}->Date2SystemTime( %GetParam, Second => 0 ) ) {
            $Error{'DateInvalid'} = 'ServerError';
        }
        if (
            $Self->{TimeObject}->Date2SystemTime( %GetParam, Second => 0 )
            < $Self->{TimeObject}->SystemTime()
            )
        {
            $Error{'DateInvalid'} = 'ServerError';
        }
    }

    # check To
    if ( !$GetParam{To} ) {
        $Error{'ToInvalid'} = 'ServerError';
    }

    # check body
    if ( !$GetParam{Body} ) {
        $Error{'BodyInvalid'} = 'ServerError';
    }

    # check subject
    if ( !$GetParam{Subject} ) {
        $Error{'SubjectInvalid'} = 'ServerError';
    }

    if (
        $Self->{ConfigObject}->Get('Ticket::Frontend::AccountTime')
        && $Self->{ConfigObject}->Get('Ticket::Frontend::NeedAccountedTime')
        && $GetParam{TimeUnits} eq ''
        )
    {
        $Error{'TimeUnitsInvalid'} = 'ServerError';
    }

    # prepare subject
    my %Ticket = $Self->{TicketObject}->TicketGet(
        TicketID      => $Self->{TicketID},
        DynamicFields => 1,
    );

    # create HTML strings for all dynamic fields
    my %DynamicFieldHTML;

    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $PossibleValuesFilter;

        my $IsACLReducible = $Self->{BackendObject}->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible',
        );

        if ($IsACLReducible) {

            # get PossibleValues
            my $PossibleValues = $Self->{BackendObject}->PossibleValuesGet(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            # check if field has PossibleValues property in its configuration
            if ( IsHashRefWithData($PossibleValues) ) {

                # convert possible values key => value to key => key for ACLs using a Hash slice
                my %AclData = %{$PossibleValues};
                @AclData{ keys %AclData } = keys %AclData;

                # set possible values filter from ACLs
                my $ACL = $Self->{TicketObject}->TicketAcl(
                    %GetParam,
                    %ACLCompatGetParam,
                    Action        => $Self->{Action},
                    TicketID      => $Self->{TicketID},
                    ReturnType    => 'Ticket',
                    ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
                    Data          => \%AclData,
                    UserID        => $Self->{UserID},
                );
                if ($ACL) {
                    my %Filter = $Self->{TicketObject}->TicketAclData();

                    # convert Filer key => key back to key => value using map
                    %{$PossibleValuesFilter} = map { $_ => $PossibleValues->{$_} }
                        keys %Filter;
                }
            }
        }

        my $ValidationResult = $Self->{BackendObject}->EditFieldValueValidate(
            DynamicFieldConfig   => $DynamicFieldConfig,
            PossibleValuesFilter => $PossibleValuesFilter,
            ParamObject          => $Self->{ParamObject},
            Mandatory =>
                $Self->{Config}->{DynamicField}->{ $DynamicFieldConfig->{Name} } == 2,
        );

        if ( !IsHashRefWithData($ValidationResult) ) {

            return $Self->{LayoutObject}->ErrorScreen(
                Message =>
                    "Could not perform validation on field $DynamicFieldConfig->{Label}!",
                Comment => 'Please contact the admin.',
            );
        }

        # propagate validation error to the Error variable to be detected by the frontend
        if ( $ValidationResult->{ServerError} ) {
            $Error{ $DynamicFieldConfig->{Name} } = ' ServerError';
        }

        # get field HTML
        $DynamicFieldHTML{ $DynamicFieldConfig->{Name} } =
            $Self->{BackendObject}->EditFieldRender(
            DynamicFieldConfig   => $DynamicFieldConfig,
            PossibleValuesFilter => $PossibleValuesFilter,
            Mandatory =>
                $Self->{Config}->{DynamicField}->{ $DynamicFieldConfig->{Name} } == 2,
            ServerError  => $ValidationResult->{ServerError}  || '',
            ErrorMessage => $ValidationResult->{ErrorMessage} || '',
            LayoutObject => $Self->{LayoutObject},
            ParamObject  => $Self->{ParamObject},
            AJAXUpdate   => 1,
            UpdatableFields => $Self->_GetFieldsToUpdate(),
            );
    }

    # transform pending time, time stamp based on user time zone
    if (
        defined $GetParam{Year}
        && defined $GetParam{Month}
        && defined $GetParam{Day}
        && defined $GetParam{Hour}
        && defined $GetParam{Minute}
        )
    {
        %GetParam = $Self->{LayoutObject}->TransformDateSelection(
            %GetParam,
        );
    }

    # check some values
    LINE:
    for my $Line (qw(To Cc Bcc)) {
        next LINE if !$GetParam{$Line};
        for my $Email ( Mail::Address->parse( $GetParam{$Line} ) ) {
            if ( !$Self->{CheckItemObject}->CheckEmail( Address => $Email->address() ) ) {
                $Error{ $Line . 'ErrorType' } = $Line . $Self->{CheckItemObject}->CheckErrorType() . 'ServerErrorMsg';
                $Error{ "$Line" . "Invalid" } = 'ServerError';
            }
            my $IsLocal = $Self->{SystemAddress}->SystemAddressIsLocalAddress(
                Address => $Email->address()
            );
            if ($IsLocal) {
                $Error{ "$Line" . "Invalid" } = 'ServerError';
            }
        }
    }

    # run compose modules
    my %ArticleParam;
    if ( ref( $Self->{ConfigObject}->Get('Ticket::Frontend::ArticleComposeModule') ) eq 'HASH' ) {
        my %Jobs = %{ $Self->{ConfigObject}->Get('Ticket::Frontend::ArticleComposeModule') };
        for my $Job ( sort keys %Jobs ) {

            # load module
            if ( !$Self->{MainObject}->Require( $Jobs{$Job}->{Module} ) ) {
                return $Self->{LayoutObject}->FatalError();
            }
            my $Object = $Jobs{$Job}->{Module}->new(
                %{$Self},
                Debug => $Self->{Debug},
            );

            # get params
            for my $Param ( $Object->Option( %GetParam, Config => $Jobs{$Job} ) ) {
                $GetParam{$Param} = $Self->{ParamObject}->GetParam( Param => $Param );
            }

            # run module
            $Object->Run( %GetParam, Config => $Jobs{$Job} );

            # ticket params
            %ArticleParam = (
                %ArticleParam,
                $Object->ArticleOption( %GetParam, Config => $Jobs{$Job} ),
            );

            # get errors
            %Error = (
                %Error,
                $Object->Error( %GetParam, Config => $Jobs{$Job} ),
            );
        }
    }

    # attachment delete
    my @AttachmentIDs = map {
        my ($ID) = $_ =~ m{ \A AttachmentDelete (\d+) \z }xms;
        $ID ? $ID : ();
    } $Self->{ParamObject}->GetParamNames();

    COUNT:
    for my $Count ( reverse sort @AttachmentIDs ) {
        my $Delete = $Self->{ParamObject}->GetParam( Param => "AttachmentDelete$Count" );
        next COUNT if !$Delete;
        %Error = ();
        $Error{AttachmentDelete} = 1;
        $Self->{UploadCacheObject}->FormIDRemoveFile(
            FormID => $GetParam{FormID},
            FileID => $Count,
        );
    }

    # attachment upload
    if ( $Self->{ParamObject}->GetParam( Param => 'AttachmentUpload' ) ) {
        %Error = ();
        $Error{AttachmentUpload} = 1;
        my %UploadStuff = $Self->{ParamObject}->GetUploadAll(
            Param => 'FileUpload',
        );
        $Self->{UploadCacheObject}->FormIDAddFile(
            FormID => $GetParam{FormID},
            %UploadStuff,
        );
    }

    # get all attachments meta data
    my @Attachments = $Self->{UploadCacheObject}->FormIDGetAllFilesMeta(
        FormID => $GetParam{FormID},
    );

    # check if there is an error
    if (%Error) {

        my $QueueID = $Self->{TicketObject}->TicketQueueID( TicketID => $Self->{TicketID} );
        my $Output = $Self->{LayoutObject}->Header(
            Type      => 'Small',
            BodyClass => 'Popup',
        );
        $Output .= $Self->_Mask(
            TicketNumber => $Ticket{TicketNumber},
            Title        => $Ticket{Title},
            TicketID     => $Self->{TicketID},
            QueueID      => $QueueID,
            NextStates   => $Self->_GetNextStates(
                %GetParam,
                %ACLCompatGetParam,
            ),
            Errors              => \%Error,
            MultipleCustomer    => \@MultipleCustomer,
            MultipleCustomerCc  => \@MultipleCustomerCc,
            MultipleCustomerBcc => \@MultipleCustomerBcc,
            Attachments         => \@Attachments,
            DynamicFieldHTML    => \%DynamicFieldHTML,
            %GetParam,
        );
        $Output .= $Self->{LayoutObject}->Footer(
            Type => 'Small',
        );
        return $Output;
    }

    # replace <OTRS_TICKET_STATE> with next ticket state name
    if ($NextState) {
        $GetParam{Body} =~ s/(&lt;|<)OTRS_TICKET_STATE(&gt;|>)/$NextState/g;
    }

    # get pre loaded attachments
    my @AttachmentData = $Self->{UploadCacheObject}->FormIDGetAllFilesData(
        FormID => $GetParam{FormID},
    );

    # get submit attachment
    my %UploadStuff = $Self->{ParamObject}->GetUploadAll(
        Param => 'FileUpload',
    );
    if (%UploadStuff) {
        push @AttachmentData, \%UploadStuff;
    }

    my $MimeType = 'text/plain';
    if ( $Self->{LayoutObject}->{BrowserRichText} ) {
        $MimeType = 'text/html';

        # remove unused inline images
        my @NewAttachmentData;

        ATTACHMENT:
        for my $Attachment (@AttachmentData) {
            my $ContentID = $Attachment->{ContentID};
            if ( $ContentID && ( $Attachment->{ContentType} =~ /image/i ) ) {
                my $ContentIDHTMLQuote = $Self->{LayoutObject}->Ascii2Html(
                    Text => $ContentID,
                );

                # workaround for link encode of rich text editor, see bug#5053
                my $ContentIDLinkEncode = $Self->{LayoutObject}->LinkEncode($ContentID);
                $GetParam{Body} =~ s/(ContentID=)$ContentIDLinkEncode/$1$ContentID/g;

                # ignore attachment if not linked in body
                next ATTACHMENT if $GetParam{Body} !~ /(\Q$ContentIDHTMLQuote\E|\Q$ContentID\E)/i;
            }

            # remember inline images and normal attachments
            push @NewAttachmentData, \%{$Attachment};
        }
        @AttachmentData = @NewAttachmentData;

        # verify HTML document
        $GetParam{Body} = $Self->{LayoutObject}->RichTextDocumentComplete(
            String => $GetParam{Body},
        );
    }

    # send email
    my $To = '';

    KEY:
    for my $Key (qw(To Cc Bcc)) {
        next KEY if !$GetParam{$Key};
        if ($To) {
            $To .= ', ';
        }
        $To .= $GetParam{$Key}
    }
    my $ArticleID = $Self->{TicketObject}->ArticleSend(
        ArticleTypeID  => $Self->{GetParam}->{ArticleTypeID},
        SenderType     => 'agent',
        TicketID       => $Self->{TicketID},
        HistoryType    => 'EmailAgent',
        HistoryComment => "\%\%$To",
        From           => $GetParam{From},
        To             => $GetParam{To},
        Cc             => $GetParam{Cc},
        Bcc            => $GetParam{Bcc},
        Subject        => $GetParam{Subject},
        UserID         => $Self->{UserID},
        Body           => $GetParam{Body},
        InReplyTo      => $GetParam{InReplyTo},
        References     => $GetParam{References},
        Charset        => $Self->{LayoutObject}->{UserCharset},
        MimeType       => $MimeType,
        Attachment     => \@AttachmentData,
        %ArticleParam,
    );

    # error page
    if ( !$ArticleID ) {

        return $Self->{LayoutObject}->ErrorScreen(
            Comment => 'Please contact the admin.',
        );
    }

    # time accounting
    if ( $GetParam{TimeUnits} ) {
        $Self->{TicketObject}->TicketAccountTime(
            TicketID  => $Self->{TicketID},
            ArticleID => $ArticleID,
            TimeUnit  => $GetParam{TimeUnits},
            UserID    => $Self->{UserID},
        );
    }

    # set dynamic fields
    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # set the object ID (TicketID or ArticleID) depending on the field configuration
        my $ObjectID = $DynamicFieldConfig->{ObjectType} eq 'Article' ? $ArticleID : $Self->{TicketID};

        # set the value
        my $Success = $Self->{BackendObject}->ValueSet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ObjectID           => $ObjectID,
            Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
            UserID             => $Self->{UserID},
        );
    }

    # set state
    if ($NextState) {
        $Self->{TicketObject}->TicketStateSet(
            TicketID  => $Self->{TicketID},
            ArticleID => $ArticleID,
            State     => $NextState,
            UserID    => $Self->{UserID},
        );

        # should I set an unlock?
        if ( $StateData{TypeName} =~ /^close/i ) {
            $Self->{TicketObject}->TicketLockSet(
                TicketID => $Self->{TicketID},
                Lock     => 'unlock',
                UserID   => $Self->{UserID},
            );
        }

        # set pending time
        elsif ( $StateData{TypeName} =~ /^pending/i ) {
            $Self->{TicketObject}->TicketPendingTimeSet(
                UserID   => $Self->{UserID},
                TicketID => $Self->{TicketID},
                %GetParam,
            );
        }
    }

    # remove pre-submitted attachments
    $Self->{UploadCacheObject}->FormIDRemove( FormID => $GetParam{FormID} );

    # redirect
    if ( defined $StateData{TypeName} && $StateData{TypeName} =~ /^close/i ) {

        return $Self->{LayoutObject}->PopupClose(
            URL => ( $Self->{LastScreenOverview} || 'Action=AgentDashboard' ),
        );
    }

    return $Self->{LayoutObject}->PopupClose(
        URL => "Action=AgentTicketZoom;TicketID=$Self->{TicketID};ArticleID=$ArticleID",
    );
}

sub AjaxUpdate {
    my ( $Self, %Param ) = @_;

    my %Error;
    my %ACLCompatGetParam = %{ $Self->{ACLCompatGetParam} };

    my %GetParamExtended = $Self->_GetExtendedParams();

    my %GetParam            = %{ $GetParamExtended{GetParam} };
    my @MultipleCustomer    = @{ $GetParamExtended{MultipleCustomer} };
    my @MultipleCustomerCc  = @{ $GetParamExtended{MultipleCustomerCc} };
    my @MultipleCustomerBcc = @{ $GetParamExtended{MultipleCustomerBcc} };

    my @ExtendedData;

    # run compose modules
    if ( ref $Self->{ConfigObject}->Get('Ticket::Frontend::ArticleComposeModule') eq 'HASH' ) {
        my %Jobs = %{ $Self->{ConfigObject}->Get('Ticket::Frontend::ArticleComposeModule') };

        JOB:
        for my $Job ( sort keys %Jobs ) {

            # load module
            next JOB if !$Self->{MainObject}->Require( $Jobs{$Job}->{Module} );

            my $Object = $Jobs{$Job}->{Module}->new(
                %{$Self},
                Debug => $Self->{Debug},
            );

            # get params
            for my $Parameter ( $Object->Option( %GetParam, Config => $Jobs{$Job} ) ) {
                $GetParam{$Parameter} = $Self->{ParamObject}->GetParam( Param => $Parameter );
            }

            # run module
            my %Data = $Object->Data( %GetParam, Config => $Jobs{$Job} );

            my $Key = $Object->Option( %GetParam, Config => $Jobs{$Job} );
            if ($Key) {
                push(
                    @ExtendedData,
                    {
                        Name        => $Key,
                        Data        => \%Data,
                        SelectedID  => $GetParam{$Key},
                        Translation => 1,
                        Max         => 100,
                    }
                );
            }
        }
    }

    my %DynamicFieldValues;

    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # extract the dynamic field value form the web request
        $DynamicFieldValues{ $DynamicFieldConfig->{Name} } =
            $Self->{BackendObject}->EditFieldValueGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            ParamObject        => $Self->{ParamObject},
            LayoutObject       => $Self->{LayoutObject},
            );
    }

    # convert dynamic field values into a structure for ACLs
    my %DynamicFieldACLParameters;
    DYNAMICFIELD:
    for my $DynamicField ( sort keys %DynamicFieldValues ) {
        next DYNAMICFIELD if !$DynamicField;
        next DYNAMICFIELD if !$DynamicFieldValues{$DynamicField};

        $DynamicFieldACLParameters{ 'DynamicField_' . $DynamicField } = $DynamicFieldValues{$DynamicField};
    }
    $GetParam{DynamicField} = \%DynamicFieldACLParameters;

    my $NextStates = $Self->_GetNextStates(
        %GetParam,
        %ACLCompatGetParam,
    );

    # update Dynamic Fields Possible Values via AJAX
    my @DynamicFieldAJAX;

    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);
        next DYNAMICFIELD if $DynamicFieldConfig->{ObjectType} ne 'Ticket';

        my $IsACLReducible = $Self->{BackendObject}->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible',
        );
        next DYNAMICFIELD if !$IsACLReducible;

        my $PossibleValues = $Self->{BackendObject}->PossibleValuesGet(
            DynamicFieldConfig => $DynamicFieldConfig,
        );

        # convert possible values key => value to key => key for ACLs using a Hash slice
        my %AclData = %{$PossibleValues};
        @AclData{ keys %AclData } = keys %AclData;

        # set possible values filter from ACLs
        my $ACL = $Self->{TicketObject}->TicketAcl(
            %GetParam,
            %ACLCompatGetParam,
            Action        => $Self->{Action},
            TicketID      => $Self->{TicketID},
            QueueID       => $Self->{QueueID},
            ReturnType    => 'Ticket',
            ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
            Data          => \%AclData,
            UserID        => $Self->{UserID},
        );
        if ($ACL) {
            my %Filter = $Self->{TicketObject}->TicketAclData();

            # convert Filer key => key back to key => value using map
            %{$PossibleValues} = map { $_ => $PossibleValues->{$_} } keys %Filter;
        }

        my $DataValues = $Self->{BackendObject}->BuildSelectionDataGet(
            DynamicFieldConfig => $DynamicFieldConfig,
            PossibleValues     => $PossibleValues,
            Value              => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
        ) || $PossibleValues;

        # add dynamic field to the list of fields to update
        push(
            @DynamicFieldAJAX,
            {
                Name        => 'DynamicField_' . $DynamicFieldConfig->{Name},
                Data        => $DataValues,
                SelectedID  => $DynamicFieldValues{ $DynamicFieldConfig->{Name} },
                Translation => $DynamicFieldConfig->{Config}->{TranslatableValues} || 0,
                Max         => 100,
            }
        );
    }

    my $JSON = $Self->{LayoutObject}->BuildSelectionJSON(
        [
            {
                Name         => 'ComposeStateID',
                Data         => $NextStates,
                SelectedID   => $GetParam{ComposeStateID},
                Translation  => 1,
                PossibleNone => 1,
                Max          => 100,
            },
            @ExtendedData,
            @DynamicFieldAJAX,
        ],
    );

    return $Self->{LayoutObject}->Attachment(
        ContentType => 'application/json; charset=' . $Self->{LayoutObject}->{Charset},
        Content     => $JSON,
        Type        => 'inline',
        NoCache     => 1,
    );
}

sub _GetNextStates {
    my ( $Self, %Param ) = @_;

    # get next states
    my %NextStates = $Self->{TicketObject}->TicketStateList(
        %Param,
        Action   => $Self->{Action},
        TicketID => $Self->{TicketID},
        UserID   => $Self->{UserID},
    );

    return \%NextStates;
}

sub _Mask {
    my ( $Self, %Param ) = @_;

    my $DynamicFieldNames = $Self->_GetFieldsToUpdate(
        OnlyDynamicFields => 1
    );

    # create a string with the quoted dynamic field names separated by commas
    if ( IsArrayRefWithData($DynamicFieldNames) ) {
        for my $Field ( @{$DynamicFieldNames} ) {
            $Param{DynamicFieldNamesStrg} .= ", '" . $Field . "'";
        }
    }

    # build next states string
    my %State;
    if ( !$Param{ComposeStateID} ) {
        $State{SelectedValue} = $Self->{Config}->{StateDefault};
    }
    else {
        $State{SelectedID} = $Param{ComposeStateID};
    }

    $Param{NextStatesStrg} = $Self->{LayoutObject}->BuildSelection(
        Data         => $Param{NextStates},
        Name         => 'ComposeStateID',
        PossibleNone => 1,
        %State,
    );
    my %ArticleTypes;
    my @ArticleTypesPossible = @{ $Self->{Config}->{ArticleTypes} };
    for my $ArticleType (@ArticleTypesPossible) {
        $ArticleTypes{ $Self->{TicketObject}->ArticleTypeLookup( ArticleType => $ArticleType ) } = $ArticleType;
    }
    if ( $Self->{GetParam}->{ArticleTypeID} ) {
        $Param{ArticleTypesStrg} = $Self->{LayoutObject}->BuildSelection(
            Data       => \%ArticleTypes,
            Name       => 'ArticleTypeID',
            SelectedID => $Self->{GetParam}->{ArticleTypeID},
        );
    }
    else {
        $Param{ArticleTypesStrg} = $Self->{LayoutObject}->BuildSelection(
            Data          => \%ArticleTypes,
            Name          => 'ArticleTypeID',
            SelectedValue => $Self->{Config}->{ArticleTypeDefault},
        );
    }

    # build customer search autocomplete field
    $Self->{LayoutObject}->Block(
        Name => 'CustomerSearchAutoComplete',
    );

    # prepare errors!
    if ( $Param{Errors} ) {
        for my $Error ( sort keys %{ $Param{Errors} } ) {
            $Param{$Error} = $Self->{LayoutObject}->Ascii2Html( Text => $Param{Errors}->{$Error} );
        }
    }

    # pending data string
    $Param{PendingDateString} = $Self->{LayoutObject}->BuildDateSelection(
        %Param,
        YearPeriodPast       => 0,
        YearPeriodFuture     => 5,
        Format               => 'DateInputFormatLong',
        DiffTime             => $Self->{ConfigObject}->Get('Ticket::Frontend::PendingDiffTime') || 0,
        Class                => $Param{Errors}->{DateInvalid} || ' ',
        Validate             => 1,
        ValidateDateInFuture => 1,
    );

    # Multiple-Autocomplete
    # Cc
    my $CustomerCounterCc = 0;
    if ( $Param{MultipleCustomerCc} ) {
        for my $Item ( @{ $Param{MultipleCustomerCc} } ) {
            $Self->{LayoutObject}->Block(
                Name => 'CcMultipleCustomer',
                Data => $Item,
            );
            $Self->{LayoutObject}->Block(
                Name => 'Cc' . $Item->{CustomerErrorMsg},
                Data => $Item,
            );
            if ( $Item->{CustomerError} ) {
                $Self->{LayoutObject}->Block(
                    Name => 'CcCustomerErrorExplantion',
                );
            }
            $CustomerCounterCc++;
        }
    }

    if ( !$CustomerCounterCc ) {
        $Param{CcCustomerHiddenContainer} = 'Hidden';
    }

    # set customer counter
    $Self->{LayoutObject}->Block(
        Name => 'CcMultipleCustomerCounter',
        Data => {
            CustomerCounter => $CustomerCounterCc++,
        },
    );

    # Bcc
    my $CustomerCounterBcc = 0;
    if ( $Param{MultipleCustomerBcc} ) {
        for my $Item ( @{ $Param{MultipleCustomerBcc} } ) {
            $Self->{LayoutObject}->Block(
                Name => 'BccMultipleCustomer',
                Data => $Item,
            );
            $Self->{LayoutObject}->Block(
                Name => 'Bcc' . $Item->{CustomerErrorMsg},
                Data => $Item,
            );
            if ( $Item->{CustomerError} ) {
                $Self->{LayoutObject}->Block(
                    Name => 'BccCustomerErrorExplantion',
                );
            }
            $CustomerCounterBcc++;
        }
    }

    if ( !$CustomerCounterBcc ) {
        $Param{BccCustomerHiddenContainer} = 'Hidden';
    }

    # set customer counter
    $Self->{LayoutObject}->Block(
        Name => 'BccMultipleCustomerCounter',
        Data => {
            CustomerCounter => $CustomerCounterBcc++,
        },
    );

    # To
    my $CustomerCounter = 0;
    if ( $Param{MultipleCustomer} ) {
        for my $Item ( @{ $Param{MultipleCustomer} } ) {
            $Self->{LayoutObject}->Block(
                Name => 'MultipleCustomer',
                Data => $Item,
            );
            $Self->{LayoutObject}->Block(
                Name => $Item->{CustomerErrorMsg},
                Data => $Item,
            );
            if ( $Item->{CustomerError} ) {
                $Self->{LayoutObject}->Block(
                    Name => 'CustomerErrorExplantion',
                );
            }
            $CustomerCounter++;
        }
    }

    if ( !$CustomerCounter ) {
        $Param{CustomerHiddenContainer} = 'Hidden';
    }

    # set customer counter
    $Self->{LayoutObject}->Block(
        Name => 'MultipleCustomerCounter',
        Data => {
            CustomerCounter => $CustomerCounter++,
        },
    );

    if ( $Param{ToInvalid} && $Param{Errors} && !$Param{Errors}->{ToErrorType} ) {
        $Self->{LayoutObject}->Block(
            Name => 'ToServerErrorMsg',
        );
    }

    if ( $Param{CcInvalid} && $Param{Errors} && !$Param{Errors}->{CcErrorType} ) {
        $Self->{LayoutObject}->Block(
            Name => 'CcServerErrorMsg',
        );
    }

    if ( $Param{BccInvalid} && $Param{Errors} && !$Param{Errors}->{BccErrorType} ) {
        $Self->{LayoutObject}->Block(
            Name => 'BccServerErrorMsg',
        );
    }

    # Dynamic fields
    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # skip fields that HTML could not be retrieved
        next DYNAMICFIELD if !IsHashRefWithData(
            $Param{DynamicFieldHTML}->{ $DynamicFieldConfig->{Name} }
        );

        # get the HTML strings form $Param
        my $DynamicFieldHTML = $Param{DynamicFieldHTML}->{ $DynamicFieldConfig->{Name} };

        $Self->{LayoutObject}->Block(
            Name => 'DynamicField',
            Data => {
                Name  => $DynamicFieldConfig->{Name},
                Label => $DynamicFieldHTML->{Label},
                Field => $DynamicFieldHTML->{Field},
            },
        );

        # example of dynamic fields order customization
        $Self->{LayoutObject}->Block(
            Name => 'DynamicField_' . $DynamicFieldConfig->{Name},
            Data => {
                Name  => $DynamicFieldConfig->{Name},
                Label => $DynamicFieldHTML->{Label},
                Field => $DynamicFieldHTML->{Field},
            },
        );
    }

    # show time accounting box
    if ( $Self->{ConfigObject}->Get('Ticket::Frontend::AccountTime') ) {
        if ( $Self->{ConfigObject}->Get('Ticket::Frontend::NeedAccountedTime') ) {
            $Self->{LayoutObject}->Block(
                Name => 'TimeUnitsLabelMandatory',
                Data => \%Param,
            );
        }
        else {
            $Self->{LayoutObject}->Block(
                Name => 'TimeUnitsLabel',
                Data => \%Param,
            );
        }
        $Self->{LayoutObject}->Block(
            Name => 'TimeUnits',
            Data => \%Param,
        );
    }

    my $ShownOptionsBlock;

    # show spell check
    if ( $Self->{LayoutObject}->{BrowserSpellChecker} ) {

        # check if need to call Options block
        if ( !$ShownOptionsBlock ) {
            $Self->{LayoutObject}->Block(
                Name => 'TicketOptions',
                Data => {},
            );

            # set flag to "true" in order to prevent calling the Options block again
            $ShownOptionsBlock = 1;
        }

        $Self->{LayoutObject}->Block(
            Name => 'SpellCheck',
            Data => {},
        );
    }

    # show address book
    if ( $Self->{LayoutObject}->{BrowserJavaScriptSupport} ) {

        # check if need to call Options block
        if ( !$ShownOptionsBlock ) {
            $Self->{LayoutObject}->Block(
                Name => 'TicketOptions',
                Data => {},
            );

            # set flag to "true" in order to prevent calling the Options block again
            $ShownOptionsBlock = 1;
        }

        $Self->{LayoutObject}->Block(
            Name => 'AddressBook',
            Data => {},
        );
    }

    # build text template string
    my %StandardTemplates = $Self->{StandardTemplateObject}->StandardTemplateList(
        Valid => 1,
        Type  => 'Email',
    );

    my $QueueStandardTemplates = $Self->_GetStandardTemplates(
        %Param,
        TicketID => $Self->{TicketID} || '',
    );

    if (
        IsHashRefWithData(
            $QueueStandardTemplates
                || ( $Param{Queue} && IsHashRefWithData( \%StandardTemplates ) )
        )
        )
    {
        $Param{StandardTemplateStrg} = $Self->{LayoutObject}->BuildSelection(
            Data       => $QueueStandardTemplates    || {},
            Name       => 'StandardTemplateID',
            SelectedID => $Param{StandardTemplateID} || '',
            PossibleNone => 1,
            Sort         => 'AlphanumericValue',
            Translation  => 1,
            Max          => 200,
        );
        $Self->{LayoutObject}->Block(
            Name => 'StandardTemplate',
            Data => {%Param},
        );
    }

    # show attachments
    ATTACHMENT:
    for my $Attachment ( @{ $Param{Attachments} } ) {
        if (
            $Attachment->{ContentID}
            && $Self->{LayoutObject}->{BrowserRichText}
            && ( $Attachment->{ContentType} =~ /image/i )
            )
        {
            next ATTACHMENT;
        }

        $Self->{LayoutObject}->Block(
            Name => 'Attachment',
            Data => $Attachment,
        );
    }

    # add rich text editor
    if ( $Self->{LayoutObject}->{BrowserRichText} ) {

        # use height/width defined for this screen
        $Param{RichTextHeight} = $Self->{Config}->{RichTextHeight} || 0;
        $Param{RichTextWidth}  = $Self->{Config}->{RichTextWidth}  || 0;

        $Self->{LayoutObject}->Block(
            Name => 'RichText',
            Data => \%Param,
        );
    }

    # create & return output
    return $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentTicketEmailOutbound',
        Data         => \%Param
    );
}

sub _GetFieldsToUpdate {
    my ( $Self, %Param ) = @_;

    my @UpdatableFields;

    # set the fields that can be updateable via AJAXUpdate
    if ( !$Param{OnlyDynamicFields} ) {
        @UpdatableFields = qw( ComposeStateID );
    }

    # cycle through the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $IsACLReducible = $Self->{BackendObject}->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible',
        );
        next DYNAMICFIELD if !$IsACLReducible;

        push @UpdatableFields, 'DynamicField_' . $DynamicFieldConfig->{Name};
    }

    return \@UpdatableFields;
}

sub _GetExtendedParams {
    my ( $Self, %Param ) = @_;

    my %GetParam = %{ $Self->{GetParam} };

    # hash for check duplicated entries
    my %AddressesList;

    my @MultipleCustomer;
    my $CustomersNumber = $Self->{ParamObject}->GetParam( Param => 'CustomerTicketCounterToCustomer' ) || 0;
    my $Selected = $Self->{ParamObject}->GetParam( Param => 'CustomerSelected' ) || '';

    if ($CustomersNumber) {
        my $CustomerCounter = 1;
        for my $Count ( 1 ... $CustomersNumber ) {
            my $CustomerElement = $Self->{ParamObject}->GetParam( Param => 'CustomerTicketText_' . $Count );
            my $CustomerSelected = ( $Selected eq $Count ? 'checked="checked"' : '' );
            my $CustomerKey = $Self->{ParamObject}->GetParam( Param => 'CustomerKey_' . $Count )
                || '';
            my $CustomerQueue = $Self->{ParamObject}->GetParam( Param => 'CustomerQueue_' . $Count )
                || '';
            if ($CustomerElement) {

                if ( $GetParam{To} ) {
                    $GetParam{To} .= ', ' . $CustomerElement;
                }
                else {
                    $GetParam{To} = $CustomerElement;
                }

                # check email address
                my $CustomerErrorMsg = 'CustomerGenericServerErrorMsg';
                my $CustomerError    = '';
                for my $Email ( Mail::Address->parse($CustomerElement) ) {
                    if ( !$Self->{CheckItemObject}->CheckEmail( Address => $Email->address() ) ) {
                        $CustomerErrorMsg = $Self->{CheckItemObject}->CheckErrorType()
                            . 'ServerErrorMsg';
                        $CustomerError = 'ServerError';
                    }
                }

                # check for duplicated entries
                if ( defined $AddressesList{$CustomerElement} && $CustomerError eq '' ) {
                    $CustomerErrorMsg = 'IsDuplicatedServerErrorMsg';
                    $CustomerError    = 'ServerError';
                }

                my $CustomerDisabled = '';
                my $CountAux         = $CustomerCounter++;
                if ( $CustomerError ne '' ) {
                    $CustomerDisabled = 'disabled="disabled"';
                    $CountAux         = $Count . 'Error';
                }

                if ( $CustomerQueue ne '' ) {
                    $CustomerQueue = $Count;
                }

                push @MultipleCustomer, {
                    Count            => $CountAux,
                    CustomerElement  => $CustomerElement,
                    CustomerSelected => $CustomerSelected,
                    CustomerKey      => $CustomerKey,
                    CustomerError    => $CustomerError,
                    CustomerErrorMsg => $CustomerErrorMsg,
                    CustomerDisabled => $CustomerDisabled,
                    CustomerQueue    => $CustomerQueue,
                };
                $AddressesList{$CustomerElement} = 1;
            }
        }
    }

    my @MultipleCustomerCc;
    my $CustomersNumberCc = $Self->{ParamObject}->GetParam( Param => 'CustomerTicketCounterCcCustomer' ) || 0;

    if ($CustomersNumberCc) {
        my $CustomerCounterCc = 1;
        for my $Count ( 1 ... $CustomersNumberCc ) {
            my $CustomerElementCc = $Self->{ParamObject}->GetParam( Param => 'CcCustomerTicketText_' . $Count );
            my $CustomerKeyCc     = $Self->{ParamObject}->GetParam( Param => 'CcCustomerKey_' . $Count )
                || '';
            my $CustomerQueueCc = $Self->{ParamObject}->GetParam( Param => 'CcCustomerQueue_' . $Count )
                || '';

            if ($CustomerElementCc) {

                if ( $GetParam{Cc} ) {
                    $GetParam{Cc} .= ', ' . $CustomerElementCc;
                }
                else {
                    $GetParam{Cc} = $CustomerElementCc;
                }

                # check email address
                my $CustomerErrorMsgCc = 'CustomerGenericServerErrorMsg';
                my $CustomerErrorCc    = '';
                for my $Email ( Mail::Address->parse($CustomerElementCc) ) {
                    if ( !$Self->{CheckItemObject}->CheckEmail( Address => $Email->address() ) ) {
                        $CustomerErrorMsgCc = $Self->{CheckItemObject}->CheckErrorType()
                            . 'ServerErrorMsg';
                        $CustomerErrorCc = 'ServerError';
                    }
                }

                # check for duplicated entries
                if ( defined $AddressesList{$CustomerElementCc} && $CustomerErrorCc eq '' ) {
                    $CustomerErrorMsgCc = 'IsDuplicatedServerErrorMsg';
                    $CustomerErrorCc    = 'ServerError';
                }

                my $CustomerDisabledCc = '';
                my $CountAuxCc         = $CustomerCounterCc++;
                if ( $CustomerErrorCc ne '' ) {
                    $CustomerDisabledCc = 'disabled="disabled"';
                    $CountAuxCc         = $Count . 'Error';
                }

                if ( $CustomerQueueCc ne '' ) {
                    $CustomerQueueCc = $Count;
                }

                push @MultipleCustomerCc, {
                    Count            => $CountAuxCc,
                    CustomerElement  => $CustomerElementCc,
                    CustomerKey      => $CustomerKeyCc,
                    CustomerError    => $CustomerErrorCc,
                    CustomerErrorMsg => $CustomerErrorMsgCc,
                    CustomerDisabled => $CustomerDisabledCc,
                    CustomerQueue    => $CustomerQueueCc,
                };
                $AddressesList{$CustomerElementCc} = 1;
            }
        }
    }

    my @MultipleCustomerBcc;
    my $CustomersNumberBcc = $Self->{ParamObject}->GetParam( Param => 'CustomerTicketCounterBccCustomer' ) || 0;

    if ($CustomersNumberBcc) {
        my $CustomerCounterBcc = 1;
        for my $Count ( 1 ... $CustomersNumberBcc ) {
            my $CustomerElementBcc = $Self->{ParamObject}->GetParam( Param => 'BccCustomerTicketText_' . $Count );
            my $CustomerKeyBcc     = $Self->{ParamObject}->GetParam( Param => 'BccCustomerKey_' . $Count )
                || '';
            my $CustomerQueueBcc = $Self->{ParamObject}->GetParam( Param => 'BccCustomerQueue_' . $Count )
                || '';

            if ($CustomerElementBcc) {

                if ( $GetParam{Bcc} ) {
                    $GetParam{Bcc} .= ', ' . $CustomerElementBcc;
                }
                else {
                    $GetParam{Bcc} = $CustomerElementBcc;
                }

                # check email address
                my $CustomerErrorMsgBcc = 'CustomerGenericServerErrorMsg';
                my $CustomerErrorBcc    = '';
                for my $Email ( Mail::Address->parse($CustomerElementBcc) ) {
                    if ( !$Self->{CheckItemObject}->CheckEmail( Address => $Email->address() ) ) {
                        $CustomerErrorMsgBcc = $Self->{CheckItemObject}->CheckErrorType()
                            . 'ServerErrorMsg';
                        $CustomerErrorBcc = 'ServerError';
                    }
                }

                # check for duplicated entries
                if ( defined $AddressesList{$CustomerElementBcc} && $CustomerErrorBcc eq '' ) {
                    $CustomerErrorMsgBcc = 'IsDuplicatedServerErrorMsg';
                    $CustomerErrorBcc    = 'ServerError';
                }

                my $CustomerDisabledBcc = '';
                my $CountAuxBcc         = $CustomerCounterBcc++;
                if ( $CustomerErrorBcc ne '' ) {
                    $CustomerDisabledBcc = 'disabled="disabled"';
                    $CountAuxBcc         = $Count . 'Error';
                }

                if ( $CustomerQueueBcc ne '' ) {
                    $CustomerQueueBcc = $Count;
                }

                push @MultipleCustomerBcc, {
                    Count            => $CountAuxBcc,
                    CustomerElement  => $CustomerElementBcc,
                    CustomerKey      => $CustomerKeyBcc,
                    CustomerError    => $CustomerErrorBcc,
                    CustomerErrorMsg => $CustomerErrorMsgBcc,
                    CustomerDisabled => $CustomerDisabledBcc,
                    CustomerQueue    => $CustomerQueueBcc,
                };
                $AddressesList{$CustomerElementBcc} = 1;
            }
        }
    }

    return (
        GetParam            => \%GetParam,
        MultipleCustomer    => \@MultipleCustomer,
        MultipleCustomerCc  => \@MultipleCustomerCc,
        MultipleCustomerBcc => \@MultipleCustomerBcc,
    );
}

sub _GetStandardTemplates {
    my ( $Self, %Param ) = @_;

    # get create templates
    my %Templates;

    # check needed
    return \%Templates if !$Param{QueueID} && !$Param{TicketID};

    my $QueueID = $Param{QueueID} || '';
    if ( !$Param{QueueID} && $Param{TicketID} ) {

        # get QueueID from the ticket
        my %Ticket = $Self->{TicketObject}->TicketGet(
            TicketID      => $Param{TicketID},
            DynamicFields => 0,
            UserID        => $Self->{UserID},
        );
        $QueueID = $Ticket{QueueID} || '';
    }

    # fetch all std. templates
    my %StandardTemplates = $Self->{QueueObject}->QueueStandardTemplateMemberList(
        QueueID       => $QueueID,
        TemplateTypes => 1,
    );

    # return empty hash if there are no templates for this screen
    return \%Templates if !IsHashRefWithData( $StandardTemplates{Email} );

    # return just the templates for this screen
    return $StandardTemplates{Email};
}

1;

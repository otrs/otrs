# --
# Kernel/Modules/AdminGenericAgent.pm - admin generic agent interface
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AdminGenericAgent;

use strict;
use warnings;

use Kernel::System::Event;
use Kernel::System::DynamicField;
use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    $Self->{DynamicFieldObject} = Kernel::System::DynamicField->new(%Param);
    $Self->{EventObject}        = Kernel::System::Event->new(
        %Param,
        DynamicFieldObject => $Self->{DynamicFieldObject},
    );

    # get the dynamic fields for ticket object
    $Self->{DynamicField} = $Self->{DynamicFieldObject}->DynamicFieldListGet(
        Valid      => 1,
        ObjectType => ['Ticket'],
    );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $ParamObject        = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $LayoutObject       = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $GenericAgentObject = $Kernel::OM->Get('Kernel::System::GenericAgent');
    my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    # create local object
    my $CheckItemObject = Kernel::System::CheckItem->new( %{$Self} );

    # secure mode message (don't allow this action till secure mode is enabled)
    if ( !$Kernel::OM->Get('Kernel::Config')->Get('SecureMode') ) {
        return $LayoutObject->SecureMode();
    }

    # get config data
    $Self->{Profile}    = $ParamObject->GetParam( Param => 'Profile' )    || '';
    $Self->{OldProfile} = $ParamObject->GetParam( Param => 'OldProfile' ) || '';
    $Self->{Subaction}  = $ParamObject->GetParam( Param => 'Subaction' )  || '';

    # ---------------------------------------------------------- #
    # run a generic agent job -> "run now"
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'RunNow' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        my $Run = $GenericAgentObject->JobRun(
            Job    => $Self->{Profile},
            UserID => 1,
        );

        # redirect
        if ($Run) {
            return $LayoutObject->Redirect(
                OP => "Action=$Self->{Action}",
            );
        }

        # redirect
        return $LayoutObject->ErrorScreen();
    }

    if ( $Self->{Subaction} eq 'Run' ) {

        return $Self->_MaskRun();
    }

    # --------------------------------------------------------------- #
    # save generic agent job and show a view of all affected tickets
    # --------------------------------------------------------------- #
    # show result site
    if ( $Self->{Subaction} eq 'UpdateAction' ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        my ( %GetParam, %Errors );

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        # get single params
        for my $Parameter (
            qw(TicketNumber Title From To Cc Subject Body CustomerID
            CustomerUserLogin Agent SearchInArchive
            NewTitle
            NewCustomerID NewPendingTime NewPendingTimeType NewCustomerUserLogin
            NewStateID NewQueueID NewPriorityID NewOwnerID NewResponsibleID
            NewTypeID NewServiceID NewSLAID
            NewNoteFrom NewNoteSubject NewNoteBody NewNoteTimeUnits NewModule
            NewParamKey1 NewParamKey2 NewParamKey3 NewParamKey4
            NewParamValue1 NewParamValue2 NewParamValue3 NewParamValue4
            NewParamKey5 NewParamKey6 NewParamKey7 NewParamKey8
            NewParamValue5 NewParamValue6 NewParamValue7 NewParamValue8
            NewLockID NewDelete NewCMD NewSendNoNotification NewArchiveFlag
            ScheduleLastRun Valid
            )
            )
        {
            $GetParam{$Parameter} = $ParamObject->GetParam( Param => $Parameter );

            # remove leading and trailing blank spaces
            $CheckItemObject->StringClean( StringRef => \$GetParam{$Parameter} )
                if $GetParam{$Parameter};
        }

        for my $Type (
            qw(Time ChangeTime CloseTime LastChangeTime TimePending EscalationTime EscalationResponseTime EscalationUpdateTime EscalationSolutionTime)
            )
        {
            my $Key = $Type . 'SearchType';
            $GetParam{$Key} = $ParamObject->GetParam( Param => $Key );
        }
        for my $Type (
            qw(
            TicketCreate           TicketChange
            TicketClose            TicketLastChange
            TicketPending
            TicketEscalation       TicketEscalationResponse
            TicketEscalationUpdate TicketEscalationSolution
            )
            )
        {
            for my $Attribute (
                qw(
                TimePoint TimePointFormat TimePointStart
                TimeStart TimeStartDay TimeStartMonth TimeStopMonth
                TimeStop TimeStopDay TimeStopYear TimeStartYear
                )
                )
            {
                my $Key = $Type . $Attribute;
                $GetParam{$Key} = $ParamObject->GetParam( Param => $Key );
            }

            # validate data
            for my $Attribute (
                qw(TimeStartDay TimeStartMonth TimeStopMonth TimeStopDay)
                )
            {
                my $Key = $Type . $Attribute;
                $GetParam{$Key} = sprintf( '%02d', $GetParam{$Key} ) if $GetParam{$Key};
            }
        }

        # get dynamic fields to set from web request
        # to store dynamic fields profile data
        my %DynamicFieldValues;

        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            # extract the dynamic field value form the web request
            my $DynamicFieldValue = $BackendObject->EditFieldValueGet(
                DynamicFieldConfig      => $DynamicFieldConfig,
                ParamObject             => $ParamObject,
                LayoutObject            => $LayoutObject,
                ReturnTemplateStructure => 1,
            );

            # set the comple value structure in GetParam to store it later in the Generic Agent Job
            if ( IsHashRefWithData($DynamicFieldValue) ) {
                %DynamicFieldValues = ( %DynamicFieldValues, %{$DynamicFieldValue} );
            }
        }

        # get array params
        for my $Parameter (
            qw(LockIDs StateIDs StateTypeIDs QueueIDs PriorityIDs OwnerIDs ResponsibleIDs
            TypeIDs ServiceIDs SLAIDs
            ScheduleDays ScheduleMinutes ScheduleHours
            EventValues
            )
            )
        {

            # get search array params (get submitted params)
            if ( $ParamObject->GetArray( Param => $Parameter ) ) {
                @{ $GetParam{$Parameter} } = $ParamObject->GetArray( Param => $Parameter );
            }
        }

        # get Dynamic fields for search from web request
        # cycle trough the activated Dynamic Fields for this screen
        DYNAMICFIELD:
        for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
            next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

            # get search field preferences
            my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

            PREFERENCE:
            for my $Preference ( @{$SearchFieldPreferences} ) {

                # extract the dynamic field value from the web request
                my $DynamicFieldValue = $BackendObject->SearchFieldValueGet(
                    DynamicFieldConfig     => $DynamicFieldConfig,
                    ParamObject            => $ParamObject,
                    ReturnProfileStructure => 1,
                    LayoutObject           => $LayoutObject,
                    Type                   => $Preference->{Type},
                );

                # set the complete value structure in %DynamicFieldValues to store it later in the
                # Generic Agent Job
                if ( IsHashRefWithData($DynamicFieldValue) ) {
                    %DynamicFieldValues = ( %DynamicFieldValues, %{$DynamicFieldValue} );
                }
            }
        }

        # check needed data
        if ( !$Self->{Profile} ) {
            $Errors{ProfileInvalid} = 'ServerError';
        }

        # if no errors occurred
        if ( !%Errors ) {

            if ( $Self->{OldProfile} ) {

                # remove/clean up old profile stuff
                $GenericAgentObject->JobDelete(
                    Name   => $Self->{OldProfile},
                    UserID => $Self->{UserID},
                );
            }

            # insert new profile params
            my $JobAddResult = $GenericAgentObject->JobAdd(
                Name => $Self->{Profile},
                Data => {
                    %GetParam,
                    %DynamicFieldValues,
                },
                UserID => $Self->{UserID},
            );

            if ($JobAddResult) {
                return $LayoutObject->Redirect(
                    OP => "Action=$Self->{Action}",
                );
            }
            else {
                $Errors{ProfileInvalid}    = 'ServerError';
                $Errors{ProfileInvalidMsg} = 'AddError';
            }
        }

        # something went wrong
        my $JobDataReference;
        $JobDataReference = $Self->_MaskUpdate(
            %Param,
            %GetParam,
            %DynamicFieldValues,
            %Errors,
        );

        # generate search mask
        my $Output = $LayoutObject->Header( Title => 'Edit' );
        $Output .= $LayoutObject->NavigationBar();
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminGenericAgent',
            Data         => $JobDataReference,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ---------------------------------------------------------- #
    # edit generic agent job
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'Update' ) {
        my $JobDataReference;
        $JobDataReference = $Self->_MaskUpdate(%Param);

        # generate search mask
        my $Output = $LayoutObject->Header( Title => 'Edit' );
        $Output .= $LayoutObject->NavigationBar();
        $Output .= $LayoutObject->Output(
            TemplateFile => 'AdminGenericAgent',
            Data         => $JobDataReference,
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # ---------------------------------------------------------- #
    # delete an generic agent job
    # ---------------------------------------------------------- #
    if ( $Self->{Subaction} eq 'Delete' && $Self->{Profile} ) {

        # challenge token check for write action
        $LayoutObject->ChallengeTokenCheck();

        if ( $Self->{Profile} ) {
            $GenericAgentObject->JobDelete(
                Name   => $Self->{Profile},
                UserID => $Self->{UserID},
            );
        }
    }

    # ---------------------------------------------------------- #
    # overview of all generic agent jobs
    # ---------------------------------------------------------- #
    $LayoutObject->Block(
        Name => 'ActionList',
    );
    $LayoutObject->Block(
        Name => 'ActionAdd',
    );
    $LayoutObject->Block(
        Name => 'Overview',
    );
    my %Jobs = $GenericAgentObject->JobList();

    # if there are any data, it is shown
    if (%Jobs) {
        my $Counter = 1;
        for my $JobKey ( sort keys %Jobs ) {
            my %JobData = $GenericAgentObject->JobGet( Name => $JobKey );

            # css setting and text for valid or invalid jobs
            if ( $JobData{Valid} ) {
                $JobData{ShownValid} = 'valid';
            }
            else {
                $JobData{ShownValid} = 'invalid';
            }

            # seperate each searchresult line by using several css

            $LayoutObject->Block(
                Name => 'Row',
                Data => {%JobData},
            );
        }
    }

    # otherwise a no data found msg is displayed
    else {
        $LayoutObject->Block(
            Name => 'NoDataFoundMsg',
            Data => {},
        );
    }

    # generate search mask
    my $Output = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AdminGenericAgent',
        Data         => \%Param,
    );
    $Output .= $LayoutObject->Footer();
    return $Output;
}

sub _MaskUpdate {
    my ( $Self, %Param ) = @_;

    my $ParamObject    = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $TicketObject   = $Kernel::OM->Get('Kernel::System::Ticket');
    my $LayoutObject   = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');
    my $PriorityObject = $Kernel::OM->Get('Kernel::System::Priority');
    my $StateObject    = $Kernel::OM->Get('Kernel::System::State');
    my $LockObject     = $Kernel::OM->Get('Kernel::System::Lock');
    my $BackendObject  = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
    my $QueueObject    = $Kernel::OM->Get('Kernel::System::Queue');

    my %JobData;

    if ( $Self->{Profile} ) {

        # get db job data
        %JobData = $Kernel::OM->Get('Kernel::System::GenericAgent')->JobGet( Name => $Self->{Profile} );
    }
    $JobData{Profile} = $Self->{Profile};

    # get list type
    my $TreeView = 0;
    if ( $ConfigObject->Get('Ticket::Frontend::ListType') eq 'tree' ) {
        $TreeView = 1;
    }

    my %ShownUsers = $Kernel::OM->Get('Kernel::System::User')->UserList(
        Type  => 'Long',
        Valid => 1,
    );
    $JobData{OwnerStrg} = $LayoutObject->BuildSelection(
        Data        => \%ShownUsers,
        Name        => 'OwnerIDs',
        Multiple    => 1,
        Size        => 5,
        Translation => 0,
        SelectedID  => $JobData{OwnerIDs},
    );
    $JobData{NewOwnerStrg} = $LayoutObject->BuildSelection(
        Data        => \%ShownUsers,
        Name        => 'NewOwnerID',
        Size        => 5,
        Multiple    => 0,
        Translation => 0,
        SelectedID  => $JobData{NewOwnerID},
    );
    my %Hours;
    for my $Number ( 0 .. 23 ) {
        $Hours{$Number} = sprintf( "%02d", $Number );
    }
    $JobData{ScheduleHoursList} = $LayoutObject->BuildSelection(
        Data        => \%Hours,
        Name        => 'ScheduleHours',
        Size        => 6,
        Multiple    => 1,
        Translation => 0,
        SelectedID  => $JobData{ScheduleHours},
    );
    $JobData{ScheduleMinutesList} = $LayoutObject->BuildSelection(
        Data => {
            '00' => '00',
            10   => '10',
            20   => '20',
            30   => '30',
            40   => '40',
            50   => '50',
        },
        Name        => 'ScheduleMinutes',
        Size        => 6,
        Multiple    => 1,
        Translation => 0,
        SelectedID  => $JobData{ScheduleMinutes},
    );
    $JobData{ScheduleDaysList} = $LayoutObject->BuildSelection(
        Data => {
            1 => 'Mon',
            2 => 'Tue',
            3 => 'Wed',
            4 => 'Thu',
            5 => 'Fri',
            6 => 'Sat',
            0 => 'Sun',
        },
        Sort       => 'NumericKey',
        Name       => 'ScheduleDays',
        Size       => 7,
        Multiple   => 1,
        SelectedID => $JobData{ScheduleDays},
    );

    $JobData{StatesStrg} = $LayoutObject->BuildSelection(
        Data => {
            $StateObject->StateList(
                UserID => 1,
                Action => $Self->{Action},
            ),
        },
        Name       => 'StateIDs',
        Multiple   => 1,
        Size       => 5,
        SelectedID => $JobData{StateIDs},
    );
    $JobData{NewStatesStrg} = $LayoutObject->BuildSelection(
        Data => {
            $StateObject->StateList(
                UserID => 1,
                Action => $Self->{Action},
            ),
        },
        Name       => 'NewStateID',
        Size       => 5,
        Multiple   => 0,
        SelectedID => $JobData{NewStateID},
    );
    $JobData{NewPendingTimeTypeStrg} = $LayoutObject->BuildSelection(
        Data => [
            {
                Key   => 60,
                Value => 'minute(s)',
            },
            {
                Key   => 3600,
                Value => 'hour(s)',
            },
            {
                Key   => 86400,
                Value => 'day(s)',
            },
            {
                Key   => 2592000,
                Value => 'month(s)',
            },
            {
                Key   => 31536000,
                Value => 'year(s)',
            },

        ],
        Name        => 'NewPendingTimeType',
        Size        => 1,
        Multiple    => 0,
        SelectedID  => $JobData{NewPendingTimeType},
        Translation => 1,
        Title       => $LayoutObject->{LanguageObject}->Translate('Time unit'),
    );
    $JobData{QueuesStrg} = $LayoutObject->AgentQueueListOption(
        Data               => { $QueueObject->GetAllQueues(), },
        Size               => 5,
        Multiple           => 1,
        Name               => 'QueueIDs',
        SelectedIDRefArray => $JobData{QueueIDs},
        TreeView           => $TreeView,
        OnChangeSubmit     => 0,
    );
    $JobData{NewQueuesStrg} = $LayoutObject->AgentQueueListOption(
        Data           => { $QueueObject->GetAllQueues(), },
        Size           => 5,
        Multiple       => 0,
        Name           => 'NewQueueID',
        SelectedID     => $JobData{NewQueueID},
        TreeView       => $TreeView,
        OnChangeSubmit => 0,
    );
    $JobData{PrioritiesStrg} = $LayoutObject->BuildSelection(
        Data => {
            $PriorityObject->PriorityList(
                UserID => 1,
                Action => $Self->{Action},
            ),
        },
        Name       => 'PriorityIDs',
        Size       => 5,
        Multiple   => 1,
        SelectedID => $JobData{PriorityIDs},
    );
    $JobData{NewPrioritiesStrg} = $LayoutObject->BuildSelection(
        Data => {
            $PriorityObject->PriorityList(
                UserID => 1,
                Action => $Self->{Action},
            ),
        },
        Name       => 'NewPriorityID',
        Size       => 5,
        Multiple   => 0,
        SelectedID => $JobData{NewPriorityID},
    );

    # get time option
    my %Map = (
        TicketCreate             => 'Time',
        TicketChange             => 'ChangeTime',
        TicketClose              => 'CloseTime',
        TicketLastChange         => 'LastChangeTime',
        TicketPending            => 'TimePending',
        TicketEscalation         => 'EscalationTime',
        TicketEscalationResponse => 'EscalationResponseTime',
        TicketEscalationUpdate   => 'EscalationUpdateTime',
        TicketEscalationSolution => 'EscalationSolutionTime',
    );
    for my $Type (
        qw(
        TicketCreate           TicketClose
        TicketChange           TicketLastChange
        TicketPending
        TicketEscalation       TicketEscalationResponse
        TicketEscalationUpdate TicketEscalationSolution
        )
        )
    {
        my $SearchType = $Map{$Type} . 'SearchType';
        if ( !$JobData{$SearchType} ) {
            $JobData{ $SearchType . '::None' } = 'checked="checked"';
        }
        elsif ( $JobData{$SearchType} eq 'TimePoint' ) {
            $JobData{ $SearchType . '::TimePoint' } = 'checked="checked"';
        }
        elsif ( $JobData{$SearchType} eq 'TimeSlot' ) {
            $JobData{ $SearchType . '::TimeSlot' } = 'checked="checked"';
        }

        my %Counter;
        for my $Number ( 1 .. 60 ) {
            $Counter{$Number} = sprintf( "%02d", $Number );
        }

        # time
        $JobData{ $Type . 'TimePoint' } = $LayoutObject->BuildSelection(
            Data        => \%Counter,
            Name        => $Type . 'TimePoint',
            SelectedID  => $JobData{ $Type . 'TimePoint' },
            Translation => 0,
        );
        $JobData{ $Type . 'TimePointStart' } = $LayoutObject->BuildSelection(
            Data => {
                Last   => 'within the last ...',
                Next   => 'within the next ...',
                Before => 'more than ... ago',
            },
            Name       => $Type . 'TimePointStart',
            SelectedID => $JobData{ $Type . 'TimePointStart' } || 'Last',
        );
        $JobData{ $Type . 'TimePointFormat' } = $LayoutObject->BuildSelection(
            Data => {
                minute => 'minute(s)',
                hour   => 'hour(s)',
                day    => 'day(s)',
                week   => 'week(s)',
                month  => 'month(s)',
                year   => 'year(s)',
            },
            Name       => $Type . 'TimePointFormat',
            SelectedID => $JobData{ $Type . 'TimePointFormat' },
        );
        $JobData{ $Type . 'TimeStart' } = $LayoutObject->BuildDateSelection(
            %JobData,
            Prefix   => $Type . 'TimeStart',
            Format   => 'DateInputFormat',
            DiffTime => -( 60 * 60 * 24 ) * 30,
            Validate => 1,
        );
        $JobData{ $Type . 'TimeStop' } = $LayoutObject->BuildDateSelection(
            %JobData,
            Prefix   => $Type . 'TimeStop',
            Format   => 'DateInputFormat',
            Validate => 1,
        );
    }

    $JobData{DeleteOption} = $LayoutObject->BuildSelection(
        Data       => $ConfigObject->Get('YesNoOptions'),
        Name       => 'NewDelete',
        SelectedID => $JobData{NewDelete} || 0,
    );
    $JobData{ValidOption} = $LayoutObject->BuildSelection(
        Data       => $ConfigObject->Get('YesNoOptions'),
        Name       => 'Valid',
        SelectedID => defined( $JobData{Valid} ) ? $JobData{Valid} : 1,
    );
    $JobData{LockOption} = $LayoutObject->BuildSelection(
        Data => {
            $LockObject->LockList(
                UserID => 1,
                Action => $Self->{Action},
            ),
        },
        Name       => 'LockIDs',
        Multiple   => 1,
        Size       => 3,
        SelectedID => $JobData{LockIDs},
    );
    $JobData{NewLockOption} = $LayoutObject->BuildSelection(
        Data => {
            $LockObject->LockList(
                UserID => 1,
                Action => $Self->{Action},
            ),
        },
        Name       => 'NewLockID',
        Size       => 3,
        Multiple   => 0,
        SelectedID => $JobData{NewLockID},
    );

    # REMARK: we changed the wording "Send no notifications" to
    # "Send agent/customer notifications on changes" in frontend.
    # But the backend code is still the same (compatiblity).
    # Because of this case we changed 1=>'Yes' to 1=>'No'
    $JobData{SendNoNotificationOption} = $LayoutObject->BuildSelection(
        Data => {
            '1' => 'No',
            '0' => 'Yes'
        },
        Name       => 'NewSendNoNotification',
        SelectedID => $JobData{NewSendNoNotification} || 0,
    );
    $LayoutObject->Block(
        Name => 'ActionList',
    );
    $LayoutObject->Block(
        Name => 'ActionOverview',
    );
    $LayoutObject->Block(
        Name => 'Edit',
        Data => {
            %Param,
            %JobData,
        },
    );

    # check for profile errors
    if ( defined $Param{ProfileInvalid} ) {
        $Param{ProfileInvalidMsg} //= '';
        $LayoutObject->Block(
            Name => 'ProfileInvalidMsg' . $Param{ProfileInvalidMsg},
        );
    }

    # check if the schedule options are selected
    if (
        !defined $JobData{ScheduleDays}->[0]
        || !defined $JobData{ScheduleHours}->[0]
        || !defined $JobData{ScheduleMinutes}->[0]
        )
    {
        $LayoutObject->Block(
            Name => 'JobScheduleWarning',
        );
    }

    # build type string
    if ( $ConfigObject->Get('Ticket::Type') ) {
        my %Type = $Kernel::OM->Get('Kernel::System::Type')->TypeList(
            UserID => $Self->{UserID},
        );
        $JobData{TypesStrg} = $LayoutObject->BuildSelection(
            Data        => \%Type,
            Name        => 'TypeIDs',
            SelectedID  => $JobData{TypeIDs},
            Sort        => 'AlphanumericValue',
            Size        => 3,
            Multiple    => 1,
            Translation => 0,
        );
        $LayoutObject->Block(
            Name => 'TicketType',
            Data => \%JobData,
        );
        $JobData{NewTypesStrg} = $LayoutObject->BuildSelection(
            Data        => \%Type,
            Name        => 'NewTypeID',
            SelectedID  => $JobData{NewTypeID},
            Sort        => 'AlphanumericValue',
            Size        => 3,
            Multiple    => 0,
            Translation => 0,
        );
        $LayoutObject->Block(
            Name => 'NewTicketType',
            Data => \%JobData,
        );
    }

    # build service string
    if ( $ConfigObject->Get('Ticket::Service') ) {

        # get list type
        my %Service = $Kernel::OM->Get('Kernel::System::Service')->ServiceList(
            Valid        => 1,
            KeepChildren => 1,
            UserID       => $Self->{UserID},
        );
        my %NewService = %Service;
        $JobData{ServicesStrg} = $LayoutObject->BuildSelection(
            Data        => \%Service,
            Name        => 'ServiceIDs',
            SelectedID  => $JobData{ServiceIDs},
            Size        => 5,
            Multiple    => 1,
            TreeView    => $TreeView,
            Translation => 0,
            Max         => 200,
        );
        $JobData{NewServicesStrg} = $LayoutObject->BuildSelection(
            Data        => \%NewService,
            Name        => 'NewServiceID',
            SelectedID  => $JobData{NewServiceID},
            Size        => 5,
            Multiple    => 0,
            TreeView    => $TreeView,
            Translation => 0,
            Max         => 200,
        );
        my %SLA = $Kernel::OM->Get('Kernel::System::SLA')->SLAList(
            UserID => $Self->{UserID},
        );
        $JobData{SLAsStrg} = $LayoutObject->BuildSelection(
            Data        => \%SLA,
            Name        => 'SLAIDs',
            SelectedID  => $JobData{SLAIDs},
            Sort        => 'AlphanumericValue',
            Size        => 5,
            Multiple    => 1,
            Translation => 0,
            Max         => 200,
        );
        $JobData{NewSLAsStrg} = $LayoutObject->BuildSelection(
            Data        => \%SLA,
            Name        => 'NewSLAID',
            SelectedID  => $JobData{NewSLAID},
            Sort        => 'AlphanumericValue',
            Size        => 5,
            Multiple    => 0,
            Translation => 0,
            Max         => 200,
        );
        $LayoutObject->Block(
            Name => 'TicketService',
            Data => {%JobData},
        );
        $LayoutObject->Block(
            Name => 'NewTicketService',
            Data => {%JobData},
        );
    }

    # ticket responsible string
    if ( $ConfigObject->Get('Ticket::Responsible') ) {
        $JobData{ResponsibleStrg} = $LayoutObject->BuildSelection(
            Data        => \%ShownUsers,
            Name        => 'ResponsibleIDs',
            Size        => 5,
            Multiple    => 1,
            Translation => 0,
            SelectedID  => $JobData{ResponsibleIDs},
        );
        $JobData{NewResponsibleStrg} = $LayoutObject->BuildSelection(
            Data        => \%ShownUsers,
            Name        => 'NewResponsibleID',
            Size        => 5,
            Multiple    => 0,
            Translation => 0,
            SelectedID  => $JobData{NewResponsibleID},
        );
        $LayoutObject->Block(
            Name => 'TicketResponsible',
            Data => {%JobData},
        );
        $LayoutObject->Block(
            Name => 'NewTicketResponsible',
            Data => {%JobData},
        );
    }

    # prepare archive
    if ( $ConfigObject->Get('Ticket::ArchiveSystem') ) {

        $JobData{'SearchInArchiveStrg'} = $LayoutObject->BuildSelection(
            Data => {
                ArchivedTickets    => 'Archived tickets',
                NotArchivedTickets => 'Unarchived tickets',
                AllTickets         => 'All tickets',
            },
            Name       => 'SearchInArchive',
            SelectedID => $JobData{SearchInArchive} || 'AllTickets',
        );

        $LayoutObject->Block(
            Name => 'SearchInArchive',
            Data => {%JobData},
        );

        $JobData{'NewArchiveFlagStrg'} = $LayoutObject->BuildSelection(
            Data => {
                y => 'archive tickets',
                n => 'restore tickets from archive',
            },
            Name         => 'NewArchiveFlag',
            PossibleNone => 1,
            SelectedID   => $JobData{NewArchiveFlag} || '',
        );

        $LayoutObject->Block(
            Name => 'NewArchiveFlag',
            Data => {%JobData},
        );
    }

    # create dynamic field HTML for set with historical data options
    my $PrintDynamicFieldsSearchHeader = 1;

    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # get search field preferences
        my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
            DynamicFieldConfig => $DynamicFieldConfig,
        );

        next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

        PREFERENCE:
        for my $Preference ( @{$SearchFieldPreferences} ) {

            # get field html
            my $DynamicFieldHTML = $BackendObject->SearchFieldRender(
                DynamicFieldConfig => $DynamicFieldConfig,
                Profile            => \%JobData,
                DefaultValue =>
                    $Self->{Config}->{Defaults}->{DynamicField}->{ $DynamicFieldConfig->{Name} },
                LayoutObject           => $LayoutObject,
                ConfirmationCheckboxes => 1,
                Type                   => $Preference->{Type},
            );

            next PREFERENCE if !IsHashRefWithData($DynamicFieldHTML);

            if ($PrintDynamicFieldsSearchHeader) {
                $LayoutObject->Block( Name => 'DynamicField' );
                $PrintDynamicFieldsSearchHeader = 0;
            }

            # output dynamic field
            $LayoutObject->Block(
                Name => 'DynamicFieldElement',
                Data => {
                    Label => $DynamicFieldHTML->{Label},
                    Field => $DynamicFieldHTML->{Field},
                },
            );
        }
    }

    # create dynamic field HTML for set with historical data options
    my $PrintDynamicFieldsEditHeader = 1;

    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        my $PossibleValuesFilter;

        my $IsACLReducible = $BackendObject->HasBehavior(
            DynamicFieldConfig => $DynamicFieldConfig,
            Behavior           => 'IsACLReducible',
        );

        if ($IsACLReducible) {

            # get PossibleValues
            my $PossibleValues = $BackendObject->PossibleValuesGet(
                DynamicFieldConfig => $DynamicFieldConfig,
            );

            # check if field has PossibleValues property in its configuration
            if ( IsHashRefWithData($PossibleValues) ) {

                # convert possible values key => value to key => key for ACLs using a Hash slice
                my %AclData = %{$PossibleValues};
                @AclData{ keys %AclData } = keys %AclData;

                # set possible values filter from ACLs
                my $ACL = $TicketObject->TicketAcl(
                    Action        => $Self->{Action},
                    Type          => 'DynamicField_' . $DynamicFieldConfig->{Name},
                    ReturnType    => 'Ticket',
                    ReturnSubType => 'DynamicField_' . $DynamicFieldConfig->{Name},
                    Data          => \%AclData,
                    UserID        => $Self->{UserID},
                );
                if ($ACL) {
                    my %Filter = $TicketObject->TicketAclData();

                    # convert Filer key => key back to key => value using map
                    %{$PossibleValuesFilter} = map { $_ => $PossibleValues->{$_} }
                        keys %Filter;
                }
            }
        }

        # get field html
        my $DynamicFieldHTML = $BackendObject->EditFieldRender(
            DynamicFieldConfig   => $DynamicFieldConfig,
            PossibleValuesFilter => $PossibleValuesFilter,
            LayoutObject         => $LayoutObject,
            ParamObject          => $ParamObject,
            UseDefaultValue      => 0,
            OverridePossibleNone => 1,
            ConfirmationNeeded   => 1,
            Template             => \%JobData,
            MaxLength            => 200,
        );

        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldHTML);

        if ($PrintDynamicFieldsEditHeader) {
            $LayoutObject->Block( Name => 'NewDynamicField' );
            $PrintDynamicFieldsEditHeader = 0;
        }

        # output dynamic field
        $LayoutObject->Block(
            Name => 'NewDynamicFieldElement',
            Data => {
                Label => $DynamicFieldHTML->{Label},
                Field => $DynamicFieldHTML->{Field},
            },
        );
    }

    # get registered event triggers from the config
    my %RegisteredEvents = $Self->{EventObject}->EventList(
        ObjectTypes => [ 'Ticket', 'Article' ],
    );

    # create the event triggers table
    for my $Event ( @{ $JobData{EventValues} || [] } ) {

        # set the event type ( event object like Article or Ticket)
        my $EventType;
        EVENTTYPE:
        for my $Type ( sort keys %RegisteredEvents ) {
            if ( grep { $_ eq $Event } @{ $RegisteredEvents{$Type} } ) {
                $EventType = $Type;
                last EVENTTYPE;
            }
        }

        # paint each event row in event triggers table
        $LayoutObject->Block(
            Name => 'EventRow',
            Data => {
                Event     => $Event,
                EventType => $EventType || '-',
            },
        );
    }

    my @EventTypeList;
    my $SelectedEventType = $ParamObject->GetParam( Param => 'EventType' ) || 'Ticket';

    # create event trigger selectors (one for each type)
    TYPE:
    for my $Type ( sort keys %RegisteredEvents ) {

        # refresh event list for each event type

        # hide inactive event lists
        my $EventListHidden = '';
        if ( $Type ne $SelectedEventType ) {
            $EventListHidden = 'Hidden';
        }

        # paint each selector
        my $EventStrg = $LayoutObject->BuildSelection(
            Data => $RegisteredEvents{$Type} || [],
            Name => $Type . 'Event',
            Sort => 'AlphanumericValue',
            PossibleNone => 0,
            Class        => 'EventList GenericInterfaceSpacing ' . $EventListHidden,
            Title        => $LayoutObject->{LanguageObject}->Translate('Event'),
        );

        $LayoutObject->Block(
            Name => 'EventAdd',
            Data => {
                EventStrg => $EventStrg,
            },
        );

        push @EventTypeList, $Type;
    }

    # create event type selector
    my $EventTypeStrg = $LayoutObject->BuildSelection(
        Data          => \@EventTypeList,
        Name          => 'EventType',
        Sort          => 'AlphanumericValue',
        SelectedValue => $SelectedEventType,
        PossibleNone  => 0,
        Class         => '',
        Title         => $LayoutObject->{LanguageObject}->Translate('Type'),
    );
    $LayoutObject->Block(
        Name => 'EventTypeStrg',
        Data => {
            EventTypeStrg => $EventTypeStrg,
        },
    );

    return \%JobData;
}

sub _MaskRun {
    my ( $Self, %Param ) = @_;

    my $TicketObject  = $Kernel::OM->Get('Kernel::System::Ticket');
    my $LayoutObject  = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $BackendObject = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');

    my %JobData;

    if ( $Self->{Profile} ) {
        %JobData = $Kernel::OM->Get('Kernel::System::GenericAgent')->JobGet( Name => $Self->{Profile} );
        if ( exists $JobData{SearchInArchive} && $JobData{SearchInArchive} eq 'ArchivedTickets' ) {
            $JobData{ArchiveFlags} = ['y'];
        }
        if ( exists $JobData{SearchInArchive} && $JobData{SearchInArchive} eq 'AllTickets' ) {
            $JobData{ArchiveFlags} = [ 'y', 'n' ];
        }
    }
    else {
        $LayoutObject->FatalError( Message => "Need Profile!" );
    }
    $JobData{Profile} = $Self->{Profile};

    # dynamic fields search parameters for ticket search
    my %DynamicFieldSearchParameters;

    # cycle trough the activated Dynamic Fields for this screen
    DYNAMICFIELD:
    for my $DynamicFieldConfig ( @{ $Self->{DynamicField} } ) {
        next DYNAMICFIELD if !IsHashRefWithData($DynamicFieldConfig);

        # get search field preferences
        my $SearchFieldPreferences = $BackendObject->SearchFieldPreferences(
            DynamicFieldConfig => $DynamicFieldConfig,
        );

        next DYNAMICFIELD if !IsArrayRefWithData($SearchFieldPreferences);

        PREFERENCE:
        for my $Preference ( @{$SearchFieldPreferences} ) {

            if (
                !$JobData{
                    'Search_DynamicField_'
                        . $DynamicFieldConfig->{Name}
                        . $Preference->{Type}
                }
                )
            {
                next PREFERENCE;
            }

            # extract the dynamic field value from the profile
            my $SearchParameter = $BackendObject->SearchFieldParameterBuild(
                DynamicFieldConfig => $DynamicFieldConfig,
                Profile            => \%JobData,
                LayoutObject       => $LayoutObject,
                Type               => $Preference->{Type},
            );

            # set search parameter
            if ( defined $SearchParameter ) {
                $DynamicFieldSearchParameters{ 'DynamicField_' . $DynamicFieldConfig->{Name} }
                    = $SearchParameter->{Parameter};
            }
        }
    }

    # perform ticket search
    my $Counter = $TicketObject->TicketSearch(
        Result          => 'COUNT',
        SortBy          => 'Age',
        OrderBy         => 'Down',
        UserID          => 1,
        Limit           => 60_000,
        ConditionInline => 1,
        %JobData,
        %DynamicFieldSearchParameters,
    ) || 0;

    my @TicketIDs = $TicketObject->TicketSearch(
        Result          => 'ARRAY',
        SortBy          => 'Age',
        OrderBy         => 'Down',
        UserID          => 1,
        Limit           => 30,
        ConditionInline => 1,
        %JobData,
        %DynamicFieldSearchParameters,
    );

    $LayoutObject->Block(
        Name => 'ActionList',
    );
    $LayoutObject->Block(
        Name => 'ActionOverview',
    );
    $LayoutObject->Block(
        Name => 'Result',
        Data => {
            %Param,
            Name        => $Self->{Profile},
            AffectedIDs => $Counter,
        },
    );

    if (@TicketIDs) {
        $LayoutObject->Block( Name => 'ResultBlock' );
        for my $TicketID (@TicketIDs) {

            # get first article data
            my %Data = $TicketObject->ArticleFirstArticle(
                TicketID      => $TicketID,
                DynamicFields => 0,
            );

            # Fallback for tickets without articles
            if ( !%Data ) {

                # get ticket data instead
                %Data = $TicketObject->TicketGet(
                    TicketID      => $TicketID,
                    DynamicFields => 0,
                );

                # set missing information
                $Data{Subject} = $Data{Title};
            }

            $Data{Age} = $LayoutObject->CustomerAge(
                Age   => $Data{Age},
                Space => ' '
            );
            $Data{css} = "PriorityID-$Data{PriorityID}";

            # user info
            my %UserInfo = $Kernel::OM->Get('Kernel::System::User')->GetUserData(
                User => $Data{Owner},
            );
            $Data{UserLastname}  = $UserInfo{UserLastname};
            $Data{UserFirstname} = $UserInfo{UserFirstname};

            $LayoutObject->Block(
                Name => 'Ticket',
                Data => \%Data,
            );
        }

        if ( $JobData{NewDelete} ) {
            $LayoutObject->Block( Name => 'DeleteWarning' );
        }
    }

    # html search mask output
    my $Output = $LayoutObject->Header( Title => 'Affected Tickets' );
    $Output .= $LayoutObject->NavigationBar();
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AdminGenericAgent',
        Data         => \%Param,
    );

    # build footer
    $Output .= $LayoutObject->Footer();
    return $Output;
}

1;

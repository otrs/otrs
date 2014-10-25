# --
# Kernel/Modules/AdminGenericInterfaceInvokerEventDefault.pm - provides a generic interface invoker event edit screen for admins
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AdminGenericInterfaceInvokerEventDefault;

use strict;
use warnings;

use Kernel::System::JSON;
use Kernel::System::Valid;
use Kernel::System::GenericInterface::Webservice;
use Kernel::System::DynamicField;
use Kernel::System::Event;

use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {%Param};
    bless( $Self, $Type );

    for (qw(ParamObject LayoutObject LogObject ConfigObject)) {
        if ( !$Self->{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Got no $_!" );
        }
    }

    # create additional objects
    $Self->{JSONObject}         = Kernel::System::JSON->new( %{$Self} );
    $Self->{ValidObject}        = Kernel::System::Valid->new( %{$Self} );
    $Self->{WebserviceObject}   = Kernel::System::GenericInterface::Webservice->new( %{$Self} );
    $Self->{DynamicFieldObject} = Kernel::System::DynamicField->new( %{$Self} );
    $Self->{EventObject}        = Kernel::System::Event->new(
        %{$Self},
        DynamicFieldObject => $Self->{DynamicFieldObject},
    );

    $Self->{DeletedString}
        = '_GenericInterface_Mapping_Simple_DeletedString_Dont_Use_It_String_Please';

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $WebserviceID = $Self->{ParamObject}->GetParam( Param => 'WebserviceID' )
        || '';
    my $Invoker = $Self->{ParamObject}->GetParam( Param => 'Invoker' )
        || '';
    my $Event = $Self->{ParamObject}->GetParam( Param => 'Event' )
        || '';

    # get configured Invoker registrations
    my $InvokerModules
        = $Self->{ConfigObject}->Get( 'GenericInterface::Invoker::Module' );

    # check for valid Invoker registration
    if ( !IsHashRefWithData($InvokerModules) ) {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "Could not get registered modules for Invoker",
        );
    }

    # get configured Invoker Event registration
    my $InvokerEventModules
        = $Self->{ConfigObject}->Get( 'GenericInterface::Invoker::Event::Module' );

    # check for valid Invoker Event registration
    if ( !IsHashRefWithData($InvokerEventModules) ) {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "Could not get registered modules for Invoker Event",
        );
    }

    # check for WebserviceID
    if ( !$WebserviceID ) {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "Need WebserviceID!",
        );
    }

    # get webservice configuration
    my $WebserviceData =
        $Self->{WebserviceObject}->WebserviceGet( ID => $WebserviceID );

    # check for valid webservice configuration
    if ( !IsHashRefWithData($WebserviceData) ) {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "Could not get data for WebserviceID $WebserviceID",
        );
    }

    if (
        ref $WebserviceData->{Config} ne 'HASH'
        || ref $WebserviceData->{Config}->{Requester} ne 'HASH'
        || ref $WebserviceData->{Config}->{Requester}->{Invoker} ne 'HASH'
        || ref $WebserviceData->{Config}->{Requester}->{Invoker}->{$Invoker} ne 'HASH'
        )
    {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "Could not determine config for invoker $Invoker",
        );
    }

    # get Invoker configuration
    my $InvokerConfig = $WebserviceData->{Config}->{Requester}->{Invoker}->{$Invoker};

    # get Invoker type
    my $InvokerType = $InvokerConfig->{'Type'};

    # check for valid InvokerType backend
    if ( !$InvokerType ) {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "Could not get backend for Invoker $Invoker",
        );
    }

    # get the configuration dialog for the event
    my $InvokerEventFrontendModule = $InvokerEventModules->{$InvokerType}->{'ConfigDialog'};

    # get the configuration dialog for the Invoker
    my $InvokerTypeFrontendModule = $InvokerModules->{$InvokerType}->{'ConfigDialog'};

    # get Webservice name
    my $WebserviceName = $WebserviceData->{Name};

    # get invoker events
    my $InvokerEvents = $WebserviceData->{Config}->{Requester}->{Invoker}->{$Invoker}->{Events};

    # get list of all registered events
    my %RegisteredEvents = $Self->{EventObject}->EventList();

    # prepare event type
    my $EventType;

    # prepare condition
    my $Condition;

    # loop trough invoker events and compare them with current event
    INVOKEREVENT:
    for my $InvokerEvent ( @{ $InvokerEvents } ) {

        if ( $Event eq $InvokerEvent->{Event} ) {

            # set the event type (event object like Article or Ticket) and event conditon
            EVENTTYPE:
            for my $Type ( sort keys %RegisteredEvents ) {

                if ( grep { $_ eq $InvokerEvent->{Event} } @{ $RegisteredEvents{$Type} || [] } ) {

                    $EventType = $Type;
                    $Condition = $InvokerEvent->{Condition};

                    last EVENTTYPE;
                }
            }

            last INVOKEREVENT;
        }
    }

    # check if we found a valid event
    if ( !$EventType ) {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "The event $Event is not valid.",
        );
    }

    # ------------------------------------------------------------ #
    # subaction Change: load webservice and show edit screen
    # ------------------------------------------------------------ #
    if ( $Self->{Subaction} eq 'Add' || $Self->{Subaction} eq 'Change' ) {

        return $Self->_ShowEdit(
            %Param,
            WebserviceID                => $WebserviceID,
            WebserviceName              => $WebserviceName,
            Invoker                     => $Invoker,
            InvokerType                 => $InvokerType,
            InvokerTypeFrontendModule   => $InvokerTypeFrontendModule,
            InvokerEventFrontendModule  => $InvokerEventFrontendModule,
            Event                       => $Event,
            EventType                   => $EventType,
            Condition                   => $Condition,
            Subaction                   => 'Change',
        );
    }

    # ------------------------------------------------------------ #
    # subaction ChangeAction: write config and return to overview
    # ------------------------------------------------------------ #
    elsif ( $Self->{Subaction} eq 'ChangeAction' ) {

        # challenge token check for write action
        $Self->{LayoutObject}->ChallengeTokenCheck();

        # get parameter from web browser
        my $GetParam = $Self->_GetParams();

        # if there is an error return to edit screen
        if ( $GetParam->{Error} ) {
            return $Self->_ShowEdit(
                %Param,
                WebserviceID                => $WebserviceID,
                WebserviceName              => $WebserviceName,
                Invoker                     => $Invoker,
                InvokerType                 => $InvokerType,
                InvokerTypeFrontendModule   => $InvokerTypeFrontendModule,
                InvokerEventFrontendModule  => $InvokerEventFrontendModule,
                Event                       => $Event,
                EventType                   => $EventType,
                Condition                   => $Condition,
                Subaction                   => 'Change',
            );
        }

        my %NewCondition = (
            Condition => $GetParam->{Config},
        );

        # This map statement loops through the Array of Hashes of
        # @{ $WebserviceData->{Config}->{Requester}->{Invoker}->{$Invoker}->{Events} }
        # 
        # If it drops over the array containing the HashKeys "Event" and this Key equals
        # $Event, it takes the Original Hash and extends the keys by the keys of %NewCondition
        #
        # If it doesn't match $Event it takes the original unchanged HashRef
        #
        # (e.g. just extending one single hash of all existing hashes inside the Events Array)
        @{ $WebserviceData->{Config}->{Requester}->{Invoker}->{$Invoker}->{Events} } = 
            map { 
                    ( $_->{Event} eq $Event )? 
                        { %{ $_ }, %NewCondition }: 
                        $_ 
                } 
                @{ $WebserviceData->{Config}->{Requester}->{Invoker}->{$Invoker}->{Events} };

        # otherwise save configuration and return to overview screen
        my $Success = $Self->{WebserviceObject}->WebserviceUpdate(
            ID      => $WebserviceID,
            Name    => $WebserviceData->{Name},
            Config  => $WebserviceData->{Config},
            ValidID => $WebserviceData->{ValidID},
            UserID  => $Self->{UserID},
        );

        # check for successful web service update
        if ( !$Success ) {
            return $Self->{LayoutObject}->ErrorScreen(
                Message => "Could not update configuration data for WebserviceID $WebserviceID",
            );
        }

        # save and finish button: go to Webservice.
        if ( $Self->{ParamObject}->GetParam( Param => 'ReturnToAction' ) ) {
            my $RedirectURL
                = "Action=$InvokerTypeFrontendModule;Subaction=Change;Invoker=$Invoker;"
                . "WebserviceID=$WebserviceID;";

            return $Self->{LayoutObject}->Redirect(
                OP => $RedirectURL,
            );
        }

        # recreate structure for edit
        $Condition = $NewCondition{Condition};

        # check if stay on mapping screen or redirect to prev screen
        return $Self->_ShowEdit(
            %Param,
            WebserviceID                => $WebserviceID,
            WebserviceName              => $WebserviceName,
            Invoker                     => $Invoker,
            InvokerType                 => $InvokerType,
            InvokerTypeFrontendModule   => $InvokerTypeFrontendModule,
            InvokerEventFrontendModule  => $InvokerEventFrontendModule,
            Event                       => $Event,
            EventType                   => $EventType,
            Condition                   => $Condition,
            Subaction                   => 'Change',
        );
    }

    # ------------------------------------------------------------ #
    # Error
    # ------------------------------------------------------------ #
    else {
        return $Self->{LayoutObject}->ErrorScreen(
            Message => "This subaction is not valid",
        );
    }
}

sub _ShowEdit {
    my ( $Self, %Param ) = @_;

    # get Condition information
    my $ConditionData = $Param{Condition} || {};

    # set action for go back button
    $Param{LowerCaseActionType} = lc 'Invoker';

    my $Output = $Self->{LayoutObject}->Header();
    $Output .= $Self->{LayoutObject}->NavigationBar();

    my %Error;
    if ( defined $Param{WebserviceData}->{Error} ) {
        %Error = %{ $Param{WebserviceData}->{Error} };
    }
    $Param{DeletedString} = $Self->{DeletedString};

    $Param{FreshConditionLinking} = $Self->{LayoutObject}->BuildSelection(
        Data => [ 'and', 'or', 'xor' ],
        Name => "ConditionLinking[_INDEX_]",
        Sort => 'AlphanumericKey',
        Translation => 1,
        Class       => 'W50pc',
    );

    $Param{FreshConditionFieldType} = $Self->{LayoutObject}->BuildSelection(
        Data => {
            'String' => 'String',

# disable hash and array selection here, because there is no practical way to enter the needed data in the GUI
# TODO: implement a possibility to enter the data in a correct way in the GUI
#'Hash'   => 'Hash',
#'Array'  => 'Array',
            'Regexp' => 'Regexp',
            'Module' => 'Transition Validation Module'
        },
        SelectedID  => 'String',
        Name        => "ConditionFieldType[_INDEX_][_FIELDINDEX_]",
        Sort        => 'AlphanumericKey',
        Translation => 1,
    );

    if ( 
        defined $Param{Subaction} 
        && $Param{Subaction} eq 'Change' 
        && IsHashRefWithData($Param{Condition}) 
        && IsHashRefWithData($Param{Condition}->{Condition}) 
        && IsStringWithData($Param{Condition}->{ConditionLinking})
    ) {

        $Param{OverallConditionLinking} = $Self->{LayoutObject}->BuildSelection(
            Data => [ 'and', 'or', 'xor' ],
            Name => 'OverallConditionLinking',
            ID   => 'OverallConditionLinking',
            Sort => 'AlphanumericKey',
            Translation => 1,
            Class       => 'W50pc',
            SelectedID  => $ConditionData->{ConditionLinking},
        );

        my @Conditions = sort keys %{ $ConditionData->{Condition} };

        for my $Condition (@Conditions) {

            my %ConditionData = %{ $ConditionData->{Condition}->{$Condition} };

            my $ConditionLinking = $Self->{LayoutObject}->BuildSelection(
                Data => [ 'and', 'or', 'xor' ],
                Name => "ConditionLinking[$Condition]",
                Sort => 'AlphanumericKey',
                Translation => 1,
                Class       => 'W50pc',
                SelectedID  => $ConditionData{Type},
            );

            $Self->{LayoutObject}->Block(
                Name => 'ConditionItemEditRow',
                Data => {
                    ConditionLinking => $ConditionLinking,
                    Index            => $Condition,
                },
            );

            my @Fields = sort keys %{ $ConditionData{Fields} };
            for my $Field (@Fields) {

                my %FieldData          = %{ $ConditionData{Fields}->{$Field} };
                my $ConditionFieldType = $Self->{LayoutObject}->BuildSelection(
                    Data => {
                        'String' => 'String',

# disable hash and array selection here, because there is no practical way to enter the needed data in the GUI
# TODO: implement a possibility to enter the data in a correct way in the GUI
#'Hash'   => 'Hash',
#'Array'  => 'Array',
                        'Regexp' => 'Regexp',
                        'Module' => 'Transition Validation Module'
                    },
                    Name        => "ConditionFieldType[$Condition][$Field]",
                    Sort        => 'AlphanumericKey',
                    Translation => 1,
                    SelectedID  => $FieldData{Type},
                );

                # show fields
                $Self->{LayoutObject}->Block(
                    Name => "ConditionItemEditRowField",
                    Data => {
                        Index              => $Condition,
                        FieldIndex         => $Field,
                        ConditionFieldType => $ConditionFieldType,
                        %FieldData,
                    },
                );
            }
        }
    }
    else {

        $Param{OverallConditionLinking} = $Self->{LayoutObject}->BuildSelection(
            Data => [ 'and', 'or', 'xor' ],
            Name => 'OverallConditionLinking',
            ID   => 'OverallConditionLinking',
            Sort => 'AlphanumericKey',
            Translation => 1,
            Class       => 'W50pc',
        );

        $Param{ConditionLinking} = $Self->{LayoutObject}->BuildSelection(
            Data => [ 'and', 'or', 'xor' ],
            Name => 'ConditionLinking[_INDEX_]',
            Sort => 'AlphanumericKey',
            Translation => 1,
            Class       => 'W50pc',
        );

        $Param{ConditionFieldType} = $Self->{LayoutObject}->BuildSelection(
            Data => {
                'String' => 'String',

# disable hash and array selection here, because there is no practical way to enter the needed data in the GUI
# TODO: implement a possibility to enter the data in a correct way in the GUI
#'Hash'   => 'Hash',
#'Array'  => 'Array',
                'Regexp' => 'Regexp',
                'Module' => 'Transition Validation Module'
            },
            Name        => 'ConditionFieldType[_INDEX_][_FIELDINDEX_]',
            Sort        => 'AlphanumericKey',
            Translation => 1,
            SelectedID  => 'String',
        );

        $Self->{LayoutObject}->Block(
            Name => 'ConditionItemInitRow',
            Data => {
                %Param,
            },
        );
    }

    $Output .= $Self->{LayoutObject}->Output(
        TemplateFile => $Param{InvokerEventFrontendModule},
        Data         => {
            %Param,
            %{$ConditionData},
        },
    );

    $Output .= $Self->{LayoutObject}->Footer();

    return $Output;
}

sub _GetParams {
    my ( $Self, %Param ) = @_;

    my $GetParam;

    # get parameters from web browser
    $GetParam->{Name} = $Self->{ParamObject}->GetParam( Param => 'Name' ) || '';
    $GetParam->{ConditionConfig} = $Self->{ParamObject}->GetParam( Param => 'ConditionConfig' )
        || '';

    my $Config = $Self->{JSONObject}->Decode(
        Data => $GetParam->{ConditionConfig}
    );
    $GetParam->{Config} = {};
    $GetParam->{Config}->{Condition} = $Config;
    $GetParam->{Config}->{ConditionLinking}
        = $Self->{ParamObject}->GetParam( Param => 'OverallConditionLinking' ) || '';

    return $GetParam;
}

1;

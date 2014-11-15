# --
# Kernel/GenericInterface/Event/Handler.pm - event handler module for the GenericInterface
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::GenericInterface::Event::Handler;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(IsHashRefWithData);

our @ObjectDependencies = (
    'Kernel::GenericInterface::Requester',
    'Kernel::System::Scheduler',
    'Kernel::System::GenericInterface::Webservice',
    'Kernel::System::Log',
    'Kernel::System::Event',
);

=head1 NAME

Kernel::GenericInterface::Event::Handler - GenericInterface event handler

=head1 SYNOPSIS

This event handler intercepts all system events and fires connected GenericInterface
invokers.

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Data Event Config)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')
                ->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    # get webservice objects
    my $WebserviceObject = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice');

    my %WebserviceList = %{
        $WebserviceObject->WebserviceList(
            Valid => 1,
        ),
    };

    # loop over webservices
    WEBSERVICE:
    for my $WebserviceID ( sort keys %WebserviceList ) {

        my $WebserviceData = $WebserviceObject->WebserviceGet(
            ID => $WebserviceID,
        );

        next WEBSERVICE if !IsHashRefWithData( $WebserviceData->{Config} );
        next WEBSERVICE if !IsHashRefWithData( $WebserviceData->{Config}->{Requester} );
        next WEBSERVICE if !IsHashRefWithData( $WebserviceData->{Config}->{Requester}->{Invoker} );

        # check invokers of the webservice, to see if some might be connected to this event
        INVOKER:
        for my $Invoker ( sort keys %{ $WebserviceData->{Config}->{Requester}->{Invoker} } ) {

            my $InvokerConfig = $WebserviceData->{Config}->{Requester}->{Invoker}->{$Invoker};

            next INVOKER if ref $InvokerConfig->{Events} ne 'ARRAY';

            EVENT:
            for my $Event ( @{ $InvokerConfig->{Events} } ) {

                next EVENT if ref $Event ne 'HASH';

                # check if the invoker is connected to this event
                if ( $Event->{Event} eq $Param{Event} ) {

                    # get list of all registered events
                    my %RegisteredEvents = $Kernel::OM->Get('Kernel::System::Event')->EventList();

                    # prepare event type
                    my $EventType;

                    # set the event type (event object like Article or Ticket) and event condition
                    EVENTTYPE:
                    for my $Type ( sort keys %RegisteredEvents ) {

                        if ( grep { $_ eq $Event->{Event} } @{ $RegisteredEvents{$Type} || [] } ) {

                            $EventType = $Type;

                            last EVENTTYPE;
                        }
                    }

                    # check if we found a valid event
                    if ( !$EventType ) {
                        return $Self->{LayoutObject}->ErrorScreen(
                            Message => "The event $Event is not valid.",
                        );
                    }

                    # get object data
                    my %ObjectData = $Kernel::OM->Get('Kernel::GenericInterface::Event::' . $EventType)->DataGet(
                        Data => $Param{Data},
                    );

                    # Set check result to 1, so invokers are executed
                    #   if there is no conditon configured.
                    my $ConditionCheckResult = 1;

                    # Check if condition is available and has data
                    if ( $Event->{Condition} && IsHashRefWithData( $Event->{Condition} ) ) {

                        # check if the event condition matches
                        $ConditionCheckResult = $Self->_ConditionCheck(
                            Condition => $Event->{Condition},
                            Data      => \%ObjectData,
                        );
                    }

                    next EVENT if ref $ConditionCheckResult ne 1;

                    # create a scheduler task for later execution
                    if ( $Event->{Asynchronous} ) {

                        my $TaskID = $Kernel::OM->Get('Kernel::System::Scheduler')->TaskRegister(
                            Type => 'GenericInterface',
                            Data => {
                                WebserviceID => $WebserviceID,
                                Invoker      => $Invoker,
                                Data         => $Param{Data},
                            },
                        );

                    }
                    else {    # or execute Event directly

                        $Kernel::OM->Get('Kernel::GenericInterface::Requester')->Run(
                            WebserviceID => $WebserviceID,
                            Invoker      => $Invoker,
                            Data         => $Param{Data},
                        );
                    }
                }
            }
        }
    }

    return 1;
}

=item ConditionCheck()

    Checks if one or more conditions are true

    my $ConditionCheck = ConditionCheck(

        Condition => {
            ConditionLinking  => 'and',
            Cond1 => {
                Type   => 'and',
                Fields => {
                    DynamicField_Make    => [ '2' ],
                    DynamicField_VWModel => {
                        Type  => 'String',
                        Match => 'Golf',
                    },
                    DynamicField_A => {
                        Type  => 'Hash',
                        Match => {
                            Value  => 1,
                        },
                    },
                    DynamicField_B => {
                        Type  => 'Regexp',
                        Match => qr{ [\n\r\f] }xms
                    },
                    DynamicField_C => {
                        Type  => 'Module',
                        Match =>
                            'Kernel::GenericInterface::InvokerValidation::MyModule',
                    },
                    Queue =>  {
                        Type  => 'Array',
                        Match => [ 'Raw' ],
                    },
                    # ...
                }
            }
            # ...
        },

        Data => {
            Queue         => 'Raw',
            DynamicField1 => 'Value',
            Subject       => 'Testsubject',
            # ...
        },
    );

    Returns:
    $CheckResult = 1;   # 1 = process with Scheduler or Requester
                        # 0 = stop processing

=cut

sub _ConditionCheck {
    my ( $Self, %Param ) = @_;

    # Check if we have Condition and Data
    for my $Needed (qw(Condition Data)) {
        if ( !defined $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!",
            );

            return;
        }
    }

    # Check if we have Data to check against Condition
    if ( !IsHashRefWithData( $Param{Data} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Data has no values!",
        );

        return;
    }

    # Check if we have Conditon to check against Date
    if ( !IsHashRefWithData( $Param{Condition} ) ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Condition has no values!",
        );

        return;
    }

    my $ConditionLinking = $Param{Condition}->{ConditionLinking} || 'and';

    # If there is something else than 'and', 'or', 'xor'
    # log defect condition configuration
    if (
        $ConditionLinking ne 'and'
        && $ConditionLinking ne 'or'
        && $ConditionLinking ne 'xor'
        )
    {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Invalid Condition->Type!",
        );
        return;
    }
    my ( $ConditionSuccess, $ConditionFail ) = ( 0, 0 );

    # Loop through all submitted conditions
    CONDITIONLOOP:
    for my $Cond (
        sort { $a cmp $b }
        keys %{ $Param{Condition}->{Condition} }
        )
    {

        next CONDITIONLOOP if $Cond eq 'ConditionLinking';

        # get the condition
        my $ActualCondition = $Param{Condition}->{Condition}->{$Cond};

        # Check if we have Fields in our Cond
        if ( !IsHashRefWithData( $ActualCondition->{Fields} ) )
        {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "No Fields in Condition->$Cond found!",
            );
            return;
        }

        # If we don't have a Condition->$Cond->Type, set it to 'and' by default
        my $CondType = $ActualCondition->{Type} || 'and';

        # If there is something else than 'and', 'or', 'xor'
        # log defect condition configuration
        if ( $CondType ne 'and' && $CondType ne 'or' && $CondType ne 'xor' ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Invalid Condition->$Cond->Type!",
            );
            return;
        }

        my ( $FieldSuccess, $FieldFail ) = ( 0, 0 );

        FIELDLOOP:
        for my $Field ( sort keys %{ $ActualCondition->{Fields} } ) {

            # If we have just a String transform it into string check condition
            if ( ref $ActualCondition->{Fields}->{$Field} eq '' ) {
                $ActualCondition->{Fields}->{$Field} = {
                    Type  => 'String',
                    Match => $ActualCondition->{Fields}->{$Field},
                };
            }

            # If we have an Arrayref in "Fields" we deal with just values
            # -> transform it into a { Type => 'Array', Match => [1,2,3,4] } structure
            # to unify testing later on
            if ( ref $ActualCondition->{Fields}->{$Field} eq 'ARRAY' ) {
                $ActualCondition->{Fields}->{$Field} = {
                    Type  => 'Array',
                    Match => $ActualCondition->{Fields}->{$Field},
                };
            }

            # If we don't have a Condition->$Cond->Fields->Field->Type
            # set it to 'String' by default
            my $FieldType = $ActualCondition->{Fields}->{$Field}->{Type} || 'String';

            # If there is something else than 'String', 'Regexp', 'Hash', 'Array', 'Module'
            # log defect config
            if (
                $FieldType ne 'String'
                && $FieldType ne 'Hash'
                && $FieldType ne 'Array'
                && $FieldType ne 'Regexp'
                && $FieldType ne 'Module'
                )
            {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Invalid Condition->Type!",
                );
                return;
            }

            if ( $ActualCondition->{Fields}->{$Field}->{Type} eq 'String' ) {

                # if our Check contains anything else than a string we can't check
                # Special Condition: if Match contains '0' we can check
                #
                if (
                    (
                        !$ActualCondition->{Fields}->{$Field}->{Match}
                        && $ActualCondition->{Fields}->{$Field}->{Match} ne '0'
                    )
                    || ref $ActualCondition->{Fields}->{$Field}->{Match}
                    )
                {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message =>
                            "Condition->$Cond->Fields->$Field Match must"
                            . " be a String if Type is set to String!",
                    );
                    return;
                }

                # make sure the data string is here
                # and it isn't a ref (array or whatsoever)
                # then compare it to our Config
                if (
                    defined $Param{Data}->{$Field}
                    && defined $ActualCondition->{Fields}->{$Field}->{Match}
                    && ( $Param{Data}->{$Field} || $Param{Data}->{$Field} eq '0' )
                    && ref $Param{Data}->{$Field} eq ''
                    && $ActualCondition->{Fields}->{$Field}->{Match} eq $Param{Data}->{$Field}
                    )
                {
                    $FieldSuccess++;

                    # Successful check if we just need one matching Condition
                    # to make this Condition valid
                    if ( $ConditionLinking eq 'or' && $CondType eq 'or' ) {
                        return 1;
                    }

                    next CONDITIONLOOP if $ConditionLinking ne 'or' && $CondType eq 'or';
                }
                else {
                    $FieldFail++;

                    # Failed check if we have all 'and' conditions
                    if ( $ConditionLinking eq 'and' && $CondType eq 'and' ) {
                        return;
                    }

                    # Try next Cond if all Cond Fields have to be true
                    next CONDITIONLOOP if $CondType eq 'and';
                }
                next FIELDLOOP;
            }
            elsif ( $ActualCondition->{Fields}->{$Field}->{Type} eq 'Array' ) {

                # 1. go through each Condition->$Cond->Fields->$Field->Value (map)
                # 2. assign the value to $CheckValue
                # 3. grep through $Data->{$Field}
                #   to find the "toCheck" value inside the Data->{$Field} Array
                # 4. Assign all found Values to @CheckResults
                my $CheckValue;
                my @CheckResults = map {
                    $CheckValue = $_;
                    grep { $CheckValue eq $_ } @{ $Param{Data}->{$Field} }
                    }
                    @{ $ActualCondition->{Fields}->{$Field}->{Match} };

                # if the found amount is the same as the "toCheck" amount we succeeded
                if (
                    scalar @CheckResults
                    == scalar @{ $ActualCondition->{Fields}->{$Field}->{Match} }
                    )
                {
                    $FieldSuccess++;

                    # Successful check if we just need one matching Condition
                    # to make this Condition valid
                    if ( $ConditionLinking eq 'or' && $CondType eq 'or' ) {
                        return 1;
                    }

                    next CONDITIONLOOP if $ConditionLinking ne 'or' && $CondType eq 'or';
                }
                else {
                    $FieldFail++;

                    # Failed check if we have all 'and' conditions
                    if ( $ConditionLinking eq 'and' && $CondType eq 'and' ) {
                        return;
                    }

                    # Try next Cond if all Cond Fields have to be true
                    next CONDITIONLOOP if $CondType eq 'and';
                }
                next FIELDLOOP;
            }
            elsif ( $ActualCondition->{Fields}->{$Field}->{Type} eq 'Hash' ) {

                # if our Check doesn't contain a hash
                if ( ref $ActualCondition->{Fields}->{$Field}->{Match} ne 'HASH' ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message =>
                            "Condition->$Cond->Fields->$Field Match must"
                            . " be a Hash!",
                    );
                    return;
                }

                # If we have no data or Data isn't a hash, test failed
                if (
                    !$Param{Data}->{$Field}
                    || ref $Param{Data}->{$Field} ne 'HASH'
                    )
                {
                    $FieldFail++;
                    next FIELDLOOP;
                }

                # Find all Data Hash values that equal to the Condition Match Values
                my @CheckResults = grep {
                    $Param{Data}->{$Field}->{$_} eq
                        $ActualCondition->{Fields}->{$Field}->{Match}->{$_}
                } keys %{ $ActualCondition->{Fields}->{$Field}->{Match} };

                # If the amount of Results equals the amount of Keys in our hash
                # this part matched
                if (
                    scalar @CheckResults
                    == scalar keys %{ $ActualCondition->{Fields}->{$Field}->{Match} }
                    )
                {

                    $FieldSuccess++;

                    # Successful check if we just need one matching Condition
                    # to make this condition valid
                    if ( $ConditionLinking eq 'or' && $CondType eq 'or' ) {
                        return 1;
                    }

                    next CONDITIONLOOP if $ConditionLinking ne 'or' && $CondType eq 'or';

                }
                else {
                    $FieldFail++;

                    # Failed check if we have all 'and' conditions
                    if ( $ConditionLinking eq 'and' && $CondType eq 'and' ) {
                        return;
                    }

                    # Try next Cond if all Cond Fields have to be true
                    next CONDITIONLOOP if $CondType eq 'and';
                }
                next FIELDLOOP;
            }
            elsif ( $ActualCondition->{Fields}->{$Field}->{Type} eq 'Regexp' )
            {

                # if our Check contains anything else then a string we can't check
                if (
                    !$ActualCondition->{Fields}->{$Field}->{Match}
                    ||
                    (
                        ref $ActualCondition->{Fields}->{$Field}->{Match} ne 'Regexp'
                        && ref $ActualCondition->{Fields}->{$Field}->{Match} ne ''
                    )
                    )
                {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message =>
                            "Condition->$Cond->Fields->$Field Match must"
                            . " be a Regular expression if Type is set to Regexp!",
                    );
                    return;
                }

                # precompile Regexp if is a string
                if ( ref $ActualCondition->{Fields}->{$Field}->{Match} eq '' ) {
                    my $Match = $ActualCondition->{Fields}->{$Field}->{Match};

                    eval {
                        $ActualCondition->{Fields}->{$Field}->{Match} = qr{$Match};
                    };
                    if ($@) {
                        $Kernel::OM->Get('Kernel::System::Log')->Log(
                            Priority => 'error',
                            Message  => $@,
                        );
                        return;
                    }
                }

                # make sure the data string is here
                # and it is of ref Regexp
                # then compare validate it
                if (
                    $Param{Data}->{$Field}
                    && ref $Param{Data}->{$Field} eq ''
                    && $Param{Data}->{$Field} =~ $ActualCondition->{Fields}->{$Field}->{Match}
                    )
                {
                    $FieldSuccess++;

                    # Successful check if we just need one matching Condition
                    # to make this Condition valid
                    if ( $ConditionLinking eq 'or' && $CondType eq 'or' ) {
                        return 1;
                    }

                    next CONDITIONLOOP if $ConditionLinking ne 'or' && $CondType eq 'or';
                }
                else {
                    $FieldFail++;

                    # Failed check if we have all 'and' conditions
                    if ( $ConditionLinking eq 'and' && $CondType eq 'and' ) {
                        return;
                    }

                    # Try next Cond if all Cond Fields have to be true
                    next CONDITIONLOOP if $CondType eq 'and';
                }
                next FIELDLOOP;
            }
            elsif ( $ActualCondition->{Fields}->{$Field}->{Type} eq 'Module' ) {

                # Load Validation Modules
                # Default location for validation modules:
                # Kernel/GenericInterface/Event/Validation/
                if ( 
                        !$Kernel::OM->Get('Kernel::System::Main')->Require(
                            'Kernel::GenericInterface::Event::Validation::' 
                            . $ActualCondition->{Fields}->{$Field}->{Match} 
                        )
                    )
                {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message  => "Can't load "
                            . $ActualCondition->{Fields}->{$Field}->{Type}
                            . "Module for Condition->$Cond->Fields->$Field validation!",
                    );
                    return;
                }

                # create new ValidateModuleObject
                my $ValidateModuleObject = $Kernel::OM->Get(
                    'Kernel::GenericInterface::Event::Validation::' 
                    . $ActualCondition->{Fields}->{$Field}->{Match} 
                );

                # handle "Data" Param to ValidateModule's "Validate" subroutine
                if ( $ValidateModuleObject->Validate( Data => $Param{Data} ) ) {
                    $FieldSuccess++;

                    # Successful check if we just need one matching Condition
                    # to make this Condition valid
                    if ( $ConditionLinking eq 'or' && $CondType eq 'or' ) {
                        return 1;
                    }

                    next CONDITIONLOOP if $ConditionLinking ne 'or' && $CondType eq 'or';
                }
                else {
                    $FieldFail++;

                    # Failed check if we have all 'and' conditions
                    if ( $ConditionLinking eq 'and' && $CondType eq 'and' ) {
                        return;
                    }

                    # Try next Cond if all Cond Fields have to be true
                    next CONDITIONLOOP if $CondType eq 'and';
                }
                next FIELDLOOP;
            }
        }

        # FIELDLOOP END
        if ( $CondType eq 'and' ) {

            # if we had no failing check this condition matched
            if ( !$FieldFail ) {

                # Successful check if we just need one matching Condition
                # to make this Condition valid
                if ( $ConditionLinking eq 'or' ) {
                    return 1;
                }
                $ConditionSuccess++;
            }
            else {
                $ConditionFail++;

                # Failed check if we have all 'and' conditions
                if ( $ConditionLinking eq 'and' ) {
                    return;
                }
            }
        }
        elsif ( $CondType eq 'or' )
        {

            # if we had at least one successful check, this condition matched
            if ( $FieldSuccess > 0 ) {

                # Successful check if we just need one matching Condition
                # to make this Condition valid
                if ( $ConditionLinking eq 'or' ) {
                    return 1;
                }
                $ConditionSuccess++;
            }
            else {
                $ConditionFail++;

                # Failed check if we have all 'and' conditions
                if ( $ConditionLinking eq 'and' ) {
                    return;
                }
            }
        }
        elsif ( $CondType eq 'xor' )
        {

            # if we had exactly one successful check, this condition matched
            if ( $FieldSuccess == 1 ) {

                # Successful check if we just need one matching Condition
                # to make this Condition valid
                if ( $ConditionLinking eq 'or' ) {
                    return 1;
                }
                $ConditionSuccess++;
            }
            else {
                $ConditionFail++;
            }
        }
    }

    # CONDITIONLOOP END
    if ( $ConditionLinking eq 'and' ) {

        # if we had no failing conditions this Condition matched
        if ( !$ConditionFail ) {
            return 1;
        }
    }
    elsif ( $ConditionLinking eq 'or' )
    {

        # if we had at least one successful condition, this condition matched
        if ( $ConditionSuccess > 0 ) {
            return 1;
        }
    }
    elsif ( $ConditionLinking eq 'xor' )
    {

        # if we had exactly one successful condition, this conditoion matched
        if ( $ConditionSuccess == 1 ) {
            return 1;
        }
    }

    # If no condition matched till here, we failed
    return;

}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

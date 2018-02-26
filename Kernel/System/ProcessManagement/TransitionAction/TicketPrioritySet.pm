# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::ProcessManagement::TransitionAction::TicketPrioritySet;

use strict;
use warnings;
use utf8;

use Kernel::System::VariableCheck qw(:all);

use parent qw(Kernel::System::ProcessManagement::TransitionAction::Base);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Ticket',
);

=head1 NAME

Kernel::System::ProcessManagement::TransitionAction::TicketPrioritySet - A Module to set the type of a Ticket

=head1 DESCRIPTION

All TicketPrioritySet functions.

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $TicketPrioritySetObject = $Kernel::OM->Get('Kernel::System::ProcessManagement::TransitionAction::TicketPrioritySet');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 Run()

    Run Data

    my $TicketPrioritySetResult = $TicketPrioritySetActionObject->Run(
        UserID                   => 123,
        Ticket                   => \%Ticket,   # required
        ProcessEntityID          => 'P123',
        ActivityEntityID         => 'A123',
        TransitionEntityID       => 'T123',
        TransitionActionEntityID => 'TA123',
        Config                   => {
            Priority => 'Default',
            # or
            PriorityID => 1,
            UserID => 123,                      # optional, to override the UserID from the logged user

        }
    );
    Ticket contains the result of TicketGet including DynamicFields
    Config is the Config Hash stored in a Process::TransitionAction's  Config key
    Returns:

    $TicketPrioritySetResult = 1; # 0

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # define a common message to output in case of any error
    my $CommonMessage = "Process: $Param{ProcessEntityID} Activity: $Param{ActivityEntityID}"
        . " Transition: $Param{TransitionEntityID}"
        . " TransitionAction: $Param{TransitionActionEntityID} - ";

    # check for missing or wrong params
    my $Success = $Self->_CheckParams(
        %Param,
        CommonMessage => $CommonMessage,
    );
    return if !$Success;

    # override UserID if specified as a parameter in the TA config
    $Param{UserID} = $Self->_OverrideUserID(%Param);

    # use ticket attributes if needed
    $Self->_ReplaceTicketAttributes(%Param);

    if ( !$Param{Config}->{PriorityID} && !$Param{Config}->{Priority} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $CommonMessage . "No Priority or PriorityID configured!",
        );
        return;
    }

    $Success = 0;

    if (
        defined $Param{Config}->{Priority}
        && $Param{Config}->{Priority} ne $Param{Ticket}->{Priority}
        )
    {
        $Success = $Kernel::OM->Get('Kernel::System::Ticket')->TicketPrioritySet(
            Priority     => $Param{Config}->{Priority},
            TicketID => $Param{Ticket}->{TicketID},
            UserID   => $Param{UserID},
        );
    }
    elsif (
        defined $Param{Config}->{PriorityID}
        && $Param{Config}->{PriorityID} ne $Param{Ticket}->{PriorityID}
        )
    {
        $Success = $Kernel::OM->Get('Kernel::System::Ticket')->TicketPrioritySet(
            PriorityID   => $Param{Config}->{PriorityID},
            TicketID => $Param{Ticket}->{TicketID},
            UserID   => $Param{UserID},
        );
    }
    else {

        # data is the same as in ticket nothing to do
        $Success = 1;
    }

    if ( !$Success ) {
        my $CustomMessage;
        if ( defined $Param{Config}->{Priority} ) {
            $CustomMessage = "Priority: $Param{Config}->{Priority},";
        }
        else {
            $CustomMessage = "PriorityID: $Param{Config}->{PriorityID},";
        }
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $CommonMessage
                . 'Ticket priority could not be updated to '
                . $CustomMessage
                . ' for Ticket: '
                . $Param{Ticket}->{TicketID} . '!',
        );
        return;
    }

    return 1;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

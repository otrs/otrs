# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Ticket::Event::LockAfterCreate;

use strict;
use warnings;
our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::Ticket',
);

sub new {
    my ( $Type, %Param ) = @_;

    # Allocate new hash for object.
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # Check needed stuff.
    for (qw(Data Event Config)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $_!"
            );
            return;
        }
    }
    if ( !$Param{Data}->{TicketID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need $_ in Data!"
        );
        return;
    }

    # Check ticket NewUserID.
    return 1 if ( $Param{Data}->{NewUserID} );

    # Check ticket source.
    return 1 if ( $Param{Data}->{Source} ne $Param{Config}->{Source} );

    # Get ticket object.
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    my %Ticket = $TicketObject->TicketGet(
        TicketID      => $Param{Data}->{TicketID},
        UserID        => $Param{UserID},
        DynamicFields => 0,
    );

    # If ticket closed,return 1.
    return 1 if ( $Ticket{State} =~ /^close/i );

    # If ticket locked ,return 1.
    return 1 if ( lc $Ticket{Lock} ne 'unlock' );

    # Set lock.
    $TicketObject->TicketLockSet(
        TicketID => $Param{Data}->{TicketID},
        Lock     => 'lock',
        UserID   => $Param{UserID},
    );
    return 1;
}

1;

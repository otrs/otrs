# --
# Kernel/System/Console/Command/Maint/Ticket/UnlockAll.pm - console command
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Console::Command::Maint::Ticket::UnlockAll;

use strict;
use warnings;

use base qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::Lock',
    'Kernel::System::Ticket',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Unlock all tickets by force.');

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Unlocking all tickets...</yellow>\n");

    my @ViewableLockIDs = $Kernel::OM->Get('Kernel::System::Lock')->LockViewableLock( Type => 'ID' );

    my @Tickets;
    $Kernel::OM->Get('Kernel::System::DB')->Prepare(
        SQL => "
            SELECT st.tn, st.id
            FROM ticket st
            WHERE st.ticket_lock_id NOT IN ( ${\(join ', ', @ViewableLockIDs)} ) ",
    );

    while ( my @Row = $Kernel::OM->Get('Kernel::System::DB')->FetchrowArray() ) {
        push @Tickets, \@Row;
    }
    for (@Tickets) {
        my @Row = @{$_};
        $Self->Print(" Unlocking ticket id $Row[0]... ");
        my $Unlock = $Kernel::OM->Get('Kernel::System::Ticket')->LockSet(
            TicketID => $Row[1],
            Lock     => 'unlock',
            UserID   => 1,
        );
        if ($Unlock) {
            $Self->Print("<green>done.</green>\n");
        }
        else {
            $Self->Print("<red>failed.</red>\n");
        }
    }
    $Self->Print("<green>Done.</green>\n");
    return $Self->ExitCodeOk();
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

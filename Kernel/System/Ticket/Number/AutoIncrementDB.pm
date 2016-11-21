# --
# Copyright (C) 2016 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# Based on AutoIncrement.pm by OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

#
# Generates autoincremented ticket numbers (like 1010138, 1010139, ...).
# Counter is being stored in DB.
# --

package Kernel::System::Ticket::Number::AutoIncrementDB;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::Ticket',
    'Kernel::System::Counter',
);

sub new {
    my ($Type) = @_;

    my $Self = {};
    return bless( $Self, $Type );
}

sub TicketCreateNumber {
    my ( $Self, $JumpCounter ) = @_;

    if ( !$JumpCounter ) {
        $JumpCounter = 0;
    }

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');
    my $CounterObject = $Kernel::OM->Get('Kernel::System::Counter');

    # get needed config options
    my $CounterLog = $ConfigObject->Get('Ticket::CounterLog');
    my $SystemID = $ConfigObject->Get('SystemID');
    my $MinSize = $ConfigObject->Get('Ticket::NumberGenerator::AutoIncrement::MinCounterSize')
        || $ConfigObject->Get('Ticket::NumberGenerator::MinCounterSize')
        || 5;

    # get next TicketNumber counter value for new ticket
    my $Count = $CounterObject->IncrementAndGet(
        CounterName => 'TicketNumber',
        Value => 1 + $JumpCounter,
        UserID => 1,
    );

    # abort if counter value cannot be obtained
    return if !defined $Count;

    # pad ticket number with leading '0' to length $MinSize (config option)
    $Count = sprintf "%.*u", $MinSize, $Count;

    # create new ticket number
    my $Tn = $SystemID . $Count;

    # Check ticket number. If exists generate new one!
    if ( $Kernel::OM->Get('Kernel::System::Ticket')->TicketCheckNumber( Tn => $Tn ) ) {

        $Self->{LoopProtectionCounter}++;

        if ( $Self->{LoopProtectionCounter} >= 16000 ) {

            # loop protection
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "CounterLoopProtection is now $Self->{LoopProtectionCounter}!"
                    . " Stopped TicketCreateNumber()!",
            );
            return;
        }

        # create new ticket number again
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => "Tn ($Tn) exists! Creating a new one.",
        );

        $Tn = $Self->TicketCreateNumber( $Self->{LoopProtectionCounter} );
    }

    return $Tn;
}

sub GetTNByString {
    my ( $Self, $String ) = @_;

    if ( !$String ) {
        return;
    }

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # get needed config options
    my $CheckSystemID = $ConfigObject->Get('Ticket::NumberGenerator::CheckSystemID');
    my $SystemID      = '';

    if ($CheckSystemID) {
        $SystemID = $ConfigObject->Get('SystemID');
    }

    my $TicketHook        = $ConfigObject->Get('Ticket::Hook');
    my $TicketHookDivider = $ConfigObject->Get('Ticket::HookDivider');
    my $MinSize           = $ConfigObject->Get('Ticket::NumberGenerator::AutoIncrement::MinCounterSize')
        || $ConfigObject->Get('Ticket::NumberGenerator::MinCounterSize')
        || 5;
    my $MaxSize = $MinSize + 5;

    # check ticket number
    if ( $String =~ /\Q$TicketHook$TicketHookDivider\E($SystemID\d{$MinSize,$MaxSize})/i ) {
        return $1;
    }

    if ( $String =~ /\Q$TicketHook\E:\s{0,2}($SystemID\d{$MinSize,$MaxSize})/i ) {
        return $1;
    }

    return;
}

1;

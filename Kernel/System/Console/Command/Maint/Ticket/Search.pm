# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Console::Command::Maint::Ticket::Search;

use strict;
use warnings;

use base qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Search Tickets.');
    $Self->AddOption(
        Name        => 'count',
        Description => "Count matching tickets.",
        Required    => 0,
        HasValue    => 0,
    );
    $Self->AddOption(
        Name        => 'userid',
        Description => "Search for UserID (Default: 1).",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+$/smx,
    );
    $Self->AddOption(
        Name        => 'limit',
        Description => "Maximum number of results.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+$/smx,
    );
    $Self->AddOption(
        Name        => 'title',
        Description => "Ticket title.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^.*$/smx,
    );
    $Self->AddOption(
        Name        => 'ticketnum',
        Description => "Ticket number.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^(\d|\*|%)+(,(\d|\*|%)+)*$/smx,
    );
    $Self->AddOption(
        Name        => 'queues',
        Description => "Queus to search in.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^.*$/smx,
    );
    $Self->AddOption(
        Name        => 'queueids',
        Description => "Queue-IDs to search in.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+(,\d+)*$/smx,
    );
    $Self->AddOption(
        Name        => 'subqueues',
        Description => "Also search in Subqueues.",
        Required    => 0,
        HasValue    => 0,
    );
    $Self->AddOption(
        Name        => 'states',
        Description => "States to search for.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^.*$/smx,
    );
    $Self->AddOption(
        Name        => 'stateids',
        Description => "StateIDs to search for.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+(,\d+)*$/smx,
    );
    $Self->AddOption(
        Name        => 'statetypes',
        Description => "Statetypes to search for.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^.*$/smx,
    );
    $Self->AddOption(
        Name        => 'statetypeids',
        Description => "StateTypeIDs to search for.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+(,\d+)*$/smx,
    );
    $Self->AddOption(
        Name        => 'priorityids',
        Description => "Priority-IDs to search for.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+(,\d+)*$/smx,
    );
    $Self->AddOption(
        Name        => 'locks',
        Description => "Locks to search for.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^.*$/smx,
    );
    $Self->AddOption(
        Name        => 'lockids',
        Description => "Lock-IDs to search for.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+(,\d+)*$/smx,
    );
 
    return;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    $Self->{ResultType} = 'ARRAY';
    if ( defined $Self->GetOption('count') ) {
        $Self->{ResultType} = 'COUNT';
    }
    if ( defined $Self->GetOption('userid') ) {
        $Self->{UserID} = $Self->GetOption('userid');
    }
    else {
        $Self->{UserID} = 1;
    }
    $Self->{Limit} = $Self->GetOption('limit');
    if ( defined $Self->GetOption('ticketnum') ) {
        my @ticketnum = split(',', $Self->GetOption('ticketnum'));
        $Self->{TicketNumber} = \@ticketnum;
    }
    $Self->{Title} = $Self->GetOption('title');
    if ( defined $Self->GetOption('queues') ) {
        my @queues = split(',', $Self->GetOption('queues'));
        $Self->{Queues} = \@queues;
    }
    if ( defined $Self->GetOption('queueids') ) {
        my @queueids = split(',', $Self->GetOption('queueids'));
        $Self->{QueueIDs} = \@queueids;
    }
    $Self->{UseSubQueues} = $Self->GetOption('subqueues');
    if ( defined $Self->GetOption('states') ) {
        my @states = split(',', $Self->GetOption('states'));
        $Self->{States} = \@states;
    }
    if ( defined $Self->GetOption('stateids') ) {
        my @stateids = split(',', $Self->GetOption('stateids'));
        $Self->{StateIDs} = \@stateids;
    }
    if ( defined $Self->GetOption('statetypes') ) {
        my @statetype = split(',', $Self->GetOption('statetypes'));
        $Self->{StateType} = \@statetype;
    }
    if ( defined $Self->GetOption('statetypeids') ) {
        my @statetypeids = split(',', $Self->GetOption('statetypeids'));
        $Self->{StateTypeIDs} = \@statetypeids;
    }
    if ( defined $Self->GetOption('priorityids') ) {
        my @priorityids = split(',', $Self->GetOption('priorityids'));
        $Self->{PriorityIDs} = \@priorityids;
    }
    if ( defined $Self->GetOption('locks') ) {
        my @locks = split(',', $Self->GetOption('locks'));
        $Self->{Locks} = \@locks;
    }
    if ( defined $Self->GetOption('lockids') ) {
        my @lockids = split(',', $Self->GetOption('lockids'));
        $Self->{LockIDs} = \@lockids;
    }

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Searching for Tickets...</yellow>\n");

    my @result = $Kernel::OM->Get('Kernel::System::Ticket')->TicketSearch(
        Result          => $Self->{ResultType},
        Limit           => $Self->{Limit},
        UserID          => $Self->{UserID},
        TicketNumber    => $Self->{TicketNumber},
        Title           => $Self->{Title},
        Queues          => $Self->{Queues},
        QueueIDs        => $Self->{QueueIDs},
        UseSubQueues    => $Self->{UseSubQueues},
        States          => $Self->{States},
        StateIDs        => $Self->{StateIDs},
        StateType       => $Self->{StateType},
        StateTypeIDs    => $Self->{StateTypeIDs},
        PriorityIDs     => $Self->{PriorityIDs},
        Locks           => $Self->{Locks},
        LockIDs         => $Self->{LockIDs},
    );

    if ( $Self->{ResultType} eq 'COUNT' ) {
        $Self->Print(" Number of matching tickets: ".$result[0]."\n");
    }
    else {
        if ( !@result ) {
            $Self->Print("<red>No results.</red>\n");
        }
        else {
            $Self->Print(" ".join("\n ", @result)."\n");
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

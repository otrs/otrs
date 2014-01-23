# --
# Kernel/System/Ticket/IndexAccelerator/RuntimeDB.pm - realtime database
# queue ticket index module
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Ticket::IndexAccelerator::RuntimeDB;

use strict;
use warnings;

sub TicketAcceleratorUpdate {
    my ( $Self, %Param ) = @_;

    return 1;
}

sub TicketAcceleratorDelete {
    my ( $Self, %Param ) = @_;

    return 1;
}

sub TicketAcceleratorAdd {
    my ( $Self, %Param ) = @_;

    return 1;
}

sub TicketAcceleratorIndex {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(UserID QueueID ShownQueueIDs)) {
        if ( !exists( $Param{$_} ) ) {
            $Self->{LogObject}->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    # db quote
    for (qw(UserID)) {
        $Param{$_} = $Self->{DBObject}->Quote( $Param{$_}, 'Integer' );
    }

    # get user groups
    my $Type             = 'rw';
    my $AgentTicketQueue = $Self->{ConfigObject}->Get('Ticket::Frontend::AgentTicketQueue');
    if (
        $AgentTicketQueue
        && ref $AgentTicketQueue eq 'HASH'
        && $AgentTicketQueue->{ViewAllPossibleTickets}
        )
    {
        $Type = 'ro';
    }
    my @GroupIDs = $Self->{GroupObject}->GroupMemberList(
        UserID => $Param{UserID},
        Type   => $Type,
        Result => 'ID',
    );
    my @QueueIDs = @{ $Param{ShownQueueIDs} };
    my %Queues;
    $Queues{MaxAge}       = 0;
    $Queues{TicketsShown} = 0;
    $Queues{TicketsAvail} = 0;

    # prepare "All tickets: ??" in Queue
    my @ViewableLockIDs = $Self->{LockObject}->LockViewableLock(
        Type => 'ID',
    );
    my %ViewableLockIDs = ( map { $_ => 1 } @ViewableLockIDs ); # for lookup
    my @ViewableStateIDs = $Self->{StateObject}->StateGetStatesByType(
        Type   => 'Viewable',
        Result => 'ID',
    );

    if (@QueueIDs) {
        my $SQL = "
            SELECT count(*)
            FROM ticket st
            WHERE st.ticket_state_id IN ( ${\(join ', ', @ViewableStateIDs)} )
                AND st.archive_flag = 0
                AND st.queue_id IN (";
        for ( 0 .. $#QueueIDs ) {
            if ( $_ > 0 ) {
                $SQL .= ",";
            }
            $SQL .= $Self->{DBObject}->Quote( $QueueIDs[$_], 'Integer' );
        }
        $SQL .= " )";

        $Self->{DBObject}->Prepare( SQL => $SQL );
        while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
            $Queues{AllTickets} = $Row[0];
        }
    }

    # check if user is in min. one group! if not, return here
    if ( !@GroupIDs ) {
        my %Hashes;
        $Hashes{QueueID} = 0;
        $Hashes{Queue}   = 'CustomQueue';
        $Hashes{MaxAge}  = 0;
        $Hashes{Count}   = 0;
        push @{ $Queues{Queues} }, \%Hashes;
        return %Queues;
    }

    # CustomQueue add on
    return if !$Self->{DBObject}->Prepare(
	# Differentiate between total and unlocked tickets
        SQL => "
            SELECT count(*), st.ticket_lock_id 
            FROM ticket st, queue sq, personal_queues suq
            WHERE st.ticket_state_id IN ( ${\(join ', ', @ViewableStateIDs)} )
                AND st.queue_id = sq.id
                AND st.archive_flag = 0
                AND suq.queue_id = st.queue_id
                AND sq.group_id IN ( ${\(join ', ', @GroupIDs)} )
                AND suq.user_id = $Param{UserID}
	        GROUP BY st.ticket_lock_id",
    );

    my %CustomQueueHashes = ( 
        QueueID => 0, 
        Queue => 'CustomQueue', 
        MaxAge => 0,
        Count => 0,
        Total => 0,
    );
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
        $CustomQueueHashes{Total} += $Row[0];
        if ( $ViewableLockIDs{$Row[1]} ) {
            $CustomQueueHashes{Count} += $Row[0];
        }
    }
    push @{ $Queues{Queues} }, \%CustomQueueHashes;
    
    # set some things
    if ( $Param{QueueID} == 0 ) {
	$Queues{TicketsShown} = $CustomQueueHashes{Total};
	$Queues{TicketsAvail} = $CustomQueueHashes{Count};
    }

    # prepare the tickets in Queue bar (all data only with my/your Permission)
    # First query gets _all_ tickets (regardless of lock)
    return if !$Self->{DBObject}->Prepare(
        SQL => "
            SELECT st.queue_id, sq.name, count(*)
            FROM ticket st, queue sq
            WHERE st.ticket_state_id IN ( ${\(join ', ', @ViewableStateIDs)} )
                AND st.queue_id = sq.id
                AND st.archive_flag = 0
                AND sq.group_id IN ( ${\(join ', ', @GroupIDs)} )
            GROUP BY st.queue_id, sq.name
            ORDER BY sq.name"
    );

    my %QueuesSeen;
    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
	my $Queue  = $Row[1];
	my %QueueData = (
	    QueueID => $Row[0], 
	    Queue	=> $Queue, 
	    Total	=> $Row[2], 
	    Count	=> 0, 
	    MaxAge	=> 0,
	);
	push @{ $Queues{Queues} }, \%QueueData;
	$QueuesSeen{$Queue} = \%QueueData;
    }

    return if !$Self->{DBObject}->Prepare(
        SQL => "
            SELECT st.queue_id, sq.name, min(st.create_time_unix), count(*)
            FROM ticket st, queue sq
            WHERE st.ticket_state_id IN ( ${\(join ', ', @ViewableStateIDs)} )
                AND st.ticket_lock_id IN ( ${\(join ', ', @ViewableLockIDs)} )
                AND st.queue_id = sq.id
                AND st.archive_flag = 0
                AND sq.group_id IN ( ${\(join ', ', @GroupIDs)} )
            GROUP BY st.queue_id, sq.name
            ORDER BY sq.name"
    );

    while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
	my $Count  = $Row[3];
	my $MaxAge = $Self->{TimeObject}->SystemTime() - $Row[2];

	# Merge with existing data for the queue
	my $Queue  = $Row[1];
	my $QueueData = $QueuesSeen{$Queue};	# ref to HASH
	$QueueData->{Count} = $Row[3];
	$QueueData->{MaxAge} = $MaxAge if $MaxAge > $QueueData->{MaxAge};

        # set some things
        if ( $Param{QueueID} eq $Queue ) {
            $Queues{TicketsShown} = $QueueData->{Total};
            $Queues{TicketsAvail} = $QueueData->{Count};
        }

        # get the oldest queue id
        if ( $QueueData->{MaxAge} > $Queues{MaxAge} ) {
            $Queues{MaxAge}          = $QueueData->{MaxAge};
            $Queues{QueueIDOfMaxAge} = $QueueData->{QueueID};
        }
    }

    return %Queues;
}

sub TicketAcceleratorRebuild {
    my ( $Self, %Param ) = @_;

    return 1;
}

1;

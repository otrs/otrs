# --
# Kernel/Output/HTML/DashboardTicketOwnerOverview.pm
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::DashboardTicketOwnerOverview;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # get needed parameters
    for my $Object (qw( Config Name UserID )) {
        die "Got no $Object!" if ( !$Self->{$Object} );
    }

    $Self->{PrefKey}  = 'UserDashboardPref' . $Self->{Name} . '-Shown';
    $Self->{CacheKey} = $Self->{Name} . '-' . $Self->{UserID};

    return $Self;
}

sub Preferences {
    my ( $Self, %Param ) = @_;

    return;
}

sub Config {
    my ( $Self, %Param ) = @_;

    return (
        %{ $Self->{Config} },

        # remember, do not allow to use page cache
        # (it's not working because of internal filter)
        CacheKey => undef,
        CacheTTL => undef,
    );
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $CacheKey = 'User' . '-' . $Self->{UserID};

    my $Content = $Self->{CacheObject}->Get(
        Type => 'DashboardOwnerOverview',
        Key  => $CacheKey,
    );
    return $Content if defined $Content;

    # get configured states, get their state ID and test if they exist while we do it
    my %States;
    my $StateIDURL;
    my %ConfiguredStates = %{ $Self->{Config}->{States} };
    for my $StateOrder ( sort { $a <=> $b } keys %ConfiguredStates ) {
        my $State = $ConfiguredStates{$StateOrder};

        # check if state is found, to record StateID
        my $StateID = $Kernel::OM->Get('Kernel::System::State')->StateLookup(
            State => $State,
        ) || '';
        if ($StateID) {
            $States{$State} = $StateID;

            # append StateID to URL for search string
            $StateIDURL .= "StateIDs=$StateID;";
        }
        else {

            # state does not exist, skipping
            delete $ConfiguredStates{$StateOrder};
        }
    }


    # get custom queues
    my @ViewableQueueIDs = $Self->{QueueObject}->GetAllCustomQueues(
        UserID => $Self->{UserID},
    );

    my $Sort = $Self->{Config}->{Sort} || '';

    # search ticket
    my @TicketIDs;
    if ( @ViewableQueueIDs ) {
        @TicketIDs = $Self->{TicketObject}->TicketSearch(
            Result     => 'ARRAY',
            Limit      => 1000,
            States     => [ values %ConfiguredStates ],
            QueueIDs   => \@ViewableQueueIDs,
            UserID     => $Self->{UserID},
            Permission => 'ro',
        );
    }

    # count ticket by user and state
    my ( %Count, %StatusTotal );
    my %OwnerList;
    for my $TicketID ( @TicketIDs ) {
        my %Ticket = $Self->{TicketObject}->TicketGet(
            TicketID => $TicketID,
        );
        next if ( !%Ticket );
        if ( ref $Count{ $Ticket{OwnerID} } ne 'HASH' ) {
            my %State;
            $Count{ $Ticket{OwnerID} } = {};
        }
        if ( !$OwnerList{ $Ticket{OwnerID} } ) {
            my %UserInfo = $Self->{UserObject}->GetUserData(
                UserID => $Ticket{OwnerID},
            );
            $OwnerList{ $Ticket{OwnerID} } = \%UserInfo;
        }
        $Count{ $Ticket{OwnerID} }->{ $Ticket{StateID} }++;
        $StatusTotal{ $Ticket{StateID} }++;
    }

    # build header
    my @Headers = ( 'Owner', );
    for my $StateOrder ( sort { $a <=> $b } keys %ConfiguredStates ) {
        push @Headers, $ConfiguredStates{$StateOrder};
    }

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    for my $HeaderItem (@Headers) {
        $LayoutObject->Block(
            Name => 'ContentLargeTicketOwnerOverviewHeaderStatus',
            Data => {
                Text => $HeaderItem,
            },
        );
    }

    my $OwnerIDURL;

    # iterate over all owners, print results;
    OWNER:
    for my $OwnerID ( sort {
        ( $OwnerList{$a}->{UserTitle} || '' ) cmp ( $OwnerList{$b}->{UserTitle} || '' )
        || $OwnerList{$a}->{UserLogin} cmp $OwnerList{$b}->{UserLogin}
        } keys %OwnerList )
    {
        $LayoutObject->Block(
            Name => 'ContentLargeTicketOwnerOverviewOwnerName',
            Data => {
                OwnerName => $OwnerList{$OwnerID}->{UserFullname},
            }
        );

        # iterate over states
        my $RowTotal = 0;
        for my $StateOrderID ( sort { $a <=> $b } keys %ConfiguredStates ) {
            if ( ref $Count{ $OwnerID } eq 'HASH' ) {
                $LayoutObject->Block(
                    Name => 'ContentLargeTicketOwnerOverviewOwnerResults',
                    Data => {
                        Number   => $Count{ $OwnerID }->{ $States{ $ConfiguredStates{$StateOrderID} } } || 0,
                        OwnerID  => $OwnerID,
                        StateID  => $States{ $ConfiguredStates{$StateOrderID} },
                        State    => $ConfiguredStates{$StateOrderID},
                        Sort     => $Sort,
                    },
                );
                $RowTotal += $Count{ $OwnerID }->{ $States{ $ConfiguredStates{$StateOrderID} } } || 0;
            }
            else {
                $Self->{LayoutObject}->Block(
                    Name => 'CountRow',
                    Data => {
                        Count => 0,
                    },
                );
            }
        }

        # print row (owner) total
        $LayoutObject->Block(
            Name => 'ContentLargeTicketOwnerOverviewOwnerTotal',
            Data => {
                Number   => $RowTotal,
                OwnerID  => $OwnerID,
                StateIDs => $StateIDURL,
                Sort     => $Sort,
            },
        );

        # add owner to SearchURL
        $OwnerIDURL .= "OwnerIDs=$OwnerID;";
    }

    $LayoutObject->Block(
        Name => 'ContentLargeTicketOwnerOverviewStatusTotalRow',
    );

    for my $StateOrderID ( sort { $a <=> $b } keys %ConfiguredStates ) {
        $LayoutObject->Block(
            Name => 'ContentLargeTicketOwnerOverviewStatusTotal',
            Data => {
                Number   => $StatusTotal{ $States{ $ConfiguredStates{$StateOrderID} } } || 0,
                OnwerIDs => $OwnerIDURL,
                StateID  => $States{ $ConfiguredStates{$StateOrderID} },
                Sort     => $Sort,
            },
        );
    }

    $Content = $LayoutObject->Output(
        TemplateFile => 'AgentDashboardTicketOwnerOverview',
        Data         => {
            %{ $Self->{Config} },
            Name => $Self->{Name},
        },
        KeepScriptTags => $Param{AJAX},
    );

    # cache result
    if ( $Self->{Config}->{CacheTTLLocal} ) {
        $Self->{CacheObject}->Set(
            Type  => 'DashboardOwnerOverview',
            Key   => $CacheKey,
            Value => $Content || '',
            TTL   => 2 * 60,
        );
    }

    return $Content;
}

1;

#!/usr/bin/perl
# --
# otrs.MarkTicketAsSeen.pl - set all ticket to seen
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU AFFERO General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
# or see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use Getopt::Std;
use Time::HiRes qw(usleep);

use Kernel::System::ObjectManager;

# get options
my %Opts;
getopt( 'ab', \%Opts );
if ( $Opts{h} ) {
    print "otrs.MarkTicketAsSeen.pl - mark tickets as seen by the agent\n";
    print "Copyright (C) 2001-2014 OTRS AG, http://otrs.com/\n\n";
    print "usage: otrs.MarkTicketAsSeen.pl [-a] [-b sleeptime per ticket in microseconds]\n\n";
    print "If you pass '-a' it will update ALL tickets, otherwise only non-closed\n";
    print "tickets will be updated.\n";
    exit 1;
}

if ( $Opts{b} && $Opts{b} !~ m{ \A \d+ \z }xms ) {
    print STDERR "ERROR: sleeptime needs to be a numeric value! e.g. 1000\n";
    exit 1;
}

# create object manager
local $Kernel::OM = Kernel::System::ObjectManager->new(
    'Kernel::System::Log' => {
        LogPrefix => 'otrs.MarkTicketAsSeen.pl',
    },
);

# disable cache
$Kernel::OM->Get('Kernel::System::Cache')->Configure(
    CacheInMemory  => 0,
    CacheInBackend => 1,
);

# disable ticket events
$Kernel::OM->Get('Kernel::Config')->{'Ticket::EventModulePost'} = undef;

my %Search;
if ( !$Opts{a} ) {
    print "Only processing tickets that are not closed:\n";
    $Search{StateType} = 'Open';
}
else {
    print "Processing all tickets:\n";
}

# get all users
my %Users = $Kernel::OM->Get('Kernel::System::User')->UserList(
    Type  => 'Short',
    Valid => 1,
);

# get ticket object
my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

# get all tickets
my @TicketIDs = $TicketObject->TicketSearch(

    # result (required)
    Result  => 'ARRAY',
    OrderBy => 'Down',

    # result limit
    Limit      => 1_000_000_000,
    UserID     => 1,
    Permission => 'ro',

    # restriction
    %Search,
);

my $TicketCount = scalar @TicketIDs;
my $Count       = 0;

TICKETID:
for my $TicketID (@TicketIDs) {

    $Count++;

    # check permission
    my %UserAccess;
    for my $UserID ( sort keys %Users ) {

        my $Access = $TicketObject->TicketPermission(
            Type     => 'ro',
            TicketID => $TicketID,
            LogNo    => 1,
            UserID   => $UserID,
        );

        $UserAccess{$UserID} = $Access;
    }

    # update article flag
    my @ArticleIndex = $TicketObject->ArticleIndex(
        TicketID => $TicketID,
        UserID   => 1,
    );

    my @Data;
    for my $ArticleID (@ArticleIndex) {

        USERID:
        for my $UserID ( sort keys %Users ) {

            # check permission
            next USERID if !$UserAccess{$UserID};

            push @Data, {
                ArticleID => $ArticleID,
                UserID    => $UserID,
            };
        }
    }

    # mark article as seen
    for my $Row (@Data) {
        $TicketObject->ArticleFlagSet(
            ArticleID => $Row->{ArticleID},
            Key       => 'Seen',
            Value     => 1,
            UserID    => $Row->{UserID},
        );
    }

    # update ticket flag
    USERID:
    for my $UserID ( sort keys %Users ) {

        # check permission
        next USERID if !$UserAccess{$UserID};

        # set ticket flag
        $TicketObject->TicketFlagSet(
            TicketID => $TicketID,
            Key      => 'Seen',
            Value    => 1,
            UserID   => $UserID,
        );
    }

    print "NOTICE: $Count of $TicketCount tickets.\n";

    next TICKETID if !$Opts{b};

    Time::HiRes::usleep( $Opts{b} );
}

print "NOTICE: done.\n";

exit 0;

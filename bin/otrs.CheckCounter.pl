#!/usr/bin/perl -w
# --
# otrs.CheckCounter.pl - OTRS counters for Icinga/Nagios
# Copyright (C) 2013-2015 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
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

use Switch;
use Getopt::Std;
use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Log;
use Kernel::System::Time;
use Kernel::System::Main;
use Kernel::System::DB;
use Kernel::System::AuthSession;

my %opts;
getopts( 'hc:t:', \%opts );
if ( $opts{h} ) {
    print "Usage: $FindBin::Script -c CounterName [-t minutes]\n";
    print "where:\n";
    print "  CounterName - one of:\n";
    print "     1 or Articles                number of all articles in OTRS DB\n";
    print "     2 or ArticlesValid           number of valid articles in OTRS DB\n";
    print "     3 or Customers               number of all customer users in OTRS DB\n";
    print "     4 or CustomerSessions        number of customer user active sessions in OTRS DB\n";
    print "     5 or CustomerSessionsUnique  number of unique customer user active sessions in OTRS DB\n";
    print "     6 or CustomersValid          number of valid customer users in OTRS DB\n";
    print "     7 or Tickets                 number of all tickets in OTRS DB\n";
    print "     8 or TicketsValid            number of valid tickets in OTRS DB\n";
    print "     9 or Users                   number of all users in OTRS DB\n";
    print "    10 or UserSessions            number of user active sessions in OTRS DB\n";
    print "    11 or UserSessionsUnique      number of unique user active sessions in OTRS DB\n";
    print "    12 or UsersValid              number of valid users in OTRS DB\n";
    print "    13 or UsersValidWoAdmin       number of valid users in OTRS DB without user with id 1\n";
    print "\n";
    print "  minutes - number of idle minutes after session is ignored (15 by default)\n";
    print "\n";
    print "Examples:\n";
    print "  $FindBin::Script -c 7\n";
    print "  $FindBin::Script -c UserSessionsUnique -t 10\n";
    print "\n";
    exit(0);
}

# check arguments
if ( !$opts{c} ) {
    print STDERR "ERROR: need -c CounterName; use -h for help\n";
    exit(1);
}

my $IdleMinutes = 15;
if ( $opts{t} ) {

    if ( $opts{t} !~ /^\d+\z/ ) {
        print STDERR "ERROR: -t requires integer value; use -h for help\n";
        exit(1);
    }
    $IdleMinutes = $opts{t};
}

# create common objects
my %CommonObject = ();
$CommonObject{ConfigObject} = Kernel::Config->new();
$CommonObject{EncodeObject} = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject} = Kernel::System::Log->new(
    LogPrefix    => 'OTRS-otrs.CheckCounter.pl',
    ConfigObject => $CommonObject{ConfigObject},
);
$CommonObject{MainObject} = Kernel::System::Main->new(%CommonObject);
$CommonObject{TimeObject} = Kernel::System::Time->new(%CommonObject);
$CommonObject{DBObject} = Kernel::System::DB->new(%CommonObject);
$CommonObject{SessionObject} = Kernel::System::AuthSession->new(%CommonObject);

# check database state
if ( ! $CommonObject{DBObject} ) {
    print "ERROR: database connection failed"
}

# count sessions if session counter requested
my %SessionCounters = ();
if ( $opts{c} =~ /^UserSessions|^CustomerSessions|^4$|^5$|^10$|^11$/i ) {

    # get all sessions
    $SessionCounters{UserSession} = 0;
    $SessionCounters{CustomerSession} = 0;
    $SessionCounters{UserSessionUniq} = 0;
    $SessionCounters{CustomerSessionUniq} = 0;

    # get current timestamp
    my $Time = $CommonObject{TimeObject}->SystemTime();

    my @List = $CommonObject{SessionObject}->GetAllSessionIDs();
    SESSIONID:
    for my $SessionID (@List) {
        my %Data = $CommonObject{SessionObject}->GetSessionIDData( SessionID => $SessionID );

        # check last request time / idle time out; skip sessions not active in last 15 mins.
        next SESSIONID if !$Data{UserLastRequest};
        next SESSIONID if $Data{UserLastRequest} + ( $IdleMinutes * 60 ) < $Time;

        if ($Data{UserType} && $Data{UserLogin}) {
            $SessionCounters{"$Data{UserType}Session"}++;
            if ( !$SessionCounters{"$Data{UserLogin}"} ) {
                $SessionCounters{"$Data{UserType}SessionUniq"}++;
                $SessionCounters{"$Data{UserLogin}"} = 1;
            }
        }
    }
}

my $query;
switch ($opts{c}) {

    case ["1", "Articles"] {
        $query = 'select count(*) from article';
    }

    case ["2", "ArticlesValid"] {
        $query = 'select count(*) from article where valid_id=1';
    }

    case ["3", "Customers"] {
        $query = 'select count(*) from customer_user';
    }

    case ["4", "CustomerSessions"] {
        print $SessionCounters{CustomerSession};
        exit(0);
    }

    case ["5", "CustomerSessionsUnique"] {
        print $SessionCounters{CustomerSessionUniq};
        exit(0);
    }

    case ["6", "CustomersValid"] {
        $query = 'select count(*) from customer_user where valid_id=1';
    }

    case ["7", "Tickets"] {
        $query = 'select count(*) from ticket';
    }

    case ["8", "TicketsValid"] {
        $query = 'select count(*) from ticket where valid_id=1';
    }

    case ["9", "Users"] {
        $query = 'select count(*) from users';
    }

    case ["10", "UserSessions"] {
        print $SessionCounters{UserSession};
        exit(0);
    }

    case ["11", "UserSessionsUnique"] {
        print $SessionCounters{UserSessionUniq};
        exit(0);
    }

    case ["12", "UsersValid"] {
        $query = 'select count(*) from users where valid_id=1';
    }

    case ["13", "UsersValidWoAdmin"] {
        $query = 'select count(*) from users where valid_id=1 and id>1';
    }

    else {
        print "invalid counter " . $opts{c} . "!\n";
        exit(1);
    }
}

$CommonObject{DBObject}->Prepare(SQL => $query);
while ( my @Row = $CommonObject{DBObject}->FetchrowArray() ) {
    print $Row[0];
    exit(0);
}

print "ERROR: error querying OTRS database\n";
exit(1);

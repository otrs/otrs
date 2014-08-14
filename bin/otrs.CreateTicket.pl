#!/usr/bin/perl
# --
# bin/otrs.CreateTicket.pl - Add Ticket from CLI
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
use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Time;
use Kernel::System::DB;
use Kernel::System::Log;
use Kernel::System::Main;
use Kernel::System::Ticket;
use Kernel::System::Ticket::Article;

# create common objects
my %CommonObject;
$CommonObject{ConfigObject} = Kernel::Config->new(%CommonObject);
$CommonObject{EncodeObject} = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject}    = Kernel::System::Log->new(
    LogPrefix => 'OTRS-otrs.CreateTicket.pl',
    %CommonObject,
);
$CommonObject{MainObject}          = Kernel::System::Main->new(%CommonObject);
$CommonObject{DBObject}            = Kernel::System::DB->new(%CommonObject);
$CommonObject{TimeObject}         = Kernel::System::Time->new(%CommonObject);
$CommonObject{TicketObject}         = Kernel::System::Ticket->new(%CommonObject);

# get options
my %Opts;
getopts( 'ht:q:c:u:o:p:s:r:l:', \%Opts );

if ( $Opts{h} ) {
    print STDOUT "otrs.CreateTicket.pl - add new Ticket\n";
    print STDOUT "Copyright (C) 2001-2014 OTRS AG, http://otrs.com/\n";
    print STDOUT "usage: otrs.CreateTicket.pl -t <TITLE> -q <QUEUE> -c <CUSTOMERID> -u <CUSTOMERUSER> -o <OWNERID> [-p <PRIORITY> -s <STATE> -r <RESPONSIBLEID> -l <lock|unlock>] \n";
    exit 1;
}

if ( !$Opts{t} ) {
    print STDERR "ERROR: Need -t <title>\n";
    exit 1;
}
if ( !$Opts{q} ) {
    print STDERR "ERROR: Need -q <queue>\n";
    exit 1;
}
if ( !$Opts{c} ) {
    print STDERR "ERROR: Need -c <customerid>\n";
    exit 1;
}
if ( !$Opts{u} ) {
    print STDERR "ERROR: Need -u <customeruser>\n";
    exit 1;
}
if ( !$Opts{o} ) {
    print STDERR "ERROR: Need -o <ownerid>\n";
    exit 1;
}

if ( $Opts{l} ) {
    if ($Opts{l} ne 'lock' and $Opts{l} ne 'unlock') {
        print STDERR "ERROR: Invalid -l $Opts{l} parameter. It should be 'lock' or 'unlock'\n";
        exit 1;
    }
}

my $SystemAddressID;

# add Ticket
my $TicketID = $CommonObject{TicketObject}->TicketCreate(
    Title        => $Opts{t},
    Queue        => $Opts{q},
    Lock         => $Opts{l} || 'unlock',
    Priority     => $Opts{p} || '3 normal',       # or PriorityID => 2,
    State        => $Opts{s} || 'new',            # or StateID => 5,
    CustomerID   => $Opts{c},
    CustomerUser => $Opts{u},
    OwnerID      => $Opts{o},
    ResponsibleID => $Opts{r},
    UserID       => 1,
);

# error handling
if ( !$TicketID ) {
    print STDERR "ERROR: Can't create Ticket!\n";
    exit 1;
}

my $ArticleID = $CommonObject{TicketObject}->ArticleCreate(
    TicketID         => $TicketID,
    ArticleType      => 'note-internal',                        # email-external|email-internal|phone|fax|...
    SenderType       => 'agent',                                # agent|system|customer
    From             => $Opts{u},       # not required but useful
#    To               => 'Some Customer A <customer-a@example.com>', # not required but useful
    Subject          => $Opts{t},               # required
    Body             => $Opts{t},                     # required
    Charset          => 'ISO-8859-15',
    MimeType         => 'text/plain',
    HistoryType      => 'WebRequestCustomer',                          # EmailCustomer|Move|AddNote|PriorityUpdate|WebRequestCustomer|...
    HistoryComment   => 'Customer request via web.',
    UserID           => 1,
    );

# error handling
if ( !$ArticleID ) {
    print STDERR "ERROR: Can't create Article for the Ticket!\n";
    exit 1;
}

print STDOUT "Ticket '$Opts{t}' created.\n";
exit 0;

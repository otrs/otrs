#!/usr/bin/perl
# --
# bin/otrs.AddCustomerCompany.pl - Add Customer Company from CLI
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

use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Log;
use Kernel::System::Time;
use Kernel::System::Main;
use Kernel::System::DB;
use Kernel::System::CustomerCompany;

# create common objects
my %CommonObject;
$CommonObject{ConfigObject} = Kernel::Config->new(%CommonObject);
$CommonObject{EncodeObject} = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject}
    = Kernel::System::Log->new( %CommonObject, LogPrefix => 'OTRS-otrs.AddCustomerCompany.pl' );
$CommonObject{TimeObject} = Kernel::System::Time->new(%CommonObject);
$CommonObject{MainObject} = Kernel::System::Main->new(%CommonObject);
$CommonObject{DBObject}   = Kernel::System::DB->new(%CommonObject);
$CommonObject{CustomerObject} = Kernel::System::CustomerCompany->new(%CommonObject);

my %Options;
use Getopt::Std;
getopt( 'nsztluc', \%Options );
unless ( $ARGV[0] ) {
    print
        "$FindBin::Script [-n customername] [-s street] [-z zipcode] [-t city] [-l country] [-u url] [-c comment] customerID\n";
    print "\n";
    exit;
}

my %Param;

#user id of the person adding the record
$Param{UserID} = '1';

#Validrecord
$Param{ValidID} = '1';

$Param{Source}              = 'CustomerCompany';
$Param{CustomerID}          = $ARGV[0];
$Param{CustomerCompanyName} = defined $Options{n} ? $Options{n} : $ARGV[0];;
$Param{CustomerCompanyStreet}   = $Options{s};
$Param{CustomerCompanyZIP}   = $Options{z};
$Param{CustomerCompanyCity}   = $Options{t};
$Param{CustomerCompanyCountry}   = $Options{l};
$Param{CustomerCompanyURL}   = $Options{u};
$Param{CustomerCompanyComment}   = $Options{c};

if ( $Param{UID} = $CommonObject{CustomerObject}->CustomerCompanyAdd( %Param ) ) {
    print "Customer Company added. Customer id is $Param{UID}\n";
}

exit(0);

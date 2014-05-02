#!/usr/bin/perl
# --
# bin/otrs.AddState.pl - Add State from CLI
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
use Kernel::System::State;
use Kernel::System::Main;

# create common objects
my %CommonObject;
$CommonObject{ConfigObject} = Kernel::Config->new(%CommonObject);
$CommonObject{EncodeObject} = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject}    = Kernel::System::Log->new(
    LogPrefix => 'OTRS-otrs.AddState.pl',
    %CommonObject,
);
$CommonObject{MainObject}          = Kernel::System::Main->new(%CommonObject);
$CommonObject{DBObject}            = Kernel::System::DB->new(%CommonObject);
$CommonObject{StateObject}         = Kernel::System::State->new(%CommonObject);

# get options
my %Opts;
getopts( 'hn:t:c:', \%Opts );

if ( $Opts{h} ) {
    print STDOUT "otrs.AddState.pl - add new state\n";
    print STDOUT "Copyright (C) 2001-2014 OTRS AG, http://otrs.com/\n";
    print STDOUT "usage: otrs.AddState.pl -n <NAME> -t <TYPE-NUMBER> [-c <comment>] \n";
    print STDOUT "types: 1 - new, 2 - open, 3 - closed, 4 - pending reminder \n";
    print STDOUT "       5 - pending auto, 6 - removed, 7 - merged \n";
    exit 1;
}

if ( !$Opts{n} ) {
    print STDERR "ERROR: Need -n <name>\n";
    exit 1;
}
if ( !$Opts{t} ) {
    print STDERR "ERROR: Need -t <type-number>\n";
    exit 1;
}

my $SystemAddressID;

# add state
my $Success = $CommonObject{StateObject}->StateAdd(
    Name              => $Opts{n},
    Comment           => $Opts{c} || undef,
    TypeID            => $Opts{t},
    ValidID           => 1,
    UserID            => 1,
);

# error handling
if ( !$Success ) {
    print STDERR "ERROR: Can't create State!\n";
    exit 1;
}

print STDOUT "State '$Opts{n}' created.\n";
exit 0;

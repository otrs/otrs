#!/usr/bin/perl
# --
# bin/otrs.InvalidateState.pl - Invalidate State from CLI
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
    LogPrefix => 'OTRS-otrs.InvalidateState.pl',
    %CommonObject,
);
$CommonObject{MainObject}          = Kernel::System::Main->new(%CommonObject);
$CommonObject{DBObject}            = Kernel::System::DB->new(%CommonObject);
$CommonObject{StateObject}         = Kernel::System::State->new(%CommonObject);

# get options
my %Opts;
getopts( 'hi:', \%Opts );

if ( $Opts{h} ) {
    print STDOUT "otrs.InvalidateState.pl - add new state\n";
    print STDOUT "Copyright (C) 2001-2014 OTRS AG, http://otrs.com/\n";
    print STDOUT "usage: otrs.InvalidateState.pl -i <STATE-ID>\n";
    exit 1;
}

if ( !$Opts{i} ) {
    print STDERR "ERROR: Need -i <STATE-ID>\n";
    exit 1;
}

# get state
my %State = $CommonObject{StateObject}->StateGet(
                    ID    => $Opts{i},
                );

# invalidate state
my $Success = $CommonObject{StateObject}->StateUpdate(
    ID             => $Opts{i},
    Name           => $State{Name},
    Comment        => $State{Comment},
    ValidID        => 2,
    TypeID         => $State{TypeID},
    CheckSysConfig => $State{CheckSysConfig},   # (optional) default 1
    UserID         => 1,
);

# error handling
if ( !$Success ) {
    print STDERR "ERROR: Can't invalidate State!\n";
    exit 1;
}

print STDOUT "State '$Opts{i}' invalidated.\n";
exit 0;

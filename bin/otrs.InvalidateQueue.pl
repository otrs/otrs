#!/usr/bin/perl
# --
# bin/otrs.InvalidateQueue.pl - Invalidate Queue from CLI
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
use Kernel::System::Queue;
use Kernel::System::Main;

# create common objects
my %CommonObject;
$CommonObject{ConfigObject} = Kernel::Config->new(%CommonObject);
$CommonObject{EncodeObject} = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject}    = Kernel::System::Log->new(
    LogPrefix => 'OTRS-otrs.InvalidateQueue.pl',
    %CommonObject,
);
$CommonObject{MainObject}          = Kernel::System::Main->new(%CommonObject);
$CommonObject{DBObject}            = Kernel::System::DB->new(%CommonObject);
$CommonObject{QueueObject}         = Kernel::System::Queue->new(%CommonObject);

# get options
my %Opts;
getopts( 'hi:', \%Opts );

if ( $Opts{h} ) {
    print STDOUT "otrs.InvalidateQueue.pl - add new state\n";
    print STDOUT "Copyright (C) 2001-2014 OTRS AG, http://otrs.com/\n";
    print STDOUT "usage: otrs.InvalidateQueue.pl -i <STATE-ID>\n";
    exit 1;
}

if ( !$Opts{i} ) {
    print STDERR "ERROR: Need -i <STATE-ID>\n";
    exit 1;
}

# get state
my %Queue = $CommonObject{QueueObject}->QueueGet(
                    ID    => $Opts{i},
                );

# invalidate state
my $Success = $CommonObject{QueueObject}->QueueUpdate(
        QueueID             => $Queue{QueueID},
        Name                => $Queue{Name},
        ValidID             => 2,
        GroupID             => $Queue{GroupID},
        SystemAddressID     => $Queue{SystemAddressID},
        SalutationID        => $Queue{SalutationID},
        SignatureID         => $Queue{SignatureID},
        UserID              => 1,
        FollowUpID          => $Queue{FollowUpID},
        Comment             => $Queue{Comment},
        DefaultSignKey      => $Queue{DefaultSignKey},
        UnlockTimeOut       => $Queue{UnlockTimeOut},
        FollowUpLock        => $Queue{FollowUpLock},
        ParentQueueID       => $Queue{ParentQueueID},
);

# error handling
if ( !$Success ) {
    print STDERR "ERROR: Can't invalidate Queue!\n";
    exit 1;
}

print STDOUT "Queue '$Opts{i}' invalidated.\n";
exit 0;

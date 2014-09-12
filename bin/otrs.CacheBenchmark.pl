#!/usr/bin/perl
# --
# bin/otrs.CacheBenchmark.pl - cache modules performance testing
# Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
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
use utf8;

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use Kernel::Config;
use Kernel::System::Encode;
use Kernel::System::Log;
use Kernel::System::Main;
use Kernel::System::Cache;
use Time::HiRes qw(time);

# create common objects
my %CommonObject = ();
$CommonObject{ConfigObject} = Kernel::Config->new();
$CommonObject{EncodeObject} = Kernel::System::Encode->new(%CommonObject);
$CommonObject{LogObject}    = Kernel::System::Log->new(
    LogPrefix    => 'OTRS-otrs.CacheBenchmark.pl',
    ConfigObject => $CommonObject{ConfigObject},
);
$CommonObject{MainObject} = Kernel::System::Main->new(%CommonObject);

# get home directory
my $HomeDir = $CommonObject{ConfigObject}->Get('Home');

# get all avaliable backend modules
my @BackendModuleFiles = $CommonObject{MainObject}->DirectoryRead(
    Directory => $HomeDir . '/Kernel/System/Cache/',
    Filter    => '*.pm',
    Silent    => 1,
);


MODULEFILE:
for my $ModuleFile (@BackendModuleFiles) {

    next MODULEFILE if !$ModuleFile;

    # extract module name
    my ($Module) = $ModuleFile =~ m{ \/+ ([a-zA-Z0-9]+) \.pm $ }xms;

    next MODULEFILE if !$Module;

    $CommonObject{ConfigObject}->Set(
        Key   => 'Cache::Module',
        Value => "Kernel::System::Cache::$Module",
    );

    # create a local cache object
    my $CacheObject = Kernel::System::Cache->new(
        %CommonObject,
        ConfigObject => $CommonObject{ConfigObject},
    );

    next MODULEFILE if !$CacheObject;

    # create unique ID for this session
    my @chars = ("A".."Z");
    my $sessid;
    $sessid .= $chars[rand @chars] for 1..8;

    my $Result;
    my $SetOK;
    my $GetOK;
    my $DelOK;

    print "Testing cache module $Module\n";

    # load cache initially with 100k 1kB items
    print "Preloading cache with 100k x 1kB items... ";
    $| = 1;
    my $content_1kB = '.' x 1024;
    for (my $i = 0; $i < 100000; $i++) {
        $Result = $CacheObject->Set(
            Type  => 'CacheTestInitContent' . $sessid . ($i % 10),
            Key   => 'Test' . $i,
            Value => $content_1kB,
            TTL   => 60 * 24 * 60 * 60,
        );
    }
    print "done.\n";

    print "Cache module    Item Size[b] Operations Time[s]    Op/s  Set OK  Get OK  Del OK\n";
    print "--------------- ------------ ---------- ------- ------- ------- ------- -------\n";

    for my $ItemSize (64, 256, 512, 1024, 4096, 10240, 102400, 1048576, 4194304) {

        my $content = ' ' x $ItemSize;
        my $opcount = 10 + 50 * int(7 - log10($ItemSize));

        printf("%-15s %12d %10d ", $Module, $ItemSize, 100*$opcount);
        $| = 1;

        # start timer
        my $start = Time::HiRes::time();

        $SetOK = 0;
        for (my $i = 0; $i < $opcount; $i++) {
            $Result = $CacheObject->Set(
                Type  => 'CacheTest' . $sessid . ($i % 10),
                Key   => 'Test' . $i,
                Value => $content,
                TTL   => 60 * 24,
            );
            $SetOK++ if $Result;
        };

        $GetOK = 0;
        for (my $j = 0; $j < 98; $j++) {
            for (my $i = 0; $i < $opcount; $i++) {
                $Result = $CacheObject->Get(
                    Type => 'CacheTest' . $sessid . ($i % 10),
                    Key  => 'Test' . $i,
                );

                $GetOK++ if ( $Result && ($Result eq $content) );
            }
        }

        $DelOK = 0;
        for (my $i = 0; $i < $opcount; $i++) {
            $Result = $CacheObject->Delete(
                Type => 'CacheTest' . $sessid . ($i % 10),
                Key  => 'Test' . $i,
            );
            $DelOK++ if $Result;
        };

        # end timer
        my $stop = Time::HiRes::time();

        # report
        printf("%7.2f %7.0f %6.2f%% %6.2f%% %6.2f%%\n",
            ($stop-$start),
            100*$opcount/($stop-$start),
            100*$SetOK/($opcount),
            100*$GetOK/(98*$opcount),
            100*$DelOK/($opcount));
    }

    # cleanup initial cache
    print "Removing preloaded 100k x 1kB items... ";
    for (my $i = 0; $i < 10; $i++) {
        $Result = $CacheObject->CleanUp(
            Type  => 'CacheTestInitContent' . $sessid . ($i % 10),
        );
    }
    print "done.\n";

}

sub log10 {
    my $n = shift;
    return log($n)/log(10);
}

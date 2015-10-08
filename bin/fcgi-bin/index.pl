#!/usr/bin/perl
# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
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

# use ../../ as lib location
use FindBin qw($Bin);
use lib "$Bin/../..";
use lib "$Bin/../../Kernel/cpan-lib";
use lib "$Bin/../../Custom";

# Imports the library; required line
use CGI::Fast;

# load agent web interface
use Kernel::System::Web::InterfaceAgent();
use Kernel::System::ObjectManager;

# 0=off;1=on;
my $Debug = 0;

my $Cnt = 0;
#Switch that tells process to finish gracefully
my $exit_requested = 0; 

# Number of requests before restart. Can be moved to Config.pm easily
# Prevents OTRS to get big ammount of memory because of memory leaks
my $accept_limit = 100; 
my $WebRequest;

sub sig_handler {
    my $var = shift;
    $exit_requested = 1;
    warn "Exit by Signal: $var PID: $$";
    exit(0) if !$WebRequest;
}

#this allows quick restarts of FastCGI processes via Signal, like:
# pkill -SIGHUP index.pl
# This is useful if you have some system(FS) watcher on ZZZAuto.pm, ZZZAAuto.pm and ZZZProcessManagement.pm
# So you send graceful restart signal on changes via SysConfig

# $SIG{USR1} = \&sig_handler; #You can use own signal to make graceful exit
$SIG{TERM} = \&sig_handler;
$SIG{HUP} = \&sig_handler;
$SIG{PIPE} = 'IGNORE';


# Response loop
while ( $WebRequest = new CGI::Fast ) {

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $Interface = Kernel::System::Web::InterfaceAgent->new(
        Debug      => $Debug,
        WebRequest => $WebRequest,
    );
    $Interface->Run();
    
    $Cnt++;
    if ($Cnt >$accept_limit){
        $exit_requested=1;
        warn "Exit by limit $accept_limit PID: $$";
    }
    last if $exit_requested;
    #    print STDERR "This is connection number $Cnt\n";
}

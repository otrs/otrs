#!/usr/bin/perl
# --
#please define log_name as a path in your system
#also, please add high limit and spread to set the maximum number of requests script will process
#ToDo: add this conf to Config.pm or Framework.xml
#Because of the size of the project OTRS may have memory leaks.
#When you run it on FastCGI, you get up to 1GB processes in memory in 1-2 days on active environments. 
#So, if you get like 100-1000 requests, then graceful exit/restart by your FastCGI manager (like multiwatch) - the problem is solved.
#Also, it is not useful to do restarts on some changes in SysConfig or ProcessManagemnt on FastCGI. 
#As you don't see your changes after saving and need to restart processes manually after updating them. 
#It is easy to make a graceful exit (with finishing all active requests gracefully) by a signal from FS watcher on ZZZAuto.pm, ZZZAAuto.pm, ZZZACL.pm and ZZZProcessManagement.pm
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

# load customer web interface
use Kernel::System::Web::InterfaceCustomer();
use Kernel::System::ObjectManager; 
use POSIX qw(:errno_h);

# 0=off;1=on;
my $Debug = 0;

my $accept_limit = 400;
my $accept_limit_spread = 60;
# protect against out-of-bound values
$accept_limit_spread = 80 if $accept_limit_spread > 80;
$accept_limit_spread = 0 if $accept_limit_spread < 0;

# the "int( ... + 0.5)" thing is a poor man's round() implementation
my $limit_low = int($accept_limit - 0.5 * $accept_limit * $accept_limit_spread / 100);
my $limit_high = int($accept_limit + 0.5 * $accept_limit * $accept_limit_spread / 100 + 0.5);
# the ternary operator here is to handle the special case of rand(0)
$accept_limit = $accept_limit_spread > 0 ? int($limit_low + rand($accept_limit * $accept_limit_spread / 100) + 0.5) : $limit_high;
my $count = 0;
my $exit_requested = '';
sub exit_handler
{
        $exit_requested = shift;
}

$SIG{USR1} = $SIG{TERM} = $SIG{HUP} = \&exit_handler;

sub printerr
{
    my $msg = shift;
    my $time = scalar localtime;
    print STDERR "[$time] PID $$: $msg\n";
}


my $log_name = "/var/log/otrs/err-index-" . time() . ".$$";

use IO::File;
my $io = new IO::File ">>$log_name";
CGI::Fast->file_handles({fcgi_error_file_handle => $io});

# Response loop
my $WebRequest;
while ( $WebRequest = new CGI::Fast ) {
    open(STDERR, ">>$log_name") || die $!;
    printerr '';
    printerr "Invocation #$count; configured maximum of invocations is $limit_low to $limit_high; mine is $accept_limit";

    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $Interface = Kernel::System::Web::InterfaceCustomer->new(
        Debug      => $Debug,
        WebRequest => $WebRequest,
    );
    $Interface->Run();

    printerr "Finished processing request #$count";
    $count++;
    last if $count >= $accept_limit;
    last if $exit_requested;
}
$CGI::Fast::Ext_Request->Finish();
$CGI::Fast::Ext_Request->LastCall();

if ($exit_requested) {
    printerr "Signal $exit_requested received, exiting";
} elsif ($count >= $accept_limit) {
    printerr "Invocation limit reached at $count, exiting";
} else {
    printerr "UNEXPECTED EXIT!";
}

close STDERR;
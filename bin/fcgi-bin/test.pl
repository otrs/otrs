#!/usr/bin/perl
use strict;
use warnings;

#Switch that tells process to finish gracefully
my $exit_requested = 0; 
my $last_sig = undef;
my $delay_restart = 5;
my $run = 'pkill -SIGHUP index.pl';

sub exit_handler {
    my $var = shift;
    $exit_requested = 1;
    warn "Exit by Signal: $var PID: $$";
    exit(0);
}

sub alarm_handler {
    my $var = shift;
    warn "Trying to restart: $var PID: $$";
    if ((defined $last_sig) and (time() + $delay_restart +1 > $last_sig)){
        warn "Restarted by Signal: $var PID: $$";
        $last_sig = undef;
        `$run`;    
    }
}

sub sig_handler {
    my $var = shift;
    $last_sig = time();
    alarm($delay_restart);
    warn "Got Signal: $var PID: $$";    
}
#this allows quick restarts of FastCGI processes via Signal, like:
# pkill -SIGHUP index.pl
# This is useful if you have some system(FS) watcher on ZZZAuto.pm, ZZZAAuto.pm and ZZZProcessManagement.pm
# So you send graceful restart signal on changes via SysConfig

# $SIG{USR1} = \&sig_handler; #You can use own signal to make graceful exit
$SIG{TERM} = \&exit_handler;
$SIG{HUP} = \&exit_handler;

$SIG{PIPE} = 'IGNORE';

$SIG{ALRM} = \&alarm_handler;

$SIG{USR1} = \&sig_handler;

# Main Loop
while (1) {
    sleep 2;
}

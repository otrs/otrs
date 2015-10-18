#!/usr/bin/perl

$| = 1;

use warnings;
use strict;

use Time::HiRes qw/ualarm stat/;
use Digest::file qw/digest_file/;

my $DELAY = $ARGV[0] || 10;
my $COMMAND = $ARGV[1] || "/bin/true";
my @shell = ('/bin/bash', '-c');

my @watch_files = qw(
	/opt/otrs/Kernel/Config/Files/ZZZAuto.pm
	/opt/otrs/Kernel/Config/Files/ZZZAAuto.pm
#	/opt/otrs/Kernel/Config/Files/ZZZACL.pm
	/opt/otrs/Kernel/Config/Files/ZZZProcessManagement.pm
	);
my $flag = 0;
my $fire = 0;

$SIG{USR1} = sub {
	$flag = 1;
};

$SIG{ALRM} = sub {
	$fire = 1;
};

plog(sprintf("PID $$ starting, watching files:\n\t%s", join("\n\t", @watch_files)));

my %old_sums = get_sums();
my %old_stat = get_stat();

while (select(undef, undef, undef, 1) || 1) {
	my %stat = get_stat();
	my @changed_files;
	if (!compare(\%old_stat, \%stat, \@changed_files, 'numeric')) {
		$flag = 2;
		%old_stat = %stat;
	}
	if ($flag == 1 || $flag == 2) {
		my $prev = ualarm($DELAY * 1000000);
		my $old_alarm = '';
		$old_alarm = sprintf('; previous timer was at %.2f seconds', $prev / 1000000) if $prev > 0;
		my $reason = '';
		if ($flag == 1) {
			$reason = 'Received a signal';
		} else {
			$reason = 'Watched files inode change time updated';
		}
		plog("$reason, scheduling a reload in $DELAY seconds$old_alarm");
		plog(sprintf("Change times updated on:\n\t%s", join("\n\t", @changed_files))) if $flag == 2;
		$flag = 0;
	}
	if ($fire == 1) {
		plog("Reload delay timeout reached, checking file contents...");
		my %sums = get_sums();
		my @changed_files = ();
		if (compare(\%old_sums, \%sums, \@changed_files, 'string')) {
			plog("Watched files contents unchanged, reload request ignored");
		} else {
			plog(sprintf("Running %s '%s', list of changed files:\n\t%s",
				join(' ', @shell), $COMMAND, join("\n\t", @changed_files)));
			system(@shell, $COMMAND);
			%old_sums = %sums;
		}
		$fire = 0;
	}
}

sub plog
{
	print scalar localtime . "	$_[0]\n";
}

sub get_sums
{
	my %sums;
	foreach my $n (@watch_files) {
		$sums{$n} = digest_file($n, 'SHA-256');
	}
	return %sums;
}

sub compare
{
	my ($old, $new, $list, $type) = @_;

	my $ret = 1;
	foreach my $n (@watch_files) {
		if (($type eq 'string' && $old->{$n} ne $new->{$n}) || ($type eq 'numeric' && $old->{$n} != $new->{$n})) {
			push @{$list}, $n if defined $list;
			$ret = 0;
		}
	}
	return $ret;
}

sub get_stat
{
	my %stat;
	foreach my $n (@watch_files) {
		my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev,$size,
                   $atime,$mtime,$ctime,$blksize,$blocks)
                       = stat($n);
                $stat{$n} = $ctime;
	}
	return %stat;
}

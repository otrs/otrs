# --
# Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

## no critic (Modules::RequireExplicitPackage)
use strict;
use warnings;
use utf8;

use vars (qw($Self));

my @Tests = (

    {
        Name         => 'UTC',
        TimeStampUTC => '2014-01-10 11:12:13',
        LIGEROTimeZone => 'UTC',
        Result       => 'Fri, 10 Jan 2014 11:12:13 +0000',
    },
    {
        Name         => 'Europe/Berlin',
        TimeStampUTC => '2014-01-10 11:12:13',
        LIGEROTimeZone => 'Europe/Berlin',
        Result       => 'Fri, 10 Jan 2014 12:12:13 +0100',
    },
    {
        Name         => 'America/Los_Angeles',
        TimeStampUTC => '2014-01-10 11:12:13',
        LIGEROTimeZone => 'America/Los_Angeles',
        Result       => 'Fri, 10 Jan 2014 03:12:13 -0800',
    },
    {
        Name         => 'Australia/Sydney',
        TimeStampUTC => '2014-01-10 11:12:13',
        LIGEROTimeZone => 'Australia/Sydney',
        Result       => 'Fri, 10 Jan 2014 22:12:13 +1100',
    },
    {
        Name         => 'Europe/London',
        TimeStampUTC => '2014-01-10 11:12:13',
        LIGEROTimeZone => 'Europe/London',
        Result       => 'Fri, 10 Jan 2014 11:12:13 +0000',
    },
    {
        Name         => 'Europe/Berlin',
        TimeStampUTC => '2014-08-03 02:03:04',
        LIGEROTimeZone => 'Europe/Berlin',
        Result       => 'Sun, 3 Aug 2014 04:03:04 +0200',
    },
    {

        Name         => 'America/Los_Angeles',
        TimeStampUTC => '2014-08-03 02:03:04',
        LIGEROTimeZone => 'America/Los_Angeles',
        Result       => 'Sat, 2 Aug 2014 19:03:04 -0700',
    },
    {
        Name         => 'Australia/Sydney',
        TimeStampUTC => '2014-08-03 02:03:04',
        LIGEROTimeZone => 'Australia/Sydney',
        Result       => 'Sun, 3 Aug 2014 12:03:04 +1000',
    },
    {
        Name         => 'Europe/London DST',
        TimeStampUTC => '2014-08-03 02:03:04',
        LIGEROTimeZone => 'Europe/London',
        Result       => 'Sun, 3 Aug 2014 03:03:04 +0100',
    },
    {
        Name         => 'Europe/Berlin DST',
        TimeStampUTC => '2014-08-03 02:03:04',
        LIGEROTimeZone => 'Europe/Berlin',
        Result       => 'Sun, 3 Aug 2014 04:03:04 +0200',
    },
    {
        Name         => 'Asia/Kathmandu, offset with minutes',
        TimeStampUTC => '2014-08-03 02:03:04',
        LIGEROTimeZone => 'Asia/Kathmandu',
        Result       => 'Sun, 3 Aug 2014 07:48:04 +0545',
    },
);

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
my $HelperObject = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

for my $Test (@Tests) {

    my $DateTimeObject = $Kernel::OM->Create(
        'Kernel::System::DateTime',
        ObjectParams => {
            String   => $Test->{TimeStampUTC},
            TimeZone => 'UTC',
        },
    );

    # Set LIGERO time zone to matching one.
    $ConfigObject->Set(
        Key   => 'LIGEROTimeZone',
        Value => $Test->{LIGEROTimeZone},
    );

    $HelperObject->FixedTimeSet($DateTimeObject);

    # Discard time object because of changed time zone
    $Kernel::OM->ObjectsDiscard(
        Objects => [ 'Kernel::System::Time', ],
    );
    my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');

    $DateTimeObject->ToTimeZone( TimeZone => $Test->{LIGEROTimeZone} );

    my $MailTimeStamp = $TimeObject->MailTimeStamp();

    $Self->Is(
        $MailTimeStamp,
        $Test->{Result},
        "$Test->{Name} ($Test->{LIGEROTimeZone}) Timestamp $Test->{TimeStampUTC}:",
    );

    $HelperObject->FixedTimeUnset();
}

1;

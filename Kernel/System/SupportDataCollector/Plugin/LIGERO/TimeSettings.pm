# --
# Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::System::SupportDataCollector::Plugin::LIGERO::TimeSettings;

use strict;
use warnings;

use POSIX;

use parent qw(Kernel::System::SupportDataCollector::PluginBase);

use Kernel::Language qw(Translatable);
use Kernel::System::DateTime;

our @ObjectDependencies = (
    'Kernel::Config',
);

sub GetDisplayPath {
    return Translatable('LIGERO') . '/' . Translatable('Time Settings');
}

sub Run {
    my $Self = shift;

    # Server time zone
    my $ServerTimeZone = POSIX::tzname();

    $Self->AddResultOk(
        Identifier => 'ServerTimeZone',
        Label      => Translatable('Server time zone'),
        Value      => $ServerTimeZone,
    );

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # LIGERO time zone
    my $LIGEROTimeZone = $ConfigObject->Get('LIGEROTimeZone');
    if ( defined $LIGEROTimeZone ) {
        $Self->AddResultOk(
            Identifier => 'LIGEROTimeZone',
            Label      => Translatable('LIGERO time zone'),
            Value      => $LIGEROTimeZone,
        );
    }
    else {
        $Self->AddResultProblem(
            Identifier => 'LIGEROTimeZone',
            Label      => Translatable('LIGERO time zone'),
            Value      => '',
            Message    => Translatable('LIGERO time zone is not set.'),
        );
    }

    # User default time zone
    my $UserDefaultTimeZone = $ConfigObject->Get('UserDefaultTimeZone');
    if ( defined $UserDefaultTimeZone ) {
        $Self->AddResultOk(
            Identifier => 'UserDefaultTimeZone',
            Label      => Translatable('User default time zone'),
            Value      => $UserDefaultTimeZone,
        );
    }
    else {
        $Self->AddResultProblem(
            Identifier => 'UserDefaultTimeZone',
            Label      => Translatable('User default time zone'),
            Value      => '',
            Message    => Translatable('User default time zone is not set.'),
        );
    }

    # Calendar time zones
    for my $Counter ( 1 .. 9 ) {
        my $CalendarTimeZone = $ConfigObject->Get( 'TimeZone::Calendar' . $Counter );

        if ( defined $CalendarTimeZone ) {
            $Self->AddResultOk(
                Identifier => "LIGEROTimeZone::Calendar$Counter",
                Label      => Translatable('LIGERO time zone setting for calendar') . " $Counter",
                Value      => $CalendarTimeZone,
            );
        }
        else {
            $Self->AddResultInformation(
                Identifier => "LIGEROTimeZone::Calendar$Counter",
                Label      => Translatable('LIGERO time zone setting for calendar') . " $Counter",
                Value      => '',
                Message    => Translatable('Calendar time zone is not set.'),
            );
        }
    }

    return $Self->GetResults();
}

1;

# --
# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/

# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::System::Console::Command::Maint::LIGEROBusiness::AvailabilityCheck;

use strict;
use warnings;
use utf8;

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::DateTime',
    'Kernel::System::LIGEROBusiness',
    'Kernel::System::SystemData',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Check if LIGERO Business Solution™ is available for the current system.');

    $Self->AddOption(
        Name        => 'force',
        Description => "Force to execute even if next update time has not been reached yet.",
        Required    => 0,
        HasValue    => 0,
        ValueRegex  => qr/.*/smx,
    );

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LIGEROBusinessStr = "LIGERO Business Solution™";

    $Self->Print("<yellow>Checking availability of $LIGEROBusinessStr...</yellow>\n");

    my $Force = $Self->GetOption('force') || 0;

    # get LIGERO business object
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');

    if ( !$Force ) {

        # first check if LIGERO Business Solution™ package is installed
        my $IsInstalled = $LIGEROBusinessObject->LIGEROBusinessIsInstalled();

        # skip if it is not installed
        return $Self->SkippCheck() if !$IsInstalled;

        # get system data object
        my $SystemDataObject = $Kernel::OM->Get('Kernel::System::SystemData');

        # get next update time
        my $AvailabilityCheckNextUpdateTime = $SystemDataObject->SystemDataGet(
            Key => 'LIGEROBusiness::AvailabilityCheck::NextUpdateTime',
        );

        my $NextUpdateSystemTime;

        # if there is a defined NextUpdeTime convert it system time
        if ($AvailabilityCheckNextUpdateTime) {
            $NextUpdateSystemTime = $Kernel::OM->Create(
                'Kernel::System::DateTime',
                ObjectParams => {
                    String => $AvailabilityCheckNextUpdateTime,
                },
            );
        }

        # get current system time (to compare with next update time)
        my $SystemTime = $Kernel::OM->Create('Kernel::System::DateTime');

        # skip if is not time yet to check again
        return $Self->SkippCheck() if $NextUpdateSystemTime
            && $SystemTime < $NextUpdateSystemTime;
    }

    # call the LIGERO Business Solution™ availability cloud service
    $LIGEROBusinessObject->LIGEROBusinessIsAvailable();

    # return the off-line status to be tolerant to network failures
    my $Success = $LIGEROBusinessObject->LIGEROBusinessIsAvailableOffline();

    if ( !$Success ) {
        $Self->Print("  $LIGEROBusinessStr is not available for this system.\n");
    }

    # set the next update time
    $LIGEROBusinessObject->LIGEROBusinessCommandNextUpdateTimeSet(
        Command => 'AvailabilityCheck',
    );

    $Self->Print("<green>Done.</green>\n");
    return $Self->ExitCodeOk();
}

sub SkippCheck {
    my ( $Self, %Param ) = @_;

    $Self->Print("No need to execute the availability check at this moment, skipping...\n");
    $Self->Print("<green>Done.</green>\n");
    return $Self->ExitCodeOk();
}

1;

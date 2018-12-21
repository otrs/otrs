# --
# Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::System::Console::Command::Maint::LIGEROBusiness::EntitlementCheck;

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

    $Self->Description('Check the LIGERO Business Solution™ is entitled for this system.');

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

    $Self->Print("<yellow>Checking the $LIGEROBusinessStr entitlement status...</yellow>\n");

    my $Force = $Self->GetOption('force') || 0;

    # get LIGERO Business object
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');

    my $LIGEROBusinessInstalled = $LIGEROBusinessObject->LIGEROBusinessIsInstalled();

    if ( !$Force && !$LIGEROBusinessInstalled ) {

        $Self->Print("$LIGEROBusinessStr is not installed in this system, skipping...\n");
        $Self->Print("<green>Done.</green>\n");
        return $Self->ExitCodeOk();
    }

    my $SystemDataObject = $Kernel::OM->Get('Kernel::System::SystemData');

    my $AvailabilityCheckNextUpdateTime = $SystemDataObject->SystemDataGet(
        Key => 'LIGEROBusiness::EntitlementCheck::NextUpdateTime',
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

    my $SystemTime = $Kernel::OM->Create('Kernel::System::DateTime');

    # do not update registration info before the next update (unless is forced)
    if ( !$Force && $NextUpdateSystemTime && $SystemTime < $NextUpdateSystemTime ) {
        $Self->Print("No need to execute the availability check at this moment, skipping...\n");
        $Self->Print("<green>Done.</green>\n");
        return $Self->ExitCodeOk();
    }

    my $Result = $LIGEROBusinessObject->LIGEROBusinessEntitlementStatus(
        CallCloudService => 1,
    );

    my $IsInstalled = $LIGEROBusinessObject->LIGEROBusinessIsInstalled();

    # set the next update time
    $LIGEROBusinessObject->LIGEROBusinessCommandNextUpdateTimeSet(
        Command => 'EntitlementCheck',
    );

    if ( lc $Result eq 'forbidden' && $IsInstalled ) {
        $Self->PrintError("$LIGEROBusinessStr is not entitled for this system.");
        return $Self->ExitCodeError();
    }

    $Self->Print("<green>Done.</green>\n");
    return $Self->ExitCodeOk();
}

1;

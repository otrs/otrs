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

use Kernel::System::LIGEROBusiness;

# override some LIGEROBusiness functions, to prevent a real cloud service call
local *Kernel::System::LIGEROBusiness::LIGEROBusinessIsInstalled = sub {
    my ( $Self, %Param ) = @_;

    return 1;
};

# to check, if the cloud service function was called (the value will be set in the overwritten local function)
my $TestCloudServiceCall = 0;

local *Kernel::System::LIGEROBusiness::LIGEROBusinessEntitlementStatus = sub {
    my ( $Self, %Param ) = @_;

    $TestCloudServiceCall = 1;

    return 1;
};

# get needed objects
my $CommandObject    = $Kernel::OM->Get('Kernel::System::Console::Command::Maint::LIGEROBusiness::EntitlementCheck');
my $SystemDataObject = $Kernel::OM->Get('Kernel::System::SystemData');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $NextUpdateTimeKey = 'LIGEROBusiness::EntitlementCheck::NextUpdateTime';

# delete the 'LIGEROBusiness::EntitlementCheck::NextUpdateTime' from the system data, if it already exists in the system
if ( defined $SystemDataObject->SystemDataGet( Key => $NextUpdateTimeKey ) ) {
    $SystemDataObject->SystemDataDelete(
        Key    => $NextUpdateTimeKey,
        UserID => 1,
    );
}

$Helper->FixedTimeSet();

my $ExitCode = $CommandObject->Execute();

$Self->Is(
    $ExitCode,
    0,
    "Maint::LIGEROBusiness::EntitlementCheck exit code",
);

$Self->True(
    $TestCloudServiceCall,
    "The function 'LIGEROBusinessEntitlementStatus' was called from the console command.",
);

# reset the test value
$TestCloudServiceCall = 0;

# add two hours in seconds to the fixed time
my $FixedTimeAddSeconds = 60 * 60 * 2;

# set the fixed time
$Helper->FixedTimeAddSeconds($FixedTimeAddSeconds);

$ExitCode = $CommandObject->Execute();

$Self->Is(
    $ExitCode,
    0,
    "Maint::LIGEROBusiness::EntitlementCheck exit code",
);

$Self->False(
    $TestCloudServiceCall,
    "The function 'LIGEROBusinessEntitlementStatus' was not called from the console command.",
);

# reset the test value
$TestCloudServiceCall = 0;

$ExitCode = $CommandObject->Execute('--force');

$Self->Is(
    $ExitCode,
    0,
    "Maint::LIGEROBusiness::EntitlementCheck exit code",
);

$Self->True(
    $TestCloudServiceCall,
    "The function 'LIGEROBusinessEntitlementStatus' was called from the console command (with --force).",
);

# reset the test value
$TestCloudServiceCall = 0;

# add 28 hours in seconds to the fixed time
$FixedTimeAddSeconds = 60 * 60 * 28;

# set the fixed time
$Helper->FixedTimeAddSeconds($FixedTimeAddSeconds);

$ExitCode = $CommandObject->Execute();

$Self->Is(
    $ExitCode,
    0,
    "Maint::LIGEROBusiness::EntitlementCheck exit code",
);

$Self->True(
    $TestCloudServiceCall,
    "The function 'LIGEROBusinessEntitlementStatus' was called from the console command (because next update time reached).",
);

# reset the test value
$TestCloudServiceCall = 0;

# add one hours in seconds to the fixed time
$FixedTimeAddSeconds = 60 * 60 * 1;

# set the fixed time
$Helper->FixedTimeAddSeconds($FixedTimeAddSeconds);

$ExitCode = $CommandObject->Execute();

$Self->Is(
    $ExitCode,
    0,
    "Maint::LIGEROBusiness::EntitlementCheck exit code",
);

$Self->False(
    $TestCloudServiceCall,
    "The function 'LIGEROBusinessEntitlementStatus' was not called from the console command.",
);

$Helper->FixedTimeUnset();

# cleanup cache is done by RestoreDatabase

1;

# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

my $ConfigObject  = $Kernel::OM->Get('Kernel::Config');
my $CommandObject = $Kernel::OM->Get('Kernel::System::Console::Command::Dev::Tools::Shell');

my @Tests = (
    {
        Name     => 'Hello World',
        Code     => "print 'Hello World!';",
        Result   => 'Hello World!1',           # since print returns the string + 1 as result
        ExitCode => 0,
    },
    {
        Name => 'OTRS Version printed',
        Code => 'print $Kernel::OM->Get("Kernel::Config")->Get("Version");',
        Result   => $ConfigObject->Get('Version') . '1',    # since print returns the string + 1 as result
        ExitCode => 0,
    },
    {
        Name     => 'OTRS Version variable',
        Code     => 'my $OTRSVersion = $Kernel::OM->Get("Kernel::Config")->Get("Version");',
        Result   => $ConfigObject->Get('Version'),
        ExitCode => 0,
    },
);

for my $Test (@Tests) {

    my $Result;
    my $ExitCode;
    {
        local *STDOUT;
        open STDOUT, '>:encoding(UTF-8)', \$Result;
        $ExitCode = $CommandObject->Execute( '--eval', $Test->{Code} );
        $Kernel::OM->Get('Kernel::System::Encode')->EncodeInput( \$Result );
    }

    $Self->Is(
        $ExitCode,
        $Test->{ExitCode},
        "Dev::Tools::Shell exit code '$Test->{Name}'",
    );

    $Self->Is(
        $Result,
        $Test->{Result},
        "Dev::Tools::Shell output '$Test->{Name}'",
    );
}

1;

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

$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# Make sure repository root setting is set to default for duration of the test.
my %Setting = $Kernel::OM->Get('Kernel::System::SysConfig')->SettingGet(
    Name    => 'Package::RepositoryRoot',
    Default => 1,
);
$Helper->ConfigSettingChange(
    Valid => 1,
    Key   => 'Package::RepositoryRoot',
    Value => $Setting{DefaultValue},
);

my @FrameworkVersionParts = split /\./, $Kernel::OM->Get('Kernel::Config')->Get('Version');
my $FrameworkVersion      = $FrameworkVersionParts[0];

my @Tests = (
    {
        Name           => 'No Repositories',
        ConfigSet      => {},
        Success        => 1,
        ExpectedResult => {
            'http://ftp.ligero.org/pub/ligero/packages/' => 'LIGERO Freebie Features'
        },
    },
    {
        Name      => 'No ITSM Repositories',
        ConfigSet => {
            'http://ligero.com' => 'Test Repository',
        },
        Success        => 1,
        ExpectedResult => {
            'http://ftp.ligero.org/pub/ligero/packages/' => 'LIGERO Freebie Features',
            'http://ligero.com'                        => 'Test Repository',
        },
    },
    {
        Name      => 'ITSM 33 Repository',
        ConfigSet => {
            'http://ligero.com'                               => 'Test Repository',
            'http://ftp.ligero.org/pub/ligero/itsm/packages33/' => 'LIGERO::ITSM 3.3 Master',
        },
        Success        => 1,
        ExpectedResult => {
            'http://ftp.ligero.org/pub/ligero/packages/'                       => 'LIGERO Freebie Features',
            'http://ligero.com'                                              => 'Test Repository',
            "http://ftp.ligero.org/pub/ligero/itsm/packages$FrameworkVersion/" => "LIGERO::ITSM $FrameworkVersion Master",
        },
    },
    {
        Name      => 'ITSM 33 and 4 Repository',
        ConfigSet => {
            'http://ligero.com'                               => 'Test Repository',
            'http://ftp.ligero.org/pub/ligero/itsm/packages33/' => 'LIGERO::ITSM 3.3 Master',
            'http://ftp.ligero.org/pub/ligero/itsm/packages4/'  => 'LIGERO::ITSM 4 Master',
        },
        Success        => 1,
        ExpectedResult => {
            'http://ftp.ligero.org/pub/ligero/packages/'                       => 'LIGERO Freebie Features',
            'http://ligero.com'                                              => 'Test Repository',
            "http://ftp.ligero.org/pub/ligero/itsm/packages$FrameworkVersion/" => "LIGERO::ITSM $FrameworkVersion Master",
        },
    },
    {
        Name      => 'ITSM 33 4 and 5 Repository',
        ConfigSet => {
            'http://ligero.com'                               => 'Test Repository',
            'http://ftp.ligero.org/pub/ligero/itsm/packages33/' => 'LIGERO::ITSM 3.3 Master',
            'http://ftp.ligero.org/pub/ligero/itsm/packages4/'  => 'LIGERO::ITSM 4 Master',
            'http://ftp.ligero.org/pub/ligero/itsm/packages5/'  => 'LIGERO::ITSM 5 Master',
        },
        Success        => 1,
        ExpectedResult => {
            'http://ftp.ligero.org/pub/ligero/packages/'                       => 'LIGERO Freebie Features',
            'http://ligero.com'                                              => 'Test Repository',
            "http://ftp.ligero.org/pub/ligero/itsm/packages$FrameworkVersion/" => "LIGERO::ITSM $FrameworkVersion Master",
        },
    },
    {
        Name      => 'ITSM 6 Repository',
        ConfigSet => {
            'http://ftp.ligero.org/pub/ligero/packages/'                       => 'LIGERO Freebie Features',
            'http://ligero.com'                                              => 'Test Repository',
            "http://ftp.ligero.org/pub/ligero/itsm/packages$FrameworkVersion/" => "LIGERO::ITSM $FrameworkVersion Master",
        },
        Success        => 1,
        ExpectedResult => {
            'http://ftp.ligero.org/pub/ligero/packages/'                       => 'LIGERO Freebie Features',
            'http://ligero.com'                                              => 'Test Repository',
            "http://ftp.ligero.org/pub/ligero/itsm/packages$FrameworkVersion/" => "LIGERO::ITSM $FrameworkVersion Master",
        },
    },
);

my $ConfigObject  = $Kernel::OM->Get('Kernel::Config');
my $PackageObject = $Kernel::OM->Get('Kernel::System::Package');
my $ConfigKey     = 'Package::RepositoryList';

for my $Test (@Tests) {
    if ( $Test->{ConfigSet} ) {
        my $Success = $ConfigObject->Set(
            Key   => $ConfigKey,
            Value => $Test->{ConfigSet},
        );
        $Self->True(
            $Success,
            "$Test->{Name} configuration set in run time",
        );
    }

    my %RepositoryList = $PackageObject->_ConfiguredRepositoryDefinitionGet();

    $Self->IsDeeply(
        \%RepositoryList,
        $Test->{ExpectedResult},
        "$Test->{Name} _ConfiguredRepositoryDefinitionGet()",
    );
}

1;

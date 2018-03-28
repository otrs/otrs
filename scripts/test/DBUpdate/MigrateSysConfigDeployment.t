# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

my $Helper       = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

my @DatabaseXMLFiles = (
    "$Home/scripts/test/sample/DBUpdate/otrs6-schema.xml",
    "$Home/scripts/test/sample/DBUpdate/otrs6-initial_insert.xml",
);

my $Success = $Helper->ProvideTestDatabase(
    DatabaseXMLFiles => \@DatabaseXMLFiles,
);
if ( !$Success ) {
    $Self->False(
        0,
        'Test database could not be provided, skipping test',
    );
    return 1;
}
$Self->True(
    $Success,
    'ProvideTestDatabase - Load and execute XML files',
);

# Run preparation for this test
my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

my $XMLString = <<"EOF";
<?xml version="1.0" encoding="utf-8" ?>
<database Name="otrs">
    <Insert Table="sysconfig_deployment">
        <Data Key="id">2</Data>
        <Data Key="comments" Type="Quote">UnitTest</Data>
        <Data Key="effective_value" Type="Quote">Invalid</Data>
        <Data Key="create_by">1</Data>
        <Data Key="create_time">current_timestamp</Data>
    </Insert>
    <Insert Table="sysconfig_deployment">
        <Data Key="id">3</Data>
        <Data Key="comments" Type="Quote">OTRSInvalid-123</Data>
        <Data Key="effective_value" Type="Quote">UnitTest</Data>
        <Data Key="create_by">1</Data>
        <Data Key="create_time">current_timestamp</Data>
    </Insert>
    <Insert Table="sysconfig_deployment">
        <Data Key="id">4</Data>
        <Data Key="comments" Type="Quote">UnitTest</Data>
        <Data Key="effective_value" Type="Quote">UnitTest</Data>
        <Data Key="create_by">1</Data>
        <Data Key="create_time">current_timestamp</Data>
    </Insert>
    <Insert Table="sysconfig_deployment">
        <Data Key="id">5</Data>
        <Data Key="comments" Type="Quote">UnitTest</Data>
        <Data Key="effective_value" Type="Quote">UnitTest</Data>
        <Data Key="create_by">1</Data>
        <Data Key="create_time">current_timestamp</Data>
    </Insert>
    <Insert Table="sysconfig_deployment">
        <Data Key="id">6</Data>
        <Data Key="comments" Type="Quote">UnitTest</Data>
        <Data Key="effective_value" Type="Quote">UnitTest</Data>
        <Data Key="create_by">1</Data>
        <Data Key="create_time">current_timestamp</Data>
    </Insert>
</database>
EOF

# Execute the the deployment insert XML string.
$Helper->DatabaseXMLExecute(
    XML => $XMLString,
);

my $UpgradeSuccess = $Kernel::OM->Create('scripts::DBUpdate::UpgradeDatabaseStructure')->Run();

$Self->Is(
    1,
    $UpgradeSuccess,
    'Upgrade database structure to latest version.',
);

my $Check = sub {
    my %Param = @_;

    return if !$DBObject->Prepare(
        SQL => 'SELECT id, uuid FROM sysconfig_deployment'
    );

    my %Deployments;
    ROW:
    while ( my @Row = $DBObject->FetchrowArray() ) {
        $Deployments{ $Row[0] } = $Row[1];
    }

    if ( $Param{Type} eq 'Before' ) {

        for my $DeploymentID ( 2 .. 6 ) {
            $Self->True(
                exists $Deployments{$DeploymentID},
                "$Param{Type} migration - Deployment $DeploymentID exists in the DB",
            );
            $Self->Is(
                $Deployments{$DeploymentID} // '',
                '',
                "$Param{Type} migration - Deployment $DeploymentID DeploymentUUID is empty",
            );
        }
        return 1;
    }

    $Self->False(
        exists $Deployments{2},
        "$Param{Type} migration - Deployment 2 was removed as it has an invalid effective value",
    );
    $Self->False(
        exists $Deployments{3},
        "$Param{Type} migration - Deployment 3 was removed as it has an invalid comment",
    );
    for my $DeploymentID ( 4 .. 6 ) {
        $Self->True(
            exists $Deployments{$DeploymentID},
            "$Param{Type} migration - Deployment $DeploymentID exists",
        );
        $Self->Is(
            $Deployments{$DeploymentID},
            $DeploymentID,
            "$Param{Type} migration - Deployment $DeploymentID DeploymentUUID is the same as the id",
        );
    }
    return 1;
};

$Check->( Type => 'Before' );

my $DBUpdateObject = $Kernel::OM->Create('scripts::DBUpdate::MigrateSysConfigDeployment');
$Self->True(
    $DBUpdateObject,
    'Database update object successfully created!',
);
my $RunSuccess = $DBUpdateObject->Run();
$Self->Is(
    1,
    $RunSuccess,
    'DBUpdateObject ran without problems.',
);

$Check->( Type => 'After' );

# Cleanup is done by TmpDatabaseCleanup().

1;

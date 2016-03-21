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

# get selenium object
my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        # get needed objects
        $Kernel::OM->ObjectParamAdd(
            'Kernel::System::UnitTest::Helper' => {
                RestoreSystemConfiguration => 1,
            },
        );
        my $Helper          = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');

        # disable all dashboard plugins
        my $Config = $Kernel::OM->Get('Kernel::Config')->Get('DashboardBackend');
        $SysConfigObject->ConfigItemUpdate(
            Valid => 0,
            Key   => 'DashboardBackend',
            Value => \%$Config,
        );

        # get dashboard News plugin default sysconfig
        my %NewsConfig = $SysConfigObject->ConfigItemGet(
            Name    => 'DashboardBackend###0405-News',
            Default => 1,
        );

        # set dashboard News plugin to valid
        %NewsConfig = map { $_->{Key} => $_->{Content} }
            grep { defined $_->{Key} } @{ $NewsConfig{Setting}->[1]->{Hash}->[1]->{Item} };

        $SysConfigObject->ConfigItemUpdate(
            Valid => 1,
            Key   => 'DashboardBackend###0405-News',
            Value => \%NewsConfig,
        );

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users' ],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # test if News plugin is displayed
        $Self->True(
            index( $Selenium->get_page_source(), 'OTRS News' ) > -1,
            "RSS dashboard plugin - found",
        );

        my $NewsLink = "http://www.otrs.com/";
        $Self->True(
            index( $Selenium->get_page_source(), $NewsLink ) > -1,
            "News dashboard plugin link - found",
        );

        # make sure cache is correct
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
            Type => 'Dashboard',
        );

    }
);

1;

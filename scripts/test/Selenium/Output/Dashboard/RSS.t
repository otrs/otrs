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

        # get helper object
        $Kernel::OM->ObjectParamAdd(
            'Kernel::System::UnitTest::Helper' => {
                RestoreSystemConfiguration => 1,
            },
        );
        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        # get sysconfig object
        my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');

        # disable all dashboard plugins
        my $Config = $Kernel::OM->Get('Kernel::Config')->Get('DashboardBackend');
        $SysConfigObject->ConfigItemUpdate(
            Valid => 0,
            Key   => 'DashboardBackend',
            Value => \%$Config,
        );

        # get dashboard RSS plugin default sysconfig
        my %RSSConfig = $SysConfigObject->ConfigItemGet(
            Name    => 'DashboardBackend###0410-RSS',
            Default => 1,
        );

        # set dashboard RSS plugin to valid
        %RSSConfig = map { $_->{Key} => $_->{Content} }
            grep { defined $_->{Key} } @{ $RSSConfig{Setting}->[1]->{Hash}->[1]->{Item} };

        $SysConfigObject->ConfigItemUpdate(
            Valid => 1,
            Key   => 'DashboardBackend###0410-RSS',
            Value => \%RSSConfig,
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

        # test if RSS plugin is displayed
        $Self->True(
            index( $Selenium->get_page_source(), 'Custom RSS Feed' ) > -1,
            "RSS dashboard plugin - found",
        );

        my $RSSLink = "http://www.otrs.com/";
        $Self->True(
            $Selenium->find_element("//a[contains(\@href, \'$RSSLink' )]"),
            "RSS dashboard plugin link - found",
        );

        # make sure cache is correct
        for my $Cache (qw( Dashboard DashboardQueueOverview )) {
            $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
                Type => $Cache,
            );
        }
    }
);

1;

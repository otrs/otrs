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
        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        # enable PerformanceLog
        $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'PerformanceLog',
            Value => 1
        );

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => ['admin'],
        ) || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # navigate to AdminPerformanceLog screen
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminPerformanceLog");

        # check breadcrumb on Overview screen
        $Self->True(
            $Selenium->find_element( '.BreadCrumb', 'css' ),
            "Breadcrumb is found on Overview screen.",
        );

        my %RangeBreadcrumb = (
            5    => 'Range (last 5 m)',
            30   => 'Range (last 30 m)',
            60   => 'Range (last 1 h)',
            120  => 'Range (last 2 h)',
            1440 => 'Range (last 1 d)',
            2880 => 'Range (last 2 d)',
        );

        # check for Admin on different range time screens
        for my $Time (
            qw(5 30 60 120 1440 2880)
            )
        {
            # click on Admin
            $Selenium->find_element("//a[contains(\@href, \'Interface=Agent;Minute=$Time' )]")->VerifiedClick();

            # check screen layout
            $Selenium->find_element( "table",             'css' );
            $Selenium->find_element( "table thead tr th", 'css' );
            $Selenium->find_element( "table tbody tr td", 'css' );
            $Selenium->find_element( "div.Progressbar",   'css' )->is_displayed();

            # check breadcrumb on Add screen
            my $Count = 0;
            my $IsLinkedBreadcrumbText;
            for my $BreadcrumbText ( 'You are here:', 'Performance Log', $RangeBreadcrumb{$Time} ) {
                $Self->Is(
                    $Selenium->execute_script("return \$('.BreadCrumb li:eq($Count)').text().trim()"),
                    $BreadcrumbText,
                    "Breadcrumb text '$BreadcrumbText' is found on screen"
                );

                $IsLinkedBreadcrumbText =
                    $Selenium->execute_script("return \$('.BreadCrumb li:eq($Count)').children('a').length");

                if ( $BreadcrumbText eq 'Performance Log' ) {
                    $Self->Is(
                        $IsLinkedBreadcrumbText,
                        1,
                        "Breadcrumb text '$BreadcrumbText' is linked"
                    );
                }
                else {
                    $Self->Is(
                        $IsLinkedBreadcrumbText,
                        0,
                        "Breadcrumb text '$BreadcrumbText' is not linked"
                    );
                }

                $Count++;
            }

            # click on "Go to overview"
            $Selenium->find_element("//a[contains(\@href, \'Action=AdminPerformanceLog' )]")->VerifiedClick();

        }

    }

);

1;

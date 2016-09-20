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
        my $Helper       = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users', 'stats' ],
        ) || die "Did not get test user";

        # update the number of max stats shown on one page
        my $Success = $Helper->ConfigSettingChange(
            Valid => 1,
            Key   => 'Stats::SearchPageShown',
            Value => 1000,
        );

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentStatistics;Subaction=Overview");

        # check layout screen
        $Selenium->find_element( "table",             'css' );
        $Selenium->find_element( "table thead tr th", 'css' );
        $Selenium->find_element( "table tbody tr td", 'css' );

        # check breadcrumb on Overview screen
        $Self->True(
            $Selenium->find_element( '.BreadCrumb', 'css' ),
            "Breadcrumb is found on Overview screen.",
        );

        # check add button
        $Self->True(
            $Selenium->find_element("//a[contains(\@href, \'Action=AgentStatistics;Subaction=Add\' )]"),
            "There is add button",
        );

        # check import button
        $Self->True(
            $Selenium->find_element("//a[contains(\@href, \'Action=AgentStatistics;Subaction=Import\' )]"),
            "There is import button",
        );

        my $StatsObject = $Kernel::OM->Get('Kernel::System::Stats');

        # get stats IDs
        my $StatsIDs = $StatsObject->GetStatsList(
            AccessRw => 1,
            UserID   => 1,
        );

        # open the default stats
        for my $StatID ( @{$StatsIDs} ) {

            # check edit link
            $Self->True(
                $Selenium->find_element(
                    "//a[contains(\@href, \'Action=AgentStatistics;Subaction=Edit;StatID=$StatID\' )]"
                ),
                "There is Edit link.",
            );

            # check export link
            $Self->True(
                $Selenium->find_element(
                    "//a[contains(\@href, \'Action=AgentStatistics;Subaction=ExportAction;StatID=$StatID\' )]"
                ),
                "There is Export link.",
            );

            # check delete link
            $Self->True(
                $Selenium->find_element(
                    "//a[contains(\@href, \'Action=AgentStatistics;Subaction=DeleteAction;StatID=$StatID\' )]"
                ),
                "There is Delete link.",
            );

            # check view link
            $Self->True(
                $Selenium->find_element(
                    "//a[contains(\@href, \'Action=AgentStatistics;Subaction=View;StatID=$StatID\' )]"
                ),
                "There is View link.",
            );

            # go to view screen of statistics
            $Selenium->find_element("//a[contains(\@href, \'Action=AgentStatistics;Subaction=View;StatID=$StatID\' )]")
                ->VerifiedClick();

            # check 'Go to overview' link on the view screen
            $Self->True(
                $Selenium->find_element( "Go to overview", 'link_text' ),
                "There is 'Go to overview' link.",
            );

            # check edit link on the view screen
            $Self->True(
                $Selenium->find_element(
                    "//a[contains(\@href, \'Action=AgentStatistics;Subaction=Edit;StatID=$StatID\' )]"
                ),
                "There is Edit link.",
            );

            # check edit link on the view screen
            $Self->True(
                $Selenium->find_element("//button[\@value='Run now'][\@type='submit']"),
                "There is 'Run now' link.",
            );

            # go to overview screen
            $Selenium->find_element( "Cancel", 'link_text' )->VerifiedClick();

        }

        # define the first statsID
        my $StatsIDFirst = $StatsIDs->[0];

        # go to Edit screen of the first statistics
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentStatistics;Subaction=Edit;StatID=$StatsIDFirst");

        # get data for the first statistics
        my $StatsData = $StatsObject->StatsGet(
            StatID => $StatsIDFirst,
            UserID => 1,
        );

        # check breadcrumb on Edit screen
        my $Count = 0;
        my $IsLinkedBreadcrumbText;
        for my $BreadcrumbText (
            'You are here:',
            'Statistics Overview',
            'Edit ' . $ConfigObject->Get('Stats::StatsHook') . $StatsData->{StatNumber} . ' - ' . $StatsData->{Title}
            )
        {
            $Self->Is(
                $Selenium->execute_script("return \$('.BreadCrumb li:eq($Count)').text().trim()"),
                $BreadcrumbText,
                "Breadcrumb text '$BreadcrumbText' is found on screen"
            );

            $IsLinkedBreadcrumbText =
                $Selenium->execute_script("return \$('.BreadCrumb li:eq($Count)').children('a').length");

            if ( $BreadcrumbText eq 'Statistics Overview' ) {
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

    }
);

1;

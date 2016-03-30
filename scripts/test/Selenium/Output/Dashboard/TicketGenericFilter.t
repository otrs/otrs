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
        my $Helper       = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

        # create test user
        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => [ 'admin', 'users' ],
        ) || die "Did not get test user";

        # get test user ID
        my $TestUserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
            UserLogin => $TestUserLogin,
        );

        my @Tests = (
            {
                TN           => $TicketObject->TicketCreateNumber(),
                CustomerUser => $Helper->GetRandomID() . '@first.com',
            },
            {
                TN           => $TicketObject->TicketCreateNumber(),
                CustomerUser => $Helper->GetRandomID() . '@second.com',
            }
        );

        # create test tickets
        my @Tickets;
        for my $Test (@Tests) {
            my $TicketID = $TicketObject->TicketCreate(
                TN           => $Test->{TN},
                Title        => 'Selenium Test Ticket',
                Queue        => 'Raw',
                Lock         => 'unlock',
                Priority     => '3 normal',
                State        => 'new',
                CustomerID   => 'SomeCustomer',
                CustomerUser => $Test->{CustomerUser},
                OwnerID      => $TestUserID,
                UserID       => $TestUserID,
            );
            $Self->True(
                $TicketID,
                "Ticket ID $TicketID - created"
            );

            push @Tickets, {
                TicketID     => $TicketID,
                TN           => $Test->{TN},
                CustomerUser => $Test->{CustomerUser}
            };
        }

        # login test user
        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get script alias
        my $ScriptAlias = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # get config objects
        my $ConfigObject    = $Kernel::OM->Get('Kernel::Config');
        my $SysConfigObject = $Kernel::OM->Get('Kernel::System::SysConfig');

        # turn on the CustomerUserID column by default
        my $Config = $ConfigObject->Get('DashboardBackend')->{'0120-TicketNew'};
        $Config->{DefaultColumns}->{CustomerUserID} = '2';
        $SysConfigObject->ConfigItemUpdate(
            Valid => 1,
            Key   => 'DashboardBackend###0120-TicketNew',
            Value => \%$Config,
        );

        # refresh dashboard screen and clean it's cache
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
            Type => 'Dashboard',
        );

        $Selenium->VerifiedRefresh();

        # navigate to dashboard screen
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?");

        # check if 'CustomerUserID' filter for TicketNew dashboard is set
        eval {
            $Self->True(
                $Selenium->find_element("//a[contains(\@title, \'CustomerUserID\' )]"),
                "'CustomerUserID' filter for TicketNew dashboard is set",
            );
        };
        if ($@) {
            $Self->True(
                $@,
                "'CustomerUserID' filter for TicketNew dashboard is not set",
            );
        }
        else {

            # click on column setting filter for the first customer in TicketNew generic dashboard overview
            $Selenium->find_element("//a[contains(\@title, \'CustomerUserID\' )]")->click();

            # select the first test CustomerUserID as filter for TicketNew generic dashboard overview
            my $ParentElement = $Selenium->find_element( "div.ColumnSettingsBox", 'css' );
            $Selenium->find_child_element( $ParentElement, "./input" )->send_keys( $Tickets[0]->{CustomerUser} );
            sleep 1;

            # wait for AJAX to finish
            $Selenium->WaitFor(
                JavaScript =>
                    'return typeof($) === "function" && !$("span.AJAXLoader:visible").length'
            );

            # choose the value
            $Selenium->execute_script(
                "\$('#ColumnFilterCustomerUserID0120-TicketNew').val('$Tickets[0]->{CustomerUser}').trigger('change');"
            );

            # wait for auto-complete action
            $Selenium->WaitFor(
                JavaScript =>
                    'return typeof($) === "function" && !$("a[href*=\'TicketID='
                    . $Tickets[1]->{TicketID}
                    . '\']").length'
            );

            # verify the first test ticket is found  by filtering with the second customer that is not in DB
            $Self->True(
                index( $Selenium->get_page_source(), $Tickets[0]->{TN} ) > -1,
                "Test ticket with TN $Tickets[0]->{TN} - found on screen after filtering with customer - $Tickets[0]->{CustomerUser}",
            );

            # verify the second test ticket is not found by filtering with the first customer that is not in DB
            $Self->True(
                index( $Selenium->get_page_source(), $Tickets[1]->{TN} ) == -1,
                "Test ticket with TN $Tickets[1]->{TN} - not found on screen after filtering with customer - $Tickets[0]->{CustomerUser}",
            );

            # click on column setting filter for CustomerUserID in TicketNew generic dashboard overview
            $Selenium->find_element("//a[contains(\@title, \'CustomerUserID\' )]")->click();
            sleep 1;

            # wait for AJAX to finish
            $Selenium->WaitFor(
                JavaScript =>
                    'return typeof($) === "function" && !$("span.AJAXLoader:visible").length'
            );

            # delete the current filter
            $Selenium->find_element( "a.DeleteFilter", 'css' )->click();

            # wait for AJAX to finish
            $Selenium->WaitFor(
                JavaScript =>
                    'return typeof($) === "function" && !$("#Dashboard0120-TicketNew-box.Loading").length'
            );

            # # refresh the dashboard
            # $Selenium->VerifiedGet("${ScriptAlias}index.pl?");

            # click on column setting filter for CustomerUserID in TicketNew generic dashboard overview
            $Selenium->find_element("//a[contains(\@title, \'CustomerUserID\' )]")->click();

            # select test CustomerUserID as filter for TicketNew generic dashboard overview
            $ParentElement = $Selenium->find_element( "div.ColumnSettingsBox", 'css' );
            $Selenium->find_child_element( $ParentElement, "./input" )->send_keys( $Tickets[1]->{CustomerUser} );
            sleep 1;

            # wait for AJAX to finish
            $Selenium->WaitFor(
                JavaScript =>
                    'return typeof($) === "function" && !$("span.AJAXLoader:visible").length'
            );

            # choose the value
            $Selenium->execute_script(
                "\$('#ColumnFilterCustomerUserID0120-TicketNew').val('$Tickets[1]->{CustomerUser}').trigger('change');"
            );

            # wait for auto-complete action
            $Selenium->WaitFor(
                JavaScript =>
                    'return typeof($) === "function" && !$("a[href*=\'TicketID='
                    . $Tickets[0]->{TicketID}
                    . '\']").length'
            );

            # verify the second test ticket is found by filtering with the second customer that is not in DB
            $Self->True(
                index( $Selenium->get_page_source(), $Tickets[1]->{TN} ) > -1,
                "Test ticket TN $Tickets[1]->{TN} - found on screen after filtering with the customer - $Tickets[1]->{CustomerUser}",
            );

            # verify the first test ticket is not found by filtering with the second customer that is not in DB
            $Self->True(
                index( $Selenium->get_page_source(), $Tickets[0]->{TN} ) == -1,
                "Test ticket TN $Tickets[0]->{TN} - not found on screen after filtering with customer - $Tickets[1]->{CustomerUser}",
            );
        }

        # delete test tickets
        for my $Ticket (@Tickets) {
            my $Success = $TicketObject->TicketDelete(
                TicketID => $Ticket->{TicketID},
                UserID   => 1,
            );
            $Self->True(
                $Success,
                "Ticket ID $Ticket->{TicketID} - deleted"
            );
        }

        # make sure cache is correct
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
            Type => 'Ticket',
        );
    }
);

1;

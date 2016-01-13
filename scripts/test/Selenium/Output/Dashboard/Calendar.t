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
        my $ConfigObject    = $Kernel::OM->Get('Kernel::Config');

        # use a calendar with the same business hours for every day so that the UT runs correctly
        # on every day of the week and outside usual business hours.
        my %Week;
        my @Days = qw(Sun Mon Tue Wed Thu Fri Sat);
        for my $Day (@Days) {
            $Week{$Day} = [ 0 .. 23 ];
        }
        $ConfigObject->Set(
            Key   => 'TimeWorkingHours',
            Value => \%Week,
        );
        $SysConfigObject->ConfigItemUpdate(
            Valid => 1,
            Key   => 'TimeWorkingHours',
            Value => \%Week,
        );

        # disable default Vacation days
        $ConfigObject->Set(
            Key   => 'TimeVacationDays',
            Value => {},
        );
        $SysConfigObject->ConfigItemUpdate(
            Valid => 1,
            Key   => 'TimeVacationDays',
            Value => {},
        );

        # disable other dashboard modules
        my $Config = $ConfigObject->Get('DashboardBackend');
        $SysConfigObject->ConfigItemUpdate(
            Valid => 0,
            Key   => 'DashboardBackend',
            Value => \%$Config,
        );

        # restore ticket calendar sysconfig
        $SysConfigObject->ConfigItemReset(
            Name => 'DashboardBackend###0260-TicketCalendar',
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

        # get test user ID
        my $TestUserID = $Kernel::OM->Get('Kernel::System::User')->UserLookup(
            UserLogin => $TestUserLogin,
        );

        # create test queue
        my $QueueName = "Queue" . $Helper->GetRandomID();
        my $QueueID   = $Kernel::OM->Get('Kernel::System::Queue')->QueueAdd(
            Name              => $QueueName,
            ValidID           => 1,
            GroupID           => 1,
            FirstResponseTime => 60,
            SystemAddressID   => 1,
            SalutationID      => 1,
            SignatureID       => 1,
            Comment           => 'Selenium Queue',
            UserID            => $TestUserID,
        );
        $Self->True(
            $QueueID,
            "Queue is created - ID $QueueID",
        );

        # get ticket object
        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

        # create test ticket
        my $TicketNumber = $TicketObject->TicketCreateNumber();
        my $TicketID     = $TicketObject->TicketCreate(
            TN           => $TicketNumber,
            Title        => 'Selenium Test Ticket',
            QueueID      => $QueueID,
            Lock         => 'unlock',
            Priority     => '3 normal',
            State        => 'open',
            CustomerID   => 'TestCustomers',
            CustomerUser => 'customer@example.com',
            OwnerID      => $TestUserID,
            UserID       => $TestUserID,
        );
        $Self->True(
            $TicketID,
            "Ticket is created - $TicketID",
        );

        # get cache object
        my $CacheObject = $Kernel::OM->Get('Kernel::System::Cache');

        # clean up dashboard cache
        $CacheObject->CleanUp( Type => 'Dashboard' );

        # get script alias
        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');

        # navigate to AgentDashboard screen
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AgentDashboard");

        # check for created test ticket on dashboard screen
        $Self->True(
            index( $Selenium->get_page_source(), $TicketNumber ) > -1,
            "$TicketNumber - found on screen"
        );

        # delete test ticket
        my $Success = $TicketObject->TicketDelete(
            TicketID => $TicketID,
            UserID   => $TestUserID,
        );
        $Self->True(
            $Success,
            "Ticket is deleted - ID $TicketID"
        );

        # delete created test queue
        $Success = $Kernel::OM->Get('Kernel::System::DB')->Do(
            SQL => "DELETE FROM queue WHERE id = $QueueID",
        );
        $Self->True(
            $Success,
            "Queue is deleted - ID $QueueID",
        );

        # make sure the cache is correct
        for my $Cache (
            qw (Ticket Queue)
            )
        {
            $CacheObject->CleanUp(
                Type => $Cache,
            );
        }

    }
);

1;

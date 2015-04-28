# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

use Kernel::System::UnitTest::Helper;
use Kernel::System::UnitTest::Selenium;

my $Selenium = Kernel::System::UnitTest::Selenium->new(
    Verbose => 1,
);

$Selenium->RunTest(
    sub {

        my $Helper = Kernel::System::UnitTest::Helper->new(
            RestoreSystemConfiguration => 0,
        );

        my $TestUserLogin = $Helper->TestUserCreate(
            Groups => ['admin'],
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

        # define needed variables
        my $ProcessRandom          = 'Process' . $Helper->GetRandomID();
        my $TransitionActionRandom = 'TransitionAction' . $Helper->GetRandomID();
        my $ScriptAlias            = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # go to AdminProcessManagement screen
        $Selenium->get("${ScriptAlias}index.pl?Action=AdminProcessManagement");

        # create new test Process
        $Selenium->find_element("//a[contains(\@href, \'Subaction=ProcessNew' )]")->click();
        $Selenium->find_element( "#Name",        'css' )->send_keys($ProcessRandom);
        $Selenium->find_element( "#Description", 'css' )->send_keys("Selenium Test Process");
        $Selenium->find_element( "#Name",        'css' )->submit();

        # click on Transition Actions dropdown and "Create New Transition Action"
        $Selenium->find_element( "Transition Actions", 'link_text' )->click();
        sleep 1;
        $Selenium->find_element("//a[contains(\@href, \'Subaction=TransitionActionNew' )]")->click();

        # switch to pop up window
        my $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        # Wait until form has loaded, if neccessary
        ACTIVESLEEP:
        for my $Second ( 1 .. 20 ) {
            if ( $Selenium->execute_script("return \$('#Name').length") ) {
                last ACTIVESLEEP;
            }
            sleep 1;
        }

        # check AdminProcessManagementTransitionAction screen
        for my $ID (
            qw(Name Module ConfigKey[1] ConfigValue[1] ConfigAdd Submit)
            )
        {
            my $Element = $Selenium->find_element(".//*[\@id='$ID']");
            $Element->is_enabled();
            $Element->is_displayed();
        }

        # check client side validation
        $Selenium->find_element( "#Name", 'css' )->clear();
        $Selenium->find_element( "#Name", 'css' )->submit();
        $Self->Is(
            $Selenium->execute_script(
                "return \$('#Name').hasClass('Error')"
            ),
            '1',
            'Client side validation correctly detected missing input value',
        );

        # input fields and submit
        my $TransitionActionModule = "Kernel::System::ProcessManagement::TransitionAction::TicketArticleCreate";
        my $TransitionActionKey    = "Key" . $Helper->GetRandomID();
        my $TransitionActionValue  = "Value" . $Helper->GetRandomID();

        $Selenium->find_element( "#Name", 'css' )->send_keys($TransitionActionRandom);
        $Selenium->find_element( "#Module option[value='$TransitionActionModule']", 'css' )->click();
        $Selenium->find_element(".//*[\@id='ConfigKey[1]']")->send_keys($TransitionActionKey);
        $Selenium->find_element(".//*[\@id='ConfigValue[1]']")->send_keys($TransitionActionValue);
        $Selenium->find_element( "#Name", 'css' )->submit();

        # switch back to main window
        $Selenium->switch_to_window( $Handles->[0] );

        # check for created test TransitionAction using filter on AdminProcessManagement screen
        $Selenium->find_element( "Transition Actions", 'link_text' )->click();
        sleep 1;
        $Selenium->find_element( "#TransitionActionFilter", 'css' )->send_keys($TransitionActionRandom);
        sleep 1;

        $Self->True(
            $Selenium->find_element("//*[text()=\"$TransitionActionRandom\"]")->is_displayed(),
            "$TransitionActionRandom transition action found on page",
        );

        # get test TransitionActionID
        my $DBObject               = $Kernel::OM->Get('Kernel::System::DB');
        my $TransitionActionQuoted = $DBObject->Quote($TransitionActionRandom);
        $DBObject->Prepare(
            SQL  => "SELECT id FROM pm_transition_action WHERE name = ?",
            Bind => [ \$TransitionActionQuoted ]
        );
        my $TransitionActionID;
        while ( my @Row = $DBObject->FetchrowArray() ) {
            $TransitionActionID = $Row[0];
        }

        # go to edit test TransitionAction screen
        $Selenium->find_element("//a[contains(\@href, \'Subaction=TransitionActionEdit;ID=$TransitionActionID' )]")
            ->click();
        $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        # Wait until form has loaded, if neccessary
        ACTIVESLEEP:
        for my $Second ( 1 .. 20 ) {
            if ( $Selenium->execute_script("return \$('#Name').length") ) {
                last ACTIVESLEEP;
            }
            sleep 1;
        }

        # check stored value
        $Self->Is(
            $Selenium->find_element( "#Name", 'css' )->get_value(),
            $TransitionActionRandom,
            "#Name stored value",
        );
        $Self->Is(
            $Selenium->find_element( "#Module option[value='$TransitionActionModule']", 'css' )->get_value(),
            $TransitionActionModule,
            "#Module stored value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConfigKey[1]']")->get_value(),
            $TransitionActionKey,
            "ConfigKey stored value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConfigValue[1]']")->get_value(),
            $TransitionActionValue,
            "ConfigValue stored value",
        );

        # edit test TransactionAction values
        my $TransitionActionKeyEdit   = $TransitionActionKey . "edit";
        my $TransitionActionValueEdit = $TransitionActionValue . "edit";
        $Selenium->find_element( "#Name", 'css' )->send_keys("edit");
        $Selenium->find_element(".//*[\@id='ConfigKey[1]']")->clear();
        $Selenium->find_element(".//*[\@id='ConfigKey[1]']")->send_keys($TransitionActionKeyEdit);
        $Selenium->find_element(".//*[\@id='ConfigValue[1]']")->clear();
        $Selenium->find_element(".//*[\@id='ConfigValue[1]']")->send_keys($TransitionActionValueEdit);
        $Selenium->find_element( "#Name", 'css' )->submit();

        # return to main window
        $Selenium->switch_to_window( $Handles->[0] );

        # check for edited test TransitionAction using filter on AdminProcessManagement screen
        my $TransitionActionRandomEdit = $TransitionActionRandom . "edit";
        $Selenium->find_element( "Transition Actions", 'link_text' )->click();
        sleep 1;
        $Selenium->find_element( "#TransitionActionFilter", 'css' )->send_keys($TransitionActionRandomEdit);
        sleep 1;

        $Self->True(
            $Selenium->find_element("//*[text()=\"$TransitionActionRandomEdit\"]")->is_displayed(),
            "Edited $TransitionActionRandomEdit transition action dialog found on page",
        );

        # go to edit test TransitionAction screen again
        $Selenium->find_element("//a[contains(\@href, \'Subaction=TransitionActionEdit;ID=$TransitionActionID' )]")
            ->click();
        $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        # Wait until form has loaded, if neccessary
        ACTIVESLEEP:
        for my $Second ( 1 .. 20 ) {
            if ( $Selenium->execute_script("return \$('#Name').length") ) {
                last ACTIVESLEEP;
            }
            sleep 1;
        }

        # check edited values
        $Self->Is(
            $Selenium->find_element( "#Name", 'css' )->get_value(),
            $TransitionActionRandomEdit,
            "#Name updated value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConfigKey[1]']")->get_value(),
            $TransitionActionKeyEdit,
            "ConfigKey updated value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConfigValue[1]']")->get_value(),
            $TransitionActionValueEdit,
            "ConfigValue updated value",
        );

        # return to main window
        $Selenium->switch_to_window( $Handles->[0] );

        # get process id and return to overview afterwards
        my $ProcessID = $Selenium->execute_script('return $("#ProcessDelete").data("id")') || undef;
        $Selenium->get("${ScriptAlias}index.pl?Action=AdminProcessManagement");

        # delete test TransitionAction
        my $Success = $DBObject->Do(
            SQL => "DELETE FROM pm_transition_action WHERE id = $TransitionActionID",
        );
        $Self->True(
            $Success,
            "TransitionActionDelete - $TransitionActionRandomEdit",
        );

        # delete process
        my $Delete = $DBObject->Do(
            SQL => "DELETE FROM pm_process WHERE id = $ProcessID",
        );

        $Self->True(
            $Delete,
            "Successfully deleted test process.",
        );

        # make sure the cache is correct
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp(
            Type => 'ProcessManagement_TransitionAction',
        );

    }
);

1;

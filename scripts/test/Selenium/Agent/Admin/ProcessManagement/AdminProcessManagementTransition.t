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

# get selenium object
my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

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
        my $ProcessRandom    = 'Process' . $Helper->GetRandomID();
        my $TransitionRandom = 'Transition' . $Helper->GetRandomID();
        my $ScriptAlias      = $Kernel::OM->Get('Kernel::Config')->Get('ScriptAlias');

        # go to AdminProcessManagement screen
        $Selenium->get("${ScriptAlias}index.pl?Action=AdminProcessManagement");

        # create new test Process
        $Selenium->find_element("//a[contains(\@href, \'Subaction=ProcessNew' )]")->click();
        $Selenium->find_element( "#Name",        'css' )->send_keys($ProcessRandom);
        $Selenium->find_element( "#Description", 'css' )->send_keys("Selenium Test Process");
        $Selenium->find_element( "#Name",        'css' )->submit();

        # click on Transitions dropdown and "Create New Transition"
        $Selenium->find_element( "Transitions", 'link_text' )->click();
        sleep 1;
        $Selenium->find_element("//a[contains(\@href, \'Subaction=TransitionNew' )]")->click();

        # switch to pop up window
        my $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        # check AdminProcessManagementTransition screen
        for my $ID (
            qw(Name OverallConditionLinking ConditionLinking[_INDEX_] ConditionFieldName[1][1]
            ConditionFieldType[_INDEX_][_FIELDINDEX_] ConditionFieldValue[1][1] ConditionAdd)
            )
        {
            my $Element = $Selenium->find_element(".//*[\@id='$ID']");
            $Element->is_enabled();
            $Element->is_displayed();
        }

        for my $Button (
            qw(Remove ConditionFieldAdd Remove)
            )
        {
            my $Element = $Selenium->find_element( ".$Button", 'css' );
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
        my $TransitionFieldName = "Field" . $Helper->GetRandomID();
        my $TransitionValueName = "Value" . $Helper->GetRandomID();
        $Selenium->find_element( "#Name",                                       'css' )->send_keys($TransitionRandom);
        $Selenium->find_element( "#OverallConditionLinking option[value='or']", 'css' )->click();
        $Selenium->find_element(".//*[\@id='ConditionLinking[_INDEX_]']/option[2]")->click();
        $Selenium->find_element(".//*[\@id='ConditionFieldName[1][1]']")->send_keys($TransitionFieldName);
        $Selenium->find_element(".//*[\@id='ConditionFieldType[_INDEX_][_FIELDINDEX_]']/option[3]")->click();
        $Selenium->find_element(".//*[\@id='ConditionFieldValue[1][1]']")->send_keys($TransitionValueName);
        $Selenium->find_element( "#Name", 'css' )->submit();

        # switch back to main window
        $Selenium->switch_to_window( $Handles->[0] );

        # check for created test Transition using filter on AdminProcessManagement screen
        $Selenium->find_element( "Transitions", 'link_text' )->click();
        sleep 1;
        $Selenium->find_element( "#TransitionFilter", 'css' )->send_keys($TransitionRandom);
        sleep 1;

        $Self->True(
            $Selenium->find_element("//*[text()=\"$TransitionRandom\"]")->is_displayed(),
            "$TransitionRandom transition found on page",
        );

        # get test TransitionID
        my $DBObject         = $Kernel::OM->Get('Kernel::System::DB');
        my $TransitionQuoted = $DBObject->Quote($TransitionRandom);
        $DBObject->Prepare(
            SQL  => "SELECT id FROM pm_transition WHERE name = ?",
            Bind => [ \$TransitionQuoted ]
        );
        my $TransitionID;
        while ( my @Row = $DBObject->FetchrowArray() ) {
            $TransitionID = $Row[0];
        }

        # go to edit test Transition screen
        $Selenium->find_element("//a[contains(\@href, \'Subaction=TransitionEdit;ID=$TransitionID' )]")->click();
        $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        $Selenium->WaitFor(JavaScript => 'return $("form").length;');

        # check stored value
        $Self->Is(
            $Selenium->find_element( "#Name", 'css' )->get_value(),
            $TransitionRandom,
            "#Name stored value",
        );
        $Self->Is(
            $Selenium->find_element( "#OverallConditionLinking option[value='or']", 'css' )->get_value(),
            "or",
            "#OverallConditionLinking stored value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConditionLinking[_INDEX_]']/option[2]")->get_value(),
            "or",
            "ConditionLinking stored value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConditionFieldName[1][$TransitionFieldName]']")->get_value(),
            $TransitionFieldName,
            "ConditionFieldName stored value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConditionFieldType[1][$TransitionFieldName]']/option[3]")->get_value(),
            "String",
            "ConditionFieldType stored value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConditionFieldValue[1][$TransitionFieldName]']")->get_value(),
            $TransitionValueName,
            "ConditionFieldValue stored value",
        );

        # edit test Transition values
        my $TransitionFieldNameEdit = $TransitionFieldName . "edit";
        my $TransitionValueNameEdit = $TransitionValueName . "edit";

        $Selenium->find_element( "#Name",                                        'css' )->send_keys("edit");
        $Selenium->find_element( "#OverallConditionLinking option[value='and']", 'css' )->click();
        $Selenium->find_element(".//*[\@id='ConditionFieldName[1][$TransitionFieldName]']")->clear();
        $Selenium->find_element(".//*[\@id='ConditionFieldName[1][$TransitionFieldName]']")
            ->send_keys($TransitionFieldNameEdit);
        $Selenium->find_element(".//*[\@id='ConditionFieldValue[1][$TransitionFieldName]']")->clear();
        $Selenium->find_element(".//*[\@id='ConditionFieldValue[1][$TransitionFieldName]']")
            ->send_keys($TransitionValueNameEdit);
        $Selenium->find_element( "#Name", 'css' )->submit();

        # return to main window
        $Selenium->switch_to_window( $Handles->[0] );

        # check for edited test Transition using filter on AdminProcessManagement screen
        my $TransitionRandomEdit = $TransitionRandom . "edit";
        $Selenium->find_element( "Transitions", 'link_text' )->click();
        sleep 1;
        $Selenium->find_element( "#TransitionFilter", 'css' )->send_keys($TransitionRandomEdit);
        sleep 1;

        $Self->True(
            $Selenium->find_element("//*[text()=\"$TransitionRandomEdit\"]")->is_displayed(),
            "Edited $TransitionRandomEdit transition found on page",
        );

        # go to edit test ActivityDialog screen again
        $Selenium->find_element("//a[contains(\@href, \'Subaction=TransitionEdit;ID=$TransitionID' )]")->click();
        $Handles = $Selenium->get_window_handles();
        $Selenium->switch_to_window( $Handles->[1] );

        # check edited values
        $Self->Is(
            $Selenium->find_element( "#Name", 'css' )->get_value(),
            $TransitionRandomEdit,
            "#Name updated value",
        );
        $Self->Is(
            $Selenium->find_element( "#OverallConditionLinking option[value='and']", 'css' )->get_value(),
            "and",
            "#OverallConditionLinking updated value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConditionFieldName[1][$TransitionFieldNameEdit]']")->get_value(),
            $TransitionFieldNameEdit,
            "ConditionFieldName updated value",
        );
        $Self->Is(
            $Selenium->find_element(".//*[\@id='ConditionFieldValue[1][$TransitionFieldNameEdit]']")->get_value(),
            $TransitionValueNameEdit,
            "ConditionFieldValue updated value",
        );

        # return to main window
        $Selenium->close();
        $Selenium->switch_to_window( $Handles->[0] );

        # get process id and return to overview afterwards
        my $ProcessID = $Selenium->execute_script('return $("#ProcessDelete").data("id")') || undef;
        $Selenium->get("${ScriptAlias}index.pl?Action=AdminProcessManagement");

        # delete test Transition
        my $Success = $DBObject->Do(
            SQL => "DELETE FROM pm_transition WHERE id = $TransitionID",
        );
        $Self->True(
            $Success,
            "TransitionDelete - $TransitionRandomEdit",
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
            Type => 'ProcessManagement_Transition',
        );

    }

);

1;

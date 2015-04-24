# --
# AdminDynamicFieldTextArea.t - frontend tests for AdminDynamicFieldTextArea
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

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

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

        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');

        $Selenium->get("${ScriptAlias}index.pl?Action=AdminDynamicField");

        # create and edit Ticket and Article DynamicFieldTextArea
        for my $Type (qw(Ticket Article)) {

            my $ObjectType = $Type . "DynamicField";
            $Selenium->find_element( "#$ObjectType option[value='TextArea']", 'css' )->click();

            for my $ID (
                qw(Name Label FieldOrder Rows Cols DefaultValue AddRegEx ValidID)
                )
            {
                my $Element = $Selenium->find_element( "#$ID", 'css' );
                $Element->is_enabled();
                $Element->is_displayed();
            }

            # check client side validation
            my $Element2 = $Selenium->find_element( "#Name", 'css' );
            $Element2->send_keys("");
            $Element2->submit();

            $Self->Is(
                $Selenium->execute_script(
                    "return \$('#Name').hasClass('Error')"
                ),
                '1',
                'Client side validation correctly detected missing input value',
            );

            # create real text DynamicFieldTextArea
            my $RandomID      = $Helper->GetRandomID();
            my $RegEx         = '^[0-9]$';
            my $RegExErrorTxt = "Please remove this entry and enter a new one with the correct value.";

            $Selenium->find_element( "#Name",                        'css' )->send_keys($RandomID);
            $Selenium->find_element( "#Label",                       'css' )->send_keys($RandomID);
            $Selenium->find_element( "#Rows",                        'css' )->send_keys("3");
            $Selenium->find_element( "#Cols",                        'css' )->send_keys("5");
            $Selenium->find_element( "#AddRegEx",                    'css' )->click();
            $Selenium->find_element( "#RegEx_1",                     'css' )->send_keys($RegEx);
            $Selenium->find_element( "#CustomerRegExErrorMessage_1", 'css' )->send_keys($RegExErrorTxt);
            $Selenium->find_element( "#Name",                        'css' )->submit();

            # check for test DynamicFieldTextArea on AdminDynamicField screen
            $Self->True(
                index( $Selenium->get_page_source(), $RandomID ) > -1,
                "DynamicFieldTextArea $RandomID found on table"
            );

            # edit test DynamicFieldTextArea name, default value and set it to invalid
            $Selenium->find_element( $RandomID, 'link_text' )->click();

            $Selenium->find_element( "#Name",                      'css' )->clear();
            $Selenium->find_element( "#Name",                      'css' )->send_keys($RandomID);
            $Selenium->find_element( "#DefaultValue",              'css' )->send_keys("Default");
            $Selenium->find_element( "#ValidID option[value='2']", 'css' )->click();
            $Selenium->find_element( "#Name",                      'css' )->submit();

            # check new and edited DynamicFieldTextArea values
            $Selenium->find_element( $RandomID, 'link_text' )->click();

            $Self->Is(
                $Selenium->find_element( '#Name', 'css' )->get_value(),
                $RandomID,
                "#Name updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#Label', 'css' )->get_value(),
                $RandomID,
                "#Label updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#Rows', 'css' )->get_value(),
                "3",
                "#Label updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#Cols', 'css' )->get_value(),
                "5",
                "#Label updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#RegEx_1', 'css' )->get_value(),
                $RegEx,
                "#RegEx_1 updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#DefaultValue', 'css' )->get_value(),
                "Default",
                "#DefaultValue updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#CustomerRegExErrorMessage_1', 'css' )->get_value(),
                $RegExErrorTxt,
                "#CustomerRegExErrorMessage_1 updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#ValidID', 'css' )->get_value(),
                2,
                "#ValidID updated value",
            );

            $Selenium->go_back();

            # delete DynamicFields
            my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
            my $DynamicField       = $DynamicFieldObject->DynamicFieldGet(
                Name => $RandomID,
            );
            my $Success = $DynamicFieldObject->DynamicFieldDelete(
                ID     => $DynamicField->{ID},
                UserID => 1,
            );

            # sanity check
            $Self->True(
                $Success,
                "DynamicFieldDelete() - $RandomID"
            );

        }

        # make sure cache is correct
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp( Type => "DynamicField" );

    }

);

1;

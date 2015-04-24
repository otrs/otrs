# --
# AdminDynamicFieldCheckbox.t - frontend tests for AdminDynamicFieldCheckbox
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

        # create and edit Ticket and Article DynamicFieldCheckbox
        for my $Type (qw(Ticket Article)) {

            my $ObjectType = $Type . "DynamicField";
            $Selenium->find_element( "#$ObjectType option[value='Checkbox']", 'css' )->click();

            for my $ID (
                qw(Name Label FieldOrder ValidID)
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

            # create real text DynamicFieldCheckbox
            my $RandomID = $Helper->GetRandomID();

            $Selenium->find_element( "#Name",  'css' )->send_keys($RandomID);
            $Selenium->find_element( "#Label", 'css' )->send_keys($RandomID);
            $Selenium->find_element( "#Name",  'css' )->submit();

            # check for test DynamicFieldCheckbox on AdminDynamicField screen
            $Self->True(
                index( $Selenium->get_page_source(), $RandomID ) > -1,
                "DynamicFieldCheckbox $RandomID found on table"
            );

            # edit test DynamicFieldCheckbox default value and set it to invalid
            $Selenium->find_element( $RandomID, 'link_text' )->click();

            $Selenium->find_element( "#DefaultValue option[value='1']", 'css' )->click();
            $Selenium->find_element( "#ValidID option[value='2']",      'css' )->click();
            $Selenium->find_element( "#Name",                           'css' )->submit();

            # check new and edited DynamicFieldCheckbox values
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
                $Selenium->find_element( '#ValidID', 'css' )->get_value(),
                2,
                "#ValidID updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#FieldTypeName', 'css' )->get_value(),
                "Checkbox",
                "#FieldTypeName updated value",
            );
            $Self->Is(
                $Selenium->find_element( '#DefaultValue', 'css' )->get_value(),
                1,
                "#DefaultValue updated value",
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

        # delete cache
        $Kernel::OM->Get('Kernel::System::Cache')->CleanUp( Type => "DynamicField" );

    }

);

1;

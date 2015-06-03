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
use Kernel::Language;

# get selenium object
my $Selenium = $Kernel::OM->Get('Kernel::System::UnitTest::Selenium');

$Selenium->RunTest(
    sub {

        # get helper object
        my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

        # create test user and login
        my $TestUserLogin = $Helper->TestUserCreate() || die "Did not get test user";

        $Selenium->Login(
            Type     => 'Agent',
            User     => $TestUserLogin,
            Password => $TestUserLogin,
        );

        # get config object
        my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

        # navigate to AgentPReferences screen
        my $ScriptAlias = $ConfigObject->Get('ScriptAlias');
        $Selenium->get("${ScriptAlias}index.pl?Action=AgentPreferences");

        my @Languages = sort keys %{ $ConfigObject->Get('DefaultUsedLanguages') };

        Language:
        for my $Language (@Languages) {

            # check for the language selection box
            my $Element = $Selenium->find_element( "select#UserLanguage", 'css' );

            # select the current language & submit
            $Element = $Selenium->find_child_element( $Element, "option[value='$Language']", 'css' );
            $Element->click();
            $Element->submit();

            # now check if the language was correctly applied in the interface
            my $LanguageObject = Kernel::Language->new(
                UserLanguage => $Language,
            );

            $Element = $Selenium->find_element( '.MainBox h1', 'css' );
            $Self->Is(
                $Element->get_text(),
                $LanguageObject->Get('Edit your preferences'),
                "Heading translation in $Language",
            );

            $Self->True(
                index(
                    $Selenium->get_page_source(),
                    $LanguageObject->Get('Preferences updated successfully!')
                    ) > -1,
                "Success notification in $Language",
            );
        }
    }
);

1;

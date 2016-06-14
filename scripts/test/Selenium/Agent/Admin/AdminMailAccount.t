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

        # navigate to AdminMailAccount
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminMailAccount");

        # check AdminMailAccount screen
        $Selenium->find_element( "table",             'css' );
        $Selenium->find_element( "table thead tr th", 'css' );
        $Selenium->find_element( "table tbody tr td", 'css' );

        # check "Add mail account" link
        $Selenium->find_element("//a[contains(\@href, \'Action=AdminMailAccount;Subaction=AddNew' )]")->VerifiedClick();

        for my $ID (
            qw(TypeAdd LoginAdd PasswordAdd HostAdd IMAPFolder Trusted DispatchingBy ValidID Comment)
            )
        {
            my $Element = $Selenium->find_element( "#$ID", 'css' );
            $Element->is_enabled();
            $Element->is_displayed();
        }

        # add real test mail account
        my $RandomID = "EmailAccount" . $Helper->GetRandomID();
        $Selenium->execute_script("\$('#TypeAdd').val('IMAP').trigger('redraw.InputField').trigger('change');");
        $Selenium->find_element( "#LoginAdd",    'css' )->send_keys($RandomID);
        $Selenium->find_element( "#PasswordAdd", 'css' )->send_keys("SomePassword");
        $Selenium->find_element( "#HostAdd",     'css' )->send_keys("pop3.example.com");
        $Selenium->execute_script("\$('#Trusted').val('0').trigger('redraw.InputField').trigger('change');");
        $Selenium->execute_script("\$('#DispatchingBy').val('Queue').trigger('redraw.InputField').trigger('change');");
        $Selenium->find_element( "#Comment",  'css' )->send_keys("Selenium test AdminMailAccount");
        $Selenium->find_element( "#LoginAdd", 'css' )->VerifiedSubmit();

        # check if test mail account is present
        my $TestMailHost = "pop3.example.com / $RandomID";
        $Self->True(
            index( $Selenium->get_page_source(), $TestMailHost ) > -1,
            "$TestMailHost found on page",
        );

        # edit test mail account and set it to invalid
        $Selenium->find_element( $TestMailHost, 'link_text' )->VerifiedClick();

        $Selenium->find_element( "#HostEdit", 'css' )->clear();
        $Selenium->find_element( "#HostEdit", 'css' )->send_keys("pop3edit.example.com");
        $Selenium->execute_script("\$('#ValidID').val('2').trigger('redraw.InputField').trigger('change');");
        $Selenium->find_element( "#LoginEdit", 'css' )->VerifiedSubmit();

        # check class of invalid EmailAccount in the overview table
        $Self->True(
            $Selenium->execute_script(
                "return \$('tr.Invalid td a:contains($RandomID)').length"
            ),
            "There is a class 'Invalid' for test EmailAccount",
        );

        # check for edited mail account
        my $TestMailHostEdit = "pop3edit.example.com / $RandomID";
        $Self->True(
            index( $Selenium->get_page_source(), $TestMailHostEdit ) > -1,
            "$TestMailHostEdit found on page",
        );

        # test showing IMAP Folder and Queue fields
        $Selenium->find_element( $TestMailHostEdit, 'link_text' )->VerifiedClick();

        my @Tests = (
            {
                Name     => 'Selected option IMAP - IMAP Folder is shown',
                FieldID  => 'Type',
                ForAttr  => 'IMAPFolder',
                Selected => 'IMAP',
                Display  => 'block',
            },
            {
                Name     => 'Selected option IMAPS - IMAP Folder is shown',
                FieldID  => 'Type',
                ForAttr  => 'IMAPFolder',
                Selected => 'IMAPS',
                Display  => 'block',
            },
            {
                Name     => 'Selected option POP3 - IMAP Folder is not shown',
                FieldID  => 'Type',
                ForAttr  => 'IMAPFolder',
                Selected => 'POP3',
                Display  => 'none',
            },
            {
                Name     => 'Selected option POP3S - IMAP Folder is not shown',
                FieldID  => 'Type',
                ForAttr  => 'IMAPFolder',
                Selected => 'POP3S',
                Display  => 'none',
            },
            {
                Name     => 'Selected option POP3TLS - IMAP Folder is not shown',
                FieldID  => 'Type',
                ForAttr  => 'IMAPFolder',
                Selected => 'POP3TLS',
                Display  => 'none',
            },
            {
                Name     => "Selected 'Dispatching by email To: field.' - field Queue is not shown",
                FieldID  => 'DispatchingBy',
                ForAttr  => 'QueueID',
                Selected => 'From',
                Display  => 'none',
            },
            {
                Name     => "Selected 'Dispatching by selected Queue.' - field Queue is shown",
                FieldID  => 'DispatchingBy',
                ForAttr  => 'QueueID',
                Selected => 'Queue',
                Display  => 'block',
            }
        );

        for my $Test (@Tests) {
            my $FieldID = $Test->{FieldID};
            my $ForAttr = $Test->{ForAttr};

            $Selenium->execute_script(
                "\$('#$FieldID').val('$Test->{Selected}').trigger('redraw.InputField').trigger('change');"
            );

            $Self->Is(
                $Selenium->execute_script("return \$('label[for=$ForAttr]').parent().css('display');"),
                $Test->{Display},
                $Test->{Name},
            );
        }

        # navigate to AdminMailAccount
        $Selenium->VerifiedGet("${ScriptAlias}index.pl?Action=AdminMailAccount");

        # test mail account delete button
        my $DBObject = $Kernel::OM->Get('Kernel::System::DB');
        my $Success  = $DBObject->Prepare(
            SQL => "SELECT id FROM mail_account WHERE login='$RandomID'",
        );

        if ($Success) {
            my $MailAccountID;
            while ( my @Row = $DBObject->FetchrowArray() ) {
                $MailAccountID = $Row[0];
            }
            $Selenium->find_element("//a[contains(\@href, \'Subaction=Delete;ID=$MailAccountID' )]")->VerifiedClick();
        }

    }

);

1;

# --
# Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
my $TicketObject       = $Kernel::OM->Get('Kernel::System::Ticket');
my $UserObject         = $Kernel::OM->Get('Kernel::System::User');

# Get helper object.
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase  => 1,
        UseTmpArticleDir => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $RandomID             = $Helper->GetRandomID();
my $NotificationLanguage = 'en';
my $UserLanguage         = 'de';

my @DynamicFieldsToAdd = (
    {
        Name       => 'Replace1' . $RandomID,
        Label      => 'a description',
        FieldOrder => 9998,
        FieldType  => 'Text',
        ObjectType => 'Ticket',
        Config     => {
            Name        => 'Replace1' . $RandomID,
            Description => 'Description for Dynamic Field.',
        },
        Reorder => 0,
        ValidID => 1,
        UserID  => 1,
    },
    {
        Name       => 'Replace2' . $RandomID,
        Label      => 'a description',
        FieldOrder => 9999,
        FieldType  => 'Dropdown',
        ObjectType => 'Ticket',
        Config     => {
            Name           => 'Replace2' . $RandomID,
            Description    => 'Description for Dynamic Field.',
            PossibleValues => {
                1 => 'A',
                2 => 'B',
            }
        },
        Reorder => 0,
        ValidID => 1,
        UserID  => 1,
    },
);

my %AddedDynamicFieldIds;
my %DynamicFieldConfigs;

for my $DynamicField (@DynamicFieldsToAdd) {

    my $DynamicFieldID = $DynamicFieldObject->DynamicFieldAdd(
        %{$DynamicField},
    );
    $Self->IsNot(
        $DynamicFieldID,
        undef,
        'DynamicFieldAdd()',
    );

    # Remember added DynamicFields.
    $AddedDynamicFieldIds{$DynamicFieldID} = $DynamicField->{Name};

    my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        Name => $DynamicField->{Name},
    );
    $Self->Is(
        ref $DynamicFieldConfig,
        'HASH',
        'DynamicFieldConfig must be a hash reference',
    );

    # Remember the DF config.
    $DynamicFieldConfigs{ $DynamicField->{FieldType} } = $DynamicFieldConfig;
}

# Create template generator after the dynamic field are created as it gathers all DF in the
# constructor.
my $TemplateGeneratorObject = $Kernel::OM->Get('Kernel::System::TemplateGenerator');

my $TestCustomerLogin = $Helper->TestCustomerUserCreate(
    Language => $UserLanguage,
);

my %TestCustomerData = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserDataGet(
    User => $TestCustomerLogin,
);

my @TestUsers;
for ( 1 .. 4 ) {
    my $TestUserLogin = $Helper->TestUserCreate(
        Language => $UserLanguage,
    );
    my %TestUser = $UserObject->GetUserData(
        User => $TestUserLogin,
    );
    push @TestUsers, \%TestUser;
}

# Create time for time tags check.
my $SystemTime = $Kernel::OM->Create(
    'Kernel::System::DateTime',
    ObjectParams => {
        String => '2017-07-05 11:00:00',
    },
)->ToEpoch();

# Set the fixed time.
$Helper->FixedTimeSet($SystemTime);

# Create test queue with escalation times.
my $QueueID = $Kernel::OM->Get('Kernel::System::Queue')->QueueAdd(
    Name                => 'Queue' . $RandomID,
    ValidID             => 1,
    GroupID             => 1,
    FirstResponseTime   => 30,
    FirstResponseNotify => 80,
    UpdateTime          => 40,
    UpdateNotify        => 80,
    SolutionTime        => 50,
    SolutionNotify      => 80,
    SystemAddressID     => 1,
    SalutationID        => 1,
    SignatureID         => 1,
    UserID              => 1,
    Comment             => "Test Queue",
);
$Self->True(
    $QueueID,
    "QueueID $QueueID - created"
);

my $TicketID = $TicketObject->TicketCreate(
    Title         => 'Some Ticket_Title',
    QueueID       => $QueueID,
    Lock          => 'unlock',
    Priority      => '3 normal',
    State         => 'open',
    CustomerNo    => '123465',
    CustomerUser  => $TestCustomerLogin,
    OwnerID       => $TestUsers[0]->{UserID},
    ResponsibleID => $TestUsers[1]->{UserID},
    UserID        => $TestUsers[2]->{UserID},
);
$Self->IsNot(
    $TicketID,
    undef,
    'TicketCreate() TicketID',
);

my $Success = $BackendObject->ValueSet(
    DynamicFieldConfig => $DynamicFieldConfigs{Text},
    ObjectID           => $TicketID,
    Value              => 'ligero',
    UserID             => 1,
);
$Self->True(
    $Success,
    'DynamicField ValueSet() for Dynamic Field Text - with true',
);

$Success = $BackendObject->ValueSet(
    DynamicFieldConfig => $DynamicFieldConfigs{Dropdown},
    ObjectID           => $TicketID,
    Value              => 1,
    UserID             => 1,
);
$Self->True(
    $Success,
    'DynamicField ValueSet() Dynamic Field Dropdown - with true',
);

my $ArticleBackendObject = $Kernel::OM->Get('Kernel::System::Ticket::Article')->BackendForChannel(
    ChannelName => 'Internal',
);

# Add 5 minutes for escalation times evaluation.
$Helper->FixedTimeAddSeconds(300);

my $ArticleID = $ArticleBackendObject->ArticleCreate(
    TicketID             => $TicketID,
    IsVisibleForCustomer => 0,
    SenderType           => 'agent',
    From                 => 'Some Agent <email@example.com>',
    To                   => 'Some Customer <customer-a@example.com>',
    Subject              => 'some short description',
    Body                 => 'the message text',
    ContentType          => 'text/plain; charset=ISO-8859-15',
    HistoryType          => 'OwnerUpdate',
    HistoryComment       => 'Some free text!',
    UserID               => 1,
    NoAgentNotify        => 1,                                          # if you don't want to send agent notifications
);
$Self->IsNot(
    $ArticleID,
    undef,
    'ArticleCreate() ArticleID',
);

# Renew object because of transaction.
$Kernel::OM->ObjectsDiscard( Objects => ['Kernel::System::Ticket'] );
$TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

my @Tests = (
    {
        Name => 'Simple replace',
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_From>',
        Result   => 'Test test@home.com',
    },
    {
        Name => 'Simple replace, case insensitive',
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_FROM>',
        Result   => 'Test test@home.com',
    },
    {
        Name => 'remove unknown tags',
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_INVALID_TAG>',
        Result   => 'Test -',
    },
    {
        Name => 'LIGERO customer subject',    # <LIGERO_CUSTOMER_SUBJECT>
        Data => {
            From    => 'test@home.com',
            Subject => 'ligero',
        },
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_SUBJECT>',
        Result   => 'Test ligero',
    },
    {
        Name => 'LIGERO customer subject 3 letters',    # <LIGERO_CUSTOMER_SUBJECT[20]>
        Data => {
            From    => 'test@home.com',
            Subject => 'ligero',
        },
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_SUBJECT[3]>',
        Result   => 'Test otr [...]',
    },
    {
        Name => 'LIGERO customer subject 20 letters + garbarge',    # <LIGERO_CUSTOMER_SUBJECT[20]>
        Data => {
            From    => 'test@home.com',
            Subject => 'RE: ligero',
        },
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_SUBJECT[20]>',
        Result   => 'Test ligero',
    },
    {
        Name => 'LIGERO responsible firstname',                     # <LIGERO_RESPONSIBLE_UserFirstname>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_RESPONSIBLE_UserFirstname> <LIGERO_RESPONSIBLE_nonexisting>',
        Result   => "Test $TestUsers[1]->{UserFirstname} -",
    },
    {
        Name => 'LIGERO_TICKET_RESPONSIBLE firstname',              # <LIGERO_RESPONSIBLE_UserFirstname>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_RESPONSIBLE_UserFirstname> <LIGERO_TICKET_RESPONSIBLE_nonexisting>',
        Result   => "Test $TestUsers[1]->{UserFirstname} -",
    },
    {
        Name => 'LIGERO owner firstname',                           # <LIGERO_OWNER_*>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_OWNER_UserFirstname> <LIGERO_OWNER_nonexisting>',
        Result   => "Test $TestUsers[0]->{UserFirstname} -",
    },
    {
        Name => 'LIGERO_TICKET_OWNER firstname',                    # <LIGERO_OWNER_*>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_OWNER_UserFirstname> <LIGERO_TICKET_OWNER_nonexisting>',
        Result   => "Test $TestUsers[0]->{UserFirstname} -",
    },
    {
        Name => 'LIGERO current firstname',                         # <LIGERO_CURRENT_*>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_CURRENT_UserFirstname> <LIGERO_CURRENT_nonexisting>',
        Result   => "Test $TestUsers[2]->{UserFirstname} -",
    },
    {
        Name => 'LIGERO ticket ticketid',                           # <LIGERO_TICKET_*>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_TicketID>',
        Result   => 'Test ' . $TicketID,
    },
    {
        Name => 'LIGERO dynamic field (text)',                      # <LIGERO_TICKET_DynamicField_*>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_DynamicField_Replace1' . $RandomID . '>',
        Result   => 'Test ligero',
    },
    {
        Name => 'LIGERO dynamic field value (text)',                # <LIGERO_TICKET_DynamicField_*_Value>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_DynamicField_Replace1' . $RandomID . '_Value>',
        Result   => 'Test ligero',
    },
    {
        Name => 'LIGERO dynamic field (Dropdown)',                  # <LIGERO_TICKET_DynamicField_*>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_DynamicField_Replace2' . $RandomID . '>',
        Result   => 'Test 1',
    },
    {
        Name => 'LIGERO dynamic field value (Dropdown)',            # <LIGERO_TICKET_DynamicField_*_Value>
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_DynamicField_Replace2' . $RandomID . '_Value>',
        Result   => 'Test A',
    },
    {
        Name     => 'LIGERO config value',                          # <LIGERO_CONFIG_*>
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_CONFIG_DefaultTheme>',
        Result   => 'Test Standard',
    },
    {
        Name     => 'LIGERO secret config values, must be masked (even unknown settings)',
        Data     => {},
        RichText => 0,
        Template =>
            'Test <LIGERO_CONFIG_DatabasePw> <LIGERO_CONFIG_Core::MirrorDB::Password> <LIGERO_CONFIG_SomeOtherValue::Password> <LIGERO_CONFIG_SomeOtherValue::Pw>',
        Result => 'Test xxx xxx xxx xxx',
    },
    {
        Name     => 'LIGERO secret config value and normal config value',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_CONFIG_DatabasePw> and <LIGERO_CONFIG_DefaultTheme>',
        Result   => 'Test xxx and Standard',
    },
    {
        Name     => 'LIGERO secret config values with numbers',
        Data     => {},
        RichText => 0,
        Template =>
            'Test <LIGERO_CONFIG_AuthModule::LDAP::SearchUserPw1> and <LIGERO_CONFIG_AuthModule::LDAP::SearchUserPassword1>',
        Result => 'Test xxx and xxx',
    },
    {
        Name => 'mailto-Links RichText enabled',
        Data => {
            From => 'test@home.com',
        },
        RichText => 1,
        Template =>
            'mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20%3CLIGERO_CUSTOMER_From%3E&amp;body=From%3A%20%3CLIGERO_CUSTOMER_From%3E">E-Mail mit Subject und Body</a><br />
<br />
mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20%3CLIGERO_CUSTOMER_From%3E">E-Mail mit Subject</a><br />
<br />
mailto-Link <a href="mailto:skywalker@ligero.org?body=From%3A%20%3CLIGERO_CUSTOMER_From%3E">E-Mail mit Body</a><br />',
        Result =>
            'mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20test%40home.com&amp;body=From%3A%20test%40home.com">E-Mail mit Subject und Body</a><br /><br />mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20test%40home.com">E-Mail mit Subject</a><br /><br />mailto-Link <a href="mailto:skywalker@ligero.org?body=From%3A%20test%40home.com">E-Mail mit Body</a><br />',
    },
    {
        Name => 'mailto-Links',
        Data => {
            From => 'test@home.com',
        },
        RichText => 0,
        Template =>
            'mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20%3CLIGERO_CUSTOMER_From%3E&amp;body=From%3A%20%3CLIGERO_CUSTOMER_From%3E">E-Mail mit Subject und Body</a><br />
<br />
mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20%3CLIGERO_CUSTOMER_From%3E">E-Mail mit Subject</a><br />
<br />
mailto-Link <a href="mailto:skywalker@ligero.org?body=From%3A%20%3CLIGERO_CUSTOMER_From%3E">E-Mail mit Body</a><br />',
        Result =>
            'mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20test%40home.com&amp;body=From%3A%20test%40home.com">E-Mail mit Subject und Body</a><br />
<br />
mailto-Link <a href="mailto:skywalker@ligero.org?subject=From%3A%20test%40home.com">E-Mail mit Subject</a><br />
<br />
mailto-Link <a href="mailto:skywalker@ligero.org?body=From%3A%20test%40home.com">E-Mail mit Body</a><br />',
    },
    {
        Name => 'LIGERO AGENT + CUSTOMER FROM',    # <LIGERO_TICKET_DynamicField_*_Value>
        Data => {
            From => 'testcustomer@home.com',
        },
        DataAgent => {
            From => 'testagent@home.com',
        },
        RichText => 0,
        Template => 'Test <LIGERO_AGENT_From> - <LIGERO_CUSTOMER_From>',
        Result   => 'Test testagent@home.com - testcustomer@home.com',
    },
    {
        Name =>
            'LIGERO AGENT + CUSTOMER BODY',   # this is an special case, it sets the Body as it is since is the Data param
        Data => {
            Body => "Line1\nLine2\nLine3",
        },
        DataAgent => {
            Body => "Line1\nLine2\nLine3",
        },
        RichText => 0,
        Template => 'Test <LIGERO_AGENT_BODY> - <LIGERO_CUSTOMER_BODY>',
        Result   => "Test Line1\nLine2\nLine3 - Line1\nLine2\nLine3",
    },
    {
        Name =>
            'LIGERO AGENT + CUSTOMER BODY With RichText enabled'
        ,    # this is an special case, it sets the Body as it is since is the Data param
        Data => {
            Body => "Line1\nLine2\nLine3",
        },
        DataAgent => {
            Body => "Line1\nLine2\nLine3",
        },
        RichText => 1,
        Template => 'Test &lt;LIGERO_AGENT_BODY&gt; - &lt;LIGERO_CUSTOMER_BODY&gt;',
        Result   => "Test Line1<br/>
Line2<br/>
Line3 - Line1<br/>
Line2<br/>
Line3",
    },
    {
        Name => 'LIGERO AGENT + CUSTOMER BODY[2]',
        Data => {
            Body => "Line1\nLine2\nLine3",
        },
        DataAgent => {
            Body => "Line1\nLine2\nLine3",
        },
        RichText => 0,
        Template => 'Test <LIGERO_AGENT_BODY[2]> - <LIGERO_CUSTOMER_BODY[2]>',
        Result   => "Test > Line1\n> Line2 - > Line1\n> Line2",
    },
    {
        Name => 'LIGERO AGENT + CUSTOMER BODY[7] with RichText enabled',
        Data => {
            Body => "Line1\nLine2\nLine3\nLine4\nLine5\nLine6\nLine7\nLine8\nLine9",
        },
        DataAgent => {
            Body => "Line1\nLine2\nLine3\nLine4\nLine5\nLine6\nLine7\nLine8\nLine9",
        },
        RichText => 1,
        Template => 'Test &lt;LIGERO_AGENT_BODY[7]&gt; - &lt;LIGERO_CUSTOMER_BODY[7]&gt;',
        Result =>
            'Test <div  type="cite" style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">Line1<br/>
Line2<br/>
Line3<br/>
Line4<br/>
Line5<br/>
Line6<br/>
Line7</div> - <div  type="cite" style="border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm 4.0pt">Line1<br/>
Line2<br/>
Line3<br/>
Line4<br/>
Line5<br/>
Line6<br/>
Line7</div>',
    },
    {
        Name => 'LIGERO AGENT + CUSTOMER EMAIL',    # EMAIL without [ ] does not exists
        Data => {
            Body => "Line1\nLine2\nLine3",
        },
        DataAgent => {
            Body => "Line1\nLine2\nLine3",
        },
        RichText => 0,
        Template => 'Test <LIGERO_AGENT_EMAIL> - <LIGERO_CUSTOMER_EMAIL>',
        Result   => "Test Line1\nLine2\nLine3 - Line1\nLine2\nLine3",
    },
    {
        Name => 'LIGERO AGENT + CUSTOMER EMAIL[2]',
        Data => {
            Body => "Line1\nLine2\nLine3",
        },
        DataAgent => {
            Body => "Line1\nLine2\nLine3",
        },
        RichText => 0,
        Template => 'Test <LIGERO_AGENT_EMAIL[2]> - <LIGERO_CUSTOMER_EMAIL[2]>',
        Result   => "Test > Line1\n> Line2 - > Line1\n> Line2",
    },
    {
        Name => 'LIGERO COMMENT',
        Data => {
            Body => "Line1\nLine2\nLine3",
        },
        RichText => 0,
        Template => 'Test <LIGERO_COMMENT>',
        Result   => "Test > Line1\n> Line2\n> Line3",
    },

    {
        Name => 'LIGERO COMMENT[2]',
        Data => {
            Body => "Line1\nLine2\nLine3",
        },
        RichText => 0,
        Template => 'Test <LIGERO_COMMENT[2]>',
        Result   => "Test > Line1\n> Line2",
    },
    {
        Name => 'LIGERO AGENT + CUSTOMER SUBJECT[2]',
        Data => {
            Subject => '0123456789'
        },
        DataAgent => {
            Subject => '987654321'
        },
        RichText => 0,
        Template => 'Test <LIGERO_AGENT_SUBJECT[2]> - <LIGERO_CUSTOMER_SUBJECT[2]>',
        Result   => "Test 98 [...] - 01 [...]",
    },
    {
        Name     => 'LIGERO CUSTOMER REALNAME',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_REALNAME>',
        Result   => "Test $TestCustomerLogin $TestCustomerLogin",
    },
    {
        Name     => 'LIGERO CUSTOMER DATA UserFirstname',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_CUSTOMER_DATA_UserFirstname>',
        Result   => "Test $TestCustomerLogin",
    },
    {
        Name     => 'LIGERO <LIGERO_NOTIFICATION_RECIPIENT_UserFullname>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_NOTIFICATION_RECIPIENT_UserFullname> <LIGERO_NOTIFICATION_RECIPIENT_nonexisting>',
        Result   => "Test $TestUsers[3]->{UserFullname} -",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_EscalationResponseTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_EscalationResponseTime>',
        Result   => "Test 07/05/2017 11:30",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_EscalationUpdateTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_EscalationUpdateTime>',
        Result   => "Test 07/05/2017 11:45",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_EscalationSolutionTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_EscalationSolutionTime>',
        Result   => "Test 07/05/2017 11:50",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_EscalationTimeWorkingTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_EscalationTimeWorkingTime>',
        Result   => "Test 25 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_EscalationTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_EscalationTime>',
        Result   => "Test 25 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_FirstResponseTimeWorkingTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_FirstResponseTimeWorkingTime>',
        Result   => "Test 25 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_FirstResponseTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_FirstResponseTime>',
        Result   => "Test 25 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_UpdateTimeWorkingTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_UpdateTimeWorkingTime>',
        Result   => "Test 40 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_UpdateTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_UpdateTime>',
        Result   => "Test 40 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_SolutionTimeWorkingTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_SolutionTimeWorkingTime>',
        Result   => "Test 45 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_SolutionTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_SolutionTime>',
        Result   => "Test 45 m",
    },
);

my %Ticket = $TicketObject->TicketGet(
    TicketID      => $TicketID,
    DynamicFields => 1,
);

for my $Test (@Tests) {
    my $Result = $TemplateGeneratorObject->_Replace(
        Text        => $Test->{Template},
        Data        => $Test->{Data},
        DataAgent   => $Test->{DataAgent},
        RichText    => $Test->{RichText},
        TicketData  => \%Ticket,
        UserID      => $TestUsers[2]->{UserID},
        RecipientID => $TestUsers[3]->{UserID},
        Language    => $NotificationLanguage,
    );
    $Self->Is(
        $Result,
        $Test->{Result},
        "$Test->{Name} - _Replace()",
    );
}

# Set state to 'pending reminder'.
$Success = $TicketObject->TicketStateSet(
    State    => 'pending reminder',
    TicketID => $TicketID,
    UserID   => $TestUsers[2]->{UserID},
);
$Self->True(
    $Success,
    "TicketID $TicketID - set state to pending reminder successfully",
);

$Success = $TicketObject->TicketPendingTimeSet(
    String   => '2017-07-06 10:00:00',
    TicketID => $TicketID,
    UserID   => 1,
);
$Self->True(
    $Success,
    "Set pending time successfully",
);

# Check 'UntilTime' and 'RealTillTimeNotUsed' tags (see bug#8301).
@Tests = (
    {
        Name     => 'LIGERO <LIGERO_TICKET_UntilTime>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_UntilTime>',
        Result   => "Test 22 h 55 m",
    },
    {
        Name     => 'LIGERO <LIGERO_TICKET_RealTillTimeNotUsed>',
        Data     => {},
        RichText => 0,
        Template => 'Test <LIGERO_TICKET_RealTillTimeNotUsed>',
        Result   => "Test 07/06/2017 10:00",
    }
);

%Ticket = $TicketObject->TicketGet(
    TicketID      => $TicketID,
    DynamicFields => 1,
);

for my $Test (@Tests) {
    my $Result = $TemplateGeneratorObject->_Replace(
        Text        => $Test->{Template},
        Data        => $Test->{Data},
        DataAgent   => $Test->{DataAgent},
        RichText    => $Test->{RichText},
        TicketData  => \%Ticket,
        UserID      => $TestUsers[2]->{UserID},
        RecipientID => $TestUsers[3]->{UserID},
        Language    => $NotificationLanguage,
    );
    $Self->Is(
        $Result,
        $Test->{Result},
        "$Test->{Name} - _Replace()",
    );
}

# Cleanup is done by RestoreDatabase.

1;

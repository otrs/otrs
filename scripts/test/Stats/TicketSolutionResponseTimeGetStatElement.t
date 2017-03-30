# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase  => 1,
        UseTmpArticleDir => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $DynamicFieldObject = $Kernel::OM->Get('Kernel::System::DynamicField');
my $BackendObject      = $Kernel::OM->Get('Kernel::System::DynamicField::Backend');
my $TicketObject       = $Kernel::OM->Get('Kernel::System::Ticket');
my $ArticleObject      = $Kernel::OM->Get('Kernel::System::Ticket::Article');
my $ServiceObject      = $Kernel::OM->Get('Kernel::System::Service');

# Set fixed time.
$Helper->FixedTimeSet();

my $RandomID = $Helper->GetRandomNumber();

# Create a test customer.
my $TestUserCustomer = $Helper->TestCustomerUserCreate();

# Create a dynamic field.
my $DynamicFieldName = "TestDF$RandomID";
my $FieldID          = $DynamicFieldObject->DynamicFieldAdd(
    Name       => $DynamicFieldName,
    FieldOrder => 9992,
    FieldType  => 'Dropdown',
    Config     => {
        DefaultValue   => 'Default',
        PossibleValues => {
            Item1 => 'Value1',
            item2 => 'Value2',
        },
    },
    Label      => $DynamicFieldName,
    ObjectType => 'Ticket',
    ValidID    => 1,
    UserID     => 1,
    Reorder    => 0,
);
$Self->True(
    $FieldID,
    "DynamicFieldAdd() successful for Field ID $FieldID",
);

# Add test Service.
my $ServiceID = $ServiceObject->ServiceAdd(
    Name    => "TestService - " . $Helper->GetRandomID(),
    ValidID => 1,
    UserID  => 1,
);
$Self->True(
    $ServiceID,
    "Service $ServiceID has been created.",
);

# Add service for the test customer.
$ServiceObject->CustomerUserServiceMemberAdd(
    CustomerUserLogin => $TestUserCustomer,
    ServiceID         => $ServiceID,
    Active            => 1,
    UserID            => 1,
);

# Add test SLA.
my $SLAID = $Kernel::OM->Get('Kernel::System::SLA')->SLAAdd(
    Name                => "TestSLA - " . $Helper->GetRandomID(),
    ServiceIDs          => [$ServiceID],
    FirstResponseTime   => 5,
    FirstResponseNotify => 60,
    UpdateTime          => 10,
    UpdateNotify        => 80,
    SolutionTime        => 15,
    SolutionNotify      => 80,
    Calendar            => 1,
    ValidID             => 1,
    UserID              => 1,
);
$Self->True(
    $SLAID,
    "SLA $SLAID has been created.",
);

for my $Item ( 1 .. 5 ) {

    my $TicketID = $TicketObject->TicketCreate(
        Title        => 'Ticket One Title',
        Queue        => 'Raw',
        Lock         => 'unlock',
        Priority     => '3 normal',
        State        => 'new',
        ServiceID    => $ServiceID,
        SLAID        => $SLAID,
        CustomerID   => $TestUserCustomer,
        CustomerUser => $TestUserCustomer,
        OwnerID      => 1,
        UserID       => 1,
    );

    $Self->True(
        $TicketID,
        "TicketCreate() successful for Ticket One ID $TicketID",
    );

    my $TestFieldConfig = $DynamicFieldObject->DynamicFieldGet(
        ID => $FieldID,
    );

    $BackendObject->ValueSet(
        DynamicFieldConfig => $TestFieldConfig,
        ObjectID           => $TicketID,
        Value              => 'Item1',
        UserID             => 1,
    );

    $Helper->FixedTimeAddSeconds( 2 * $Item * 60 );

    my $Success = $TicketObject->TicketStateSet(
        StateID            => 4,
        TicketID           => $TicketID,
        SendNoNotification => 0,
        UserID             => 1,
    );
    $Self->True(
        $Success,
        "TicketStateSet() successful set state 'open' for ticket $TicketID",
    );

    my $ArticleID = $ArticleObject->ArticleCreate(
        TicketID       => $TicketID,
        ArticleType    => 'phone',
        SenderType     => 'agent',
        From           => 'Agent A <email@example.com>',
        To             => 'Customer A <customer-a@example.com>',
        Subject        => 'first response',
        Body           => 'Test body',
        ContentType    => 'text/plain; charset=ISO-8859-15',
        HistoryType    => 'OwnerUpdate',
        HistoryComment => 'first response',
        UserID         => 1,
        NoAgentNotify  => 1,
    );
    $Self->True( $ArticleID, "ArticleCreate() Created article $ArticleID" );

    $Helper->FixedTimeAddSeconds( $Item * 60 );

    $Success = $TicketObject->TicketStateSet(
        StateID            => 2,
        TicketID           => $TicketID,
        SendNoNotification => 0,
        UserID             => 1,
    );

    $Self->True(
        $Success,
        "TicketStateSet() successful set state 'close successful' for ticket $TicketID",
    );

}

my @Tests = (
    {
        KindsOfReporting => 'SolutionAverageAllOver',
        ExpectedResult   => '0h 9m',
    },
    {
        KindsOfReporting => 'SolutionMinTimeAllOver',
        ExpectedResult   => '0h 3m',
    },
    {
        KindsOfReporting => 'SolutionMaxTimeAllOver',
        ExpectedResult   => '0h 15m',
    },
    {
        KindsOfReporting => 'SolutionAverage',
        ExpectedResult   => '0h 9m',
    },
    {
        KindsOfReporting => 'SolutionMinTime',
        ExpectedResult   => '0h 3m',
    },
    {
        KindsOfReporting => 'SolutionMaxTime',
        ExpectedResult   => '0h 15m',
    },
    {
        KindsOfReporting => 'SolutionWorkingTimeAverage',
        ExpectedResult   => '0h 9m',
    },
    {
        KindsOfReporting => 'SolutionMinWorkingTime',
        ExpectedResult   => '0h 3m',
    },
    {
        KindsOfReporting => 'SolutionMaxWorkingTime',
        ExpectedResult   => '0h 15m',
    },
    {
        KindsOfReporting => 'ResponseAverage',
        ExpectedResult   => '0h 6m',
    },
    {
        KindsOfReporting => 'ResponseMinTime',
        ExpectedResult   => '0h 2m',
    },
    {
        KindsOfReporting => 'ResponseWorkingTimeAverage',
        ExpectedResult   => '0h 6m',
    },
    {
        KindsOfReporting => 'ResponseMinWorkingTime',
        ExpectedResult   => '0h 2m',
    },
    {
        KindsOfReporting => 'ResponseMaxWorkingTime',
        ExpectedResult   => '0h 10m',
    },
    {
        KindsOfReporting => 'NumberOfTickets',
        ExpectedResult   => '5',
    },
);

my $TicketSolutionResponseTimeObject = $Kernel::OM->Get('Kernel::System::Stats::Dynamic::TicketSolutionResponseTime');

# Check GetStatElement().
for my $Test (@Tests) {
    for my $Item (qw(Item1 Item2)) {

        my $Result = $TicketSolutionResponseTimeObject->GetStatElement(
            ServiceIDs                       => [$ServiceID],
            KindsOfReporting                 => [ $Test->{KindsOfReporting} ],
            "DynamicField_$DynamicFieldName" => [$Item],
        );

        my $ExpectedResult;
        if ( $Item eq 'Item2' ) {
            $ExpectedResult = 0;
        }
        else {
            $ExpectedResult = $Test->{ExpectedResult};
        }

        $Self->Is(
            $Result,
            $ExpectedResult,
            "$Test->{KindsOfReporting} is calculated well - $Result",
        );
    }

}

# Cleanup cache.
$Kernel::OM->Get('Kernel::System::Cache')->CleanUp();

1;

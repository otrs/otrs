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

use Kernel::System::PostMaster;

$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
    },
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
my $MainObject   = $Kernel::OM->Get('Kernel::System::Main');

# create a dynamic field
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

# define needed variable
my $RandomID  = $Helper->GetRandomID();
my $FieldName = 'ExternalTNRecognition' . $RandomID;
my $FieldID   = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldAdd(
    Name       => $FieldName,
    Label      => $FieldName . "_test",
    FieldOrder => 9991,
    FieldType  => 'Text',
    ObjectType => 'Ticket',
    Config     => {
        DefaultValue => 'a value',
    },
    ValidID => 1,
    UserID  => 1,
);

# verify dynamic field creation
$Self->True(
    $FieldID,
    "DynamicFieldAdd() successful for Field $FieldName",
);


# ensure that the appropriate X-Headers are available in the config
my %NeededXHeaders = (
    "X-OTRS-$FieldName"          => 1,
    "X-OTRS-FollowUp-$FieldName" => 1,
);

my $XHeaders          = $ConfigObject->Get('PostmasterX-Header');
my @PostmasterXHeader = @{$XHeaders};

HEADER:
for my $Header ( sort keys %NeededXHeaders ) {
    next HEADER if ( grep $_ eq $Header, @PostmasterXHeader );
    push @PostmasterXHeader, $Header;
}

$ConfigObject->Set(
    Key   => 'PostmasterX-Header',
    Value => \@PostmasterXHeader
);

# filter test
my @Tests = (
    {
        Name  => "#1 - Body Test",
        Email => "From: Sender <sender\@example.com>
To: Some Name <recipient\@example.com>
Subject: A simple question
X-OTRS-DynamicField-$FieldName: 1

This is a multiline
email for server: example.tld

The IP address: 192.168.0.1
        ",
        Return => 1,    # it's a new ticket
        Check  => {
            "DynamicField_$FieldName" => 1,
        },
    },
    {
        Name  => '#2 - Subject Test',
        Email => "From: Sender <sender\@example.com>
To: Some Name <recipient\@example.com>
Subject: [#1] Another question
X-OTRS-FollowUp-DynamicField-$FieldName: 0

This is a multiline
email for server: example.tld

The IP address: 192.168.0.1
        ",
        Return => 2,    # it's a followup
        Check  => {
            "DynamicField_$FieldName" => 0,
        },
    },
    {
        Name  => '#3 - Body Test - 2',
        Email => "From: Sender <sender\@example.com>
To: Some Name <recipient\@example.com>
Subject: A simple question
X-OTRS-DynamicField-$FieldName: 0

This is a multiline
email for server: example.tld

The IP address: 192.168.0.1
        ",
        Return => 1,    # it's a new ticket
        Check  => {
            "DynamicField_$FieldName" => 0,
        },
    },
 
);

my %TicketNumbers;
my %TicketIDs;

my $Index = 1;
for my $Test (@Tests) {
    my $Name  = $Test->{Name};
    my $Email = $Test->{Email};

    $Email =~ s{\[#([0-9]+)\]}{[Ticket#$TicketNumbers{$1}]};

    my @Return;
    {
        my $PostMasterObject = Kernel::System::PostMaster->new(
            Trusted => 1,
            Email => \$Email,
        );

        @Return = $PostMasterObject->Run();
    }
    $Self->Is(
        $Return[0] || 0,
        $Test->{Return},
        "$Name - NewTicket/FollowUp",
    );
    $Self->True(
        $Return[1] || 0,
        "$Name - TicketID",
    );

    # new/clear ticket object
    $Kernel::OM->ObjectsDiscard( Objects => ['Kernel::System::Ticket'] );
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    my %Ticket = $TicketObject->TicketGet(
        TicketID      => $Return[1],
        DynamicFields => 1,
    );

use Data::Dumper;
$Data::Dumper::Sortkeys = 1;
print STDERR Dumper( \%Ticket );

    for my $Key ( sort keys %{ $Test->{Check} } ) {
        $Self->Is(
            $Ticket{$Key},
            $Test->{Check}->{$Key},
            "Run('$Test->{Name}') - $Key",
        );
    }

    $TicketNumbers{$Index} = $Ticket{TicketNumber};
    $TicketIDs{ $Return[1] }++;

    $Index++;
}

for my $TicketID ( sort keys %TicketIDs ) {

    # new/clear ticket object
    $Kernel::OM->ObjectsDiscard( Objects => ['Kernel::System::Ticket'] );
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    # delete ticket
    my $Delete = $TicketObject->TicketDelete(
        TicketID => $TicketID,
        UserID   => 1,
    );

    $Self->True(
        $Delete || 0,
        "#Filter TicketDelete()",
    );
}

# cleanup is done by RestoreDatabase

1;

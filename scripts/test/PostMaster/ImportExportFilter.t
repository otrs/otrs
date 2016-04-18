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

my %NeededXHeaders = (
    'From' => 1,
    'To'   => 1,
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

# disable not needed event module
$ConfigObject->Set(
    Key => 'Ticket::EventModulePost###TicketDynamicFieldDefault',
);

# filter test
my @ExportTests = (
    {
        Name  => 'Export#1 - Simple Test' . time,
        Match => {
            From => 'test@test.tld',
        },
        Set => {
            'X-OTRS-Priority' => '2 low',
        },
        Expect => '{"x":[{"Key":"From","Not":null,"Stop":0,"Type":"Match","Value":"test@test.tld"},{"Key":"X-OTRS-Priority","Not":null,"Stop":0,"Type":"Set","Value":"2 low"}]}',
    },
);

my @ImportTests = (
    {
        Name  => 'Import#1 - Simple Test' . time,
        JSON   => '{"x":[{"Key":"From","Type":"Match","Not":null,"Value":"test@test.de","Stop":0},{"Key":"X-OTRS-Priority","Type":"Set","Not":null,"Value":"2 low","Stop":0}]}',
        Check  => {
            Match => { From => 'test@test.de' },
            Set   => { 'X-OTRS-Priority' => '2 low' },
        },
    },
);

$Kernel::OM->ObjectsDiscard( Objects => ['Kernel::System::PostMaster::Filter', 'Kernel::System::PostMaster::ImportExport'] );
my $PostMasterFilter = $Kernel::OM->Get('Kernel::System::PostMaster::Filter');
my $ImportExport     = $Kernel::OM->Get('Kernel::System::PostMaster::ImportExport');

for my $Test (@ExportTests) {
    my $Name = $Test->{Name};

    $Test->{Expect} =~ s{"x"}{"$Name"};

    my $Success = $PostMasterFilter->FilterAdd(
        Name           => $Name,
        StopAfterMatch => 0,
        %{$Test},
    );

    $Self->True(
        $Success,
        "#Filter Added " . $Name,
    );

    my %List = $PostMasterFilter->FilterList();
    my $ID   = $List{$Name};

    my $JSON = $ImportExport->PostmasterFilterExport(
        IDs => [$ID],
    );

    $Self->True(
        $JSON,
        "#Filter exported " . $Name,
    );

    $Self->Is(
        $JSON,
        $Test->{Expect},
        "#Filter exported - JSON ok " . $Name,
    );

    # remove filter
    $PostMasterFilter->FilterDelete( Name => $Test->{Name} );
}

for my $Test ( @ImportTests ) {
    my $Name = $Test->{Name};

    $Test->{JSON} =~ s{"x"}{"$Name"};

    my $Success = $ImportExport->PostmasterFilterImport(
        Filters => $Test->{JSON},
    );

    $Self->True(
        $Success,
        "#Filter import $Name",
    );

    my %Filter = $PostMasterFilter->FilterGet( Name => $Name );

    for my $Type ( qw(Match Set) ) {
        for my $Check ( keys %{ $Test->{Check}->{$Type} } ) {
            $Self->Is(
                $Filter{$Type}->{$Check},
                $Test->{Check}->{$Type}->{$Check},
                "#Filter import check - $Name - $Type - $Check",
            );
        }
    }

    # remove filter
    $PostMasterFilter->FilterDelete( Name => $Test->{Name} );
}

# cleanup is done by RestoreDatabase

1;

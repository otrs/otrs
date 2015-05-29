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

use Kernel::System::PostMaster;
use Kernel::System::VariableCheck qw(IsHashRefWithData);

# get needed objects
my $ConfigObject        = $Kernel::OM->Get('Kernel::Config');
my $MainObject          = $Kernel::OM->Get('Kernel::System::Main');
my $DynamicFieldObject  = $Kernel::OM->Get('Kernel::System::DynamicField');
my $TicketObject        = $Kernel::OM->Get('Kernel::System::Ticket');

my $FieldName = 'FollowUpDetection';
my $Header    = "X-OTRS-DynamicField-$FieldName";
my $Config = $ConfigObject->Get('PostMaster::CheckFollowUpModule')->{'0800-DynamicField'};
$Config->{DynamicField} = $FieldName;
$Config->{Header}       = "X-OTRS-DynamicField-$FieldName";
$Config->{StateTypes}   = [ 'new', 'open' ];

$ConfigObject->Set(
    Key         => 'PostmasterX-Header',
    Value       => [$Header],
);

$ConfigObject->Set(
    Key   => 'PostmasterDefaultState',
    Value => 'new'
);


my $DynamicField = $DynamicFieldObject->DynamicFieldGet(
    Name => $FieldName,
);

if ( !IsHashRefWithData( $DynamicField ) ) {
    $DynamicFieldObject->DynamicFieldAdd(
        Name    => $FieldName,
        Label   => $FieldName . '_test',
        FieldOrder      => 9992,
        FieldType       => 'Text',
        ObjectType      => 'Ticket',
        ValidID         => 1,
        UserID          => 1,
        Config          => { dummy => 1},
    );
    $DynamicField = $DynamicFieldObject->DynamicFieldGet(
        Name => $FieldName,
    );
}


my %TicketsToDelete;
my $ProcessMailFile = sub {
    my ( $Number ) = @_;
    my $Path = $ConfigObject->Get('Home') .
        "/scripts/test/sample/PostMaster/PostMaster-CheckFollowUp$Number.box";
    my $Lines = $MainObject->FileRead(
        Location => $Path,
        Mode     => 'binmode',
        Result   => 'ARRAY',
    );
    my $PostMasterObject = Kernel::System::PostMaster->new(
        Email   => $Lines,
        Trusted => 1,
    );
    my ( $Code, $TicketID ) =  $PostMasterObject->Run();
    if ( $TicketID ) {
        $TicketsToDelete{ $TicketID } = 1;
    }
    return ( $Code, $TicketID );
};

my ( $Code, $FirstTicketID ) = $ProcessMailFile->( 1 );

$Self->Is( $Code, 1, 'New ticket from email' );

my %Ticket = $TicketObject->TicketGet(
    TicketID    => $FirstTicketID,
    UserID      => 1,
    DynamicFields       => 1,
);

$Self->Is(
    $Ticket{"DynamicField_$FieldName"},
    "OTRS Rocks",
    'Dynamic field set correctly',
);

( $Code, my $FollowUpTicketID ) = $ProcessMailFile->( 2 );

$Self->Is( $Code, 2, 'Detected a follow-up through a dynamic field'  );
$Self->Is( $FirstTicketID, $FollowUpTicketID, 'Follow-up to the correct ticket' );

( $Code, my $UnrelatedTicketID ) = $ProcessMailFile->( 3 );

$Self->Is( $Code, 1, 'Different FollowUpDetection-header led to new ticket'  );

my $Success = $TicketObject->StateSet(
    TicketID    => $FirstTicketID,
    State       => 'merged',
    UserID      => 1,
);

$Self->True($Success, 'Could close ticket');

( $Code, my $RetryTicketID ) = $ProcessMailFile->( 1 );

$Self->Is( $Code, 1, 'No follow-up if previous ticket is neither open nor new');


for my $TicketID (sort keys %TicketsToDelete) {
    my $Deleted = $TicketObject->TicketDelete(
        TicketID => $TicketID,
        UserID   => 1,
    );
    $Self->True( $Deleted, "Ticket (ID $TicketID) deleted" );
}

my $Deleted = $DynamicFieldObject->DynamicFieldDelete(
    ID     => $DynamicField->{ID},
    UserID => 1,
);

$Self->True(
    $Deleted,
    'Dynamic Field deleted',
);

1;

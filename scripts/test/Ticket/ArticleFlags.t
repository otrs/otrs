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

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

my $TicketID = $TicketObject->TicketCreate(
    Title        => 'Some Ticket_Title',
    Queue        => 'Raw',
    Lock         => 'unlock',
    Priority     => '3 normal',
    State        => 'closed successfully',
    CustomerNo   => '123465',
    CustomerUser => 'customer@example.com',
    OwnerID      => 1,
    UserID       => 1,
);
$Self->True(
    $TicketID,
    'TicketCreate()',
);

my $ArticleID = $TicketObject->ArticleCreate(
    TicketID       => $TicketID,
    ArticleType    => 'note-internal',
    SenderType     => 'agent',
    From           => 'Some Agent <email@example.com>',
    To             => 'Some Customer <customer-a@example.com>',
    Subject        => 'some short description',
    Body           => 'the message text',
    ContentType    => 'text/plain; charset=ISO-8859-15',
    HistoryType    => 'OwnerUpdate',
    HistoryComment => 'Some free text!',
    UserID         => 1,
    NoAgentNotify  => 1,                                          # if you don't want to send agent notifications
);

$Self->True(
    $ArticleID,
    'ArticleCreate()',
);

my $ArticleID2 = $TicketObject->ArticleCreate(
    TicketID       => $TicketID,
    ArticleType    => 'note-internal',
    SenderType     => 'agent',
    From           => 'Some Agent <email@example.com>',
    To             => 'Some Customer <customer-a@example.com>',
    Subject        => 'some short description',
    Body           => 'the message text',
    ContentType    => 'text/plain; charset=ISO-8859-15',
    HistoryType    => 'OwnerUpdate',
    HistoryComment => 'Some free text!',
    UserID         => 1,
    NoAgentNotify  => 1,                                          # if you don't want to send agent notifications
);

$Self->True(
    $ArticleID2,
    'ArticleCreate()',
);

# article flag tests
my @Tests = (
    {
        Name   => 'seen flag',
        Key    => 'seen',
        Value  => 1,
        UserID => 1,
    },
    {
        Name   => 'not seen flag',
        Key    => 'not seen',
        Value  => 2,
        UserID => 1,
    },
);

# delete pre-existing article flags which are created on TicketCreate
$TicketObject->ArticleFlagDelete(
    ArticleID => $ArticleID,
    Key       => 'Seen',
    UserID    => 1,
);
$TicketObject->ArticleFlagDelete(
    ArticleID => $ArticleID2,
    Key       => 'Seen',
    UserID    => 1,
);

for my $Test (@Tests) {

    # set for article 1
    my %Flag = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleID,
        UserID    => 1,
    );
    $Self->False(
        $Flag{ $Test->{Key} },
        'ArticleFlagGet() article 1',
    );
    my $Set = $TicketObject->ArticleFlagSet(
        ArticleID => $ArticleID,
        Key       => $Test->{Key},
        Value     => $Test->{Value},
        UserID    => 1,
    );
    $Self->True(
        $Set,
        'ArticleFlagSet() article 1',
    );

    # set for article 2
    %Flag = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleID2,
        UserID    => 1,
    );
    $Self->False(
        $Flag{ $Test->{Key} },
        'ArticleFlagGet() article 2',
    );
    $Set = $TicketObject->ArticleFlagSet(
        ArticleID => $ArticleID2,
        Key       => $Test->{Key},
        Value     => $Test->{Value},
        UserID    => 1,
    );
    $Self->True(
        $Set,
        'ArticleFlagSet() article 2',
    );
    %Flag = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleID2,
        UserID    => 1,
    );
    $Self->Is(
        $Flag{ $Test->{Key} },
        $Test->{Value},
        'ArticleFlagGet() article 2',
    );

    # get all flags of ticket
    %Flag = $TicketObject->ArticleFlagsOfTicketGet(
        TicketID => $TicketID,
        UserID   => 1,
    );
    $Self->IsDeeply(
        \%Flag,
        {
            $ArticleID => {
                $Test->{Key} => $Test->{Value},
            },
            $ArticleID2 => {
                $Test->{Key} => $Test->{Value},
            },
        },
        'ArticleFlagsOfTicketGet() both articles',
    );

    # delete for article 1
    my $Delete = $TicketObject->ArticleFlagDelete(
        ArticleID => $ArticleID,
        Key       => $Test->{Key},
        UserID    => 1,
    );
    $Self->True(
        $Delete,
        'ArticleFlagDelete() article 1',
    );
    %Flag = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleID,
        UserID    => 1,
    );
    $Self->False(
        $Flag{ $Test->{Key} },
        'ArticleFlagGet() article 1',
    );

    %Flag = $TicketObject->ArticleFlagsOfTicketGet(
        TicketID => $TicketID,
        UserID   => 1,
    );
    $Self->IsDeeply(
        \%Flag,
        {
            $ArticleID2 => {
                $Test->{Key} => $Test->{Value},
            },
        },
        'ArticleFlagsOfTicketGet() only one article',
    );

    # delete for article 2
    $Delete = $TicketObject->ArticleFlagDelete(
        ArticleID => $ArticleID2,
        Key       => $Test->{Key},
        UserID    => 1,
    );
    $Self->True(
        $Delete,
        'ArticleFlagDelete() article 2',
    );

    %Flag = $TicketObject->ArticleFlagsOfTicketGet(
        TicketID => $TicketID,
        UserID   => 1,
    );
    $Self->IsDeeply(
        \%Flag,
        {},
        'ArticleFlagsOfTicketGet() empty articles',
    );

    # test ArticleFlagsDelete for AllUsers
    $Set = $TicketObject->ArticleFlagSet(
        ArticleID => $ArticleID,
        Key       => $Test->{Key},
        Value     => $Test->{Value},
        UserID    => 1,
    );
    $Self->True(
        $Set,
        'ArticleFlagSet() article 1',
    );
    %Flag = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleID,
        UserID    => 1,
    );
    $Self->Is(
        $Flag{ $Test->{Key} },
        $Test->{Value},
        'ArticleFlagGet() article 1',
    );
    $Delete = $TicketObject->ArticleFlagDelete(
        ArticleID => $ArticleID,
        Key       => $Test->{Key},
        AllUsers  => 1,
    );
    $Self->True(
        $Delete,
        'ArticleFlagDelete() article 2 for AllUsers',
    );
    %Flag = $TicketObject->ArticleFlagGet(
        ArticleID => $ArticleID,
        UserID    => 1,
    );
    $Self->Is(
        $Flag{ $Test->{Key} },
        scalar undef,
        'ArticleFlagGet() article 1 after delete for AllUsers',
    );
}

# test searching for article flags

my @SearchTestFlagsSet    = qw( f1 f2 f3 );
my @SearchTestFlagsNotSet = qw( f4 f5 );

for my $Flag (@SearchTestFlagsSet) {
    my $Set = $TicketObject->ArticleFlagSet(
        ArticleID => $ArticleID,
        Key       => $Flag,
        Value     => 42,
        UserID    => 1,
    );

    $Self->True(
        $Set,
        "Can set article flag $Flag",
    );
}

my @FlagSearchTests = (
    {
        Search => {
            ArticleFlag => {
                f1 => 42,
                f2 => 42,
            },
        },
        Expected => 1,
        Name     => "Can find ticket when searching for two article flags",
    },
    {
        Search => {
            ArticleFlag => {
                f1 => 42,
                f2 => 1,
            },
        },
        Expected => 0,
        Name     => "Wrong flag value leads to no match",
    },
);

for my $Test (@FlagSearchTests) {
    my $Found = $TicketObject->TicketSearch(
        TicketID => $TicketID,
        Result   => 'COUNT',
        UserID   => 1,
        %{ $Test->{Search} },
    );

    $Self->Is(
        $Found,
        $Test->{Expected},
        $Test->{Name},
    );
}

# the ticket is no longer needed
$TicketObject->TicketDelete(
    TicketID => $TicketID,
    UserID   => 1,
);

1;

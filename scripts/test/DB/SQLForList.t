# --
# SQLForList.t - database helper tests
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use vars qw($Self);

use Kernel::System::XML;

my $DBObject  = Kernel::System::DB->new( %{$Self} );

$Self->Is(
    $DBObject->SQLForList(
        Column => 'id',
        Values => [],
        Type   => 'Integer',
    ),
    '',
    'Empty values',
);

$Self->Is(
    $DBObject->SQLForList(
        Column => 'id',
        Values => [1, 2, 3],
        Type   => 'Integer',
    ),
    'id in (1, 2, 3)',
    'non-empty values',
);

$Self->Is(
    $DBObject->SQLForList(
        Column     => 'id',
        Values     => [1, 2, 3],
        Type       => 'Integer',
        LeadingAND => 1,
    ),
    'AND id in (1, 2, 3)',
    'leading AND',
);

1;

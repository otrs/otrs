# --
# ObjectManager.t - Customer Group tests
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use vars (qw($Self));

use Kernel::System::ObjectManager;

local $Kernel::OM = Kernel::System::ObjectManager->new(
    DummyObject => {
        Data => 'Test payload',
        }
);

$Self->True( $Kernel::OM, 'Could build object manager' );

my $Dummy = eval { $Kernel::OM->Get('DummyObject') };
$Self->True( !$Dummy, 'Can not get dummy object before it is registered' );

$Kernel::OM->ObjectRegister(
    Name      => 'DummyObject',
    ClassName => 'scripts::test::sample::Dummy',
);

$Dummy = $Kernel::OM->Get('DummyObject');

$Self->True( $Dummy, 'Can get dummy object after registration' );

$Self->Is(
    $Dummy->Data(),
    'Test payload',
    'Speciailization of late registered object',
);

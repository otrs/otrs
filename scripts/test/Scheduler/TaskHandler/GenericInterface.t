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

use Kernel::System::Scheduler::TaskHandler;

# get needed objects
my $HelperObject     = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');
my $WebserviceObject = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice');
my $RequesterObject  = $Kernel::OM->Get('Kernel::GenericInterface::Requester');

my $TaskHandlerObject = Kernel::System::Scheduler::TaskHandler->new(
    TaskHandlerType => 'GenericInterface',
);

my $RandomID = $HelperObject->GetRandomID();

# webservice config
my $WebserviceConfig = {
    Debugger => {
        DebugThreshold => 'debug',
        TestMode       => 1,
    },
    Requester => {
        Transport => {
            Type   => 'HTTP::Test',
            Config => {
                Fail => 0,
            },
        },
        Invoker => {
            test_operation => {
                Type => 'Test::TestSimple',
            },
        },
    },
};

# add webserver config
my $WebserviceID = $WebserviceObject->WebserviceAdd(
    Config  => $WebserviceConfig,
    Name    => "GenericInterface Scheduler Task Manager Backend Test $RandomID",
    ValidID => 1,
    UserID  => 1,
);

$Self->True(
    $WebserviceID,
    "WebserviceAdd()",
);

# task config
my @TaskList = (
    {
        Name         => 'Normal',
        WebserviceID => $WebserviceID,
        Invoker      => 'test_operation',
        Data         => {
            var1 => 'a',
        },
        Result => 1,
    },
    {
        Name         => 'Empty Data',
        WebserviceID => $WebserviceID,
        Invoker      => 'test_operation',
        Data         => {
        },
        Result => 1,
    },
    {
        Name         => 'Empty Invoker',
        WebserviceID => $WebserviceID,
        Invoker      => '',
        Data         => {
            var1 => 'a',
        },
        Result => 0,
    },
    {
        Name         => 'No WebService',
        WebserviceID => 0,
        Invoker      => 'test_operation',
        Data         => {
            var1 => 'a',
        },
        Result => 0,
    },
    {
        Name         => 'Undefined Data',
        WebserviceID => $WebserviceID,
        Invoker      => 'test_operation',
        Data         => undef,
        Result       => 0,
    },
    {
        Name         => 'Undefined Invoker',
        WebserviceID => $WebserviceID,
        Invoker      => undef,
        Data         => {
            var1 => 'a',
        },
        Result => 0,
    },
    {
        Name         => 'Undefined WebService',
        WebserviceID => undef,
        Invoker      => 'test_operation',
        Data         => {
            var1 => 'a',
        },
        Result => 0,
    },
    {
        Name         => 'Wrong invoker',
        WebserviceID => $WebserviceID,
        Invoker      => 'no_configured_invoker',
        Data         => {
            var1 => 'a',
        },
        Result => 0,
    },
    {
        Name         => 'Wrong Service ID',
        WebserviceID => 9999999,
        Invoker      => 'test_operation',
        Data         => {
            var1 => 'a',
        },
        Result => 0,
    },
    {
        Name   => 'Empty task data',
        Result => 0,
    },
);

for my $TaskData (@TaskList) {

    # result task
    my $Result = $TaskHandlerObject->Run( Data => $TaskData );

    $Self->Is(
        $Result->{Success},
        $TaskData->{Result},
        "$TaskData->{Name} execution result",
    );
}

# delete webserice config
my $Success = $WebserviceObject->WebserviceDelete(
    ID     => $WebserviceID,
    UserID => 1,
);

$Self->True(
    $Success,
    "WebserviceDelete()",
);

1;

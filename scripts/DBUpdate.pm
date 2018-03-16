# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package scripts::DBUpdate;    ## no critic

use strict;
use warnings;

use Time::HiRes ();
use Kernel::System::VariableCheck qw(IsHashRefWithData);

our @ObjectDependencies = (
    'Kernel::System::Cache',
    'Kernel::System::Main',
    'Kernel::System::SysConfig',
);

=head1 NAME

scripts::DBUpdate - Perform system upgrade.

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $DBUpdateObject = $Kernel::OM->Get('scripts::DBUpdate');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # Enable auto-flushing of STDOUT.
    $| = 1;    ## no critic

    # Enable timing feature in case it is call.
    my $TimingEnabled = $Param{CommandlineOptions}->{Timing} || 0;

    my $GeneralStartTime;
    if ($TimingEnabled) {
        $GeneralStartTime = Time::HiRes::time();
    }

    print "\n Migration started ... \n";

    my $SuccessfulMigration = 1;
    my @Components = ( 'CheckPreviousRequirement', 'Run' );

    COMPONENT:
    for my $Component (@Components) {

        $SuccessfulMigration = $Self->_ExecuteComponent(
            Component => $Component,
            %Param,
        );
        last COMPONENT if !$SuccessfulMigration;
    }

    if ($SuccessfulMigration) {
        print "\n\n\n Migration completed! \n\n";
    }
    else {
        print "\n\n\n Not possible to complete migration, check previous messages for more information. \n\n";
    }

    if ($TimingEnabled) {
        my $GeneralStopTime = Time::HiRes::time();
        my $GeneralExecutionTime = sprintf( "%.6f", $GeneralStopTime - $GeneralStartTime );
        print "    Migration took $GeneralExecutionTime seconds.\n\n";
    }

    return $SuccessfulMigration;
}

sub _ExecuteComponent {
    my ( $Self, %Param ) = @_;

    if ( !$Param{Component} ) {
        print " Error: Need Component!\n\n";
        return;
    }

    my $Component = $Param{Component};

    # Enable timing feature in case it is call.
    my $TimingEnabled = $Param{CommandlineOptions}->{Timing} || 0;

    # Get migration tasks.
    my @Tasks = $Self->_TasksGet();

    # Get the number of total steps.
    my $Steps               = scalar @Tasks;
    my $CurrentStep         = 1;
    my $SuccessfulMigration = 1;

    # Show initial message for current component
    if ( $Component eq 'Run' ) {
        print "\n Executing tasks ... \n\n";
    }
    else {
        print "\n Checking requirements ... \n\n";
    }

    TASK:
    for my $Task (@Tasks) {

        next TASK if !$Task;
        next TASK if !$Task->{Module};

        my $ModuleName = "scripts::DBUpdate::$Task->{Module}";
        if ( !$Kernel::OM->Get('Kernel::System::Main')->Require($ModuleName) ) {
            $SuccessfulMigration = 0;
            last TASK;
        }

        my $TaskStartTime;
        if ($TimingEnabled) {
            $TaskStartTime = Time::HiRes::time();
        }

        # Run module.
        $Kernel::OM->ObjectParamAdd(
            "scripts::DBUpdate::$Task->{Module}" => {
                Opts => $Self->{Opts},
            },
        );

        $Self->{TaskObjects}->{$ModuleName} //= $Kernel::OM->Create($ModuleName);
        if ( !$Self->{TaskObjects}->{$ModuleName} ) {
            print "\n    Error: Could not create object for: $ModuleName.\n\n";
            $SuccessfulMigration = 0;
            last TASK;
        }

        my $Success = 1;

        # Execute Run-Component
        if ( $Component eq 'Run' ) {
            print "    Step $CurrentStep of $Steps: $Task->{Message} ...\n";
            $Success = $Self->{TaskObjects}->{$ModuleName}->$Component(%Param);
        }

        # Execute previous check, printing a different message
        elsif ( $Self->{TaskObjects}->{$ModuleName}->can($Component) ) {
            print "    Requirement check for: $Task->{Message} ...\n";
            $Success = $Self->{TaskObjects}->{$ModuleName}->$Component(%Param);
        }

        # Do not handle timing if task has no appropriate component.
        else {
            next TASK;
        }

        if ($TimingEnabled) {
            my $StopTaskTime = Time::HiRes::time();
            my $ExecutionTaskTime = sprintf( "%.6f", $StopTaskTime - $TaskStartTime );
            print " ($ExecutionTaskTime seconds).";
        }

        if ( !$Success ) {
            $SuccessfulMigration = 0;
            last TASK;
        }

        $CurrentStep++;
    }

    return $SuccessfulMigration;
}

sub _TasksGet {
    my ( $Self, %Param ) = @_;

    my @Tasks = (
        {
            Message => 'Check framework version',
            Module  => 'FrameworkVersionCheck',
        },
        {
            Message => 'Check required Perl version',
            Module  => 'PerlVersionCheck',
        },
        {
            Message => 'Check required database version',
            Module  => 'DatabaseVersionCheck',
        },
        {
            Message => 'Check database charset',
            Module  => 'DatabaseCharsetCheck',
        },
        {
            Message => 'Check required Perl modules',
            Module  => 'PerlModulesCheck',
        },
        {
            Message => 'Check if database has been backed up',
            Module  => 'DatabaseBackupCheck',
        },
        {
            Message => 'Upgrade database structure',
            Module  => 'UpgradeDatabaseStructure',
        },
        {
            Message => 'Migrate ZoomExpand setting',
            Module  => 'MigrateZoomExpandConfig',
        },
        {
            Message => 'Refresh configuration cache',
            Module  => 'RebuildConfig',
        },

        # Add new tasks here...

        {
            Message => 'Initialize default cron jobs',
            Module  => 'InitializeDefaultCronjobs',
        },

        # ...

        {
            Message => 'Uninstall Merged Feature Add-Ons',
            Module  => 'UninstallMergedFeatureAddOns',
        },
        {
            Message => 'Clean up the cache',
            Module  => 'CacheCleanup',
        },
        {
            Message => 'Refresh configuration cache another time',
            Module  => 'RebuildConfig',
        },
    );

    return @Tasks;
}

1;

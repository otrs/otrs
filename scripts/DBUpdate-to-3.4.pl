#!/usr/bin/perl
# --
# DBUpdate-to-3.4.pl - update script to migrate OTRS 3.3.x to 3.4.x
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU AFFERO General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
# or see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

# use ../ as lib location
use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';

use Getopt::Std qw();
use Kernel::Config;
use Kernel::System::ObjectManager;
use Kernel::System::SysConfig;
use Kernel::System::Cache;
use Kernel::System::Package;
use Kernel::System::VariableCheck qw(:all);

local $Kernel::OM = Kernel::System::ObjectManager->new(
    LogObject => {
        LogPrefix => 'OTRS-DBUpdate-to-3.4.pl',
    },
);

{

    # get options
    my %Opts;
    Getopt::Std::getopt( 'h', \%Opts );

    if ( exists $Opts{h} ) {
        print <<"EOF";

DBUpdate-to-3.4.pl - Upgrade scripts for OTRS 3.3.x to 3.4.x migration.
Copyright (C) 2001-2013 OTRS AG, http://otrs.com/

Usage: $0 [-h]
    Options are as follows:
        -h      display this help

EOF
        exit 1;
    }

    # UID check if not on Windows
    if ( $^O ne 'MSWin32' && $> == 0 ) {    # $EFFECTIVE_USER_ID
        die "
Cannot run this program as root.
Please run it as the 'otrs' user or with the help of su:
    su -c \"$0\" -s /bin/bash otrs
";
    }

    # enable autoflushing of STDOUT
    $| = 1;                                 ## no critic

    print "\nMigration started...\n\n";

    # create common objects
    my $CommonObject = _CommonObjectsBase();

    # define the number of steps
    my $Steps = 9;
    my $Step  = 1;

    print "Step $Step of $Steps: Refresh configuration cache... ";
    RebuildConfig($CommonObject) || die;
    print "done.\n\n";
    $Step++;

    # create common objects with new default config
    $CommonObject = _CommonObjectsBase();

    # check framework version
    print "Step $Step of $Steps: Check framework version... ";
    _CheckFrameworkVersion($CommonObject) || die;
    print "done.\n\n";
    $Step++;

    # migrate FontAwesome
    print "Step $Step of $Steps: Migrate FontAwesome icons... ";
    if ( _MigrateFontAwesome($CommonObject) ) {
        print "done.\n\n";
    }
    else {
        print "error.\n\n";
        die;
    }
    $Step++;

    # migrate DB ACLs
    print "Step $Step of $Steps: Migrate ACLs stored in the DB... ";
    if ( _MigrateDBACLs($CommonObject) ) {
        print "done.\n\n";
    }
    else {
        print "error.\n\n";
        die;
    }
    $Step++;

    # set service notifications
    print "Step $Step of $Steps: Set service notifications... ";
    if ( _SetServiceNotifications($CommonObject) ) {
        print "done.\n\n";
    }
    else {
        print "error.\n\n";
        die;
    }
    $Step++;

    # mgrate settings
    print "Step $Step of $Steps: Migrate Settings... ";
    if ( _MigrateSettings($CommonObject) ) {
        print "done.\n\n";
    }
    else {
        print "error.\n\n";
        die;
    }
    $Step++;

    # uninstall Merged Feature Add-Ons
    print "Step $Step of $Steps: Uninstall Merged Feature Add-Ons... ";
    if ( _UninstallMergedFeatureAddOns($CommonObject) ) {
        print "done.\n\n";
    }
    else {
        print "error.\n\n";
        die;
    }
    $Step++;

    # Clean up the cache completely at the end.
    print "Step $Step of $Steps: Clean up the cache... ";
    my $CacheObject = Kernel::System::Cache->new( %{$CommonObject} ) || die;
    $CacheObject->CleanUp();
    print "done.\n\n";
    $Step++;

    print "Step $Step of $Steps: Refresh configuration cache another time... ";
    RebuildConfig($CommonObject) || die;
    print "done.\n\n";

    print "Migration completed!\n";

    exit 0;
}

sub _CommonObjectsBase {
    my %CommonObject = $Kernel::OM->ObjectHash(
        Objects =>
            [
            qw(ConfigObject EncodeObject LogObject MainObject TimeObject DBObject SysConfigObject)
            ],
    );
    return \%CommonObject;
}

=item RebuildConfig($CommonObject)

refreshes the configuration to make sure that a ZZZAAuto.pm is present
after the upgrade.

    RebuildConfig($CommonObject);

=cut

sub RebuildConfig {
    my $CommonObject = shift;

    my $SysConfigObject = Kernel::System::SysConfig->new( %{$CommonObject} );

    # Rebuild ZZZAAuto.pm with current values
    if ( !$SysConfigObject->WriteDefault() ) {
        die "Error: Can't write default config files!";
    }

    # Force a reload of ZZZAuto.pm and ZZZAAuto.pm to get the new values
    for my $Module ( sort keys %INC ) {
        if ( $Module =~ m/ZZZAA?uto\.pm$/ ) {
            delete $INC{$Module};
        }
    }

    # reload config object
    print
        "\nIf you see warnings about 'Subroutine Load redefined', that's fine, no need to worry!\n";
    $CommonObject = _CommonObjectsBase();

    return 1;
}

=item _CheckFrameworkVersion()

Check if framework it's the correct one for Dinamic Fields migration.

    _CheckFrameworkVersion();

=cut

sub _CheckFrameworkVersion {
    my $CommonObject = shift;

    my $Home = $CommonObject->{ConfigObject}->Get('Home');

    # load RELEASE file
    if ( -e !"$Home/RELEASE" ) {
        die "Error: $Home/RELEASE does not exist!";
    }
    my $ProductName;
    my $Version;
    if ( open( my $Product, '<', "$Home/RELEASE" ) ) {    ## no critic
        while (<$Product>) {

            # filtering of comment lines
            if ( $_ !~ /^#/ ) {
                if ( $_ =~ /^PRODUCT\s{0,2}=\s{0,2}(.*)\s{0,2}$/i ) {
                    $ProductName = $1;
                }
                elsif ( $_ =~ /^VERSION\s{0,2}=\s{0,2}(.*)\s{0,2}$/i ) {
                    $Version = $1;
                }
            }
        }
        close($Product);
    }
    else {
        die "Error: Can't read $CommonObject->{Home}/RELEASE: $!";
    }

    if ( $ProductName ne 'OTRS' ) {
        die "Error: No OTRS system found"
    }
    if ( $Version !~ /^3\.4(.*)$/ ) {

        die "Error: You are trying to run this script on the wrong framework version $Version!"
    }

    return 1;
}

=item _MigrateFontAwesome()

Migrate settings that has changed it name.

    _MigrateFontAwesome($CommonObject);

=cut

sub _MigrateFontAwesome {
    my $CommonObject = shift;

    my $SysConfigObject = Kernel::System::SysConfig->new( %{$CommonObject} );

    # update toolbar items settings
    # otherwise the new fontawesome icons won't be displayed

    # collect icon data for toolbar items
    my %ModuleAttributes = (
        '1-Ticket::AgentTicketQueue' => {
            'Icon' => 'fa fa-folder',
        },
        '2-Ticket::AgentTicketStatus' => {
            'Icon' => 'fa fa-list-ol',
        },
        '3-Ticket::AgentTicketEscalation' => {
            'Icon' => 'fa fa-exclamation',
        },
        '4-Ticket::AgentTicketPhone' => {
            'Icon' => 'fa fa-phone',
        },
        '5-Ticket::AgentTicketEmail' => {
            'Icon' => 'fa fa-envelope',
        },
        '6-Ticket::AgentTicketProcess' => {
            'Icon' => 'fa fa-th-large',
        },
        '6-Ticket::TicketResponsible' => {
            'Icon'        => 'fa fa-user',
            'IconNew'     => 'fa fa-user',
            'IconReached' => 'fa fa-user',
        },
        '7-Ticket::TicketWatcher' => {
            'Icon'        => 'fa fa-eye',
            'IconNew'     => 'fa fa-eye',
            'IconReached' => 'fa fa-eye',
        },
        '8-Ticket::TicketLocked' => {
            'Icon'        => 'fa fa-lock',
            'IconNew'     => 'fa fa-lock',
            'IconReached' => 'fa fa-lock',
        },
    );

    my $Setting = $CommonObject->{ConfigObject}->Get('Frontend::ToolBarModule');

    TOOLBARMODULE:
    for my $ToolbarModule ( sort keys %ModuleAttributes ) {

        next TOOLBARMODULE if !IsHashRefWithData( $Setting->{$ToolbarModule} );

        # set icon and class infos
        for my $Attribute ( sort keys %{ $ModuleAttributes{$ToolbarModule} } ) {
            $Setting->{$ToolbarModule}->{$Attribute}
                = $ModuleAttributes{$ToolbarModule}->{$Attribute};
        }

        # set new setting,
        my $Success = $SysConfigObject->ConfigItemUpdate(
            Valid => 1,
            Key   => 'Frontend::ToolBarModule###' . $ToolbarModule,
            Value => $Setting->{$ToolbarModule},
        );
    }

    # collect icon data for customer user items
    my %CustomerUserAttributes = (
        '1-GoogleMaps' => {
            'IconName' => 'fa-globe',
        },
        '2-Google' => {
            'IconName' => 'fa-google',
        },
        '2-LinkedIn' => {
            'IconName' => 'fa-linkedin',
        },
        '3-XING' => {
            'IconName' => 'fa-xing',
        },
        '15-OpenTickets' => {
            'IconNameOpenTicket'   => 'fa-exclamation-circle',
            'IconNameNoOpenTicket' => 'fa-check-circle',
        },
        '16-OpenTicketsForCustomerUserLogin' => {
            'IconNameOpenTicket'   => 'fa-exclamation-circle',
            'IconNameNoOpenTicket' => 'fa-check-circle',
        },
        '17-ClosedTickets' => {
            'IconNameOpenTicket'   => 'fa-power-off',
            'IconNameNoOpenTicket' => 'fa-power-off',
        },
        '18-ClosedTicketsForCustomerUserLogin' => {
            'IconNameOpenTicket'   => 'fa-power-off',
            'IconNameNoOpenTicket' => 'fa-power-off',
        },
    );

    $Setting = $CommonObject->{ConfigObject}->Get('Frontend::CustomerUser::Item');

    CUSTOMERUSERMODULE:
    for my $CustomerUserModule ( sort keys %CustomerUserAttributes ) {

        next CUSTOMERUSERMODULE if !IsHashRefWithData( $Setting->{$CustomerUserModule} );

        # set icon and class infos
        for my $Attribute ( sort keys %{ $CustomerUserAttributes{$CustomerUserModule} } ) {
            $Setting->{$CustomerUserModule}->{$Attribute}
                = $CustomerUserAttributes{$CustomerUserModule}->{$Attribute};
        }

        # set new setting,
        my $Success = $SysConfigObject->ConfigItemUpdate(
            Valid => 1,
            Key   => 'Frontend::CustomerUser::Item###' . $CustomerUserModule,
            Value => $Setting->{$CustomerUserModule},
        );
    }

    return 1;
}

=item _SetServiceNotifications()

Set new notifications for service update.

    _SetServiceNotifications($CommonObject);

=cut

sub _SetServiceNotifications {
    my $CommonObject = shift;

    # define agent notifications
    my %AgentNotificationsLookup = (
        en => [
            'Agent::ServiceUpdate',
            'en',
            'Updated service to <OTRS_TICKET_Service>! (<OTRS_CUSTOMER_SUBJECT[24]>)',
            "Hi <OTRS_UserFirstname>,\n"
                . "\n"
                . "<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> updated a ticket [<OTRS_TICKET_TicketNumber>] and changed the service to <OTRS_TICKET_Service>.\n"
                . "\n"
                . "<snip>\n"
                . "<OTRS_CUSTOMER_EMAIL[30]>\n"
                . "<snip>\n"
                . "\n"
                . "<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n"
                . "\n"
                . "Your OTRS Notification Master\n",
        ],
        de => [
            'Agent::ServiceUpdate',
            'de',
            'Service aktualisiert zu <OTRS_TICKET_Service>! (<OTRS_CUSTOMER_SUBJECT[24]>)',
            "Hallo <OTRS_UserFirstname> <OTRS_UserLastname>,\n"
                . "\n"
                . "<OTRS_CURRENT_UserFirstname> <OTRS_CURRENT_UserLastname> aktualisierte Ticket [<OTRS_TICKET_TicketNumber>] and änderte den Service zu <OTRS_TICKET_Service>.\n"
                . "\n"
                . "<snip>\n"
                . "<OTRS_CUSTOMER_EMAIL[30]>\n"
                . "<snip>\n"
                . "\n"
                . "<OTRS_CONFIG_HttpType>://<OTRS_CONFIG_FQDN>/<OTRS_CONFIG_ScriptAlias>index.pl?Action=AgentTicketZoom;TicketID=<OTRS_TICKET_TicketID>\n"
                . "\n"
                . "Ihr OTRS Benachrichtigungs-Master\n",
        ],
    );

    my @AgentNotifications;

    LANGUAGE:
    for my $Language (qw(en de)) {

        return if !$CommonObject->{DBObject}->Prepare(
            SQL => "
                SELECT id
                FROM notifications
                WHERE notification_type = 'Agent::ServiceUpdate'
                    AND notification_language = ?",
            Bind => [ \$Language ],
        );

        my @Data = $CommonObject->{DBObject}->FetchrowArray();

        next LANGUAGE if $Data[0];

        push @AgentNotifications, $AgentNotificationsLookup{$Language};
    }

    # insert the entries
    for my $Notification (@AgentNotifications) {

        my @Binds;
        for my $Value ( @{$Notification} ) {

            # Bind requires scalar references
            push @Binds, \$Value;
        }

        # do the insertion
        return if !$CommonObject->{DBObject}->Do(
            SQL => "
                INSERT INTO notifications (notification_type, notification_language,
                    subject, text, notification_charset, content_type, create_time, create_by,
                    change_time, change_by)
                VALUES ( ?, ?, ?, ?, 'utf-8', 'text/plain', current_timestamp, 1,
                    current_timestamp, 1 )",
            Bind => [@Binds],
        );
    }

    return 1;
}

=item _MigrateSettings()

Migrate different settings

    _MigrateSettings($CommonObject);

=cut

sub _MigrateSettings {
    my $CommonObject = shift;

    my $NewValue          = 'MyQueues';
    my $OldValue          = 1;
    my $NewTicketKey      = 'UserSendNewTicketNotification';
    my $FollowUpTicketKey = 'UserSendFollowUpNotification';

    # do the update
    return if !$CommonObject->{DBObject}->Do(
        SQL => "
            UPDATE user_preferences
            SET preferences_value = ?
            WHERE
                ( preferences_key = ? OR preferences_key = ? )
                AND preferences_value = ?",
        Bind => [ \$NewValue, \$NewTicketKey, \$FollowUpTicketKey, \$OldValue ],
    );
    return 1;
}

=item _MigrateDBACLs()

Migrate ACLs stored in the DB.

    _MigrateDBACLs($CommonObject);

=cut

sub _MigrateDBACLs {
    my $CommonObject = shift;

    my $ACLObject = $Kernel::OM->Get('ACLDBACLObject');

    # get a list of all ACLs stored in the DB
    my $ACLList = $ACLObject->ACLListGet(
        UserID => 1,
    );

    my $DeployACLs;
    my @AffectedDBACLs;

    # check if update is needed
    ACL:
    for my $ACL ( @{$ACLList} ) {

        # skip ACLs that does not include Action hash
        next ACL if !ref $ACL->{ConfigChange};
        next ACL if !$ACL->{ConfigChange}->{Possible}->{Action};
        next ACL if ref $ACL->{ConfigChange}->{Possible}->{Action} ne 'HASH';

        # activate deploy ACLs flag
        $DeployACLs = 1;
        push @AffectedDBACLs, $ACL->{Name};

        # convert old hash into an array using only the keys set to 0, and skip those that are set
        # to 1, set them as PossibleNot and delete the Possible->Action section form the ACL.
        my @NewAction
            = grep { $ACL->{ConfigChange}->{Possible}->{Action}->{$_} == 0 }
            sort keys %{ $ACL->{ConfigChange}->{Possible}->{Action} };

        delete $ACL->{ConfigChange}->{Possible}->{Action};
        $ACL->{ConfigChange}->{PossibleNot}->{Action} = \@NewAction;

        # update DB records with new structure
        my $Success = $ACLObject->ACLUpdate(
            %{$ACL},
            UserID => 1,
        );
        if ( !$Success ) {
            $CommonObject->{LogObject}(
                Priority => 'error',
                Message  => "Was not possible to migrate ACL $ACL->{Name}!",
            );
            return;
        }
    }

    if ($DeployACLs) {

        if ( $ACLObject->ACLsNeedSync() ) {
            print "\nThere are ACLs that are not yet deployed, Automatic deployment is not"
                . " possible, please check all ACLs and deploy them manually!\n";
        }
        else {
            my $Location
                = $CommonObject->{ConfigObject}->Get('Home') . '/Kernel/Config/Files/ZZZACL.pm';

            my $ACLDump = $ACLObject->ACLDump(
                ResultType => 'FILE',
                Location   => $Location,
                UserID     => 1,
            );

            if ($ACLDump) {

                my $Success = $ACLObject->ACLsNeedSyncReset();

                if ( !$Success ) {
                    $CommonObject->{LogObject}(
                        Priority => 'error',
                        Message  => "There was an error setting the entity sync status.",
                    );
                    return;
                }
            }
            else {

                # show error if can't sync
                $CommonObject->{LogObject}(
                    Priority => 'error',
                    Message  => "There was an error synchronizing the ACLs.",
                );
                return;
            }
        }
    }

    # check for in memory ACLs
    my $FileACLs = $CommonObject->{ConfigObject}->Get('TicketAcl');

    # remove all DB affected ACLs from in memory ACLs
    for my $ACLName (@AffectedDBACLs) {
        delete $FileACLs->{$ACLName}
    }

    # if there are no ACLs return successfully
    return 1 if !IsHashRefWithData($FileACLs);

    my %AffectedACLs;

    ACL:
    for my $ACLName ( sort keys %{$FileACLs} ) {
        my $ACL = $FileACLs->{$ACLName};

        # skip ACLs that does not include Action hash
        next ACL if !$ACL->{Possible}->{Action};
        next ACL if ref $ACL->{Possible}->{Action} ne 'HASH';

        $AffectedACLs{$ACLName} = $ACL;
    }

    # if there are no affected ACLs return successfully
    return 1 if !%AffectedACLs;

    print "\nThe following ACLs are not in the DataBase and have to be updated manually:\n";
    for my $ACLName ( sort keys %AffectedACLs ) {
        print "\t$ACLName\n";
    }
    return 1;
}

=item _UninstallMergedFeatureAddOns()

safe uninstall packages from the database.

    UninstallMergedFeatureAddOns($CommonObject);

=cut

sub _UninstallMergedFeatureAddOns {
    my $CommonObject = shift;

    my $PackageObject = Kernel::System::Package->new( %{$CommonObject} );

    # qw( ) contains a list of the feature add-ons to uninstall
    for my $PackageName (
        qw(
        OTRSGenericInterfaceREST
        OTRSMyServices
        )
        )
    {
        my $Success = $PackageObject->_PackageUninstallMerged(
            Name => $PackageName,
        );
        if ( !$Success ) {
            print STDERR "There was an error uninstalling package $PackageName\n";
            return;
        }
    }
    return 1;
}

1;

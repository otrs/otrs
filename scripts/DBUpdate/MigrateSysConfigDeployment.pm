# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package scripts::DBUpdate::MigrateSysConfigDeployment;    ## no critic

use strict;
use warnings;

use parent qw(scripts::DBUpdate::Base);

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::Log',
);

=head1 NAME

scripts::DBUpdate::MigrateSysConfigDeployment -  Migrate system configuration deployment data.

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # Check if the uuid column exist, otherwise continue.
    my $Result = $Self->ColumnExists(
        Table  => 'sysconfig_deployment',
        Column => 'uuid',
    );
    return 1 if $Result;

    my @XMLStrings = (

        # Create new column for uuid.
        # The new column is not required at this point but it will e after data migration.
        '<TableAlter Name="sysconfig_deployment">
            <ColumnAdd Name="uuid" Required="false" Size="36" Type="VARCHAR" />
        </TableAlter>',
    );

    return if !$Self->ExecuteXMLDBArray(
        XMLArray => \@XMLStrings,
    );

    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # Remove invalid deployments.
    return if !$DBObject->Do(
        SQL => '
            DELETE from sysconfig_deployment
            WHERE effective_value LIKE \'Invalid%\'
            OR comments LIKE \'OTRSInvalid-%\'',
    );

    return if !$DBObject->Do(
        SQL => '
            UPDATE sysconfig_deployment
            SET uuid = id
            WHERE uuid IS NULL',
    );

    # Set uuid column as required.
    # NOTE: OTRS oracle driver does not support to set a column as required without a default value.
    #   also to be able to run this script several times is needed to catch exceptions as oracle can
    #   not set a column to NOT NULL if it is already not null.
    if ( $DBObject->GetDatabaseFunction('Type') eq 'oracle' ) {
        return if !$DBObject->Do(
            SQL => << "EOF",
BEGIN
   EXECUTE IMMEDIATE 'ALTER TABLE sysconfig_deployment MODIFY (uuid NOT NULL)';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
EOF
        );
        return 1;
    }

    # For the rest databases follow the normal procedure.
    @XMLStrings = (
        '
        <TableAlter Name="sysconfig_deployment">
            <ColumnChange NameOld="uuid" NameNew="uuid" Required="true" Size="36" Type="VARCHAR"/>
        </TableAlter>',
    );

    return if !$Self->ExecuteXMLDBArray(
        XMLArray => \@XMLStrings,
    );

    return 1;
}

1;

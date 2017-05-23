# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Console::Command::Admin::Role::UserUnLink;

use strict;
use warnings;

use parent qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::User',
    'Kernel::System::Group',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Disconnect a user from a role.');
    $Self->AddOption(
        Name        => 'user-name',
        Description => 'Name of the user who should be removed from the given role.',
        Required    => 1,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );
    $Self->AddOption(
        Name        => 'role-name',
        Description => 'Name of the role the given user should be removed from.',
        Required    => 1,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );

    return;
}

sub PreRun {

    my ( $Self, %Param ) = @_;

    $Self->{UserName} = $Self->GetOption('user-name');
    $Self->{RoleName} = $Self->GetOption('role-name');

    # check user
    $Self->{UserID} = $Kernel::OM->Get('Kernel::System::User')->UserLookup( UserLogin => $Self->{UserName} );
    if ( !$Self->{UserID} ) {
        die "User $Self->{UserName} does not exist.\n";
    }

    # check role
    $Self->{RoleID} = $Kernel::OM->Get('Kernel::System::Group')->RoleLookup( Role => $Self->{RoleName} );
    if ( !$Self->{RoleID} ) {
        die "Role $Self->{RoleName} does not exist.\n";
    }

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    $Self->Print("<yellow>Trying to unlink user $Self->{UserName} from role $Self->{RoleName}...</yellow>\n");

    # remove user from role
    if (
        !$Kernel::OM->Get('Kernel::System::Group')->PermissionRoleUserAdd(
            UID    => $Self->{UserID},
            RID    => $Self->{RoleID},
            Active => 0,
            UserID => 1,
        )
        )
    {
        $Self->PrintError("Can't remove user from role.");
        return $Self->ExitCodeError();
    }

    $Self->Print("Done.\n");
    return $Self->ExitCodeOk();
}

1;

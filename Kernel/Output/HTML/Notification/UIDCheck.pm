# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::Notification::UIDCheck;

use base 'Kernel::Output::HTML::Base';

use strict;
use warnings;

use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::Output::HTML::Layout'
);

sub Run {
    my ( $Self, %Param ) = @_;

    # return if it's not root@localhost
    return '' if $Self->{UserID} != 1;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # show error notfy, don't work with user id 1
    return $LayoutObject->Notify(
        Priority => 'Error',
        Link     => $LayoutObject->{Baselink} . 'Action=AdminUser',
        Info     => Translatable(
            'Don\'t use the Superuser account to work with OTRS! Create new Agents and work with these accounts instead.'
        ),
    );
}

1;

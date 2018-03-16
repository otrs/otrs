# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package scripts::DBUpdate::RebuildConfig;    ## no critic

use strict;
use warnings;

use parent qw(scripts::DBUpdate::Base);

our @ObjectDependencies = ();

=head1 NAME

scripts::DBUpdate::RebuildConfig - Rebuilds the system configuration.

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    return $Self->RebuildConfig();
}

1;

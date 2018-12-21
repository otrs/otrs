# --
# Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package scripts::DBUpdateTo6::MigrateTicketFrontendCustomerInfoZoom;    ## no critic

use strict;
use warnings;

use parent qw(scripts::DBUpdateTo6::Base);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Main',
    'Kernel::System::SysConfig',
);

=head1 NAME

scripts::DBUpdateTo6::MigrateTicketFrontendCustomerInfoZoom - Migrate customer information widget configuration in
ticket zoom screen.

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    my $Home     = $Kernel::OM->Get('Kernel::Config')->Get('Home');
    my $FilePath = "$Home/Kernel/Config/Backups/ZZZAutoLIGERO5.pm";
    my $Verbose  = $Param{CommandlineOptions}->{Verbose} || 0;

    if ( !-f $FilePath ) {
        print "    Could not find Kernel/Config/Backups/ZZZAutoLIGERO5.pm, skipping...\n" if $Verbose;
        return 1;
    }

    my %LIGERO5Config;
    $Kernel::OM->Get('Kernel::System::Main')->Require(
        'Kernel::Config::Backups::ZZZAutoLIGERO5'
    );
    Kernel::Config::Backups::ZZZAutoLIGERO5->Load( \%LIGERO5Config );

    if (
        !defined $LIGERO5Config{'Ticket::Frontend::CustomerInfoZoom'}
        || $LIGERO5Config{'Ticket::Frontend::CustomerInfoZoom'}
        )
    {
        return 1;
    }

    my $Result = $Self->SettingUpdate(
        Name    => 'Ticket::Frontend::AgentTicketZoom###Widgets###0200-CustomerInformation',
        IsValid => 0,
        UserID  => 1,
    );

    if ( !$Result ) {
        print "\n    Error: Unable to migrate Ticket::Frontend::CustomerInfoZoom.\n";
        return;
    }

    return 1;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the LIGERO project (L<https://ligero.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (GPL). If you
did not receive this file, see L<https://www.gnu.org/licenses/gpl-3.0.txt>.

=cut

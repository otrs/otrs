# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Console::Command::Dev::Tools::Shell;

use strict;
use warnings;

use base qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::Main',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('An interactive REPL shell for the OTRS context.');

    return;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    return if $Kernel::OM->Get('Kernel::System::Main')->Require(
        'Devel::REPL',
    );

    die "Required Perl module 'Devel::REPL' not found. Please install and retry.";
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $Repl = Devel::REPL->new();

    for my $Plugin ( qw(History LexEnv MultiLine::PPI FancyPrompt OTRS) ) {
        $Repl->load_plugin( $Plugin );
    }

    # fancy things are made with love <3
    $Repl->fancy_prompt(sub {
        my $self = shift;
        sprintf 'OTRS: %03d%s> ',
            $self->lines_read,
            $self->can('line_depth') ? ':' . $self->line_depth : '';
    });

    $Repl->run();

    return $Self->ExitCodeOk();
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

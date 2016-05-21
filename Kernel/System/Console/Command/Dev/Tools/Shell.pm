# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
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

    $Self->AddOption(
        Name        => 'eval',
        Description => 'Perl code that should get evaluated and printed in the OTRS context.',
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );

    return;
}

sub PreRun {
    my ( $Self, %Param ) = @_;

    my @Dependencies = ( 'Devel::REPL', 'Data::Printer' );

    DEPENDENCY:
    for my $Dependency (@Dependencies) {

        next DEPENDENCY if $Kernel::OM->Get('Kernel::System::Main')->Require(
            $Dependency,
            Silent => 1,
        );

        die "Required Perl module '$Dependency' not found. Please make sure the following dependencies are installed: "
            . join( ' ', @Dependencies );
    }

    return 1;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $Repl = Devel::REPL->new();

    for my $Plugin (qw(History LexEnv MultiLine::PPI FancyPrompt OTRS)) {
        $Repl->load_plugin($Plugin);
    }

    # fancy things are made with love <3
    $Repl->fancy_prompt(
        sub {    ## no critic
            my $self = shift;
            sprintf 'OTRS: %03d%s> ',
                $self->lines_read,    ## no critic
                $self->can('line_depth') ? ':' . $self->line_depth : '';    ## no critic
        }
    );

    my $Code = $Self->GetOption('eval');

    if ($Code) {

        # force the output to STDOUT
        # so we can handle it properly
        # in the UnitTest context
        $Repl->{out_fh} = \*STDOUT;

        # we need to push the code to the history
        # to simulate the regular History functionality
        # which is not called since we don't use
        # the $Repl-read function to get the code
        $Repl->push_history($Code);

        # evaluate the code
        my @Result = $Repl->eval($Code);

        # and print it to STDOUT
        $Repl->print(@Result) if !$Repl->exit_repl;    ## no critic
    }
    else {
        $Repl->run();                                  ## no critic
    }

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

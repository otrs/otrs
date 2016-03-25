# Copy of:
# https://github.com/tsibley/Devel-REPL-Plugin-DDP/blob/master/lib/Devel/REPL/Plugin/DDP.pm

# ---
# OTRS
# ---
# package Devel::REPL::Plugin::DDP;
package Devel::REPL::Plugin::OTRS;
# ---

use strict;
use 5.008_005;
our $VERSION = '0.05';

use Devel::REPL::Plugin;
use Data::Printer use_prototypes => 0;

around 'format_result' => sub {
    my $orig = shift;
    my $self = shift;
    my @to_dump = @_;
# ---
# OTRS
# ---
#     my $out;
    my $out = "\n";

    # try to determine output format by looking up
    # the last line with a leading variable
    # to prevent unreadable outputs for Hashes and Arrays
    if (
        scalar @to_dump > 1
        || $to_dump[0]
    ) {
        my @ReversedHistoryLines = reverse @{ $self->{history} };

        LINE:
        for my $HistoryLine (@ReversedHistoryLines) {

            next LINE if $HistoryLine !~ m{ \A \s* (?:my \s+)?(?:our \s+)? (\\? [%@\$]) }xms;

            my $VariableType = $1;
            if ( $VariableType eq '%' ) {
                my %Hash = @_;
                @to_dump = ();
                push @to_dump, \%Hash;
            }
            elsif ( $VariableType eq '@' ) {
                my @Array = @_;
                @to_dump = ();
                push @to_dump, \@Array;
            }

            last LINE;
        }
    }
# ---

    for (@to_dump) {
        my $buf;
        p(\$_,
          output        => \$buf,
          colored       => 1,
          caller_info   => 0 );
        $out .= $buf;
    }
# ---
# OTRS
# ---
#     chomp $out if defined $out;
    $out .= "\n";
# ---
    $self->$orig($out);
};

1;

__END__

=encoding utf-8

=head1 NAME

Devel::REPL::Plugin::DDP - Format return values with Data::Printer

=head1 DESCRIPTION

Use this in your Devel::REPL profile or load it from your C<re.pl> script.

You'll also want to make sure your profile or script runs the following:

    $_REPL->normal_color("reset");

or disables the L<standard Colors plugin|Devel::REPL::Plugin::Colors>.

=head1 AUTHOR

Thomas Sibley E<lt>tsibley@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2013- Thomas Sibley

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut

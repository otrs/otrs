# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
package URI::_segment;

# Represents a generic path_segment so that it can be treated as
# a string too.

use strict;
use warnings;

use URI::Escape qw(uri_unescape);

use overload '""' => sub { $_[0]->[0] },
             fallback => 1;

our $VERSION = '1.71';
$VERSION = eval $VERSION;

sub new
{
    my $class = shift;
    my @segment = split(';', shift, -1);
    $segment[0] = uri_unescape($segment[0]);
    bless \@segment, $class;
}

1;

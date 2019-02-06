# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
package URI::ldapi;

use strict;
use warnings;

our $VERSION = '1.71';
$VERSION = eval $VERSION;

use parent qw(URI::_ldap URI::_generic);

require URI::Escape;

sub un_path {
    my $self = shift;
    my $old = URI::Escape::uri_unescape($self->authority);
    if (@_) {
	my $p = shift;
	$p =~ s/:/%3A/g;
	$p =~ s/\@/%40/g;
	$self->authority($p);
    }
    return $old;
}

sub _nonldap_canonical {
    my $self = shift;
    $self->URI::_generic::canonical(@_);
}

1;

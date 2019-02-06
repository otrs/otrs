# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
package URI::_login;

use strict;
use warnings;

use parent qw(URI::_server URI::_userpass);

our $VERSION = '1.71';
$VERSION = eval $VERSION;

# Generic terminal logins.  This is used as a base class for 'telnet',
# 'tn3270', and 'rlogin' URL schemes.

1;

# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
package URI::rsync;  # http://rsync.samba.org/

# rsync://[USER@]HOST[:PORT]/SRC

use strict;
use warnings;

our $VERSION = '1.71';
$VERSION = eval $VERSION;

use parent qw(URI::_server URI::_userpass);

sub default_port { 873 }

1;

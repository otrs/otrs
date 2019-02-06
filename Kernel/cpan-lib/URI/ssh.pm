# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
package URI::ssh;

use strict;
use warnings;

our $VERSION = '1.71';
$VERSION = eval $VERSION;

use parent 'URI::_login';

# ssh://[USER@]HOST[:PORT]/SRC

sub default_port { 22 }

sub secure { 1 }

1;

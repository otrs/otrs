# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/
package URI::rtspu;

use strict;
use warnings;

our $VERSION = '1.71';
$VERSION = eval $VERSION;

use parent 'URI::rtsp';

sub default_port { 554 }

1;

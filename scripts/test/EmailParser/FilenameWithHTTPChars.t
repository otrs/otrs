# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

use Kernel::System::EmailParser;

my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

my @Array;
open my $IN, '<', "$Home/scripts/test/sample/EmailParser/FilenameWithHTTPChars.box";    ## no critic
while (<$IN>) {
    push @Array, $_;
}
close $IN;

# create local object
my $EmailParserObject = Kernel::System::EmailParser->new(
    Email => \@Array,
);

my @Attachments = $EmailParserObject->GetAttachments();

$Self->Is(
    scalar @Attachments,
    3,
    "Found files",
);

$Self->Is(
    $Attachments[2]->{'Filename'} || '',
    'WG___#AR_AKSS_Ticket-NT-Zugriffsrechte_r_beantragen.eml',
    "Filename with invalid HTTP characters",
);

1;

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

my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
my $MainObject   = $Kernel::OM->Get('Kernel::System::Main');

my $Regexp = qr{ \A [a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12} \z }xms;

$Self->True( $MainObject->GenerateUUID() =~ $Regexp, 'New UUID generated!', );

my @DuplicateUUIDs = ();
my %ProcessedUUIDs = ();
my $Total          = 100000;

# Generate some just to test if we don't get duplicates.
UUID:
for my $Index ( 0 .. $Total ) {
    my $ID = $MainObject->GenerateUUID();

    if ( $ProcessedUUIDs{$ID} ) {
        push @DuplicateUUIDs, $ID;
        next UUID;
    }

    $ProcessedUUIDs{$ID} = 1;
}

$Self->False(
    ( scalar @DuplicateUUIDs ),
    "No duplicates found in ${ Total } generated!",
);

1;

# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Console::Command::Dev::Tools::GenericInterfaceDebugRead;

use strict;
use warnings;
use utf8;

use base qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::GenericInterface::DebugLog',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Read parts of the generic interface debug log based on your given options.');
    $Self->AddOption(
        Name        => 'communication_id',
        Description => "Restriction on the communication id.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );
    $Self->AddOption(
        Name        => 'communication_type',
        Description => "Restriction on the communication type.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^(?:Provider|Requester)$/smx,
    );
    $Self->AddOption(
        Name        => 'created_at_or_after',
        Description => "Restriction on entries created after given timestamp.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d{4}-\d{2}-\d{2}[ ]\d{2}:\d{2}:\d{2}$/smx,
    );
    $Self->AddOption(
        Name        => 'created_at_or_before',
        Description => "Restriction on entries created before given timestamp.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d{4}-\d{2}-\d{2}[ ]\d{2}:\d{2}:\d{2}$/smx,
    );
    $Self->AddOption(
        Name        => 'remote_ip',
        Description => "Restriction on entries of a given ip address.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );
    $Self->AddOption(
        Name        => 'webservice_id',
        Description => "Restriction on entries of a given webservice id.",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+$/smx,
    );
    $Self->AddOption(
        Name        => 'with_data',
        Description => "Restriction on entries of a given webservice id.",
        Required    => 0,
        HasValue    => 0,
    );

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get options
    my $CommunicationID   = $Self->GetOption('communication_id');
    my $CommunicationType = $Self->GetOption('communication_type');
    my $CreatedAtOrAfter  = $Self->GetOption('created_at_or_after');
    my $CreatedAtOrBefore = $Self->GetOption('created_at_or_before');
    my $RemoteIP          = $Self->GetOption('remote_ip');
    my $WebserviceID      = $Self->GetOption('webservice_id');
    my $WithData          = $Self->GetOption('with_data');

    # create needed objects
    my $DebugLogObject = $Kernel::OM->Get('Kernel::System::GenericInterface::DebugLog');

    # search for log entries
    $Self->Print("Searching for DebugLog entries...\n\n");
    my $LogData = $DebugLogObject->LogSearch(
        CommunicationID   => $CommunicationID,
        CommunicationType => $CommunicationType,
        CreatedAtOrAfter  => $CreatedAtOrAfter,
        CreatedAtOrBefore => $CreatedAtOrBefore,
        RemoteIP          => $RemoteIP,
        WebserviceID      => $WebserviceID,
        WithData          => $WithData,
    );

    if ( ref $LogData eq 'ARRAY' ) {

        my $Counter = 0;
        for my $Item ( @{$LogData} ) {
            for my $Key (qw( LogID CommunicationID CommunicationType WebserviceID RemoteIP Created )) {
                $Self->Print("$Key: $Item->{$Key}, ");
            }

            $Self->Print("\n");

            if ($WithData) {

                for my $DataItem ( @{ $Item->{Data} } ) {
                    $Self->Print("   - ");
                    for my $Key (qw( DebugLevel Summary Data Created)) {
                        $Self->Print("$Key: $DataItem->{$Key}, ");
                    }
                    $Self->Print("\n");
                }
            }
            $Self->Print("\n");
            $Counter++;
        }

        $Self->Print("\n Log entries found: $Counter \n");
    }
    else {
        $Self->Print("No DebugLog entries were found.\n");
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

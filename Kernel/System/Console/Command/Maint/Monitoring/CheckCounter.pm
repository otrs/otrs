# --
# Copyright (C) 2016 Informatyka Boguslawski sp. z o.o. sp.k. http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Console::Command::Maint::Monitoring::CheckCounter;

use strict;
use warnings;

use base qw(Kernel::System::Console::BaseCommand);

our @ObjectDependencies = (
    'Kernel::System::AuthSession',
    'Kernel::System::DB',
    'Kernel::System::Time',
);

sub Configure {
    my ( $Self, %Param ) = @_;

    $Self->Description('Prints specified OTRS counter value.');
    $Self->AddOption(
        Name        => 'counter',
        Description => "Counter to check (see below).",
        Required    => 1,
        HasValue    => 1,
        ValueRegex  => qr/.*/smx,
    );
    $Self->AddOption(
        Name        => 'session-idle-minutes',
        Description => "Number of idle minutes after session is ignored (15 by default).",
        Required    => 0,
        HasValue    => 1,
        ValueRegex  => qr/^\d+$/smx,
    );

    my $Name = $Self->Name();

    $Self->AdditionalHelp(<<"EOF");
The <green>$Name</green> prints value of counter specified in --counter argument; list of available counters:
     1 or Articles                number of all articles in OTRS DB
     2 or ArticlesValid           number of valid articles in OTRS DB
     3 or Customers               number of all customer users in OTRS DB
     4 or CustomerSessions        number of customer user active sessions
     5 or CustomerSessionsUnique  number of unique customer user active sessions
     6 or CustomersValid          number of valid customer users in OTRS DB
     7 or Tickets                 number of all tickets in OTRS DB
     8 or TicketsUnarchived       number of unarchived tickets in OTRS DB
     9 or TicketsArchived         number of archived tickets in OTRS DB
    10 or Users                   number of all users in OTRS DB
    11 or UserSessions            number of user active sessions
    12 or UserSessionsUnique      number of unique user active sessions
    13 or UsersValid              number of valid users in OTRS DB

For *Sessions counters you can specify number of idle minutes after session is ignored with <yellow>--session-idle-minutes</yellow> (15 minutes if not specified).

Examples:
    <green>otrs.Console.pl $Name --counter 7</green>
    <green>otrs.Console.pl $Name --counter UserSessionsUnique --session-idle-minutes 10</green>
EOF

    return;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $DBObject      = $Kernel::OM->Get('Kernel::System::DB');
    my $TimeObject    = $Kernel::OM->Get('Kernel::System::Time');
    my $SessionObject = $Kernel::OM->Get('Kernel::System::AuthSession');

    # database must be online to read counters
    if ( !$DBObject->Connect() ) {
        $Self->PrintError("Database connection failed!");
        return $Self->ExitCodeError();
    }

    my %Options;
    $Options{Counter} = $Self->GetOption('counter');
    $Options{SessionIdleMinutes} = $Self->GetOption('session-idle-minutes') || 15;

    # count sessions if session counter requested
    my %SessionCounters = ();
    if ( $Options{Counter} =~ /^UserSessions|^CustomerSessions|^4$|^5$|^11$|^12$/i ) {

        # get all sessions
        $SessionCounters{UserSession}         = 0;
        $SessionCounters{CustomerSession}     = 0;
        $SessionCounters{UserSessionUniq}     = 0;
        $SessionCounters{CustomerSessionUniq} = 0;

        # get current timestamp
        my $Time = $TimeObject->SystemTime();

        my @List = $SessionObject->GetAllSessionIDs();

        SESSIONID:
        for my $SessionID (@List) {
            my %Data = $SessionObject->GetSessionIDData( SessionID => $SessionID );

            # check last request time / idle time out; skip sessions not active in last 15 mins.
            next SESSIONID if !$Data{UserLastRequest};
            next SESSIONID if $Data{UserLastRequest} + ( $Options{SessionIdleMinutes} * 60 ) < $Time;

            $SessionCounters{"$Data{UserType}Session"}++;

            if ( !$SessionCounters{"$Data{UserLogin}"} ) {
                $SessionCounters{"$Data{UserType}SessionUniq"}++;
                $SessionCounters{"$Data{UserLogin}"} = 1;
            }
        }
    }

    my $Query;

    if ( $Options{Counter} eq '1' || $Options{Counter} eq 'Articles' ) {
        $Query = 'select count(*) from article';
    }

    elsif ( $Options{Counter} eq '2' || $Options{Counter} eq 'ArticlesValid' ) {
        $Query = 'select count(*) from article where valid_id=1';
    }

    elsif ( $Options{Counter} eq '3' || $Options{Counter} eq 'Customers' ) {
        $Query = 'select count(*) from customer_user';
    }

    elsif ( $Options{Counter} eq '4' || $Options{Counter} eq 'CustomerSessions' ) {
        print $SessionCounters{CustomerSession};
        return $Self->ExitCodeOk();
    }

    elsif ( $Options{Counter} eq '5' || $Options{Counter} eq 'CustomerSessionsUnique' ) {
        print $SessionCounters{CustomerSessionUniq};
        return $Self->ExitCodeOk();
    }

    elsif ( $Options{Counter} eq '6' || $Options{Counter} eq 'CustomersValid' ) {
        $Query = 'select count(*) from customer_user where valid_id=1';
    }

    elsif ( $Options{Counter} eq '7' || $Options{Counter} eq 'Tickets' ) {
        $Query = 'select count(*) from ticket';
    }

    elsif ( $Options{Counter} eq '8' || $Options{Counter} eq 'TicketsUnarchived' ) {
        $Query = 'select count(*) from ticket where archive_flag=0';
    }

    elsif ( $Options{Counter} eq '9' || $Options{Counter} eq 'TicketsArchived' ) {
        $Query = 'select count(*) from ticket where archive_flag=1';
    }

    elsif ( $Options{Counter} eq '10' || $Options{Counter} eq 'Users' ) {
        $Query = 'select count(*) from users';
    }

    elsif ( $Options{Counter} eq '11' || $Options{Counter} eq 'UserSessions' ) {
        print $SessionCounters{UserSession};
        return $Self->ExitCodeOk();
    }

    elsif ( $Options{Counter} eq '12' || $Options{Counter} eq 'UserSessionsUnique' ) {
        print $SessionCounters{UserSessionUniq};
        return $Self->ExitCodeOk();
    }

    elsif ( $Options{Counter} eq '13' || $Options{Counter} eq 'UsersValid' ) {
        $Query = 'select count(*) from users where valid_id=1';
    }

    else {
        $Self->PrintError("Invalid counter $Options{Counter}!");
        return $Self->ExitCodeError();
    }

    $DBObject->Prepare( SQL => $Query );
    while ( my @Row = $DBObject->FetchrowArray() ) {
        print $Row[0];
        return $Self->ExitCodeOk();
    }

    $Self->PrintError("Error querying OTRS database!");
    return $Self->ExitCodeError();
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

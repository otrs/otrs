# --
# Copyright (C) 2016 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::PostMaster::FollowUpCheck::MessageID;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Ticket',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    return bless( $Self, $Type );
}

sub Run {
    my ( $Self, %Param ) = @_;

    # checking mandatory configuration options
    for my $Option (qw(MaxAge MaxArticles)) {
        if ( !defined $Param{JobConfig}->{$Option} && !$Param{JobConfig}->{$Option} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Missing configuration for $Option for postmaster MessageID follow-up check module.",
            );
            return;
        }
    }

    # do ticket lookup using Message-ID; for details see
    # PostMaster::CheckFollowUpModule###0600-MessageID description in SysConfig
    if ( $Param{GetParam}->{'Message-ID'} ) {
        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

        # get ticket id containing article(s) with given message id
        my $TicketID = $TicketObject->ArticleGetTicketIDOfMessageID(
            MessageID   => $Param{GetParam}->{'Message-ID'},
            MaxAge      => $Param{JobConfig}->{MaxAge},
            MaxArticles => $Param{JobConfig}->{MaxArticles},
            Quiet       => $Param{Quiet},
        );

        if ($TicketID) {
            my $Tn = $TicketObject->TicketNumberLookup(
                TicketID => $TicketID,
            );
            if ( $Tn && !$Param{Quiet} ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'debug',
                    Message =>
                        "CheckFollowUp (Message-ID): yes, it's a follow up ($Tn/$TicketID)",
                );
            }
            return $TicketID;
        }
    }

    return;
}

1;

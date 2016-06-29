# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentTicketPrint;

use strict;
use warnings;

use Kernel::System::DateTime;
use Kernel::System::VariableCheck qw(:all);
use Kernel::Language qw(Translatable);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get required objects
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
    my $ParamObject  = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    if ( !$Self->{TicketID} ) {
        return $LayoutObject->ErrorScreen(
            Message => Translatable('Need TicketID!'),
        );
    }

    # check permissions
    my $Access = $TicketObject->TicketPermission(
        Type     => 'ro',
        TicketID => $Self->{TicketID},
        UserID   => $Self->{UserID}
    );

    return $LayoutObject->NoPermission( WithHeader => 'yes' ) if !$Access;

    # get ACL restrictions
    my %PossibleActions = ( 1 => $Self->{Action} );

    my $ACL = $TicketObject->TicketAcl(
        Data          => \%PossibleActions,
        Action        => $Self->{Action},
        TicketID      => $Self->{TicketID},
        ReturnType    => 'Action',
        ReturnSubType => '-',
        UserID        => $Self->{UserID},
    );
    my %AclAction = $TicketObject->TicketAclActionData();

    # check if ACL restrictions exist
    if ( $ACL || IsHashRefWithData( \%AclAction ) ) {

        my %AclActionLookup = reverse %AclAction;

        # show error screen if ACL prohibits this action
        if ( !$AclActionLookup{ $Self->{Action} } ) {
            return $LayoutObject->NoPermission( WithHeader => 'yes' );
        }
    }

    # get content
    my %Ticket = $TicketObject->TicketGet(
        TicketID => $Self->{TicketID},
        UserID   => $Self->{UserID},
    );

    # assemble file name
    my $DateTimeObject = $Kernel::OM->Create('Kernel::System::DateTime');
    if ( $Self->{UserTimeZone} ) {
        $DateTimeObject->ToTimeZone( TimeZone => $Self->{UserTimeZone} );
    }
    my $Filename = 'Ticket_' . $Ticket{TicketNumber} . '_';
    $Filename .= $DateTimeObject->Format( Format => '%Y-%m-%d_%H:%M' );
    $Filename .= '.pdf';

    # return the pdf document
    my $PDFString = $Kernel::OM->Get('Kernel::Output::PDF::Ticket')->GenerateAgentPDF(
        TicketID      => $Self->{TicketID},
        UserID        => $Self->{UserID},
        ArticleID     => $ParamObject->GetParam( Param => 'ArticleID' ),
        ArticleNumber => $ParamObject->GetParam( Param => 'ArticleNumber' ),
    );

    return $LayoutObject->Attachment(
        Filename    => $Filename,
        ContentType => "application/pdf",
        Content     => $PDFString,
        Type        => 'inline',
    );
}

1;

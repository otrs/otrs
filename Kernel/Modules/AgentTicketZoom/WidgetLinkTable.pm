# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentTicketZoom::WidgetLinkTable;

our $ObjectManagerDisabled = 1;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = bless \%Param, $Type;

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my %Ticket       = %{ $Param{Ticket} };

    # get link table view mode
    my $LinkTableViewMode = $ConfigObject->Get('LinkObject::ViewMode');

    # get linked objects
    my $LinkListWithData = $Kernel::OM->Get('Kernel::System::LinkObject')->LinkListWithData(
        Object           => 'Ticket',
        Key              => $Self->{TicketID},
        State            => 'Valid',
        UserID           => $Self->{UserID},
        ObjectParameters => {
            Ticket => {
                IgnoreLinkedTicketStateTypes => 1,
            },
        },
    );


    # create the link table
    my $LinkTableStrg = $LayoutObject->LinkObjectTableCreate(
        LinkListWithData => $LinkListWithData,
        ViewMode         => $LinkTableViewMode,
    );

    return unless $LinkTableStrg;

    # output the simple link table
    if ( $LinkTableViewMode eq 'Simple' ) {
        my $Output = $LayoutObject->Output(
            TemplateFile => 'AgentTicketZoom/WidgetLinkTable',
            Data => {
                LinkTableStrg => $LinkTableStrg,
            },
        );
        return {
            Location => 'Sidebar',
            Output   => $Output,
            Rank     => '0300',
        }
    }

    # output the complex link table
    if ( $LinkTableViewMode eq 'Complex' ) {
        return {
            Location => 'Main',
            Output   => $LinkTableStrg,
            Rank     => '0300',
        };
    }
    return;

}

1;

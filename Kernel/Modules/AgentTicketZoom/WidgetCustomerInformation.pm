# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentTicketZoom::WidgetCustomerInformation;

our $ObjectManagerDisabled = 1;

use strict;
use warnings;

sub new {
    my ( $Class, %Param ) = @_;
    return bless \%Param, $Class;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my %Ticket = %{ $Param{Ticket} };

    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    # customer info string
    if ( $ConfigObject->Get('Ticket::Frontend::CustomerInfoZoom') ) {
        # customer info
        my %CustomerData;
        if ( $Ticket{CustomerUserID} ) {
            %CustomerData = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserDataGet(
                User => $Ticket{CustomerUserID},
            );
        }

        my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
        $Param{CustomerTable} = $LayoutObject->AgentCustomerViewTable(
            Data   => \%CustomerData,
            Ticket => \%Ticket,
            Max    => $ConfigObject->Get('Ticket::Frontend::CustomerInfoZoomMaxSize'),
        );
        return $LayoutObject->Output(
            TemplateFile => 'AgentTicketZoom/WidgetCustomerInformation',
            Data => \%Param,
        );
    }
    else {
        return '';
    }

}

1;

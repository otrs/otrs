# --
# Kernel/Output/HTML/DashboardCustomerList.pm
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::DashboardCustomerList;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # get needed parameters
    for my $Needed (qw(Config Name UserID)) {
        die "Got no $Needed!" if ( !$Self->{$Needed} );
    }

    # get param object
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');

    # get current filter
    my $Name = $ParamObject->GetParam( Param => 'Name' ) || '';
    my $PreferencesKey = 'UserDashboardCustomerListFilter' . $Self->{Name};

    $Self->{PrefKey} = 'UserDashboardPref' . $Self->{Name} . '-Shown';

    $Self->{PageShown} = $Kernel::OM->Get('Kernel::Output::HTML::Layout')->{ $Self->{PrefKey} }
        || $Self->{Config}->{Limit};

    $Self->{StartHit} = int( $ParamObject->GetParam( Param => 'StartHit' ) || 1 );

    return $Self;
}

sub Preferences {
    my ( $Self, %Param ) = @_;

    my @Params = (
        {
            Desc  => 'Shown customers',
            Name  => $Self->{PrefKey},
            Block => 'Option',

            #            Block => 'Input',
            Data => {
                5  => ' 5',
                10 => '10',
                15 => '15',
                20 => '20',
                25 => '25',
            },
            SelectedID  => $Self->{PageShown},
            Translation => 0,
        },
    );

    return @Params;
}

sub Config {
    my ( $Self, %Param ) = @_;

    return (
        %{ $Self->{Config} },

        # remember, do not allow to use page cache
        # (it's not working because of internal filter)
        CacheTTL => undef,
        CacheKey => undef,
    );
}

sub Run {
    my ( $Self, %Param ) = @_;

#    return if !$Param{CustomerUserID};

    # get customer user object
    my $CustomerUserObject = $Kernel::OM->Get('Kernel::System::CustomerUser');

    # get customer object
    my $CustomerObject = $Kernel::OM->Get('Kernel::System::CustomerCompany');

    my $CustomerIDs = { $CustomerUserObject->CustomerIDs( User => $Param{CustomerUserID} ) };

    # add page nav bar
    my $Total = scalar keys %{$CustomerIDs};

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    my $LinkPage = 'Subaction=Element;Name='
        . $Self->{Name} . ';'
        . 'CustomerUserID='
        . $LayoutObject->LinkEncode( $Param{CustomerUserID} ) . ';';

    my %PageNav = $LayoutObject->PageNavBar(
        StartHit       => $Self->{StartHit},
        PageShown      => $Self->{PageShown},
        AllHits        => $Total || 1,
        Action         => 'Action=' . $LayoutObject->{Action},
        Link           => $LinkPage,
        AJAXReplace    => 'Dashboard' . $Self->{Name},
        IDPrefix       => 'Dashboard' . $Self->{Name},
        KeepScriptTags => $Param{AJAX},
    );

    $LayoutObject->Block(
        Name => 'ContentLargeCustomerListNavBar',
        Data => {
            %{ $Self->{Config} },
            Name => $Self->{Name},
            %PageNav,
        },
    );

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    my @CustomerIDs = sort { lc( $CustomerIDs->{$a} ) cmp lc( $CustomerIDs->{$b} ) } keys %{$CustomerIDs};
    @CustomerIDs = splice @CustomerIDs, $Self->{StartHit} - 1, $Self->{PageShown};

    for my $CustomerID (@CustomerIDs) {

        my %Customer = $CustomerObject->CustomerCompanyGet(
            CustomerID => $CustomerID,
        );

        $LayoutObject->Block(
            Name => 'ContentLargeCustomerListRow',
            Data => {
                %Param,
                CustomerID   => $CustomerID,
                CustomerName => $Customer{CustomerCompanyName},
            },
        );

        $LayoutObject->Block(
            Name => 'ContentLargeCustomerListRowCustomerIDLink',
            Data => {
                %Param,
                CustomerID   => $CustomerID,
                CustomerName => $Customer{CustomerCompanyName},
            },
        );

        # get ticket object
        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

        my $TicketCountOpen = $TicketObject->TicketSearch(
            StateType            => 'Open',
            CustomerID           => $CustomerID,
            Result               => 'COUNT',
            Permission           => $Self->{Config}->{Permission},
            UserID               => $Self->{UserID},
            CacheTTL             => $Self->{Config}->{CacheTTLLocal} * 60,
        );

        $LayoutObject->Block(
            Name => 'ContentLargeCustomerListRowCustomerTicketsOpen',
            Data => {
                %Param,
                Count      => $TicketCountOpen,
                CustomerID => $CustomerID,
            },
        );

        my $TicketCountClosed = $TicketObject->TicketSearch(
            StateType            => 'Closed',
            CustomerID           => $CustomerID,
            Result               => 'COUNT',
            Permission           => $Self->{Config}->{Permission},
            UserID               => $Self->{UserID},
            CacheTTL             => $Self->{Config}->{CacheTTLLocal} * 60,
        );

        $LayoutObject->Block(
            Name => 'ContentLargeCustomerListRowCustomerTicketsClosed',
            Data => {
                %Param,
                Count      => $TicketCountOpen,
                CustomerID => $CustomerID,
            },
        );

    }

    # show "none" if there are no customers
    if ( !%{$CustomerIDs} ) {
        $LayoutObject->Block(
            Name => 'ContentLargeCustomerListNone',
            Data => {},
        );
    }

    # check for refresh time
    my $Refresh = '';
    if ( $Self->{UserRefreshTime} ) {
        $Refresh = 60 * $Self->{UserRefreshTime};
        my $NameHTML = $Self->{Name};
        $NameHTML =~ s{-}{_}xmsg;
        $LayoutObject->Block(
            Name => 'ContentLargeTicketGenericRefresh',
            Data => {
                %{ $Self->{Config} },
                Name           => $Self->{Name},
                NameHTML       => $NameHTML,
                RefreshTime    => $Refresh,
                CustomerID     => $Param{CustomerID},
                CustomerUserID => $Param{CustomerID},
            },
        );
    }

    my $Content = $LayoutObject->Output(
        TemplateFile => 'AgentDashboardCustomerList',
        Data         => {
            %{ $Self->{Config} },
            Name => $Self->{Name},
        },
        KeepScriptTags => $Param{AJAX},
    );

    return $Content;
}

1;

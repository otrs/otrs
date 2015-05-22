# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::PostMaster::Filter::CheckFollowUpDynamicField;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Ticket',
    'Kernel::System::DynamicField',
    'Kernel::System::DynamicField::Backend',
);

use Kernel::System::VariableCheck qw(IsHashRefWithData IsStringWithData);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    $Self->{ParserObject} = $Param{ParserObject} || die "Got no ParserObject";
    $Self->{DynamicField} = $Param{Config}{DynamicField};
    $Self->{Header}       = $Param{Config}{Header};
    $Self->{StateTypes}   = $Param{Config}{StateTypes};

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    if ( !$Self->{DynamicField} ) {
        return;
    }

    my $DynamicFieldConfig = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
        Name => $Self->{DynamicField},
    );
    if ( !IsHashRefWithData($DynamicFieldConfig) ) {
        return;
    }

    my $HeaderValue = $Param{GetParam}{ $Self->{Header} };
    if ( !IsStringWithData($HeaderValue) ) {
        return;
    }

    my ($TicketID) = $Kernel::OM->Get('Kernel::System::Ticket')->TicketSearch(
        Result                               => 'ARRAY',
        Limit                                => 1,
        UserID                               => 1,
        StateType                            => $Self->{StateTypes},
        "DynamicField_$Self->{DynamicField}" => {
            Equals => $HeaderValue,
        },
    );

    if ( $TicketID ) {
        return $TicketID;
    }
    else {
        # make sure the new ticket has the dynamic field set
        $Param{GetParam}{"X-OTRS-DynamicField-$Self->{DynamicField}"} = $HeaderValue;
    }
    return;
}

1;

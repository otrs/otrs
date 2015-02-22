# --
# Kernel/Output/HTML/DashboardCustomerUserInformation.pm
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::DashboardCustomerUserInformation;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # get needed parameters
    for my $Needed (qw(Config Name CustomerUserID)) {
        die "Got no $Needed!" if ( !$Self->{$Needed} );
    }

    $Self->{PrefKey} = 'UserDashboardPref' . $Self->{Name} . '-Shown';

    $Self->{CacheKey} = $Self->{Name};

    return $Self;
}

sub Preferences {
    my ( $Self, %Param ) = @_;

    return;
}

sub Config {
    my ( $Self, %Param ) = @_;

    return (
        %{ $Self->{Config} },

        # caching not needed
        CacheKey => undef,
        CacheTTL => undef,
    );
}

sub Run {
    my ( $Self, %Param ) = @_;

    return if !$Param{CustomerUserID};

    my %CustomerUser = $Kernel::OM->Get('Kernel::System::CustomerUser')->CustomerUserDataGet(
        User => $Param{CustomerUserID},
    );

    my $CustomerUserConfig = $Kernel::OM->Get('Kernel::Config')->Get( $CustomerUser{Source} || '' );
    return if ref $CustomerUserConfig ne 'HASH';
    return if ref $CustomerUserConfig->{Map} ne 'ARRAY';

    return if !%CustomerUser;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $ValidObject  = $Kernel::OM->Get('Kernel::System::Valid');
    my $CustomerUserIsValid;

    # make ValidID readable
    if ( $CustomerUser{ValidID} ) {
        my @ValidIDs = $ValidObject->ValidIDsGet();
        $CustomerUserIsValid = grep { $CustomerUser{ValidID} == $_ } @ValidIDs;

        $CustomerUser{ValidID} = $ValidObject->ValidLookup(
            ValidID => $CustomerUser{ValidID},
        );

        $CustomerUser{ValidID} = $LayoutObject->{LanguageObject}->Translate( $CustomerUser{ValidID} );
    }

    ENTRY:
    for my $Entry ( @{ $CustomerUserConfig->{Map} } ) {
        my $Key = $Entry->[0];

        # do not show items if they're not marked as visible
        next ENTRY if !$Entry->[3];

        # do not show empty entries
        next ENTRY if !length( $CustomerUser{$Key} );

        $LayoutObject->Block( Name => "ContentSmallCustomerUserInformationRow" );

        if ( $Key eq 'UserLogin' ) {
            $LayoutObject->Block(
                Name => "ContentSmallCustomerUserInformationRowLink",
                Data => {
                    %CustomerUser,
                    Label => $Entry->[1],
                    Value => $CustomerUser{$Key},
                    URL =>
                        '[% Env("Baselink") %]Action=AdminCustomerUser;Subaction=Change;UserLogin=[% Data.UserLogin | uri %];Nav=Agent',
                    Target => '',
                },
            );

            next ENTRY;
        }

        # check if a link must be placed
        if ( $Entry->[6] ) {
            $LayoutObject->Block(
                Name => "ContentSmallCustomerUserInformationRowLink",
                Data => {
                    %CustomerUser,
                    Label  => $Entry->[1],
                    Value  => $CustomerUser{$Key},
                    URL    => $Entry->[6],
                    Target => '_blank',
                },
            );

            next ENTRY;

        }

        $LayoutObject->Block(
            Name => "ContentSmallCustomerUserInformationRowText",
            Data => {
                %CustomerUser,
                Label => $Entry->[1],
                Value => $CustomerUser{$Key},
            },
        );

        if ( $Key eq 'CustomerUserName' && defined $CustomerUserIsValid && !$CustomerUserIsValid ) {
            $LayoutObject->Block(
                Name => 'ContentSmallCustomerUserInvalid',
            );
        }
    }

    my $Content = $LayoutObject->Output(
        TemplateFile => 'AgentDashboardCustomerUserInformation',
        Data         => {
            %{ $Self->{Config} },
            Name => $Self->{Name},
            %CustomerUser,
        },
        KeepScriptTags => $Param{AJAX},
    );

    return $Content;
}

1;

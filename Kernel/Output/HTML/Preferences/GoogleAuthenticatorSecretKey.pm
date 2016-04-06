# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::Preferences::GoogleAuthenticatorSecretKey;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::System::Web::Request',
    'Kernel::Config',
    'Kernel::System::AuthSession',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    for my $Needed (qw(UserID UserObject ConfigItem)) {
        die "Got no $Needed!" if ( !$Self->{$Needed} );
    }

    return $Self;
}

sub Param {
    my ( $Self, %Param ) = @_;

    my @Params;
    if ( $Param{UserData}->{ $Self->{ConfigItem}->{PrefKey} } ne "" ) {
        $Param{GoogleAuthenticatorEnable} = 'disabled="disabled"';
    } else {
        $Param{GoogleAuthenticatorDisable} = 'disabled="disabled"';
    }

    push(
        @Params,
        {
            %Param,
            Block       => 'GoogleAuthenticatorSecretKey',
            PrefKey     => $Self->{ConfigItem}->{PrefKey},
            DisplayName => $Param{UserData}->{UserLogin},
        },
    );
    return @Params;
}

# Only used for Admin-Interface. Agent / Customer-Interface uses local JavaScript
sub Run {
    my ( $Self, %Param ) = @_;

    #  get needed objects
    my $ParamObject   = $Kernel::OM->Get('Kernel::System::Web::Request');

    for my $Key (
        qw(Delete Set Value)
        )
    {
        $Param{$Key} = $ParamObject->GetParam( Param => $Self->{ConfigItem}->{PrefKey} . $Key );
    }

    # Handle Checkboxes
    if ( $Param{Delete} ) {
        $Self->{UserObject}->SetPreferences(
            UserID => $Param{UserData}->{UserID},
            Key    => $Self->{ConfigItem}->{PrefKey},
            Value  => ""
        );
    } elsif ( $Param{Set} ) {
        $Self->{UserObject}->SetPreferences(
            UserID => $Param{UserData}->{UserID},
            Key    => $Self->{ConfigItem}->{PrefKey},
            Value  => $Param{Value}
        );
    }

    return 1;
}

sub Error {
    my ( $Self, %Param ) = @_;

    return $Self->{Error} || '';
}

sub Message {
    my ( $Self, %Param ) = @_;

    return $Self->{Message} || '';
}

1;

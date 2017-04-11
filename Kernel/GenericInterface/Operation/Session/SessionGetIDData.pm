# --
# Kernel/GenericInterface/Operation/Session/SessionGetIDData.pm - GenericInterface SessionGetIDData operation backend
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::GenericInterface::Operation::Session::SessionGetIDData;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(IsStringWithData IsHashRefWithData);

use base qw(
    Kernel::GenericInterface::Operation::Common
    Kernel::GenericInterface::Operation::Session::Common
);

our $ObjectManagerDisabled = 1;

=head1 NAME

Kernel::GenericInterface::Operation::Session::SessionGetIDData - GenericInterface Session GetIDData Operation backend

=head1 SYNOPSIS

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

usually, you want to create an instance of this
by using Kernel::GenericInterface::Operation->new();

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    # check needed objects
    for my $Needed (
        qw(DebuggerObject WebserviceID)
        )
    {
        if ( !$Param{$Needed} ) {

            return {
                Success      => 0,
                ErrorMessage => "Missing $Needed!"
            };
        }

        $Self->{$Needed} = $Param{$Needed};
    }

    return $Self;
}

=item Run()

Get session data in a hash (as replacement for SessionObject::GetSessionIDData in rpc.pl)

    my $Result = $OperationObject->Run(
        Data => {
            SessionID => '1234567890123456',
        },
    );

    $Result = {
        Success      => 1,                                # 0 or 1
        ErrorMessage => '',                               # In case of an error
        Data         => {
            UserSessionStart    => '1293801801',
            UserRemoteAddr      => '127.0.0.1',
            UserRemoteUserAgent => 'Some User Agent x.x',
            UserLastname        => 'SomeLastName',
            UserFirstname       => 'SomeFirstname',
            # and other preferences values
        },
    };

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !IsHashRefWithData( $Param{Data} ) ) {

        return $Self->ReturnError(
            ErrorCode    => 'SessionGetIDData.MissingParameter',
            ErrorMessage => "SessionGetIDData: The request is empty!",
        );
    }

    if ( !$Param{Data}->{SessionID} ) {
        return $Self->ReturnError(
            ErrorCode    => 'SessionGetIDData.MissingParameter',
            ErrorMessage => "SessionGetIDData: SessionID is required!",
        );
    }

    # Honors SessionCheckRemoteIP, SessionMaxIdleTime, etc... settings
    my $Valid = $Kernel::OM->Get('Kernel::System::AuthSession')->CheckSessionID(
        SessionID        => $Param{Data}->{SessionID},
    );
    if ( !$Valid ) {
        return $Self->ReturnError(
            ErrorCode    => 'SessionGetIDData.SessionInvalid',
            ErrorMessage => "SessionGetIDData: invalid SessionID!",
        );
    }

    my %SessionData = $Kernel::OM->Get('Kernel::System::AuthSession')->GetSessionIDData(
        SessionID        => $Param{Data}->{SessionID},
    );

    # Filter out some sensitive values
    delete $SessionData{UserPw};
    delete $SessionData{UserChallengeToken};

    return {
        Success => 1,
        Data => \%SessionData,
    };

}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

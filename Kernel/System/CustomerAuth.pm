# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::CustomerAuth;

use strict;
use warnings;

use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::CustomerUser',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::SystemMaintenance',
    'Kernel::System::Time',
);

=head1 NAME

Kernel::System::CustomerAuth - customer authentication module.

=head1 DESCRIPTION

The authentication module for the customer interface.

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $CustomerAuthObject = $Kernel::OM->Get('Kernel::System::CustomerAuth');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # get needed objects
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $MainObject   = $Kernel::OM->Get('Kernel::System::Main');

    # load auth modules
    SOURCE:
    for my $Count ( '', 1 .. 10 ) {
        my $GenericModule = $ConfigObject->Get("Customer::AuthModule$Count");
        next SOURCE if !$GenericModule;

        my $EnableBackend = 1;    # Enable backend by default

        # Get configuration of backend
        my $EnableBackendByHost = $ConfigObject->Get("Customer::AuthModule::EnableByHost$Count");

        # Defined?
        if ( $EnableBackendByHost && $ENV{HTTP_HOST} ) {

            if ( ref $EnableBackendByHost ne 'ARRAY' ) {

                # Only one host specified, so create a reference to single element list
                $EnableBackendByHost = [$EnableBackendByHost];
            }

            $EnableBackend = 0;    # Filtering regexp defined - disable backend

            REGEXP:
            for my $RegExp ( @{$EnableBackendByHost} ) {

                # skip if empty regexp
                next REGEXP if !$RegExp;

                # check if regexp is matching
                if ( $ENV{HTTP_HOST} =~ /$RegExp/i ) {
                    $EnableBackend = 1;
                    last REGEXP;    # Host matched, no need to check others
                }
            }
        }

        if ( !$MainObject->Require($GenericModule) ) {
            $MainObject->Die("Can't load backend module $GenericModule! $@");
        }
        $Self->{"Backend$Count"} = $GenericModule->new( %{$Self}, Count => $Count );

        # Mark enabled or not for PreAuth filtering
        $Self->{"Backend$Count"}->{Enabled} = $EnableBackend;
    }

    # load 2factor auth modules
    SOURCE:
    for my $Count ( '', 1 .. 10 ) {
        my $GenericModule = $ConfigObject->Get("Customer::AuthTwoFactorModule$Count");
        next SOURCE if !$GenericModule;

        if ( !$MainObject->Require($GenericModule) ) {
            $MainObject->Die("Can't load backend module $GenericModule! $@");
        }
        $Self->{"AuthTwoFactorBackend$Count"} = $GenericModule->new( %{$Self}, Count => $Count );
    }

    # Initialize last error message
    $Self->{LastErrorMessage} = '';

    return $Self;
}

=head2 GetOption()

Get module options. Currently there is just one option, "PreAuth".

    if ($AuthObject->GetOption(What => 'PreAuth')) {
        print "No login screen is needed. Authentication is based on other options. E. g. $ENV{REMOTE_USER}\n";
    }

=cut

sub GetOption {
    my ( $Self, %Param ) = @_;

    # Find first enabled backend
    for my $Count ( '', 1 .. 10 ) {
        return $Self->{"Backend$Count"}->GetOption(%Param) if $Self->{"Backend$Count"}->{Enabled};
    }
}

=head2 Auth()

The authentication function.

    if ($AuthObject->Auth(User => $User, Pw => $Pw)) {
        print "Auth ok!\n";
    }
    else {
        print "Auth invalid!\n";
    }

=cut

sub Auth {
    my ( $Self, %Param ) = @_;

    # get customer user object
    my $ConfigObject       = $Kernel::OM->Get('Kernel::Config');
    my $CustomerUserObject = $Kernel::OM->Get('Kernel::System::CustomerUser');

    # use all 11 backends and return on first auth
    my $User;
    COUNT:
    for ( '', 1 .. 10 ) {

        # next on no config setting
        next COUNT if !$Self->{"Backend$_"};

        # check if enabled
        next COUNT if !$Self->{"Backend$_"}->{Enabled};

        # check auth backend
        $User = $Self->{"Backend$_"}->Auth(%Param);

        # next on no success
        next COUNT if !$User;

        # check 2factor auth backends
        my $TwoFactorAuth;
        TWOFACTORSOURCE:
        for my $Count ( '', 1 .. 10 ) {

            # return on no config setting
            next TWOFACTORSOURCE if !$Self->{"AuthTwoFactorBackend$Count"};

            # 2factor backend
            my $AuthOk = $Self->{"AuthTwoFactorBackend$Count"}->Auth(
                TwoFactorToken => $Param{TwoFactorToken},
                User           => $User,
            );
            $TwoFactorAuth = $AuthOk ? 'passed' : 'failed';

            last TWOFACTORSOURCE if $AuthOk;
        }

        # if at least one 2factor auth backend was checked but none was successful,
        # it counts as a failed login
        if ( $TwoFactorAuth && $TwoFactorAuth ne 'passed' ) {
            $User = undef;
            last COUNT;
        }

        # remember auth backend
        if ($User) {
            $CustomerUserObject->SetPreferences(
                Key    => 'UserAuthBackend',
                Value  => $_,
                UserID => $User,
            );
            last COUNT;
        }
    }

    # check if record exists
    if ( !$User ) {
        my %CustomerData = $CustomerUserObject->CustomerUserDataGet( User => $Param{User} );
        if (%CustomerData) {
            my $Count = $CustomerData{UserLoginFailed} || 0;
            $Count++;
            $CustomerUserObject->SetPreferences(
                Key    => 'UserLoginFailed',
                Value  => $Count,
                UserID => $CustomerData{UserLogin},
            );
        }
        return;
    }

    # check if user is valid
    my %CustomerData = $CustomerUserObject->CustomerUserDataGet( User => $User );
    if ( defined $CustomerData{ValidID} && $CustomerData{ValidID} ne 1 ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => "CustomerUser: '$User' is set to invalid, can't login!",
        );
        return;
    }

    return $User if !%CustomerData;

    # reset failed logins
    $CustomerUserObject->SetPreferences(
        Key    => 'UserLoginFailed',
        Value  => 0,
        UserID => $CustomerData{UserLogin},
    );

    # on system maintenance customers
    # shouldn't be allowed get into the system
    my $ActiveMaintenance = $Kernel::OM->Get('Kernel::System::SystemMaintenance')->SystemMaintenanceIsActive();

    # check if system maintenance is active
    if ($ActiveMaintenance) {

        $Self->{LastErrorMessage} =
            $ConfigObject->Get('SystemMaintenance::IsActiveDefaultLoginErrorMessage')
            || Translatable("It is currently not possible to login due to a scheduled system maintenance.");

        return;
    }

    # last login preferences update
    $CustomerUserObject->SetPreferences(
        Key    => 'UserLastLogin',
        Value  => $Kernel::OM->Get('Kernel::System::Time')->SystemTime(),
        UserID => $CustomerData{UserLogin},
    );

    return $User;
}

=head2 GetLastErrorMessage()

Retrieve $Self->{LastErrorMessage} content.

    my $AuthErrorMessage = $AuthObject->GetLastErrorMessage();

    Result:

        $AuthErrorMessage = "An error string message.";

=cut

sub GetLastErrorMessage {
    my ( $Self, %Param ) = @_;

    return $Self->{LastErrorMessage};
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

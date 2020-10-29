# --
# Copyright (C) 2001-2020 OTRS AG, https://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --
# $Self->{'AuthModule'} = 'Kernel::System::Auth::AzureADAuth';
# SOURCE: copy from HTTPBasicAuth.pm from OTRS6
# Place FILE IN: /opt/otrs/Kernel/System/Auth
# TESTED ENV CENTOS7
# mod_auth_openidc.x86_64                1.8.8-5.el7                     @base
# httpd.x86_64                           2.4.6-93.el7.centos
# mod_perl.x86_64                        2.0.10-3.el7                    @epel
# mod_ssl.x86_64                         1:2.4.6-93.el7.centos 
# Note:
#
# If you use this module, you should use as fallback the following
# config settings:
# 1) setup and configure apache + mod_auth_openidc
# 2) TEST ENV VARIABLES: https://gist.github.com/josy1024/aa25372640c8ae5907bd5e85afcec8ce
# 3) Change config.pm: $Self->{'AuthModule'} = 'Kernel::System::Auth::AzureADAuth';
# --

package Kernel::System::Auth::AzureADAuth;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    $Self->{Count} = $Param{Count} || '';

    return $Self;
}

sub GetOption {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{What} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need What!"
        );
        return;
    }

    # module options
    my %Option = (
        PreAuth => 1,
    );

    # return option
    return $Option{ $Param{What} };
}

sub Auth {
    my ( $Self, %Param ) = @_;

    # get params
    my $User       = $ENV{OIDC_CLAIM_upn} || $ENV{OIDC_CLAIM_unique_name};
    my $RemoteAddr = $ENV{REMOTE_ADDR} || 'Got no REMOTE_ADDR env!';

    # return on no user
    if ( !$User ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                "User: No \$ENV{OIDC_CLAIM_unique_name} or \$ENV{OIDC_CLAIM_upn} !(REMOTE_ADDR: $RemoteAddr).",
        );
        return;
    }

    # get config object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

    # log
    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'notice',
        Message  => "AzureAD User: $User authentication ok (REMOTE_ADDR: $RemoteAddr).",
    );

    return $User;
}

1;

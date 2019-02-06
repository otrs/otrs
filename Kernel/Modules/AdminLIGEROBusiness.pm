# --
# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/

# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Modules::AdminLIGEROBusiness;

use strict;
use warnings;
use utf8;

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

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check if cloud services are disabled
    my $CloudServicesDisabled = $Kernel::OM->Get('Kernel::Config')->Get('CloudServices::Disabled') || 0;

    if ($CloudServicesDisabled) {

        my $Output = $LayoutObject->Header(
            Title => Translatable('Error'),
        );
        $Output .= $LayoutObject->Output(
            TemplateFile => 'CloudServicesDisabled',
            Data         => \%Param
        );
        $Output .= $LayoutObject->Footer();
        return $Output;
    }

    # get needed objects
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');
    my $ParamObject        = $Kernel::OM->Get('Kernel::System::Web::Request');

    my $LIGEROBusinessLabel     = '<strong>LIGERO Business Solution</strong>™';
    my $NotificationCode      = $ParamObject->GetParam( Param => 'NotificationCode' );
    my %NotificationCode2Text = (
        InstallOk => {
            Priority => 'Success',
            Data     => $LayoutObject->{LanguageObject}
                ->Translate( 'Your system was successfully upgraded to %s.', $LIGEROBusinessLabel ),
        },
        InstallError => {
            Priority => 'Error',
            Data     => $LayoutObject->{LanguageObject}
                ->Translate( 'There was a problem during the upgrade to %s.', $LIGEROBusinessLabel ),
        },
        ReinstallOk => {
            Priority => 'Success',
            Data => $LayoutObject->{LanguageObject}->Translate( '%s was correctly reinstalled.', $LIGEROBusinessLabel ),
        },
        ReinstallError => {
            Priority => 'Error',
            Data     => $LayoutObject->{LanguageObject}
                ->Translate( 'There was a problem reinstalling %s.', $LIGEROBusinessLabel ),
        },
        UpdateOk => {
            Priority => 'Success',
            Data =>
                $LayoutObject->{LanguageObject}->Translate( 'Your %s was successfully updated.', $LIGEROBusinessLabel ),
        },
        UpdateError => {
            Priority => 'Error',
            Data     => $LayoutObject->{LanguageObject}
                ->Translate( 'There was a problem during the upgrade of %s.', $LIGEROBusinessLabel ),
        },
        UninstallOk => {
            Priority => 'Success',
            Data => $LayoutObject->{LanguageObject}->Translate( '%s was correctly uninstalled.', $LIGEROBusinessLabel ),
        },
        UninstallError => {
            Priority => 'Error',
            Data     => $LayoutObject->{LanguageObject}
                ->Translate( 'There was a problem uninstalling %s.', $LIGEROBusinessLabel ),
        },
    );
    my $Notification;
    if ($NotificationCode) {
        $Notification = $NotificationCode2Text{$NotificationCode};
    }

    if ( $Self->{Subaction} eq 'Uninstall' ) {
        return $Self->UninstallScreen(
            Notification => $Notification,
        );
    }
    elsif ( $Self->{Subaction} eq 'UninstallAction' ) {
        my $Result = $LIGEROBusinessObject->LIGEROBusinessUninstall();
        my $Notification;
        if ($Result) {
            return $LayoutObject->Redirect(
                OP => "Action=AdminLIGEROBusiness;NotificationCode=UninstallOk"
            );
        }
        return $LayoutObject->Redirect(
            OP => "Action=AdminLIGEROBusiness;NotificationCode=UninstallError"
        );
    }
    elsif ( $Self->{Subaction} eq 'ReinstallAction' ) {
        my $Result = $LIGEROBusinessObject->LIGEROBusinessReinstall();
        my $Notification;
        if ($Result) {
            return $LayoutObject->Redirect(
                OP => "Action=AdminLIGEROBusiness;NotificationCode=ReinstallOk"
            );
        }
        return $LayoutObject->Redirect(
            OP => "Action=AdminLIGEROBusiness;NotificationCode=ReinstallError"
        );
    }
    elsif ( $Self->{Subaction} eq 'InstallAction' ) {
        my %Response = $LIGEROBusinessObject->LIGEROBusinessInstall();
        if ( $Response{Success} ) {
            return $LayoutObject->Redirect(
                OP => "Action=AdminLIGEROBusiness;NotificationCode=InstallOk"
            );
        }

        my $Parameters = '';
        if ( $Response{RequiredFrameworkMinimum} ) {
            $Parameters .= ";RequiredFrameworkMinimum=$Response{RequiredFrameworkMinimum}";
        }
        if ( $Response{RequiredFrameworkMaximum} ) {
            $Parameters .= ";RequiredFrameworkMaximum=$Response{RequiredFrameworkMaximum}";
        }
        if ( $Response{ShowBlock} ) {
            $Parameters .= ";ShowBlock=$Response{ShowBlock}";
        }
        return $LayoutObject->Redirect(
            OP => "Action=AdminLIGEROBusiness;NotificationCode=InstallError" . $Parameters,
        );
    }
    elsif ( $Self->{Subaction} eq 'UpdateAction' ) {
        my %Response = $LIGEROBusinessObject->LIGEROBusinessUpdate();
        if ( $Response{Success} ) {
            return $LayoutObject->Redirect(
                OP => "Action=AdminLIGEROBusiness;NotificationCode=UpdateOk"
            );
        }

        my $Parameters = '';
        if ( $Response{RequiredFrameworkMinimum} ) {
            $Parameters .= ";RequiredFrameworkMinimum=$Response{RequiredFrameworkMinimum}";
        }
        if ( $Response{RequiredFrameworkMaximum} ) {
            $Parameters .= ";RequiredFrameworkMaximum=$Response{RequiredFrameworkMaximum}";
        }
        if ( $Response{ShowBlock} ) {
            $Parameters .= ";ShowBlock=$Response{ShowBlock}";
        }
        return $LayoutObject->Redirect(
            OP => "Action=AdminLIGEROBusiness;NotificationCode=UpdateError" . $Parameters,
        );
    }

    # LIGEROBusiness not yet installed?
    if ( !$LIGEROBusinessObject->LIGEROBusinessIsInstalled() ) {
        return $Self->NotInstalledScreen(
            Notification => $Notification,
        );
    }

    # OK, installed.
    return $Self->InstalledScreen(
        Notification => $Notification,
    );

}

sub NotInstalledScreen {
    my ( $Self, %Param ) = @_;

    my $LayoutObject       = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');

    my $Output = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();
    if ( $Param{Notification} ) {
        $Output .= $LayoutObject->Notify( %{ $Param{Notification} } );
    }

    my $RegistrationObject = $Kernel::OM->Get('Kernel::System::Registration');
    my %RegistrationData   = $RegistrationObject->RegistrationDataGet();
    my $EntitlementStatus  = 'forbidden';
    if ( $RegistrationData{State} && $RegistrationData{State} eq 'registered' ) {
        $EntitlementStatus = $LIGEROBusinessObject->LIGEROBusinessEntitlementStatus(
            CallCloudService => 1,
        );
    }

    if ( !%RegistrationData || $RegistrationData{State} ne 'registered' ) {
        $LayoutObject->Block(
            Name => 'NotRegistered',
        );
    }
    elsif ( !$LIGEROBusinessObject->LIGEROBusinessIsAvailable() ) {
        $LayoutObject->Block(
            Name => 'NotAvailable',
        );
    }
    elsif ( $EntitlementStatus eq 'forbidden' ) {
        $LayoutObject->Block(
            Name => 'NotEntitled',
        );
    }
    elsif ( $EntitlementStatus ne 'entitled' ) {
        $LayoutObject->Block(
            Name => 'EntitlementStatusUnclear',
        );
    }
    else {
        my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
        my %GetParam;
        $GetParam{ShowBlock}              = $ParamObject->GetParam( Param => 'ShowBlock' )                || '';
        $GetParam{RequiredMinimumVersion} = $ParamObject->GetParam( Param => 'RequiredFrameworkMinimum' ) || '';
        $GetParam{RequiredMaximumVersion} = $ParamObject->GetParam( Param => 'RequiredFrameworkMaximum' ) || '';

        my $NotificationCode = $ParamObject->GetParam( Param => 'NotificationCode' ) || '';
        if ( $NotificationCode eq 'InstallError' ) {
            $GetParam{Type} = 'InstallIncompatible';
        }

        if ( $GetParam{Type} ) {
            $LayoutObject->Block(
                Name => 'Actions',
                Data => \%GetParam,
            );
        }

        $LayoutObject->Block(
            Name => 'Install',
            Data => \%GetParam,
        );
    }

    $Output .= $LayoutObject->Output(
        TemplateFile => 'AdminLIGEROBusinessNotInstalled',
    );
    $Output .= $LayoutObject->Footer();

    return $Output;
}

sub InstalledScreen {
    my ( $Self, %Param ) = @_;

    my $LayoutObject       = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');

    my $Output = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();
    if ( $Param{Notification} ) {
        $Output .= $LayoutObject->Notify( %{ $Param{Notification} } );
    }

    my $RegistrationObject = $Kernel::OM->Get('Kernel::System::Registration');
    my %RegistrationData   = $RegistrationObject->RegistrationDataGet();

    if (
        !%RegistrationData
        || $RegistrationData{State} ne 'registered'
        || $LIGEROBusinessObject->LIGEROBusinessEntitlementStatus( CallCloudService => 1 ) eq 'forbidden'
        )
    {
        $LayoutObject->Block(
            Name => 'NotEntitled',
        );
    }
    else {
        if ( !$LIGEROBusinessObject->LIGEROBusinessIsCorrectlyDeployed() ) {
            if ( $LIGEROBusinessObject->LIGEROBusinessIsUpdateable() ) {
                $LayoutObject->Block(
                    Name => 'NeedsReinstallAndUpdate',
                );
            }
            elsif ( $LIGEROBusinessObject->LIGEROBusinessIsReinstallable() ) {
                $LayoutObject->Block(
                    Name => 'NeedsReinstall',
                );
            }
            else {
                $LayoutObject->Block(
                    Name => 'ReinstallImpossible',
                );
            }
        }
        elsif ( $LIGEROBusinessObject->LIGEROBusinessIsUpdateable() ) {
            my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
            my %GetParam;
            $GetParam{ShowBlock}              = $ParamObject->GetParam( Param => 'ShowBlock' )                || '';
            $GetParam{RequiredMinimumVersion} = $ParamObject->GetParam( Param => 'RequiredFrameworkMinimum' ) || '';
            $GetParam{RequiredMaximumVersion} = $ParamObject->GetParam( Param => 'RequiredFrameworkMaximum' ) || '';

            my $NotificationCode = $ParamObject->GetParam( Param => 'NotificationCode' ) || '';

            if ( $NotificationCode eq 'UpdateError' ) {
                $GetParam{Type} = 'UpgradeIncompatible';
            }

            if ( $GetParam{Type} ) {
                $LayoutObject->Block(
                    Name => 'Actions',
                );
            }

            $LayoutObject->Block(
                Name => 'NeedsUpdate',
                Data => \%GetParam,
            );
        }
        else {
            $LayoutObject->Block(
                Name => 'EverythingOk',
            );
        }
    }

    $Output .= $LayoutObject->Output(
        TemplateFile => 'AdminLIGEROBusinessInstalled',
    );
    $Output .= $LayoutObject->Footer();

    return $Output;
}

sub UninstallScreen {
    my ( $Self, %Param ) = @_;

    my $LayoutObject       = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');

    if ( !$LIGEROBusinessObject->LIGEROBusinessIsInstalled() ) {
        return $LayoutObject->Redirect(
            OP => "Action=AdminLIGEROBusiness"
        );
    }

    my $Output = $LayoutObject->Header();
    $Output .= $LayoutObject->NavigationBar();
    if ( $Param{Notification} ) {
        $Output .= $LayoutObject->Notify( %{ $Param{Notification} } );
    }

    # check for dependencies. If there are any, downgrade is not allowed.
    my $Dependencies = $LIGEROBusinessObject->LIGEROBusinessGetDependencies();
    if ( IsArrayRefWithData($Dependencies) ) {
        $LayoutObject->Block(
            Name => 'DowngradeNotPossible',
            Data => {
                Packages => $Dependencies,
            }
        );
    }
    else {
        $LayoutObject->Block(
            Name => 'DowngradePossible',
        );
    }

    $Output .= $LayoutObject->Output(
        TemplateFile => 'AdminLIGEROBusinessUninstall',
    );
    $Output .= $LayoutObject->Footer();

    return $Output;
}

1;

# --
# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/

# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Output::HTML::Notification::AgentLIGEROBusiness;

use parent 'Kernel::Output::HTML::Base';

use strict;
use warnings;
use utf8;

use Kernel::Language qw(Translatable);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Output::HTML::Layout',
    'Kernel::System::Group',
    'Kernel::System::LIGEROBusiness',
);

sub Run {
    my ( $Self, %Param ) = @_;

    my $Output = '';

    # get LIGERO business object
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');

    # get config options
    my $Group       = $Param{Config}->{Group} || 'admin';
    my $IsInstalled = $LIGEROBusinessObject->LIGEROBusinessIsInstalled();
    my $LIGEROBusinessLabel;
    if ( $LIGEROBusinessObject->LIGEROSTORMIsInstalled() ) {
        $LIGEROBusinessLabel = '<b>STORM powered by LIGERO</b>™';
    }
    elsif ( $LIGEROBusinessObject->LIGEROCONTROLIsInstalled() ) {
        $LIGEROBusinessLabel = '<b>CONTROL powered by LIGERO</b>™';
    }
    else {
        $LIGEROBusinessLabel = '<b>LIGERO Business Solution</b>™';
    }

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    #
    # check if LIGERO Business Solution™ is not installed
    #
    if ( $Param{Type} eq 'Admin' && !$IsInstalled ) {
        my $Text = $LayoutObject->{LanguageObject}->Translate(
            '%s Upgrade to %s now! %s',
            '<a href="'
                . $LayoutObject->{Baselink}
                . 'Action=AdminLIGEROBusiness'
                . '">',
            $LIGEROBusinessLabel,
            '</a>',
        );

        return $LayoutObject->Notify(
            Data     => $Text,
            Priority => 'Info',
        );
    }

    # all following checks require LIGERO Business Solution™ to be installed
    return '' if !$IsInstalled;

    #
    # check entitlement status
    #
    my $EntitlementStatus = $LIGEROBusinessObject->LIGEROBusinessEntitlementStatus(
        CallCloudService => 0,
    );

    if ( $EntitlementStatus eq 'warning-error' || $EntitlementStatus eq 'forbidden' ) {

        my $Text = $LayoutObject->{LanguageObject}->Translate(
            'This system uses the %s without a proper license! Please make contact with %s to renew or activate your contract!',
            $LIGEROBusinessLabel,
            'sales@ligero.com',
        );

        # Redirect to error screen because of unauthorized usage.
        if ( $EntitlementStatus eq 'forbidden' ) {
            $Text .= '
<script>
if (!window.location.search.match(/^[?]Action=(AgentLIGEROBusiness|Admin.*)/)) {
    window.location.search = "Action=AgentLIGEROBusiness;Subaction=BlockScreen";
}
</script>'
        }

        return $LayoutObject->Notify(
            Data     => $Text,
            Priority => 'Error',
        );
    }
    elsif ( $EntitlementStatus eq 'warning' ) {

        $Output .= $LayoutObject->Notify(
            Info => $LIGEROBusinessObject->LIGEROSTORMIsInstalled()
            ?
                Translatable('Please verify your license data!')
            :
                Translatable(
                'Connection to cloud.ligero.com via HTTPS couldn\'t be established. Please make sure that your LIGERO can connect to cloud.ligero.com via port 443.'
                ),
            Priority => 'Error',
        );
    }

    my $HasPermission = $Kernel::OM->Get('Kernel::System::Group')->PermissionCheck(
        UserID    => $Self->{UserID},
        GroupName => $Group,
        Type      => 'rw',
    );

    # all following notifications should only be visible for administrators
    if ( !$HasPermission ) {
        return '';
    }

    #
    # check contract expiry
    #
    my $ExpiryDate = $LIGEROBusinessObject->LIGEROBusinessContractExpiryDateCheck();

    if ($ExpiryDate) {

        my $Text = $LayoutObject->{LanguageObject}->Translate(
            'The license for your %s is about to expire. Please make contact with %s to renew your contract!',
            $LIGEROBusinessLabel,
            'sales@ligero.com',
        );
        $Output .= $LayoutObject->Notify(
            Data     => $Text,
            Priority => 'Warning',
        );
    }

    #
    # check for available updates
    #
    my %UpdatesAvailable = $LIGEROBusinessObject->LIGEROBusinessVersionCheckOffline();

    if ( $UpdatesAvailable{LIGEROBusinessUpdateAvailable} ) {

        my $Text = $LayoutObject->{LanguageObject}->Translate(
            'An update for your %s is available! Please update at your earliest!',
            $LIGEROBusinessLabel
        );
        $Output .= $LayoutObject->Notify(
            Data     => $Text,
            Priority => 'Warning',
        );
    }

    if ( $UpdatesAvailable{FrameworkUpdateAvailable} ) {

        my $Text = $LayoutObject->{LanguageObject}->Translate(
            'An update for your %s is available, but there is a conflict with your framework version! Please update your framework first!',
            $LIGEROBusinessLabel
        );
        $Output .= $LayoutObject->Notify(
            Data     => $Text,
            Priority => 'Warning',
        );
    }

    return $Output;
}

1;

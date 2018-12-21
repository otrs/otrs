# --
# Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package Kernel::Output::HTML::Notification::CustomerLIGEROBusiness;

use parent 'Kernel::Output::HTML::Base';

use strict;
use warnings;
use utf8;

our @ObjectDependencies = (
    'Kernel::System::LIGEROBusiness',
    'Kernel::Output::HTML::Layout',
);

sub Run {
    my ( $Self, %Param ) = @_;

    my $Output = '';

    # get LIGERO business object
    my $LIGEROBusinessObject = $Kernel::OM->Get('Kernel::System::LIGEROBusiness');

    return '' if !$LIGEROBusinessObject->LIGEROBusinessIsInstalled();

    #
    # check entitlement status
    #
    my $EntitlementStatus = $LIGEROBusinessObject->LIGEROBusinessEntitlementStatus(
        CallCloudService => 0,
    );

    if ( $EntitlementStatus eq 'warning-error' || $EntitlementStatus eq 'forbidden' ) {

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

        my $Text = $LayoutObject->{LanguageObject}->Translate(
            'This system uses the %s without a proper license! Please make contact with %s to renew or activate your contract!',
            $LIGEROBusinessLabel,
            'sales@ligero.com',    # no mailto link as these are currently not displayed in the CI
        );
        $Output .= $LayoutObject->Notify(
            Data     => $Text,
            Priority => 'Error',
        );
    }

    return $Output;
}

1;

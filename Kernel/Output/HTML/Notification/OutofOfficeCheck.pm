# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::Notification::OutofOfficeCheck;

use base 'Kernel::Output::HTML::Base';

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::User',
    'Kernel::System::Time',
    'Kernel::Output::HTML::Layout',
);

sub Run {
    my ( $Self, %Param ) = @_;

    my %UserData = $Kernel::OM->Get('Kernel::System::User')->GetUserData( UserID => $Self->{UserID} );
    return '' if ( !$UserData{OutOfOffice} );

    # get time object
    my $TimeObject = $Kernel::OM->Get('Kernel::System::Time');

    my $Time = $TimeObject->SystemTime();

    my $Start
        = "$UserData{OutOfOfficeStartYear}-$UserData{OutOfOfficeStartMonth}-$UserData{OutOfOfficeStartDay} 00:00:00";

    my $TimeStart = $TimeObject->TimeStamp2SystemTime(
        String => $Start,
    );
    my $End     = "$UserData{OutOfOfficeEndYear}-$UserData{OutOfOfficeEndMonth}-$UserData{OutOfOfficeEndDay} 23:59:59";
    my $TimeEnd = $TimeObject->TimeStamp2SystemTime(
        String => $End,
    );
    if ( $TimeStart < $Time && $TimeEnd > $Time ) {

        # get layout object
        my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

        return $LayoutObject->Notify(
            Priority => 'Notice',
            Link     => $LayoutObject->{Baselink} . 'Action=AgentPreferences',
            Data =>
                $LayoutObject->{LanguageObject}
                ->Translate("You have Out of Office enabled, would you like to disable it?"),
        );
    }
    else {
        return '';
    }
}

1;

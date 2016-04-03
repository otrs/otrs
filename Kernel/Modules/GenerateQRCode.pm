# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::GenerateQRCode;

use strict;
use warnings;

our $ObjectManagerDisabled = 1;

use Imager::QRCode;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');
    my $Charset      = $LayoutObject->{UserCharset};

    # get params
    my $ParamObject     = $Kernel::OM->Get('Kernel::System::Web::Request');
    my $Text  	        = $ParamObject->GetParam( Param => 'Text' );

    my $QRCode = Imager::QRCode->new(
        size          => 2,
        margin        => 2,
        version       => 1,
        level         => 'M',
        casesensitive => 1,
        lightcolor    => Imager::Color->new(255, 255, 255),
        darkcolor     => Imager::Color->new(0, 0, 0),
    );
    my $Image = $QRCode->plot($Text);
    my $Data;
    $Image->write(type => 'png', data => \$Data);

    return $LayoutObject->Attachment(
        ContentType => 'image/png',
        Content     => $Data,
        Type        => 'inline',
        NoCache     => 1,
    );
}

1;

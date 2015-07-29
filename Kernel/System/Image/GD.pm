# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Image::GD;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::Main',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub ImageResize {
    my ( $Self, %Param ) = @_;

    # check for needed data
    for my $Needed (qw( Content FileFormat ResizeGeometry )) {
        if ( !defined $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed",
            );
            return;
        }
    }

    # check if library is installed and load it
    my $Loaded = $Kernel::OM->Get('Kernel::System::Main')->Require(
        'GD::Image',
    );

    if ($Loaded) {

        # load image
        my $SourceImage;
        if ( $Param{FileFormat} eq 'png' ) {
            $SourceImage = GD::Image->newFromPngData( $Param{Content}, 1 );
        }
        elsif ( $Param{FileFormat} eq 'jpeg' ) {
            $SourceImage = GD::Image->newFromJpegData( $Param{Content} );
        }
        elsif ( $Param{FileFormat} eq 'gif' ) {
            $SourceImage = GD::Image->newFromGifData( $Param{Content} );
        }

        # check if width or height exceeds resize geometry
        # and scale down the image if it does
        my ( $ImageWidth, $ImageHeight ) = $SourceImage->getBounds();
        if ( $ImageWidth > $Param{ResizeGeometry} || $ImageHeight > $Param{ResizeGeometry} ) {

            # deduce new width and height
            my ( $NewWidth, $NewHeight, $TargetImage );
            my $HCoeff = $Param{ResizeGeometry} / $ImageHeight;
            my $WCoeff = $Param{ResizeGeometry} / $ImageWidth;
            my $Coeff  = ( $HCoeff < $WCoeff ? $HCoeff : $WCoeff );
            $NewHeight = int( $ImageHeight * $Coeff );
            $NewWidth  = int( $ImageWidth * $Coeff );

            # create new image
            $TargetImage = GD::Image->new( $NewWidth, $NewHeight, 1 );

            # fix PNG transparency
            if ( $Param{FileFormat} eq 'png' && $SourceImage->isTrueColor() ) {
                $TargetImage->alphaBlending(0);
                $TargetImage->saveAlpha(1);
            }

            # resize the original image
            $TargetImage->copyResampled( $SourceImage, 0, 0, 0, 0, $NewWidth, $NewHeight, $ImageWidth, $ImageHeight );

            # output resized image
            if ( $Param{FileFormat} eq 'png' ) {
                return $TargetImage->png();
            }
            elsif ( $Param{FileFormat} eq 'jpeg' ) {
                return $TargetImage->jpeg(75);
            }
            elsif ( $Param{FileFormat} eq 'gif' ) {
                return $TargetImage->gif();
            }
        }
    }
    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message => 'Couldn\'t load GD library! Check if you have it installed, or switch the library in SysConfig.',
        );
    }

    return;
}

1;

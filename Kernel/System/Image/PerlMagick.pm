# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Image::PerlMagick;

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
        'Image::Magick',
    );

    if ($Loaded) {
        my $IMObject = Image::Magick->new();

        # load image
        $IMObject->BlobToImage( $Param{Content} );

        # check if width or height exceeds resize geometry
        # and scale down the image if it does
        my ( $ImageWidth, $ImageHeight ) = $IMObject->Get( 'width', 'height' );
        if ( $ImageWidth > $Param{ResizeGeometry} || $ImageHeight > $Param{ResizeGeometry} ) {
            $IMObject->Resize( geometry => "$Param{ResizeGeometry}x$Param{ResizeGeometry}" );
            return $IMObject->ImageToBlob();
        }
    }
    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                'Couldn\'t load PerlMagick library! Check if you have it installed, or switch the library in SysConfig.',
        );
    }

    return;
}

1;

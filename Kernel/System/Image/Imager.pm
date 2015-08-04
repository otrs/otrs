# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Image::Imager;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::FileTemp',
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
        'Imager',
    );

    if ($Loaded) {

        # check if target format support is loaded
        my $FormatSupport = $Kernel::OM->Get('Kernel::System::Main')->Require(
            'Imager::File::' . uc( $Param{FileFormat} ),
        );

        if ($FormatSupport) {
            my $SourceImage = Imager->new();

            # load image
            $SourceImage->read(
                data => $Param{Content},
                type => $Param{FileFormat}
            );

            # check if width or height exceeds resize geometry
            # and scale down the image if it does
            my $ImageWidth  = $SourceImage->getwidth();
            my $ImageHeight = $SourceImage->getheight();
            if ( $ImageWidth > $Param{ResizeGeometry} || $ImageHeight > $Param{ResizeGeometry} ) {
                my $ResizedImage;
                my $TargetImage = $SourceImage->scale(
                    xpixels => $Param{ResizeGeometry},
                    ypixels => $Param{ResizeGeometry}
                );
                $TargetImage->write(
                    data => \$ResizedImage,
                    type => $Param{FileFormat}
                );
                return $ResizedImage;
            }
        }
        else {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Couldn\'t load Imager format support library! Check if you have installed Imager::File::'
                    . uc( $Param{FileFormat} )
                    . ' or switch the library in SysConfig.',
            );
        }
    }
    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                'Couldn\'t load Imager library! Check if you have it installed, along with format support or switch the library in SysConfig.',
        );
    }

    return;
}

1;

# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Image::ImageMagick;

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

    # create needed objects
    my $ConfigObject   = $Kernel::OM->Get('Kernel::Config');
    my $FileTempObject = $Kernel::OM->Get('Kernel::System::FileTemp');

    # bin paths
    my $IdentifyPath = $ConfigObject->Get('Image::ImageMagick')->{IdentifyPath} || '/usr/bin/identify';
    my $ConvertPath  = $ConfigObject->Get('Image::ImageMagick')->{ConvertPath}  || '/usr/bin/convert';

    # check if command line tool is installed
    if ( -f $IdentifyPath && -f $ConvertPath ) {

        # temp files
        my ( $SourceFH, $SourceFilename ) = $FileTempObject->TempFile();
        my ( $TargetFH, $TargetFilename ) = $FileTempObject->TempFile();
        print $SourceFH $Param{Content};
        close $SourceFH;

        # get width and height
        my $IdentifyCommand = qq{"$IdentifyPath"};
        my $IdentifyOptions = "-format \"%[fx:w]x%[fx:h]\" $Param{FileFormat}:$SourceFilename";
        my $IdentifyOutput  = qx{$IdentifyCommand $IdentifyOptions 2>&1};
        my ( $ImageWidth, $ImageHeight ) = split( 'x', $IdentifyOutput );

        # check if width or height exceeds resize geometry
        # and scale down the image if it does
        if ( $ImageWidth > $Param{ResizeGeometry} || $ImageHeight > $Param{ResizeGeometry} ) {
            my $ConvertCommand = qq{"$ConvertPath"};
            my $ConvertOptions
                = "-resize $Param{ResizeGeometry}x$Param{ResizeGeometry} $Param{FileFormat}:$SourceFilename $Param{FileFormat}:$TargetFilename";
            my $ConvertOutput = qx{$ConvertCommand $ConvertOptions 2>&1};
            if ( -B $TargetFilename ) {
                {
                    local $/;
                    return <$TargetFH>;
                }
            }
        }
    }
    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                'Couldn\'t find ImageMagick command line tools! Check if you have them installed, or specify correct paths in SysConfig.',
        );
    }

    return;
}

1;

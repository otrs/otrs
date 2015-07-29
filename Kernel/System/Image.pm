# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Image;

use strict;
use warnings;

use MIME::Base64;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Encode',
    'Kernel::System::FileTemp',
    'Kernel::System::Log',
    'Kernel::System::Main',
    'Kernel::System::VirtualFS',
);

=head1 NAME

Kernel::System::Image - the image class

=head1 SYNOPSIS

Functions for saving, retrieving and manipulation of images.

=head1 PUBLIC INTERFACE

=over 4

=cut

=item new()

Create an Image object. Do not use it directly, instead use:

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $ImageObject = $Kernel::OM->Get('Kernel::System::Image');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=item ImageGet()

Returns an image from Virtual FS.

    my $Image = $ImageObject->ImageGet(
        Key      => 'ImagePreferences,   # used for first part of Virtual FS path
        ID       => '2',                 # used for second part of Virtual FS path
        Filename => 'image.png'          # used for third part of Virtual FS path
        Inline   => 1,                   # (optional) (0|1) default 0, to return image as inline base64 encoded string
    );

=cut

sub ImageGet {
    my ( $Self, %Param ) = @_;

    # check for needed data
    for my $Needed (qw( Key ID Filename )) {
        if ( !defined $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed",
            );
            return;
        }
    }

    # create needed objects
    my $VirtualFSObject = $Kernel::OM->Get('Kernel::System::VirtualFS');
    my $EncodeObject    = $Kernel::OM->Get('Kernel::System::Encode');

    # get image
    my %ImageFile = $VirtualFSObject->Read(
        Filename => "/$Param{Key}/$Param{ID}/$Param{Filename}",
        Mode     => 'binary',
    );

    if ( $ImageFile{Content} ) {

        my $ImageContent = $ImageFile{Content};

        if ( $Param{Inline} ) {
            $ImageContent = $EncodeObject->EncodeOutput( $ImageFile{Content} );
            $ImageContent = encode_base64( ${$ImageContent} );
            chomp $ImageContent;
            $ImageContent = 'data:' . $ImageFile{Preferences}->{ContentType} . ';base64,' . $ImageContent;
        }

        return $ImageContent;
    }
    else {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Error getting image!',
        );

        return;
    }
}

=item ImageAdd()

Adds an image to Virtual FS.

    my $Success = $ImageObject->ImageAdd(
        Key         => 'ImagePreferences,    # used for first part of Virtual FS path
        ID          => '2',                  # used for second part of Virtual FS path
        Filename    => 'image.png'           # used for third part of Virtual FS path
        Content     => $ImageFile{Content}, # image content in binary format
        ContentType => 'image/jpeg',         # image MIME content type
    );

=cut

sub ImageAdd {
    my ( $Self, %Param ) = @_;

    # check for needed data
    for my $Needed (qw( Key ID Filename Content ContentType )) {
        if ( !defined $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed",
            );
            return;
        }
    }

    # create needed objects
    my $ConfigObject    = $Kernel::OM->Get('Kernel::Config');
    my $VirtualFSObject = $Kernel::OM->Get('Kernel::System::VirtualFS');

    # check if image should be resized
    if ( $ConfigObject->Get('Image::Backend') && $ConfigObject->Get('Image::Resize') ) {

        # determine file format
        my ( $FileType, $FileFormat ) = split( '/', $Param{ContentType} );
        $Param{FileFormat} = $FileFormat;

        # get resize geometry
        $Param{ResizeGeometry} = $ConfigObject->Get('Image::ResizeGeometry') || 200;

        # load image backend
        my $ImageBackend = $ConfigObject->Get('Image::Backend') || 'Kernel::System::Image::PerlMagick';
        my $Loaded = $Kernel::OM->Get('Kernel::System::Main')->Require(
            $ImageBackend,
        );

        if ($Loaded) {
            my $ImageObject = $ImageBackend->new();

            # resize the image
            my $ResizedImage = $ImageBackend->ImageResize(
                %Param,
            );

            $Param{Content} = $ResizedImage if $ResizedImage;
        }
        else {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => 'Couldn\'t load image module backend!',
            );
        }
    }

    # write image to VirtualFS
    return $VirtualFSObject->Write(
        Content     => \$Param{Content},
        Filename    => "/$Param{Key}/$Param{ID}/$Param{Filename}",
        Mode        => 'binary',
        Preferences => {
            ContentType => $Param{ContentType},
        },
    );
}

=item ImageRemove()

Removes an image from Virtual FS.

    my $Success = $ImageObject->ImageRemove(
        Key         => 'ImagePreferences,    # used for first part of Virtual FS path
        ID          => '2',                  # used for second part of Virtual FS path
        Filename    => 'image.png'           # used for third part of Virtual FS path
    );

=cut

sub ImageRemove {
    my ( $Self, %Param ) = @_;

    # check for needed data
    for my $Needed (qw( Key ID Filename )) {
        if ( !defined $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed",
            );
            return;
        }
    }

    return $Kernel::OM->Get('Kernel::System::VirtualFS')->Delete(
        Filename => "/$Param{Key}/$Param{ID}/$Param{Filename}",
    );
}

1;

=back

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

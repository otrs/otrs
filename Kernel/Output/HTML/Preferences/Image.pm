# --
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::Preferences::Image;

use strict;
use warnings;
use MIME::Base64;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::Language',
    'Kernel::System::Image',
    'Kernel::System::Encode',
    'Kernel::System::VirtualFS',
    'Kernel::System::Web::Request',
    'Kernel::System::Log',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    for my $Needed (qw( UserID UserObject ConfigItem )) {
        die "Got no $Needed!" if ( !$Self->{$Needed} );
    }

    $Kernel::OM->ObjectParamAdd(
        'Kernel::Language' => {
            UserTimeZone => $Self->{UserTimeZone},
            UserLanguage => $Self->{UserLanguage},
            Action       => $Self->{Action},
        },
    );

    return $Self;
}

sub Param {
    my ( $Self, %Param ) = @_;

    my @Params = ();

    # show image if it exists
    if (
        $Param{UserData}->{ $Self->{ConfigItem}->{PrefKey} }
        && $Param{UserData}->{ $Self->{ConfigItem}->{PrefKey} } ne ''
        )
    {

        $Param{ImageFilename} = $Param{UserData}->{ $Self->{ConfigItem}->{PrefKey} };
        $Param{ImageContent}  = $Kernel::OM->Get('Kernel::System::Image')->ImageGet(
            Key      => 'ImagePreferences',
            ID       => $Param{UserData}->{UserID},
            Filename => $Param{ImageFilename},
            Inline   => 1,
        );
    }

    push(
        @Params,
        {
            %Param,
            Name  => $Self->{ConfigItem}->{PrefKey},
            Block => 'Upload',
            Group => $Self->{ConfigItem}->{Group},
            Type  => 'ImagePreferences',
            Raw   => 1,
        },

    );

    return @Params;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my %ImageFile = $Kernel::OM->Get('Kernel::System::Web::Request')->GetUploadAll(
        Param => $Self->{ConfigItem}->{PrefKey},
    );

    return 1 if !$ImageFile{Content};

    if (
        $ImageFile{ContentType}    ne 'image/png'
        && $ImageFile{ContentType} ne 'image/jpeg'
        && $ImageFile{ContentType} ne 'image/gif'
        )
    {
        $Self->{Message} = $Kernel::OM->Get('Kernel::Language')->Translate('JPEG, PNG and GIF images supported only!');
        return 1;
    }

    # create needed object
    my $ImageObject = $Kernel::OM->Get('Kernel::System::Image');

    # remove image if it exists
    if ( $Param{UserData}->{ $Self->{ConfigItem}->{PrefKey} } ) {
        $ImageObject->ImageRemove(
            Key      => 'ImagePreferences',
            ID       => $Param{UserData}->{UserID},
            Filename => $Param{UserData}->{ $Self->{ConfigItem}->{PrefKey} },
        );
    }

    # add image
    my $Success = $ImageObject->ImageAdd(
        Key         => 'ImagePreferences',
        ID          => $Param{UserData}->{UserID},
        Filename    => $ImageFile{Filename},
        Content     => $ImageFile{Content},
        ContentType => $ImageFile{ContentType},
    );

    if ($Success) {

        # set preference
        $Self->{UserObject}->SetPreferences(
            UserID => $Param{UserData}->{UserID},
            Key    => $Self->{ConfigItem}->{PrefKey},
            Value  => $ImageFile{Filename},
        );

        $Self->{Message} = $Kernel::OM->Get('Kernel::Language')->Translate('Image uploaded successfully!');

        return 1;
    }
    else {
        $Self->{Message}
            = $Kernel::OM->Get('Kernel::Language')->Translate('Couldn\'t upload the image, please try again...');

        return;
    }
}

sub Remove {
    my ( $Self, %Param ) = @_;

    my $ImageObject = $Kernel::OM->Get('Kernel::System::Image');

    my $Success = $ImageObject->ImageRemove(
        Key      => 'ImagePreferences',
        ID       => $Param{UserData}->{UserID},
        Filename => $Param{UserData}->{ $Self->{ConfigItem}->{PrefKey} },
    );

    if ($Success) {
        $Self->{Message} = $Kernel::OM->Get('Kernel::Language')->Translate('Image removed successfully');
        $Self->{UserObject}->SetPreferences(
            UserID => $Param{UserData}->{UserID},
            Key    => $Self->{ConfigItem}->{PrefKey},
            Value  => '',
        );
    }
    else {
        $Self->{Message}
            = $Kernel::OM->Get('Kernel::Language')->Translate('Couldn\'t remove the image, please try again...');
    }
}

sub Error {
    my ( $Self, %Param ) = @_;

    return $Self->{Error} || '';
}

sub Message {
    my ( $Self, %Param ) = @_;

    return $Self->{Message} || '';
}

1;

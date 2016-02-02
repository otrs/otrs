# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Web::UploadCache::FS;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Main',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    $Self->{TempDir} = $Kernel::OM->Get('Kernel::Config')->Get('TempDir') . '/upload_cache/';

    if ( !-d $Self->{TempDir} ) {
        mkdir $Self->{TempDir};
    }

    return $Self;
}

sub FormIDCreate {
    my ( $Self, %Param ) = @_;

    # return requested form id
    return time() . '.' . rand(12341241);
}

sub FormIDRemove {
    my ( $Self, %Param ) = @_;

    if ( !$Param{FormID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need FormID!'
        );
        return;
    }

    my $Directory = $Self->_GetCacheDirectory(%Param);

    if ( !-d $Directory ) {
        return 1;
    }

    # get main object
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my @List = $MainObject->DirectoryRead(
        Directory => $Directory,
        Filter    => "$Param{FormID}.*",
    );

    my @Data;
    for my $File (@List) {
        $MainObject->FileDelete(
            Location => $File,
        );
    }

    return 1;
}

sub FormIDAddFile {
    my ( $Self, %Param ) = @_;

    for (qw(FormID Filename Content ContentType)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $_!"
            );
            return;
        }
    }

    # create content id
    my $ContentID = $Param{ContentID};
    my $Disposition = $Param{Disposition} || '';
    if ( !$ContentID && lc $Disposition eq 'inline' ) {

        my $Random = rand 999999;
        my $FQDN   = $Kernel::OM->Get('Kernel::Config')->Get('FQDN');

        $ContentID = "$Disposition$Random.$Param{FormID}\@$FQDN";
    }

    # create cache subdirectory if not exist
    my $Directory = $Self->_GetCacheDirectory(%Param);
    if ( !-d $Directory ) {

        # Create directory. This could fail if another process creates the
        #   same directory, so don't use the return value.
        File::Path::mkpath( $Directory, 0, 0770 );    ## no critic

        if ( !-d $Directory ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Can't create directory '$Directory': $!",
            );
            return;
        }
    }

    # get main object
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    # files must readable for creator
    return if !$MainObject->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{FormID}.$Param{Filename}",
        Content    => \$Param{Content},
        Mode       => 'binmode',
        Permission => '640',
    );
    return if !$MainObject->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{FormID}.$Param{Filename}.ContentType",
        Content    => \$Param{ContentType},
        Mode       => 'binmode',
        Permission => '640',
    );
    return if !$MainObject->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{FormID}.$Param{Filename}.ContentID",
        Content    => \$ContentID,
        Mode       => 'binmode',
        Permission => '640',
    );
    return if !$MainObject->FileWrite(
        Directory  => $Directory,
        Filename   => "$Param{FormID}.$Param{Filename}.Disposition",
        Content    => \$Disposition,
        Mode       => 'binmode',
        Permission => '644',
    );
    return 1;
}

sub FormIDRemoveFile {
    my ( $Self, %Param ) = @_;

    for (qw(FormID FileID)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $_!"
            );
            return;
        }
    }

    my @Index = @{ $Self->FormIDGetAllFilesMeta(%Param) };
    my $ID    = $Param{FileID} - 1;
    my %File  = %{ $Index[$ID] };

    my $Directory = $Self->_GetCacheDirectory(%Param);

    if ( !-d $Directory ) {
        return 1;
    }

    # get main object
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    $MainObject->FileDelete(
        Directory => $Directory,
        Filename  => "$Param{FormID}.$File{Filename}",
    );
    $MainObject->FileDelete(
        Directory => $Directory,
        Filename  => "$Param{FormID}.$File{Filename}.ContentType",
    );
    $MainObject->FileDelete(
        Directory => $Directory,
        Filename  => "$Param{FormID}.$File{Filename}.ContentID",
    );
    $MainObject->FileDelete(
        Directory => $Directory,
        Filename  => "$Param{FormID}.$File{Filename}.Disposition",
    );

    return 1;
}

sub FormIDGetAllFilesData {
    my ( $Self, %Param ) = @_;

    if ( !$Param{FormID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need FormID!'
        );
        return;
    }

    my @Data;

    my $Directory = $Self->_GetCacheDirectory(%Param);

    if ( !-d $Directory ) {
        return \@Data;
    }

    # get main object
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my @List = $MainObject->DirectoryRead(
        Directory => $Directory,
        Filter    => "$Param{FormID}.*",
    );

    my $Counter = 0;

    FILE:
    for my $File (@List) {

        # ignore meta files
        next FILE if $File =~ /\.ContentType$/;
        next FILE if $File =~ /\.ContentID$/;
        next FILE if $File =~ /\.Disposition$/;

        $Counter++;
        my $FileSize = -s $File;

        # human readable file size
        if ($FileSize) {

            # remove meta data in files
            if ( $FileSize > 30 ) {
                $FileSize = $FileSize - 30
            }
            if ( $FileSize > 1048576 ) {    # 1024 * 1024
                $FileSize = sprintf "%.1f MBytes", ( $FileSize / 1048576 );    # 1024 * 1024
            }
            elsif ( $FileSize > 1024 ) {
                $FileSize = sprintf "%.1f KBytes", ( ( $FileSize / 1024 ) );
            }
            else {
                $FileSize = $FileSize . ' Bytes';
            }
        }
        my $Content = $MainObject->FileRead(
            Location => $File,
            Mode     => 'binmode',                                             # optional - binmode|utf8
        );
        next FILE if !$Content;

        my $ContentType = $MainObject->FileRead(
            Location => "$File.ContentType",
            Mode     => 'binmode',                                             # optional - binmode|utf8
        );
        next FILE if !$ContentType;

        my $ContentID = $MainObject->FileRead(
            Location => "$File.ContentID",
            Mode     => 'binmode',                                             # optional - binmode|utf8
        );
        next FILE if !$ContentID;

        # verify if content id is empty, set to undef
        if ( !${$ContentID} ) {
            ${$ContentID} = undef;
        }

        my $Disposition = $MainObject->FileRead(
            Location => "$File.Disposition",
            Mode     => 'binmode',                                             # optional - binmode|utf8
        );

        # strip filename
        $File =~ s/^.*\/$Param{FormID}\.(.+?)$/$1/;
        push(
            @Data,
            {
                Content     => ${$Content},
                ContentID   => ${$ContentID},
                ContentType => ${$ContentType},
                Filename    => $File,
                Filesize    => $FileSize,
                FileID      => $Counter,
                Disposition => ${$Disposition},
            },
        );
    }
    return \@Data;

}

sub FormIDGetAllFilesMeta {
    my ( $Self, %Param ) = @_;

    if ( !$Param{FormID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need FormID!'
        );
        return;
    }

    my @Data;

    my $Directory = $Self->_GetCacheDirectory(%Param);

    if ( !-d $Directory ) {
        return \@Data;
    }

    # get main object
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my @List = $MainObject->DirectoryRead(
        Directory => $Directory,
        Filter    => "$Param{FormID}.*",
    );

    my $Counter = 0;

    FILE:
    for my $File (@List) {

        # ignore meta files
        next FILE if $File =~ /\.ContentType$/;
        next FILE if $File =~ /\.ContentID$/;
        next FILE if $File =~ /\.Disposition$/;

        $Counter++;
        my $FileSize = -s $File;

        # human readable file size
        if ($FileSize) {

            # remove meta data in files
            if ( $FileSize > 30 ) {
                $FileSize = $FileSize - 30
            }
            if ( $FileSize > 1048576 ) {    # 1024 * 1024
                $FileSize = sprintf "%.1f MBytes", ( $FileSize / 1048576 );    # 1024 * 1024
            }
            elsif ( $FileSize > 1024 ) {
                $FileSize = sprintf "%.1f KBytes", ( ( $FileSize / 1024 ) );
            }
            else {
                $FileSize = $FileSize . ' Bytes';
            }
        }

        my $ContentType = $MainObject->FileRead(
            Location => "$File.ContentType",
            Mode     => 'binmode',                                             # optional - binmode|utf8
        );
        next FILE if !$ContentType;

        my $ContentID = $MainObject->FileRead(
            Location => "$File.ContentID",
            Mode     => 'binmode',                                             # optional - binmode|utf8
        );
        next FILE if !$ContentID;

        # verify if content id is empty, set to undef
        if ( !${$ContentID} ) {
            ${$ContentID} = undef;
        }

        my $Disposition = $MainObject->FileRead(
            Location => "$File.Disposition",
            Mode     => 'binmode',                                             # optional - binmode|utf8
        );

        # strip filename
        $File =~ s/^.*\/$Param{FormID}\.(.+?)$/$1/;
        push(
            @Data,
            {
                ContentID   => ${$ContentID},
                ContentType => ${$ContentType},
                Filename    => $File,
                Filesize    => $FileSize,
                FileID      => $Counter,
                Disposition => ${$Disposition},
            },
        );
    }
    return \@Data;
}

sub FormIDCleanUp {
    my ( $Self, %Param ) = @_;

    # get main object
    my $MainObject = $Kernel::OM->Get('Kernel::System::Main');

    my $CurrentTile = int( (time() - 86400) / 1000 ); # remove subdirs older than 24h
    my @List        = $MainObject->DirectoryRead(
        Directory => $Self->{TempDir},
        Filter    => '*'
    );

    for my $Subdir (@List) {
        $Subdir =~ s/^.*\/(.+?)$/$1/;
        if ( $CurrentTile > $Subdir ) {
            my @Sublist = $MainObject->DirectoryRead(
                Directory => $Self->{TempDir} . $Subdir,
                Filter    => "*",
            );

            for my $File (@Sublist) {
                $MainObject->FileDelete(
                    Location => $File,
                );
            }

            if ( !rmdir($Self->{TempDir} . $Subdir) ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'error',
                    Message  => "Can't remove: $Self->{TempDir}$Subdir: $!!",
                );
                return;
            }
        }
    }

    return 1;
}

sub _GetCacheDirectory {
    my ( $Self, %Param ) = @_;

    for my $Needed (qw(FormID)) {
        if ( !defined $Param{$Needed} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Needed!"
            );
            return;
        }
    }

    # create separate cache subdir every 1000 seconds
    # to avoid too many files in one subdirectory
    my $Subdir = $Param{FormID};
    $Subdir =~ s/^(.+?).{3}\..+?$/$1/;

    return $Self->{TempDir} . $Subdir . '/';
}

1;

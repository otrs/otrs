#!/usr/bin/perl
# --
# bin/otrs.PackageManager.pl - otrs package manager cmd version
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU AFFERO General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
# or see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

use File::Basename;
use FindBin qw($RealBin);
use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use File::Spec;
use Getopt::Std;

use Kernel::System::ObjectManager;

# create object manager
local $Kernel::OM = Kernel::System::ObjectManager->new(
    'Kernel::System::Log' => {
        LogPrefix => 'OTRS-otrs.PackageManager.pl',
    },
);

# get options
my %Opts;
getopt( 'apodv', \%Opts );

# set defaults
if ( !$Opts{o} ) {
    $Opts{o} = File::Spec->tmpdir();
}
if ( !$Opts{f} ) {
    $Opts{f} = 0;
}
if ( !$Opts{a} ) {
    $Opts{h} = 1;
}
if ( $Opts{a} && ( $Opts{a} !~ /^(list|reinstall-all)/ && !$Opts{p} ) ) {
    $Opts{h} = 1;
}
if ( $Opts{a} && ( $Opts{a} eq 'exportfile' && ( !$Opts{p} || !$Opts{d} ) ) ) {
    $Opts{h} = 1;
}
if ( $Opts{a} && $Opts{a} eq 'index' ) {
    $Opts{h} = 0;
}

# check needed params
if ( $Opts{h} ) {
    print "otrs.PackageManager.pl - OTRS Package Manager\n";
    print "Copyright (C) 2001-2014 OTRS AG, http://otrs.com/\n";
    print
        "usage: otrs.PackageManager.pl -a list|install|upgrade|uninstall|reinstall|reinstall-all|list-repository|file|build|index \n";
    print
        "      [-p package.opm|package.sopm|package|package-version] [-o OUTPUTDIR] [-f FORCE]\n";
    print " user (local):\n";
    print "   otrs.PackageManager.pl -a list\n";
    print "   otrs.PackageManager.pl -a install -p /path/to/Package-1.0.0.opm\n";
    print "   otrs.PackageManager.pl -a upgrade -p /path/to/Package-1.0.1.opm\n";
    print "   otrs.PackageManager.pl -a reinstall -p Package\n";
    print "   otrs.PackageManager.pl -a reinstall-all\n";
    print "   otrs.PackageManager.pl -a uninstall -p Package\n";
    print "   otrs.PackageManager.pl -a file -p Kernel/System/File.pm (find package of file)\n";
    print
        "   otrs.PackageManager.pl -a exportfile -p Kernel/System/File.opm -d /export/to/path/ (export files of package)\n";
    print " user (remote):\n";
    print "   otrs.PackageManager.pl -a list-repository\n";
    print "   otrs.PackageManager.pl -a install -p online:Package\n";
    print
        "   otrs.PackageManager.pl -a install -p http://ftp.otrs.org/pub/otrs/packages/:Package-1.0.0.opm\n";
    print "   otrs.PackageManager.pl -a upgrade -p online:Package\n";
    print
        "   otrs.PackageManager.pl -a upgrade -p http://ftp.otrs.org/pub/otrs/packages/:Package-1.0.0.opm\n";
    print " developer: \n";
    print "   otrs.PackageManager.pl -a build -p /path/to/Package-1.0.0.sopm\n";
    print
        "   otrs.PackageManager.pl -a build -p /path/to/Package-1.0.0.sopm -v 1.2.3 (define version)\n";
    print "   otrs.PackageManager.pl -a build -p /path/to/Package-1.0.0.sopm -d module-home-path\n";
    print
        "   otrs.PackageManager.pl -a build -p /path/to/Package-1.0.0.sopm -o location-of-opm-file\n";
    print "   otrs.PackageManager.pl -a index -d /path/to/repository/\n";
    exit 1;
}
my $FileString = '';
if ( $Opts{a} !~ /^(list|file)/ && $Opts{p} ) {
    if ( -e $Opts{p} ) {
        my $ContentRef = $Kernel::OM->Get('Kernel::System::Main')->FileRead(
            Location => $Opts{p},
            Mode     => 'utf8',      # optional - binmode|utf8
            Result   => 'SCALAR',    # optional - SCALAR|ARRAY
        );
        if ($ContentRef) {
            $FileString = ${$ContentRef};
        }
        else {
            die "ERROR: Can't open: $Opts{p}: $!";
        }
    }
    elsif ( $Opts{p} =~ /^(online|.*):(.+?)$/ ) {
        my $URL         = $1;
        my $PackageName = $2;
        if ( $URL eq 'online' ) {
            my %List = %{ $Kernel::OM->Get('Kernel::Config')->Get('Package::RepositoryList') };
            %List = (
                %List,
                $Kernel::OM->Get('Kernel::System::Package')->PackageOnlineRepositories()
            );
            for ( sort keys %List ) {
                if ( $List{$_} =~ /^\[-Master-\]/ ) {
                    $URL = $_;
                }
            }
        }
        if ( $PackageName !~ /^.+?.opm$/ ) {
            my @Packages = $Kernel::OM->Get('Kernel::System::Package')->PackageOnlineList(
                URL  => $URL,
                Lang => $Kernel::OM->Get('Kernel::Config')->Get('DefaultLanguage'),
            );
            PACKAGE:
            for my $Package (@Packages) {
                if ( $Package->{Name} eq $PackageName ) {
                    $PackageName = $Package->{File};
                    last PACKAGE;
                }
            }
        }
        $FileString = $Kernel::OM->Get('Kernel::System::Package')->PackageOnlineGet(
            Source => $URL,
            File   => $PackageName,
        );
        if ( !$FileString ) {
            die "ERROR: No such file '$Opts{p}' in $URL!";
        }
    }
    else {
        if ( $Opts{p} =~ /^(.*)\-(\d{1,4}\.\d{1,4}\.\d{1,4})$/ ) {
            $FileString = $Kernel::OM->Get('Kernel::System::Package')->RepositoryGet(
                Name    => $1,
                Version => $2,
            );
        }
        else {
            PACKAGE:
            for my $Package ( $Kernel::OM->Get('Kernel::System::Package')->RepositoryList() ) {
                if ( $Opts{p} eq $Package->{Name}->{Content} ) {
                    $FileString = $Kernel::OM->Get('Kernel::System::Package')->RepositoryGet(
                        Name    => $Package->{Name}->{Content},
                        Version => $Package->{Version}->{Content},
                    );
                    last PACKAGE;
                }
            }
        }
        if ( !$FileString ) {
            die "ERROR: No such file '$Opts{p}' or invalid 'package-version'!";
        }
    }
}

# file
if ( $Opts{a} eq 'file' ) {
    $Opts{p} =~ s/\/\//\//g;
    my $Hit = 0;
    PACKAGE:
    for my $Package ( $Kernel::OM->Get('Kernel::System::Package')->RepositoryList() ) {

        # just shown in list if PackageIsVisible flag is enable
        if (
            defined $Package->{PackageIsVisible}
            && !$Package->{PackageIsVisible}->{Content}
            )
        {
            next PACKAGE;
        }
        for my $File ( @{ $Package->{Filelist} } ) {
            if ( $Opts{p} =~ /^\Q$File->{Location}\E$/ ) {
                print
                    "+----------------------------------------------------------------------------+\n";
                print "| File:        $File->{Location}!\n";
                print "| Name:        $Package->{Name}->{Content}\n";
                print "| Version:     $Package->{Version}->{Content}\n";
                print "| Vendor:      $Package->{Vendor}->{Content}\n";
                print "| URL:         $Package->{URL}->{Content}\n";
                print "| License:     $Package->{License}->{Content}\n";
                print
                    "+----------------------------------------------------------------------------+\n";
                $Hit = 1;
            }
        }
    }
    if ($Hit) {
        exit;
    }
    else {
        print STDERR "ERROR: no package for file $Opts{p} found!\n";
        exit 1;
    }
}

# exportfile
if ( $Opts{a} eq 'exportfile' ) {
    $Opts{p} =~ s/\/\//\//g;
    my $String = '';

    # read package
    if ( -e $Opts{p} ) {
        my $ContentRef = $Kernel::OM->Get('Kernel::System::Main')->FileRead(
            Location => $Opts{p},
            Mode     => 'utf8',      # optional - binmode|utf8
            Result   => 'SCALAR',    # optional - SCALAR|ARRAY
        );
        if ($ContentRef) {
            if ( ${$ContentRef} ) {
                $String = ${$ContentRef};
            }
            else {
                print STDERR "ERROR: File $Opts{p} is empty!\n";
                exit 1;
            }
        }
        else {
            print STDERR "ERROR: no such package $Opts{p}: $! !\n";
            exit 1;
        }
    }
    else {
        print STDERR "ERROR: no package for file $Opts{p} found!\n";
        exit 1;
    }

    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $String,
    );

    # just export files if PackageIsDownloadable flag is enable
    if (
        defined $Structure{PackageIsDownloadable}
        && !$Structure{PackageIsDownloadable}->{Content}
        )
    {
        print STDERR "ERROR: Not possible to export files!\n";
        exit 1;
    }

    # export it
    print "+----------------------------------------------------------------------------+\n";
    print "| Export files of:\n";
    print "| Package: $Opts{p}\n";
    print "| To:      $Opts{d}\n";
    print "+----------------------------------------------------------------------------+\n";
    $Kernel::OM->Get('Kernel::System::Package')->PackageExport(
        String => $String,
        Home   => $Opts{d},
    );
    exit;
}

# build
if ( $Opts{a} eq 'build' ) {
    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $FileString,
    );

    # just build it if PackageIsDownloadable flag is enable
    if (
        defined $Structure{PackageIsDownloadable}
        && !$Structure{PackageIsDownloadable}->{Content}
        )
    {
        print STDERR "ERROR: Not available package!\n";
        exit 1;
    }

    if ( $Opts{v} && $Opts{v} =~ m/\d{1,4}\.\d{1,4}\.\d{1,4}/ ) {
        $Structure{Version}->{Content} = $Opts{v}
    }
    elsif ( $Opts{v} ) {
        print STDERR "ERROR: the given version ($Opts{v}) is invalid.\n";
        exit 1;
    }

    if ( !-e $Opts{o} ) {
        print STDERR "ERROR: $Opts{o} doesn't exist!\n";
        exit 1;
    }

    # build from given package directory, if any (otherwise default to OTRS home)
    if ( $Opts{d} ) {
        if ( !-d $Opts{d} ) {
            print STDERR "ERROR: $Opts{d} doesn't exist!\n";
            exit 1;
        }
        $Structure{Home} = $Opts{d};
    }

    my $Filename = $Structure{Name}->{Content} . '-' . $Structure{Version}->{Content} . '.opm';
    my $Content  = $Kernel::OM->Get('Kernel::System::Package')->PackageBuild(%Structure);
    my $File     = $Kernel::OM->Get('Kernel::System::Main')->FileWrite(
        Location   => $Opts{o} . '/' . $Filename,
        Content    => \$Content,
        Mode       => 'utf8',                       # binmode|utf8
        Type       => 'Local',                      # optional - Local|Attachment|MD5
        Permission => '644',                        # unix file permissions
    );
    if ($File) {
        print "Writing $File\n";
        exit;
    }
    else {
        print STDERR "ERROR: Can't write $File\n";
        exit 1;
    }
}
elsif ( $Opts{a} eq 'uninstall' ) {

    # get package file from db
    # parse package
    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $FileString,
    );

    # just un-install it if PackageIsRemovable flag is enable
    if (
        defined $Structure{PackageIsRemovable}
        && !$Structure{PackageIsRemovable}->{Content}
        )
    {
        my $ExitMessage = "ERROR: Not possible to remove this package!\n";

        # exchange message if package should not be visible
        if (
            defined $Structure{PackageIsVisible}
            && !$Structure{PackageIsVisible}->{Content}
            )
        {
            $ExitMessage = "ERROR: No such package!\n";
        }
        print STDERR $ExitMessage;
        exit 1;
    }

    # intro screen
    if ( $Structure{IntroUninstallPre} ) {
        my %Data = _MessageGet( Info => $Structure{IntroUninstallPre} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }

    # uninstall
    $Kernel::OM->Get('Kernel::System::Package')->PackageUninstall(
        String => $FileString,
        Force  => $Opts{f},
    );

    # intro screen
    if ( $Structure{IntroUninstallPost} ) {
        my %Data = _MessageGet( Info => $Structure{IntroUninstallPost} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }
    exit;
}
elsif ( $Opts{a} eq 'install' ) {

    # parse package
    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $FileString,
    );

    # intro screen
    if ( $Structure{IntroInstallPre} ) {
        my %Data = _MessageGet( Info => $Structure{IntroInstallPre} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }

    # install
    $Kernel::OM->Get('Kernel::System::Package')->PackageInstall(
        String => $FileString,
        Force  => $Opts{f},
    );

    # intro screen
    if ( $Structure{IntroInstallPost} ) {
        my %Data = _MessageGet( Info => $Structure{IntroInstallPost} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }
    exit;
}
elsif ( $Opts{a} eq 'reinstall' ) {

    # parse package
    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $FileString,
    );

    # intro screen
    if ( $Structure{IntroReinstallPre} ) {
        my %Data = _MessageGet( Info => $Structure{IntroReinstallPre} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }

    # install
    $Kernel::OM->Get('Kernel::System::Package')->PackageReinstall(
        String => $FileString,
        Force  => $Opts{f},
    );

    # intro screen
    if ( $Structure{IntroReinstallPost} ) {
        my %Data = _MessageGet( Info => $Structure{IntroReinstallPost} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }
    exit;
}
elsif ( $Opts{a} eq 'reinstall-all' ) {

    my @ReinstalledPackages;

    # loop all locally installed packages
    for my $Package ( $Kernel::OM->Get('Kernel::System::Package')->RepositoryList() ) {

        # do a deploy check to see if reinstallation is needed
        my $ReinstallNeeded = $Kernel::OM->Get('Kernel::System::Package')->DeployCheck(
            Name    => $Package->{Name}->{Content},
            Version => $Package->{Version}->{Content},
        );

        if ( !$ReinstallNeeded ) {

            push @ReinstalledPackages, $Package->{Name}->{Content};

            my $FileString = $Kernel::OM->Get('Kernel::System::Package')->RepositoryGet(
                Name    => $Package->{Name}->{Content},
                Version => $Package->{Version}->{Content},
            );

            $Kernel::OM->Get('Kernel::System::Package')->PackageReinstall(
                String => $FileString,
                Force  => $Opts{f},
            );
        }
    }

    if (@ReinstalledPackages) {
        for my $Package (@ReinstalledPackages) {
            print "Reinstalled: $Package\n";
        }
        print "\n";
    }
    else {
        print "No packages needed reinstallation.\n";
    }

    print "Done.\n";
    exit;
}
elsif ( $Opts{a} eq 'upgrade' ) {

    # parse package
    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $FileString,
    );

    # intro screen
    if ( $Structure{IntroUpgradePre} ) {
        my %Data = _MessageGet( Info => $Structure{IntroUpgradePre} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }

    # upgrade
    $Kernel::OM->Get('Kernel::System::Package')->PackageUpgrade(
        String => $FileString,
        Force  => $Opts{f},
    );

    # intro screen
    if ( $Structure{IntroUpgradePost} ) {
        my %Data = _MessageGet( Info => $Structure{IntroUpgradePost} );
        print "+----------------------------------------------------------------------------+\n";
        print "| $Structure{Name}->{Content}-$Structure{Version}->{Content}\n";
        print "$Data{Title}";
        print "$Data{Description}";
        print "+----------------------------------------------------------------------------+\n";
    }
    exit;
}
elsif ( $Opts{a} eq 'list' ) {

    PACKAGE:
    for my $Package ( $Kernel::OM->Get('Kernel::System::Package')->RepositoryList() ) {

        # just shown in list if PackageIsVisible flag is enable
        if (
            defined $Package->{PackageIsVisible}
            && !$Package->{PackageIsVisible}->{Content}
            )
        {
            next PACKAGE;
        }

        my %Data = _MessageGet(
            Info     => $Package->{Description},
            Reformat => 'No'
        );
        print "+----------------------------------------------------------------------------+\n";
        print "| Name:        $Package->{Name}->{Content}\n";
        print "| Version:     $Package->{Version}->{Content}\n";
        print "| Vendor:      $Package->{Vendor}->{Content}\n";
        print "| URL:         $Package->{URL}->{Content}\n";
        print "| License:     $Package->{License}->{Content}\n";
        print "| Description: $Data{Description}\n";
    }
    print "+----------------------------------------------------------------------------+\n";
    exit;
}
elsif ( $Opts{a} eq 'list-repository' ) {
    my $Count = 0;
    my %List;
    if ( $Kernel::OM->Get('Kernel::Config')->Get('Package::RepositoryList') ) {
        %List = %{ $Kernel::OM->Get('Kernel::Config')->Get('Package::RepositoryList') };
    }
    %List = ( %List, $Kernel::OM->Get('Kernel::System::Package')->PackageOnlineRepositories() );
    for my $URL ( sort { $List{$a} cmp $List{$b} } keys %List ) {
        $Count++;
        print "+----------------------------------------------------------------------------+\n";
        print "| $Count) Name: $List{$URL}\n";
        print "|    URL:  $URL\n";
    }
    print "+----------------------------------------------------------------------------+\n";
    print "| Select the repository [1]: ";
    my $Repository = <STDIN>;
    chomp $Repository;
    if ( !$Repository ) {
        $Repository = 1;
    }
    $Count = 0;
    for my $URL ( sort { $List{$a} cmp $List{$b} } keys %List ) {
        $Count++;
        if ( $Count == $Repository ) {
            print
                "+----------------------------------------------------------------------------+\n";
            print "| Package Overview:\n";
            my @Packages = $Kernel::OM->Get('Kernel::System::Package')->PackageOnlineList(
                URL  => $URL,
                Lang => $Kernel::OM->Get('Kernel::Config')->Get('DefaultLanguage'),
            );
            my $Count = 0;
            PACKAGE:
            for my $Package (@Packages) {

                # just shown in list if PackageIsVisible flag is enable
                if (
                    defined $Package->{PackageIsVisible}
                    && !$Package->{PackageIsVisible}->{Content}
                    )
                {
                    next PACKAGE;
                }
                $Count++;
                print
                    "+----------------------------------------------------------------------------+\n";
                print "| $Count) Name:        $Package->{Name}\n";
                print "|    Version:     $Package->{Version}\n";
                print "|    Vendor:      $Package->{Vendor}\n";
                print "|    URL:         $Package->{URL}\n";
                print "|    License:     $Package->{License}\n";
                print "|    Description: $Package->{Description}\n";
                print "|    Install:     -p $URL:$Package->{File}\n";
            }
            print
                "+----------------------------------------------------------------------------+\n";
            print "| Install/Upgrade Package: ";
            my $PackageCount = <STDIN>;
            chomp($PackageCount);
            $Count = 0;
            for my $Package (@Packages) {
                $Count++;
                if ( $Count eq $PackageCount ) {
                    my $FileString = $Kernel::OM->Get('Kernel::System::Package')->PackageOnlineGet(
                        Source => $URL,
                        File   => $Package->{File},
                    );
                    $Kernel::OM->Get('Kernel::System::Package')->PackageInstall(
                        String => $FileString,
                        Force  => $Opts{'f'},
                    );
                }
            }
        }
    }
    exit;
}
elsif ( $Opts{a} eq 'p' ) {

    # parse package
    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $FileString,
    );

    # perform parsing only if PackageIsVisible flag is enable
    if (
        defined $Structure{PackageIsVisible}
        && !$Structure{PackageIsVisible}->{Content}
        )
    {
        print STDERR "ERROR: no such package $Opts{p}!\n";
        exit 1;
    }

    my @Data = keys %Structure;
    for my $Tag (@Data) {
        if ( ref $Structure{$Tag} eq 'HASH' ) {
            print STDERR "Tag: $Structure{$Tag}->{TagType} - $Structure{$Tag}->{Tag} $Structure{$Tag}->{Content}\n";
        }
        elsif ( ref $Structure{$Tag} eq 'ARRAY' ) {

            # add a sub-level reference
            print STDERR "\n--- Open Sub-Tag: $Tag ---\n";

            # loop over the second level tags
            my @SubData = @{ $Structure{$Tag} };
            for my $SubTag (@SubData) {
                print STDERR "Tag: $SubTag->{TagType} $SubTag->{Tag} $SubTag->{Content}\n";
            }

            # add a sub-level reference
            print STDERR "--- Close Sub-Tag: $Tag ---\n\n";
        }
    }

}
elsif ( $Opts{a} eq 'parse' ) {
    my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse(
        String => $FileString,
    );

    # perform parsing only if PackageIsVisible flag is enable
    if (
        defined $Structure{PackageIsVisible}
        && !$Structure{PackageIsVisible}->{Content}
        )
    {
        print STDERR "ERROR: no such package $Opts{p}!\n";
        exit 1;
    }

    for my $Key ( sort keys %Structure ) {
        if ( ref( $Structure{$Key} ) eq 'ARRAY' ) {
            for my $Data ( @{ $Structure{$Key} } ) {
                print "--------------------------------------\n";
                print "$Key:\n";
                for ( %{$Data} ) {
                    if ( defined($_) && defined( $Data->{$_} ) ) {
                        print "  $_: $Data->{$_}\n";
                    }
                }
            }
        }
        else {
            print "--------------------------------------\n";
            print "$Key:\n";
            for my $Data ( %{ $Structure{$Key} } ) {
                if ( defined( $Structure{$Key}->{$Data} ) ) {
                    print "  $Data: $Structure{$Key}->{$Data}\n";
                }
            }
        }
    }
    exit;
}
elsif ( $Opts{a} eq 'index' ) {
    if ( !$Opts{d} ) {
        die "ERROR: invalid package root location -d is needed!";
    }
    elsif ( !-d $Opts{d} ) {
        die "ERROR: invalid package root location '$Opts{d}'";
    }
    my @Dirs;
    print "<?xml version=\"1.0\" encoding=\"utf-8\" ?>\n";
    print "<otrs_package_list version=\"1.0\">\n";
    BuildPackageIndex( $Opts{d} );
    print "</otrs_package_list>\n";
}
else {
    print STDERR "ERROR: Invalid -a '$Opts{a}' action\n";
    exit 1;
}

sub BuildPackageIndex {
    my $In = shift;

    my @List = $Kernel::OM->Get('Kernel::System::Main')->DirectoryRead(
        Directory => $In,
        Filter    => '*',
    );
    for my $File (@List) {
        $File =~ s/\/\//\//g;
        if ( -d $File && $File !~ /CVS/ ) {
            BuildPackageIndex($File);
            $File =~ s/$Opts{d}//;

            # print "Directory: $File\n";
        }
        else {
            my $OrigFile = $File;
            $File =~ s/$Opts{d}//;

            # print "File: $File\n";
            # my $Dir =~ s/^(.*)\//$1/;
            if ( $File !~ /Entries|Repository|Root|CVS/ && $File =~ /\.opm$/ ) {

                # print "F: $File\n";
                my $Content    = '';
                my $ContentRef = $Kernel::OM->Get('Kernel::System::Main')->FileRead(
                    Location => $OrigFile,
                    Mode     => 'utf8',      # optional - binmode|utf8
                    Result   => 'SCALAR',    # optional - SCALAR|ARRAY
                );
                if ( !$ContentRef ) {
                    print STDERR "ERROR: Can't open $OrigFile: $!\n";
                    exit 1;
                }
                my %Structure = $Kernel::OM->Get('Kernel::System::Package')->PackageParse( String => ${$ContentRef} );
                my $XML = $Kernel::OM->Get('Kernel::System::Package')->PackageBuild( %Structure, Type => 'Index' );
                print "<Package>\n";
                print $XML;
                print "  <File>$File</File>\n";
                print "</Package>\n";
            }
        }
    }
    return 1;
}

sub _MessageGet {
    my (%Param) = @_;

    my $Title       = '';
    my $Description = '';
    if ( $Param{Info} ) {
        for my $Tag ( @{ $Param{Info} } ) {
            if ( !$Description && $Tag->{Lang} eq 'en' ) {
                $Description = $Tag->{Content} || '';
                $Title       = $Tag->{Title}   || '';
            }
        }
        if ( !$Description ) {
            for my $Tag ( @{ $Param{Info} } ) {
                if ( !$Description ) {
                    $Description = $Tag->{Content} || '';
                    $Title       = $Tag->{Title}   || '';
                }
            }
        }
    }
    if ( !$Param{Reformat} || $Param{Reformat} ne 'No' ) {
        $Title =~ s/(.{4,78})(?:\s|\z)/| $1\n/gm;
        $Description =~ s/^\s*//mg;
        $Description =~ s/\n/ /gs;
        $Description =~ s/\r/ /gs;
        $Description =~ s/\<style.+?\>.*\<\/style\>//gsi;
        $Description =~ s/\<br(\/|)\>/\n/gsi;
        $Description =~ s/\<(hr|hr.+?)\>/\n\n/gsi;
        $Description =~ s/\<(\/|)(pre|pre.+?|p|p.+?|table|table.+?|code|code.+?)\>/\n\n/gsi;
        $Description =~ s/\<(tr|tr.+?|th|th.+?)\>/\n\n/gsi;
        $Description =~ s/\.+?<\/(td|td.+?)\>/ /gsi;
        $Description =~ s/\<.+?\>//gs;
        $Description =~ s/  / /mg;
        $Description =~ s/&amp;/&/g;
        $Description =~ s/&lt;/</g;
        $Description =~ s/&gt;/>/g;
        $Description =~ s/&quot;/"/g;
        $Description =~ s/&nbsp;/ /g;
        $Description =~ s/^\s*\n\s*\n/\n/mg;
        $Description =~ s/(.{4,78})(?:\s|\z)/| $1\n/gm;
    }
    return (
        Description => $Description,
        Title       => $Title,
    );
}

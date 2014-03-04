#!/usr/bin/perl
# --
# bin/otrs.CreateTranslationFile.pl - create new translation file
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

use Getopt::Std qw();

use Kernel::System::ObjectManager;

sub PrintUsage {
    print <<"EOF";

otrs.CreateTranslationFile.pl - update translation files
Copyright (C) 2001-2010 OTRS AG, http://otrs.org/

Translating OTRS
================

  Make sure that you have a clean system with a current configuration. No modules
  may be installed or linked into the system!

    otrs.CreateTranslationFile.pl -l <Language>
    otrs.CreateTranslationFile.pl -l all

Translating Extension Modules
=============================

  Make sure that you have a clean system with a current configuration. The module
  that needs to be translated has to be installed or linked into the system, but
  only this one!

    otrs.CreateTranslationFile.pl -l <Language> -m <module_directory>
    otrs.CreateTranslationFile.pl -l all -m <module_directory>

Optional Parameters
=============================

  To purge obsolete translation entries, use -p

    otrs.CreateTranslationFile.pl -l all -p

  To output debug information, use -v.

EOF
}

# common objects
local $Kernel::OM = Kernel::System::ObjectManager->new(
    LogObject => {
        LogPrefix => 'OTRS-otrs.CreateTranslationFile.pl',
    },
);
my %CommonObject = $Kernel::OM->ObjectHash(
    Objects => [qw(ConfigObject EncodeObject LogObject MainObject TimeObject DBObject SysConfigObject)],
);

my $Home = $CommonObject{ConfigObject}->Get('Home');

my $BreakLineAfterChars = 60;

{
    my @Languages;
    my %Opts;

    # get opts
    Getopt::Std::getopt( 'lmpv', \%Opts );

    # check params
    if ( $Opts{l} && $Opts{l} eq 'all' ) {
        my %DefaultUsedLanguages = %{ $CommonObject{ConfigObject}->Get('DefaultUsedLanguages') };
        @Languages = sort keys %DefaultUsedLanguages;

        # ignore en*.pm files
        @Languages = grep { $_ !~ m{ \A en .* }xms } @Languages;
    }
    elsif ( $Opts{l} ) {
        push @Languages, $Opts{l};
        if ( !-f "$Home/Kernel/Language/$Languages[0].pm" ) {
            print "ERROR: No core translation file: $Languages[0]!\n";
            exit 1;
        }
    }
    else {
        PrintUsage();
        exit 0;
    }

    print "Starting...\n\n";

    # Gather some statistics
    my %Stats;

    for my $Language (@Languages) {
        HandleLanguage(
            Language      => $Language,
            Module        => $Opts{m},
            PurgeObsolete => exists $Opts{p} ? 1 : 0,
            Stats         => \%Stats,
            Verbose       => exists $Opts{v} ? 1 : 0,
        );
    }

    my %Summary;
    for my $Language ( sort keys %Stats ) {
        $Summary{$Language}->{Translated} = scalar grep {$_} values %{ $Stats{$Language} };
        $Summary{$Language}->{Total} = scalar values %{ $Stats{$Language} };
    }

    print "\n\nTranslation statistics:\n";
    for my $Language (
        sort { $Summary{$b}->{Translated} <=> $Summary{$a}->{Translated} }
        keys %Stats
        )
    {
        my $Strings      = $Summary{$Language}->{Total};
        my $Translations = $Summary{$Language}->{Translated};
        print "\t" . sprintf( "%7s", $Language ) . ": ";
        print sprintf( "%02d", int( ( $Translations / $Strings ) * 100 ) );
        print sprintf( "%% (%4d/%4d)\n", $Translations, $Strings );

    }

    print "\n\nFinished.\n";
}

sub HandleLanguage {
    my (%Param) = @_;

    my $Language      = $Param{Language};
    my $Module        = $Param{Module};
    my $PurgeObsolete = $Param{PurgeObsolete};

    my $ModuleDirectory = $Module;
    my $LanguageFile;
    my $TargetFile;
    my $IsSubTranslation;
    my $Indent = ' ' x 8;    # 8 spaces for core files

    my $DefaultTheme = $CommonObject{ConfigObject}->Get('DefaultTheme');

    if ( !$Module ) {
        $LanguageFile = "$Home/Kernel/Language/$Language.pm";
        $TargetFile   = "$Home/Kernel/Language/$Language.pm";
    }
    else {
        $IsSubTranslation = 1;
        $Indent           = ' ' x 4;    # 4 spaces for module files

        # extract module name from module path
        $Module = basename $Module;

        # remove underscores and/or version numbers and following from module name
        # i.e. FAQ_2_0 or FAQ20
        $Module =~ s{ [_0-9]+ .+ \z }{}xms;

        # special handling of some ITSM modules
        if ( $Module eq 'ITSMIncidentProblemManagement' ) {
            $Module = 'ITSMTicket';
        }
        elsif ( $Module eq 'ITSMConfigurationManagement' ) {
            $Module = 'ITSMConfigItem';
        }

        # save module directory in target file
        $TargetFile = "$ModuleDirectory/Kernel/Language/${Language}_$Module.pm";
    }

    if ( !-w $TargetFile ) {
        print STDERR "Ignoring nonexisting file $TargetFile!\n";
        return;
    }

    if ($IsSubTranslation) {
        print
            "Processing language $Language template files from $Module, writing output to $TargetFile\n";
    }
    else {
        print "Processing language $Language template files, writing output to $TargetFile\n";
    }

    # Language file, which only contains the OTRS core translations
    my $LanguageCoreObject = Kernel::Language->new(
        %CommonObject,
        UserLanguage    => $Language,
        TranslationFile => 1,
    );

    # Language file, which contains all translations
    my $LanguageObject = Kernel::Language->new(
        %CommonObject,
        UserLanguage => $Language,
    );

    # open .tt files and write new translation file
    my $Data = '';
    my %UsedWords;
    my %UsedWordsMisc;
    my $Directory
        = $IsSubTranslation
        ? "$ModuleDirectory/Kernel/Output/HTML/$DefaultTheme"
        : "$Home/Kernel/Output/HTML/$DefaultTheme";

    my @List = $CommonObject{MainObject}->DirectoryRead(
        Directory => $Directory,
        Filter    => '*.tt',
    );

    if ( $Param{Verbose} ) {
        print "\nReading template files:\n";
    }

    for my $File (@List) {

        my $ContentRef = $CommonObject{MainObject}->FileRead(
            Location => $File,
            Mode     => 'utf8',
        );

        if ( !ref $ContentRef ) {
            die "Can't open $File: $!";
        }

        my $Content = ${$ContentRef};

        $File =~ s!^.*/(.+?)\.tt!$1!;
        if ( $Param{Verbose} ) {
            print "$File ";
        }
        $Data .= "\n" . $Indent . "# Template: $File\n";

        # do translation
        $Content =~ s{
            Translate\(
                \s*
                "(.*?)(?<!\\)"
                \s*
                (?:,[^\)]+)?
            \)
            (?:\s|[|])
        }
        {
            my $Word = $1 // '';

            # unescape any \" signs
            $Word =~ s{\\"}{"}smxg;

            # if we translate a module, we must handle also that possibly
            # there is already a translation in the core files
            if ($IsSubTranslation) {
                # ignore word if already used
                if ( $Word && !exists $UsedWords{$Word} && !exists $LanguageCoreObject->{Translation}->{$Word} ) {

                    # remove it from misc list
                    $UsedWordsMisc{$Word} = 1;

                    # lookup for existing translation
                    $UsedWords{$Word} = $LanguageObject->{Translation}->{$Word};
                    my $Translation = $UsedWords{$Word} || '';
                    $Translation =~ s/'/\\'/g;
                    my $Key = $Word;
                    $Key =~ s/'/\\'/g;

                    $Param{Stats}->{$Param{Language}}->{$Word} = $Translation;

                    if (length($Key) < $BreakLineAfterChars) {
                        $Data .= $Indent . "\$Self->{Translation}->{'$Key'} = '$Translation';\n";
                    }
                    else {
                        $Data .= $Indent . "\$Self->{Translation}->{'$Key'} =\n";
                        $Data .= $Indent . '    ' . "'$Translation';\n";
                    }
                }
            }
            else {
                # ignore word if already used
                if ( $Word && !exists $UsedWords{$Word} ) {

                    # remove it from misc list
                    $UsedWordsMisc{$Word} = 1;

                    # lookup for existing translation
                    $UsedWords{$Word} = $LanguageCoreObject->{Translation}->{$Word};
                    my $Translation = $UsedWords{$Word} || '';
                    $Translation =~ s/'/\\'/g;

                    $Param{Stats}->{$Param{Language}}->{$Word} = $Translation;

                    my $Key = $Word;
                    $Key =~ s/'/\\'/g;
                    if (length($Key) < $BreakLineAfterChars) {
                        $Data .= $Indent . "'$Key' => '$Translation',\n";
                    }
                    else {
                        $Data .= $Indent . "'$Key' =>\n";
                        $Data .= $Indent . '    ' . "'$Translation',\n";
                    }
                }
            }
            '';
        }egx;
    }

    # add translatable strings from SysConfig
    if ( $Param{Verbose} ) {
        print "SysConfig\n";
    }
    $Data .= "\n" . $Indent . "# SysConfig\n";
    my @Strings = $CommonObject{SysConfigObject}->ConfigItemTranslatableStrings();

    STRING:
    for my $String ( sort @Strings ) {

        next STRING if !$String;

        # skip if we translate a module and the word already exists in the core translation
        next STRING if $IsSubTranslation && exists $LanguageCoreObject->{Translation}->{$String};

        # ignore word if already used
        next STRING if exists $UsedWords{$String};

        # remove it from misc list
        $UsedWordsMisc{$String} = 1;

        # lookup for existing translation
        $UsedWords{$String}
            = ( $IsSubTranslation ? $LanguageObject : $LanguageCoreObject )->{Translation}
            ->{$String};

        my $Translation = $UsedWords{$String} || '';
        $Translation =~ s/'/\\'/g;

        $Param{Stats}->{ $Param{Language} }->{$String} = $Translation;

        my $Key = $String;
        $Key =~ s/'/\\'/g;
        if ($IsSubTranslation) {
            if ( length($Key) < $BreakLineAfterChars ) {
                $Data .= $Indent . "\$Self->{Translation}->{'$Key'} = '$Translation';\n";
            }
            else {
                $Data .= $Indent . "\$Self->{Translation}->{'$Key'} =\n";
                $Data .= $Indent . '    ' . "'$Translation';\n";
            }
        }
        else {
            if ( length($Key) < $BreakLineAfterChars ) {
                $Data .= $Indent . "'$Key' => '$Translation',\n";
            }
            else {
                $Data .= $Indent . "'$Key' =>\n";
                $Data .= $Indent . '    ' . "'$Translation',\n";
            }
        }
    }

    # add misc words
    if ( $Param{Verbose} ) {
        print "Obsolete Entries\n\n";
    }
    $Data .= "\n";
    $Data .= $Indent . "#\n";
    $Data .= $Indent . "# OBSOLETE ENTRIES FOR REFERENCE, DO NOT TRANSLATE!\n";
    $Data .= $Indent . "#\n";

    if ( !$PurgeObsolete ) {
        KEY:
        for my $Key ( sort keys %{ $LanguageObject->{Translation} } ) {

            # ignore words from the core if we are translating a module
            next KEY if $IsSubTranslation && exists $LanguageCoreObject->{Translation}->{$Key};

            # ignore word if already used
            next KEY if $UsedWordsMisc{$Key};

            my $Translation = $LanguageObject->{Translation}->{$Key};
            $Translation =~ s/'/\\'/g;
            $Key =~ s/'/\\'/g;

            # if a string was previously in a TT file, but has not yet been translated,
            # there's no need to preserve it in the translation file.
            next KEY if !$Translation;

            # TODO: clarify if regular expression check is still needed
            # in the past it was used to guard against wrong matches
            next KEY if $Key =~ /(a href|\$(Text|Quote)\{")/i;

            if ($IsSubTranslation) {
                if ( length($Key) < $BreakLineAfterChars ) {
                    $Data .= $Indent . "\$Self->{Translation}->{'$Key'} = '$Translation';\n";
                }
                else {
                    $Data .= $Indent . "\$Self->{Translation}->{'$Key'} =\n";
                    $Data .= $Indent . '    ' . "'$Translation';\n";
                }
            }
            else {
                if ( length($Key) < $BreakLineAfterChars ) {
                    $Data .= $Indent . "'$Key' => '$Translation',\n";
                }
                else {
                    $Data .= $Indent . "'$Key' =>\n";
                    $Data .= $Indent . '    ' . "'$Translation',\n";
                }
            }
        }
    }

    # open old translation file
    my %MetaData;
    my $NewOut = '';

    # translating a module
    if ($IsSubTranslation) {

        # needed for cvs check-in filter
        my $Separator = "# --";

        $NewOut = <<"EOF";
$Separator
# Kernel/Language/${Language}_$Module.pm - translation file
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
$Separator
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
$Separator

package Kernel::Language::${Language}_$Module;

use strict;
use warnings;
use utf8;

sub Data {
    my \$Self = shift;
$Data
}

1;
EOF
    }

    # translating the core
    else {
        open( my $In, '<', $LanguageFile ) || die "Can't open: $LanguageFile\n";    ## no critic
        while (<$In>) {
            if ( !$MetaData{DataPrinted} ) {
                $NewOut .= $_;
            }
            if ( $_ =~ /\$\$START\$\$/ && !$MetaData{DataPrinted} ) {
                $MetaData{DataPrinted} = 1;

                $NewOut .= "    # possible charsets\n";
                $NewOut .= "    \$Self->{Charset} = [";
                for ( $LanguageCoreObject->GetPossibleCharsets() ) {
                    $NewOut .= "'$_', ";
                }
                $NewOut .= "];\n";
                $NewOut .= <<"EOF";
    # date formats (\%A=WeekDay;\%B=LongMonth;\%T=Time;\%D=Day;\%M=Month;\%Y=Year;)
    \$Self->{DateFormat}          = '$LanguageCoreObject->{DateFormat}';
    \$Self->{DateFormatLong}      = '$LanguageCoreObject->{DateFormatLong}';
    \$Self->{DateFormatShort}     = '$LanguageCoreObject->{DateFormatShort}';
    \$Self->{DateInputFormat}     = '$LanguageCoreObject->{DateInputFormat}';
    \$Self->{DateInputFormatLong} = '$LanguageCoreObject->{DateInputFormatLong}';

    # csv separator
    \$Self->{Separator} = '$LanguageCoreObject->{Separator}';

EOF

                if ( $LanguageCoreObject->{TextDirection} ) {
                    $NewOut .= <<"EOF";
    # TextDirection rtl or ltr
    \$Self->{TextDirection} = '$LanguageCoreObject->{TextDirection}';

EOF
                }
                $NewOut .= <<"EOF";
    \$Self->{Translation} = {
$Data
EOF
            }
            if ( $_ =~ /\$\$STOP\$\$/ ) {
                $NewOut .= "    };\n";
                $NewOut .= "$_";
                $MetaData{DataPrinted} = 0;
            }
        }
        close $In;
    }

    if ( -e $TargetFile ) {
        if ( $Param{Verbose} ) {
            print "Moving $TargetFile to $TargetFile.old\n";
        }
        rename( $TargetFile, "$TargetFile.old" ) || die $!;
    }

    if ( $Param{Verbose} ) {
        print "Writing $TargetFile\n";
    }

    $CommonObject{MainObject}->FileWrite(
        Location => $TargetFile,
        Content  => \$NewOut,
        Mode     => 'utf8',        # binmode|utf8
    );
}

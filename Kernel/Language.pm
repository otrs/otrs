# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language;

use strict;
use warnings;

use vars qw(@ISA);

use Exporter qw(import);
our @EXPORT_OK = qw(Translatable);    ## no critic

use File::stat;
use Digest::MD5;

use Kernel::System::DateTime qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::Main',
);

=head1 NAME

Kernel::Language - global language interface

=head1 DESCRIPTION

All language functions.

=head1 PUBLIC INTERFACE


=head2 new()

create a language object. Do not use it directly, instead use:

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new(
        'Kernel::Language' => {
            UserLanguage => 'de',
        },
    );
    my $LanguageObject = $Kernel::OM->Get('Kernel::Language');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # 0=off; 1=on; 2=get all not translated words; 3=get all requests
    $Self->{Debug} = 0;

    # get needed object
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $MainObject   = $Kernel::OM->Get('Kernel::System::Main');

    # check if LanguageDebug is configured
    if ( $ConfigObject->Get('LanguageDebug') ) {
        $Self->{LanguageDebug} = 1;
    }

    # user language
    $Self->{UserLanguage} = $Param{UserLanguage}
        || $ConfigObject->Get('DefaultLanguage')
        || 'en';

    # check if language is configured
    my %Languages = %{ $ConfigObject->Get('DefaultUsedLanguages') };
    if ( !$Languages{ $Self->{UserLanguage} } ) {
        $Self->{UserLanguage} = 'en';
    }

    # take time zone
    $Self->{TimeZone} = $Param{UserTimeZone} || $Param{TimeZone} || OTRSTimeZoneGet();

    # Debug
    if ( $Self->{Debug} > 0 ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'Debug',
            Message  => "UserLanguage = $Self->{UserLanguage}",
        );
    }

    # load text catalog ...
    if ( !$MainObject->Require("Kernel::Language::$Self->{UserLanguage}") ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'Error',
            Message  => "Sorry, can't locate or load Kernel::Language::$Self->{UserLanguage} "
                . "translation! Check the Kernel/Language/$Self->{UserLanguage}.pm (perl -cw)!",
        );
    }

    # add module to ISA
    @ISA = ("Kernel::Language::$Self->{UserLanguage}");

    # execute translation map
    if ( eval { $Self->Data() } ) {

        # debug info
        if ( $Self->{Debug} > 0 ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'Debug',
                Message  => "Kernel::Language::$Self->{UserLanguage} load ... done.",
            );
        }
    }

    # load action text catalog ...
    my $CustomTranslationModule = '';

    # do not include addition translation files, a new translation file gets created
    if ( !$Param{TranslationFile} ) {

        # looking to addition translation files
        my $Home  = $ConfigObject->Get('Home') . '/';
        my @Files = $MainObject->DirectoryRead(
            Directory => $Home . "Kernel/Language/",
            Filter    => "$Self->{UserLanguage}_*.pm",
        );
        FILE:
        for my $File (@Files) {

            # get module name based on file name
            $File =~ s/^$Home(.*)\.pm$/$1/g;
            $File =~ s/\/\//\//g;
            $File =~ s/\//::/g;

            # ignore language translation files like (en_GB, en_CA, ...)
            next FILE if $File =~ /.._..$/;

            # remember custom files to load at least
            if ( $File =~ /_Custom$/ ) {
                $CustomTranslationModule = $File;
                next FILE;
            }

            # load translation module
            if ( !$MainObject->Require($File) ) {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'Error',
                    Message  => "Sorry, can't load $File! " . "Check the $File (perl -cw)!",
                );
                next FILE;
            }

            # add module to ISA
            @ISA = ($File);

            # execute translation map
            if ( eval { $Self->Data() } ) {

                # debug info
                if ( $Self->{Debug} > 0 ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'Debug',
                        Message  => "$File load ... done.",
                    );
                }
            }
        }

        # load custom text catalog ...
        if ( $CustomTranslationModule && $MainObject->Require($CustomTranslationModule) ) {

            # add module to ISA
            @ISA = ($CustomTranslationModule);

            # execute translation map
            if ( eval { $Self->Data() } ) {

                # debug info
                if ( $Self->{Debug} > 0 ) {
                    $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'Debug',
                        Message  => "Kernel::Language::$Self->{UserLanguage}_Custom load ... done.",
                    );
                }
            }
        }
    }

    # if no return charset is given, use recommended return charset
    if ( !$Self->{ReturnCharset} ) {
        $Self->{ReturnCharset} = $Self->GetRecommendedCharset();
    }

    # get source file charset
    # what charset should I use (take it from translation file)!
    if ( $Self->{Charset} && ref $Self->{Charset} eq 'ARRAY' ) {
        $Self->{TranslationCharset} = $Self->{Charset}->[-1];
    }

    return $Self;
}

=head2 Translatable()

this is a no-op to mark a text as translatable in the Perl code.

=cut

sub Translatable {
    return shift;
}

=head2 Translate()

translate a text with placeholders.

        my $Text = $LanguageObject->Translate('Hello %s!', 'world');

=cut

sub Translate {
    my ( $Self, $Text, @Parameters ) = @_;

    $Text //= '';

    $Text = $Self->{Translation}->{$Text} || $Text;

    return $Text if !@Parameters;

    for ( 0 .. $#Parameters ) {
        return $Text if !defined $Parameters[$_];
        $Text =~ s/\%(s|d)/$Parameters[$_]/;
    }

    return $Text;
}

=head2 FormatTimeString()

formats a timestamp according to the specified date format for the current
language (locale).

    my $Date = $LanguageObject->FormatTimeString(
        '2009-12-12 12:12:12',  # timestamp
        'DateFormat',           # which date format to use, e. g. DateFormatLong
        0,                      # optional, hides the seconds from the time output
    );

Please note that the TimeZone will not be applied in the case of DateFormatShort (date only)
to avoid switching to another date.

If you only pass an ISO date ('2009-12-12'), it will be returned unchanged.
Invalid strings will also be returned with an error logged.

=cut

sub FormatTimeString {
    my ( $Self, $String, $Config, $Short ) = @_;

    return '' if !$String;

    $Config ||= 'DateFormat';
    $Short  ||= 0;

    # Valid timestamp
    if ( $String =~ /(\d{4})-(\d{2})-(\d{2})\s(\d{2}):(\d{2}):(\d{2})/ ) {
        my $ReturnString = $Self->{$Config} || "$Config needs to be translated!";

        my $DateTimeObject = $Kernel::OM->Create(
            'Kernel::System::DateTime',
            ObjectParams => {
                String => $String,
            },
        );

        if ( !$DateTimeObject ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Invalid date/time string $String.",
            );

            return $String;
        }

        # Convert to time zone, but only if we actually display the time!
        # Otherwise the date might be off by one day because of the TimeZone diff.
        if ( $Self->{TimeZone} && $Config ne 'DateFormatShort' ) {
            $DateTimeObject->ToTimeZone( TimeZone => $Self->{TimeZone} );
        }

        my $DateTimeValues = $DateTimeObject->Get();

        my $Year      = $DateTimeValues->{Year};
        my $Month     = sprintf "%02d", $DateTimeValues->{Month};
        my $MonthAbbr = $DateTimeValues->{MonthAbbr};
        my $Day       = sprintf "%02d", $DateTimeValues->{Day};
        my $DayAbbr   = $DateTimeValues->{DayAbbr};
        my $Hour      = sprintf "%02d", $DateTimeValues->{Hour};
        my $Minute    = sprintf "%02d", $DateTimeValues->{Minute};
        my $Second    = sprintf "%02d", $DateTimeValues->{Second};

        if ($Short) {
            $ReturnString =~ s/\%T/$Hour:$Minute/g;
        }
        else {
            $ReturnString =~ s/\%T/$Hour:$Minute:$Second/g;
        }
        $ReturnString =~ s/\%D/$Day/g;
        $ReturnString =~ s/\%M/$Month/g;
        $ReturnString =~ s/\%Y/$Year/g;

        $ReturnString =~ s{(\%A)}{$Self->Translate($DayAbbr);}egx;
        $ReturnString
            =~ s{(\%B)}{$Self->Translate($MonthAbbr);}egx;

        # output time zone only if it differs from OTRS' time zone
        if (
            $Config ne 'DateFormatShort'
            && $Self->{TimeZone}
            && $Self->{TimeZone} ne OTRSTimeZoneGet()
            )
        {
            return $ReturnString . " ($Self->{TimeZone})";
        }

        return $ReturnString;
    }

    # Invalid string passed? (don't log for ISO dates)
    if ( $String !~ /^(\d{2}:\d{2}:\d{2})$/ ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => "No FormatTimeString() translation found for '$String' string!",
        );
    }

    return $String;

}

=head2 GetRecommendedCharset()

DEPRECATED. Don't use this function any more, 'utf-8' is always the internal charset.

Returns the recommended charset for frontend (based on translation
file or utf-8).

    my $Charset = $LanguageObject->GetRecommendedCharset().

=cut

sub GetRecommendedCharset {
    my $Self = shift;

    return 'utf-8';
}

=head2 GetPossibleCharsets()

Returns an array of possible charsets (based on translation file).

    my @Charsets = $LanguageObject->GetPossibleCharsets().

=cut

sub GetPossibleCharsets {
    my $Self = shift;

    return @{ $Self->{Charset} } if $Self->{Charset};
    return;
}

=head2 Time()

Returns a time string in language format (based on translation file).

    $Time = $LanguageObject->Time(
        Action => 'GET',
        Format => 'DateFormat',
    );

    $TimeLong = $LanguageObject->Time(
        Action => 'GET',
        Format => 'DateFormatLong',
    );

    $TimeLong = $LanguageObject->Time(
        Action => 'RETURN',
        Format => 'DateFormatLong',
        Year   => 1977,
        Month  => 10,
        Day    => 27,
        Hour   => 20,
        Minute => 10,
        Second => 05,
    );

These tags are supported: %A=WeekDay;%B=LongMonth;%T=Time;%D=Day;%M=Month;%Y=Year;

Note that %A only works correctly with Action GET, it might be dropped otherwise.

Also note that it is also possible to pass HTML strings for date input:

    $TimeLong = $LanguageObject->Time(
        Action => 'RETURN',
        Format => 'DateInputFormatLong',
        Mode   => 'NotNumeric',
        Year   => '<input value="2014"/>',
        Month  => '<input value="1"/>',
        Day    => '<input value="10"/>',
        Hour   => '<input value="11"/>',
        Minute => '<input value="12"/>',
        Second => '<input value="13"/>',
    );

Note that %B may not work in NonNumeric mode.

=cut

sub Time {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Action Format)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $_!",
            );
            return;
        }
    }
    my $ReturnString = $Self->{ $Param{Format} } || 'Need to be translated!';
    my ( $Year, $Month, $MonthAbbr, $Day, $DayAbbr, $Hour, $Minute, $Second );

    # set or get time
    if ( lc $Param{Action} eq 'get' ) {

        my $DateTimeObject = $Kernel::OM->Create(
            'Kernel::System::DateTime',
            ObjectParams => {
                TimeZone => $Self->{TimeZone},
            },
        );
        my $DateTimeValues = $DateTimeObject->Get();

        $Year      = $DateTimeValues->{Year};
        $Month     = sprintf "%02d", $DateTimeValues->{Month};
        $MonthAbbr = $DateTimeValues->{MonthAbbr};
        $Day       = sprintf "%02d", $DateTimeValues->{Day};
        $DayAbbr   = $DateTimeValues->{DayAbbr};
        $Hour      = sprintf "%02d", $DateTimeValues->{Hour};
        $Minute    = sprintf "%02d", $DateTimeValues->{Minute};
        $Second    = sprintf "%02d", $DateTimeValues->{Second};
    }
    elsif ( lc $Param{Action} eq 'return' ) {
        $Year   = $Param{Year}   || 0;
        $Month  = $Param{Month}  || 0;
        $Day    = $Param{Day}    || 0;
        $Hour   = $Param{Hour}   || 0;
        $Minute = $Param{Minute} || 0;
        $Second = $Param{Second} || 0;

        my @MonthAbbrs = qw/Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec/;
        $MonthAbbr = defined $Month && $Month =~ m/^\d+$/ ? $MonthAbbrs[ $Month - 1 ] : '';
    }

    # do replace
    if ( ( lc $Param{Action} eq 'get' ) || ( lc $Param{Action} eq 'return' ) ) {
        my $Time = '';
        if ( $Param{Mode} && $Param{Mode} =~ /^NotNumeric$/i ) {
            if ( !$Second ) {
                $Time = "$Hour:$Minute";
            }
            else {
                $Time = "$Hour:$Minute:$Second";
            }
        }
        else {
            $Time  = sprintf( "%02d:%02d:%02d", $Hour, $Minute, $Second );
            $Day   = sprintf( "%02d",           $Day );
            $Month = sprintf( "%02d",           $Month );
        }
        $ReturnString =~ s/\%T/$Time/g;
        $ReturnString =~ s/\%D/$Day/g;
        $ReturnString =~ s/\%M/$Month/g;
        $ReturnString =~ s/\%Y/$Year/g;
        $ReturnString =~ s{(\%A)}{defined $DayAbbr ? $Self->Translate($DayAbbr) : '';}egx;
        $ReturnString
            =~ s{(\%B)}{defined $MonthAbbr ? $Self->Translate($MonthAbbr) : '';}egx;
        return $ReturnString;
    }

    return $ReturnString;
}

=head2 LanguageChecksum()

This function returns an MD5 sum that is generated from all loaded language files and their modification timestamps.
Whenever a file is changed, added or removed, this checksum will change.

=cut

sub LanguageChecksum {
    my $Self = shift;

    my $Home = $Kernel::OM->Get('Kernel::Config')->Get('Home');

    my @Files;
    for my $Class (@ISA) {
        my $File = "$Home/$Class.pm";
        $File =~ s{::}{/}smxg;
        push @Files, $File;
    }

    # Create a string with filenames and file mtimes of the config files
    my $LanguageString;
    for my $File (@Files) {

        # get file metadata
        my $Stat = stat($File);

        if ( !$Stat ) {
            print STDERR "Error: cannot stat file '$File': $!";
            return;
        }

        $LanguageString .= $File . $Stat->mtime();
    }

    return Digest::MD5::md5_hex($LanguageString);
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

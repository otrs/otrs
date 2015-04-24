# --
# JSUnitTest.t - frontend tests that collect the JavaScript unit test results
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

use Time::HiRes qw(sleep);

use Kernel::System::UnitTest::Selenium;

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');

my $Selenium = Kernel::System::UnitTest::Selenium->new(
    Verbose => 1,
);

$Selenium->RunTest(
    sub {

        my $WebPath = $ConfigObject->Get('Frontend::WebPath');

        my @Files = $Kernel::OM->Get('Kernel::System::Main')->DirectoryRead(
            Directory => $Kernel::OM->Get('Kernel::Config')->Get('Home') . '/var/httpd/htdocs/js/test',
            Filter    => "*.html",
        );

        for my $File (@Files) {

            # Remove path
            $File =~ s{.*/}{}smx;

            $Selenium->get("${WebPath}js/test/$File");

            # wait for the javascript tests (including AJAX) to complete
            ACTIVESLEEP:
            for ( 1 .. 20 ) {

                if ( eval { $Selenium->find_element( "p.result span.failed", 'css' ); } ) {
                    last ACTIVESLEEP;
                }

                sleep(1);
            }

            $Selenium->find_element( "p.result span.failed", 'css' );
            $Selenium->find_element( "p.result span.passed", 'css' );
            $Selenium->find_element( "p.result span.total",  'css' );

            my ( $Passed, $Failed, $Total );
            $Passed = $Selenium->execute_script(
                "return \$('p.result span.passed').text()"
            );
            $Failed = $Selenium->execute_script(
                "return \$('p.result span.failed').text()"
            );
            $Total = $Selenium->execute_script(
                "return \$('p.result span.total').text()"
            );

            $Self->True( $Passed, "$File - found passed tests" );
            $Self->Is( $Passed, $Total, "$File - total number of tests" );
            $Self->False( $Failed, "$File - failed tests" );
        }

    }
);

1;

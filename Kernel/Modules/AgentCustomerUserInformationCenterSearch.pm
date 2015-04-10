# --
# Kernel/Modules/AgentCustomerUserInformationCenterSearch.pm - customer user information
# Copyright (C) 2001-2015 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentCustomerUserInformationCenterSearch;
## nofilter(TidyAll::Plugin::OTRS::Perl::DBObject)

use strict;
use warnings;

use Kernel::System::CustomerUser;
use Kernel::System::CustomerCompany;
use Kernel::System::VariableCheck qw(:all);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # check needed objects
    for (qw(ParamObject DBObject LayoutObject LogObject ConfigObject MainObject EncodeObject)) {
        if ( !$Self->{$_} ) {
            $Self->{LayoutObject}->FatalError( Message => "Got no $_!" );
        }
    }

    $Self->{CustomerUserObject}    = Kernel::System::CustomerUser->new(%Param);
    $Self->{CustomerCompanyObject} = Kernel::System::CustomerCompany->new(%Param);

    $Self->{SlaveDBObject}     = $Self->{DBObject};
    $Self->{SlaveTicketObject} = $Self->{TicketObject};

    # use a slave db to search dashboard date
    if ( $Self->{ConfigObject}->Get('Core::MirrorDB::DSN') ) {

        $Self->{SlaveDBObject} = Kernel::System::DB->new(
            LogObject    => $Param{LogObject},
            ConfigObject => $Param{ConfigObject},
            MainObject   => $Param{MainObject},
            EncodeObject => $Param{EncodeObject},
            DatabaseDSN  => $Self->{ConfigObject}->Get('Core::MirrorDB::DSN'),
            DatabaseUser => $Self->{ConfigObject}->Get('Core::MirrorDB::User'),
            DatabasePw   => $Self->{ConfigObject}->Get('Core::MirrorDB::Password'),
        );

        if ( $Self->{SlaveDBObject} ) {

            $Self->{SlaveTicketObject} = Kernel::System::Ticket->new(
                %Param,
                DBObject => $Self->{SlaveDBObject},
            );
        }
    }

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my $AutoCompleteConfig = $Self->{ConfigObject}->Get('AutoComplete::Agent###CustomerSearch');

    my $MaxResults = $AutoCompleteConfig->{MaxResultsDisplayed} || 20;

    if ( $Self->{Subaction} eq 'SearchCustomerID' ) {

        my %CustomerList = $Self->{CustomerUserObject}->CustomerSearch(
            CustomerID => $Self->{ParamObject}->GetParam( Param => 'Term' ) || '',
        );

        my @Result;

        my $Count = 1;

        CUSTOMERLOGIN:
        for my $CustomerLogin ( sort keys %CustomerList ) {
            my %CustomerData = $Self->{CustomerUserObject}->CustomerUserDataGet(
                User => $CustomerLogin,
            );
            push @Result,
                {
                Label => $CustomerData{UserCustomerID} . " ($CustomerList{$CustomerLogin})",
                Value => $CustomerData{UserLogin}
                };

            last CUSTOMERLOGIN if $Count++ >= $MaxResults;
        }

        my $JSON = $Self->{LayoutObject}->JSONEncode(
            Data => \@Result,
        );

        return $Self->{LayoutObject}->Attachment(
            ContentType => 'application/json; charset=' . $Self->{LayoutObject}->{Charset},
            Content     => $JSON || '',
            Type        => 'inline',
            NoCache     => 1,
        );
    }
    elsif ( $Self->{Subaction} eq 'SearchCustomerUser' ) {

        my %CustomerList = $Self->{CustomerUserObject}->CustomerSearch(
            Search => $Self->{ParamObject}->GetParam( Param => 'Term' ) || '',
        );

        my @Result;

        my $Count = 1;

        CUSTOMERLOGIN:
        for my $CustomerLogin ( sort keys %CustomerList ) {
            my %CustomerData = $Self->{CustomerUserObject}->CustomerUserDataGet(
                User => $CustomerLogin,
            );
            push @Result,
                {
                Label => $CustomerList{$CustomerLogin},
                Value => $CustomerData{UserLogin}
                };

            last CUSTOMERLOGIN if $Count++ >= $MaxResults;
        }

        my $JSON = $Self->{LayoutObject}->JSONEncode(
            Data => \@Result,
        );

        return $Self->{LayoutObject}->Attachment(
            ContentType => 'application/json; charset=' . $Self->{LayoutObject}->{Charset},
            Content     => $JSON || '',
            Type        => 'inline',
            NoCache     => 1,
        );
    }

    my $Output .= $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentCustomerUserInformationCenterSearch',
        Data         => \%Param,
    );
    return $Self->{LayoutObject}->Attachment(
        NoCache     => 1,
        ContentType => 'text/html',
        Charset     => $Self->{LayoutObject}->{UserCharset},
        Content     => $Output || '',
        Type        => 'inline',
    );
}

1;

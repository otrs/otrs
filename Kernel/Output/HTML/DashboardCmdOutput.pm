# --
# Kernel/Output/HTML/AgentDashboardCmdOutput.dtl
# Copyright (C) 2014 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Output::HTML::DashboardCmdOutput;

use strict;
use warnings;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    # get needed objects
    for (
        qw(Config Name ConfigObject LogObject DBObject LayoutObject ParamObject TicketObject UserID EncodeObject)
        )
    {
        die "Got no $_!" if ( !$Self->{$_} );
    }

    return $Self;
}

sub Preferences {
    my ( $Self, %Param ) = @_;

    return;
}

sub Config {
    my ( $Self, %Param ) = @_;

    return (
        %{ $Self->{Config} }
    );
}

sub Run {
    my ( $Self, %Param ) = @_;

    # command to run
    my $Cmd = $Self->{Config}->{Cmd};

    my $CmdOutput = qx{$Cmd 2>&1};

    $Self->{EncodeObject}->EncodeInput( \$CmdOutput );

    my $Content = $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentDashboardCmdOutput',
        Data         => {
            CmdOutput => $CmdOutput,
            %{ $Self->{Config} },
        },
    );

    return $Content;
}

1;

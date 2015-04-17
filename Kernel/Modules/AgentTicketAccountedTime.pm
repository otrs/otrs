# --
# Kernel/Modules/AgentTicketAccountedTime.pm - agent accounted time module
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentTicketAccountedTime;

use strict;
use warnings;

sub new {
	my ( $Type, %Param ) = @_;

	# allocate new hash for object
	my $Self = {%Param};
	bless( $Self, $Type );

	# check needed objects
	for my $Needed (
            qw(ParamObject DBObject TicketObject LayoutObject LogObject QueueObject ConfigObject UserObject MainObject)
        )	{
		if ( !$Self->{$Needed} ) {
			$Self->{LayoutObject}->FatalError( Message => "Got no $Needed!" );
		}
	}

	$Self->{TicketID} = $Self->{ParamObject}->GetParam( Param => 'TicketID' ) || '';

	return $Self;
}

sub Run {
	my ( $Self, %Param ) = @_;

	# check needed stuff
	for my $Needed (qw(TicketID)) {
		if ( !defined $Self->{$Needed} ) {
			return $Self->{LayoutObject}->ErrorScreen(
				Message => "AgentTicketAccountedTime.pm - $Needed is needed!",
				Comment => 'Please contact your administrator',
			);
		}
	}
    
    # check permissions
    my $Access = $Self->{TicketObject}->TicketPermission(
        Type     => 'ro',
        TicketID => $Self->{TicketID},
        UserID   => $Self->{UserID},
    );

    # error screen, don't show ticket
    if ( !$Access ) {
        return $Self->{LayoutObject}->NoPermission( WithHeader => 'yes' );
    }
    
    # get ticket data
    my %Ticket = $Self->{TicketObject}->TicketGet(
        TicketID      => $Self->{TicketID},
    );

    unless ( $Self->{ConfigObject}->Get('Ticket::Frontend::AccountTime') &&
         $Self->{ConfigObject}->Get('Ticket::Frontend::AgentAccountedTime') ) {
         return $Self->{LayoutObject}->ErrorScreen(
				Message => 'Time accounting has been disabled!',
				Comment => 'Please turn it on before using this panel (look for Ticket::Frontend::AccountTime'
                         . 'and Ticket::Frontend::AgentAccountedTime in SysConfig).',
			);
    }
    
    # check if we have some time accounted
    $Ticket{TotalAccountedTime} = $Self->{TicketObject}->TicketAccountedTimeGet(%Ticket);
    
    if ( $Ticket{TotalAccountedTime} ) {
    
        # show the table
        $Self->{LayoutObject}->Block(
            Name => 'AgentAccountedTimeTable',
            Data => \%Ticket,
        );
    
        # db query
        return if !$Self->{DBObject}->Prepare(
            SQL  => 'SELECT users.id, users.first_name, users.last_name, '
                  . 'user_preferences.preferences_value as user_email, '
                  . 'COUNT(time_accounting.article_id) AS article_number, '
                  . 'SUM(time_accounting.time_unit) AS accounted_time, time_accounting.create_time FROM users '
                  . 'JOIN user_preferences ON user_preferences.user_id=users.id AND user_preferences.preferences_key="UserEmail" '
                  . 'JOIN time_accounting ON time_accounting.create_by=users.id AND time_accounting.ticket_id=? '
                  . 'GROUP BY users.id',
            Bind => [ \$Ticket{TicketID} ],
        );
        
        while ( my @Row = $Self->{DBObject}->FetchrowArray() ) {
            
            # get rid of trailing zeroes
            $Row[5] =~ s/\.00//;
            
            # output row
            $Self->{LayoutObject}->Block(
                Name => 'AgentAccountedTimeRow',
                Data => {
                    UserID        => $Row[0],
                    Name          => $Row[1] . ' ' . $Row[2],
                    Email         => $Row[3],
                    ArticleNumber => $Row[4],
                    AccountedTime => $Row[5],
                    CreateTime    => $Row[6],
                    AccountedTimeHours => int ( $Row[5] / 60 ),
                    AccountedTimeMinutes => $Row[5] % 60,
                },
            );
                    
        }
        
    } else {

        # output empty message
        $Self->{LayoutObject}->Block(
            Name => 'AgentAccountedTimeEmpty',
        );
        
    }
    
    # output header
    my $Output = $Self->{LayoutObject}->Header(
        Type      => 'Small',
        BodyClass => 'Popup',
    );
    
    # output template
    $Output .= $Self->{LayoutObject}->Output(
        TemplateFile => 'AgentTicketAccountedTime',
        Data         => \%Ticket,
    );

    # output footer
    $Output .= $Self->{LayoutObject}->Footer( Type => 'Small', );

    return $Output;

}

1;

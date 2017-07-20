# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Modules::AgentTicketProcessTrace;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(:all);

our $ObjectManagerDisabled = 1;

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    # get layout object
    my $LayoutObject = $Kernel::OM->Get('Kernel::Output::HTML::Layout');

    # check needed stuff
    if ( !$Self->{TicketID} ) {

        # error page
        return $LayoutObject->ErrorScreen(
            Message => 'Can\'t show history, no TicketID is given!',
            Comment => 'Please contact the admin.',
        );
    }

    #get ticket object
    my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

    # check permissions
    if (
        !$TicketObject->TicketPermission(
            Type     => 'ro',
            TicketID => $Self->{TicketID},
            UserID   => $Self->{UserID},
        )
        )
    {

        # error screen, don't show ticket
        return $LayoutObject->NoPermission( WithHeader => 'yes' );
    }

    # get ACL restrictions
    my %PossibleActions = ( 1 => $Self->{Action} );

    my $ACL = $TicketObject->TicketAcl(
        Data          => \%PossibleActions,
        Action        => $Self->{Action},
        TicketID      => $Self->{TicketID},
        ReturnType    => 'Action',
        ReturnSubType => '-',
        UserID        => $Self->{UserID},
    );
    my %AclAction = $TicketObject->TicketAclActionData();

    # check if ACL restrictions exist
    if ( $ACL || IsHashRefWithData( \%AclAction ) ) {

        my %AclActionLookup = reverse %AclAction;

        # show error screen if ACL prohibits this action
        if ( !$AclActionLookup{ $Self->{Action} } ) {
            return $LayoutObject->NoPermission( WithHeader => 'yes' );
        }
    }

    my %Ticket = $TicketObject->TicketGet( TicketID => $Self->{TicketID} );

    my @Lines = $TicketObject->HistoryGet(
        TicketID => $Self->{TicketID},
        UserID   => $Self->{UserID},
    );

    my $TicketNumber = $TicketObject->TicketNumberLookup( TicketID => $Self->{TicketID} );

    # get shown user info
    if ( $Kernel::OM->Get('Kernel::Config')->Get('Ticket::Frontend::HistoryOrder') eq 'reverse' ) {
        @Lines = reverse(@Lines);
    }

    # get mapping of history types to readable strings
    my %HistoryTypes;
    my %HistoryTypeConfig = %{ $Kernel::OM->Get('Kernel::Config')->Get('Ticket::Frontend::HistoryTypes') // {} };
    for my $Entry ( sort keys %HistoryTypeConfig ) {
        %HistoryTypes = (
            %HistoryTypes,
            %{ $HistoryTypeConfig{$Entry} },
        );
    }

    # get activity object
    my $ActivityObject = $Kernel::OM->Get('Kernel::System::ProcessManagement::Activity');
    my $ActivityData;
    my @ProcessHistory;
    my $Variable = 0;
    my $TicketIDRecord;
    for my $Data ( @Lines ) {

        # replace text
        if ( $Data->{Name} && $Data->{Name} =~ m/^%%/x ) {

            $Data->{Name} =~ s/^%%//xg;

            # split activity name
            my @Values = split( /%%/x, $Data->{Name} );

            # check  Activity  process  or not
            if ( 
                 $Values[1] &&
                ($Values[1] eq "ProcessManagementActivityID") && 
                ($Data->{HistoryType} eq 'TicketDynamicFieldUpdate')
                )
            {
                # check history records , choose the record which oldValue is undefine, that means the first record. 
                if ( !$Values[5] ) {

                    my %ProcessInformation;

                    # get activity from activity_id
                    $ActivityData = $ActivityObject->ActivityGet(
                        Interface        => 'AgentInterface',
                        ActivityEntityID => $Values[3],
                    );

                    # check owner of ticket , if owner's name is null ,just instead of process user.
                    $ProcessInformation{Operator}     = $Data->{UserFullname};
                    $ProcessInformation{StartTime}    = $Data->{CreateTime};
                    $ProcessInformation{ActivityName} = $ActivityData->{Name};
                    push @ProcessHistory, \%ProcessInformation;
                }
                else {

                    my %ProcessInformation;

                    # activity data
                    $ActivityData = $ActivityObject->ActivityGet(        
                        Interface        => 'AgentInterface',       
                        ActivityEntityID => $Values[3],    
                    );

                    my $OldActivityData = $ActivityObject->ActivityGet(        
                        Interface        => 'AgentInterface',       
                        ActivityEntityID => $Values[5],    
                    );

                    # the first record
                    if ( $Variable == 0 ) {
                        $ProcessHistory[0]{EndTime}    = $Data->{CreateTime};
                        $ProcessHistory[0]{Circulation} = $ProcessHistory[0]{ActivityName}."--->".$ActivityData->{Name};
                    }
                    else {

                        # the other records
                        $ProcessInformation{Operator}     = $Data->{UserFullname};
                        $ProcessInformation{StartTime}    = $ProcessHistory[$Variable-1]{EndTime};
                        $ProcessInformation{ActivityName} = $OldActivityData->{Name};
                        $ProcessInformation{EndTime}      = $Data->{CreateTime};
                        $ProcessInformation{Circulation}  = $OldActivityData->{Name}."--->".$ActivityData->{Name};
                        push @ProcessHistory, \%ProcessInformation;
                    }

                    # consume time
                    my $ProcessUpdateStartTime = $Kernel::OM->Get('Kernel::System::Time')->TimeStamp2SystemTime(
                        String => $ProcessHistory[$Variable]{StartTime},
                    );
                    my $ProcessUpdateEndTime = $Kernel::OM->Get('Kernel::System::Time')->TimeStamp2SystemTime(
                        String => $ProcessHistory[$Variable]{EndTime},
                    );

                    if ( $ProcessUpdateEndTime == $ProcessUpdateStartTime ) {
                        $ProcessHistory[$Variable]->{ConsumeTime} = 0;
                    }
                    else {
                        my $SpendTime = $ProcessUpdateEndTime - $ProcessUpdateStartTime;
                        my $ConsumeTime   = $LayoutObject->CustomerAge(
                            Age   => $SpendTime,
                            Space => ' ',
                        );
                        $ProcessHistory[$Variable]{ConsumeTime} = $ConsumeTime;
                    }

                    $Variable++;
                }
            }
        }
    }

    if ( @ProcessHistory ) {
        for my $Real ( @ProcessHistory ){

            $LayoutObject->Block(
                Name => 'Row',
                Data => $Real,
            );
        }
    }

    # build page
    my $Output = $LayoutObject->Header(
        Value => $TicketNumber,
        Type  => 'Small',
    );
    $Output .= $LayoutObject->Output(
        TemplateFile => 'AgentTicketProcessTrace',
        Data         => {
            TicketNumber => $TicketNumber,
            TicketID     => $Self->{TicketID},
            Title        => $Ticket{Title},
        },
    );
    $Output .= $LayoutObject->Footer(
        Type => 'Small',
    );

    return $Output;
}

1;

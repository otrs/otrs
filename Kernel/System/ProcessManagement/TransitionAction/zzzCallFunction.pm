# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --
package Kernel::System::ProcessManagement::TransitionAction::zzzCallFunction;

use strict;
use warnings;
use utf8;

use Kernel::System::VariableCheck qw(:all);

use base qw(Kernel::System::ProcessManagement::TransitionAction::Base);


sub new {
    my ( $Type, %Param ) = @_;
    my $Self = {%Param};
    bless( $Self, $Type );
    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;
	$Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'notice',
            Message  => 'Entering Routine - CallFunction - '. $CommonMessage,
        );
    # define a common message to output in case of any error
    my $CommonMessage = "Process: $Param{ProcessEntityID} Activity: $Param{ActivityEntityID}"
        . " Transition: $Param{TransitionEntityID}"
        . " TransitionAction: $Param{TransitionActionEntityID} - ";
		
	if ( !IsHashRefWithData( $Param{Config} ) ) {
        $Self->{LogObject}->Log(
            Priority => 'error',
            Message  => "Config Error!".$CommonMessage,
        );
        return;
	}

    # override UserID if specified as a parameter in the TA config
    $Param{UserID} = $Self->_OverrideUserID(%Param);
    # use ticket attributes if needed
    $Self->_ReplaceTicketAttributes(%Param);
	my $TicketID	  = $Param{Ticket}->{TicketID};
	my $TicketNr	  = $Param{Ticket}->{TicketNumber};
	my $FunctionName  = $Param{Config}->{FunctionName};
	# first entry is the path that is called
	# ticketnumber and id are standard arguments and always present
	delete $Param{Config}->{FunctionName};
	# to keep things dynamically and name independent 
	# the FunctionName Option is removed from the hash
	# every following option is considered an arguments
	# create one TransitionAction for every os Script you call
	my @arCall = ($FunctionName,$TicketNr,$TicketID);	
	for my $CurrentConfig ( sort keys %{ $Param{Config} } ) {
		push (@arCall, $Param{Config}->{$CurrentConfig});
	}
	# eventually do the os call and check the result
	system("@arCall");	
	my $Message = "Function Executed " .$CommonMessage." "."@arCall";
	if ( $? == -1 )
	{
		$Message = "Error Executing Scirpt - ".$CommonMessage.$!;	  
	}
    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'notice',
        Message  => $Message,
    );		
	return 1;
}

1;

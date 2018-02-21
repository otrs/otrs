# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::CustomerAuth::Google;

use strict;
use warnings;

use REST::Client;

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::Log',
    'Kernel::System::JSON',
);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    # Debug 0=off 1=on
    $Self->{Debug} = 0;

    $Self->{Count} = $Param{Count} || '';

    return $Self;
}

sub GetOption {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    if ( !$Param{What} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "Need What!"
        );
        return;
    }

    # module options
    my %Option = (
        PreAuth => 1,
    );

    # return option
    return $Option{ $Param{What} };
}

sub Auth {
    my ( $Self, %Param ) = @_;

	my $User;	
    my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
    my $ParamObject = $Kernel::OM->Get('Kernel::System::Web::Request');
    	my $JSONObject   = $Kernel::OM->Get('Kernel::System::JSON');
    my $EncodeObject = $Kernel::OM->Get('Kernel::System::Encode');
    
	$Param{idtoken} = $ParamObject->GetParam( 'Param' => 'idtoken' ) || '';	#the token given by javascript google-client
	
	my $url = "https://www.googleapis.com/oauth2/v3/tokeninfo?";	
	my $request = $url."id_token=".$Param{idtoken};
	
	my $config = $ConfigObject->Get('Customer::AuthModule::Google');

	$EncodeObject->EncodeOutput( \$request );

	my $RestClient = REST::Client->new(
        {
            timeout => $config->{authtimeout},
        }
    );
    
    $RestClient->GET($request);
    
    my $ResponseCode = $RestClient->responseCode();
    	
    	if ( $ResponseCode ne 200 )
    	{				
    		$Kernel::OM->Get('Kernel::System::Log')->Log(
        		Priority => 'error',
        		Message  => "no valid response from google.",
    		);
    		return;
    	}
        
    my $ResponseContent = $RestClient->responseContent();
    
    $ResponseContent = $EncodeObject->Convert2CharsetInternal(
        Text => $ResponseContent,
        From => 'utf-8',
    );
    
    my $Result = $JSONObject->Decode(
            Data => $ResponseContent,
        );   
    
    if ( !$Result ) 
    {
    	    $Kernel::OM->Get('Kernel::System::Log')->Log(
        		Priority => 'error',
        		Message  => "no valid response from google.",
    		);       
		return;
    }
        
	if (!$Result->{aud} || $Result->{aud} ne $config->{clientid})
   	{
    		$Kernel::OM->Get('Kernel::System::Log')->Log(
        		Priority => 'error',
        		Message  => "Token is not for our client-id",
    		);
        return;
	}

	my $UserObject    = $Kernel::OM->Get('Kernel::System::CustomerUser');
	my %filter = map {
		$_ => $Result->{ $config->{customerUserMatchMap}->{$_} }
	} keys %{$config->{customerUserMatchMap}};
	
	my $CustomerUserIDsRef = $UserObject->CustomerSearchDetail(
		%filter,
		Result => 'Array'
	);
 
 	if (%{$config->{customerUserMatchPref}})
 	{
	 
		%filter = map {
			$_ => $Result->{ $config->{customerUserMatchPref}->{$_} }
		} keys %{$config->{customerUserMatchPref}};
		
		my %UserList = $UserObject->SearchPreferences(%filter);
		

	    #TODO: filter for unmatched
 	}
 
	if (!@{$CustomerUserIDsRef}) #no user present
	{
		if ($config->{createCustomerUser}) # should it be created
		{
			if ($config->{createCustomerUserMapping} && $config->{createCustomerUserBackend}) #if backend information is present
			{
					my %UserData = map {
										$_ => $Result->{ $config->{createCustomerUserMapping}->{$_} };
										} keys %{$config->{createCustomerUserMapping}}; #generate User defined by mapping
			    		map {
							$UserData{$_} => $config->{createCustomerUserFixData}->{$_};
						} keys %{$config->{createCustomerUserFixData}};	# add fixed data
						
				    my $UserLogin = $UserObject->CustomerUserAdd(
				        Source         => $config->{createCustomerUserBackend}, # CustomerUser source config
				        UserID => 1,
				        ValidID => 1,
						%UserData,
    					);
    					$User = $UserLogin;
				
			} else # no configuration defined
			{
				$Kernel::OM->Get('Kernel::System::Log')->Log(
        				Priority => 'error',
        				Message  => "no configuration for sync found.",
    				);
    				return;
			}
		} else #user should not be created
		{
			$Kernel::OM->Get('Kernel::System::Log')->Log(
        			Priority => 'notice',
        			Message  => "User: $User Authentication ok via Google Auth. but no User in Backend and no sync activated",
    			);
    			return;
		}
	}   
	else		#user found
	{
		if (scalar @{$CustomerUserIDsRef} eq 1) #exactly one found
		{
			$User =  $CustomerUserIDsRef->[0]; #take this
		}
	}     

    # log
    $Kernel::OM->Get('Kernel::System::Log')->Log(
        Priority => 'notice',
        Message  => "User: $User Authentication ok via Google Auth.",
    );

	if ( $config->{updateCustomerUserMapping} )	# check to update User-Data
	{
		my %UserData = $UserObject->CustomerUserDataGet(User => $User);	#get current user-data
		$UserData{ID} = $UserData{UserLogin};	# add anchor
		map {
			$UserData{$_} = $Result->{ $config->{updateCustomerUserMapping}->{$_} };
		} keys %{$config->{updateCustomerUserMapping}};	# change possible new data

	$UserObject->CustomerUserUpdate(%UserData,UserID => 1);
	}

	if ( $config->{updateCustomerUserPref} )	#check to update user-preferences
	{
		map {
			$UserObject->SetPreferences(
				Key => $_,
				Value => $Result->{ $config->{updateCustomerUserPref}->{$_} },
				UserID => $User,
				);
		} keys %{$config->{updateCustomerUserPref}};	# cycle trough configured prefs

	}
    return $User;
}

1;

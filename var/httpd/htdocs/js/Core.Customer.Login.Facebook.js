// --
// Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Customer = Core.Customer || {};
Core.Customer.Login = Core.Customer.Login || {};
/**
 * @namespace Core.Customer.Login.Facebook
 * @memberof Core.Customer.Login
 * @author OTRS AG
 * @description
 *      This namespace contains all functions for the Customer login.
 */
Core.Customer.Login.Facebook = (function (TargetNS) {
    if (!Core.Debug.CheckDependency('Core.Customer.Login.Facebook', 'Core.UI', 'Core.UI')) {
        return false;
    }


    /**
     * @name Init
     * @memberof Core.Customer.Login.Facebook
     * @function
     * @returns {Boolean} False if browser is not supported
     * @description
     *      This function initializes the Facebook-login functions.
     */
    TargetNS.Init = function () {

    	};

    	TargetNS.statusChangeCallback = function (response)
    	{
    		if (response.status == "connected")
    		{
    			  if ( /^.*Action=Logout$/.test(window.location) )
    			  {
//    				  alert("out");
    				  FB.logout(function(response) {
    					  window.location = "customer.pl";
    					  });
    				  
    			  } else
    			  {
    				  var accessToken = response.authResponse.accessToken;
    	 			  var form = document.getElementsByName('login');
    				  var idtokeninput = document.createElement('input');
    				  idtokeninput.id = 'accessToken';
    				  idtokeninput.name = 'accessToken';
    				  idtokeninput.value = accessToken;
    				  idtokeninput.style.display = 'none';
    				  form[0].appendChild(idtokeninput);
    				  if (document.getElementsByClassName('ErrorBox').length == 0)
    				  {
    					  form[0].submit();		
    				  }    			 
    			  }
    		}

    	};
    	
	TargetNS.onSignIn = function () {
		
		FB.getLoginStatus(function(response) {
		    TargetNS.statusChangeCallback(response);
		  });
//		  var profile = FacebookUser.getBasicProfile();
//		  var id_token = FacebookUser.getAuthResponse().id_token;
//
//		  if ( /^.*Action=Logout$/.test(window.location) )
//		  {
//			  var auth_user = window
//		        .gapi
//		        .auth2
//		        .getAuthInstance();
//			  auth_user.signOut();
//
//			  window.location = "customer.pl";
//		  } else
//		  {
// 			  var form = document.getElementsByName('login');
//			  var idtokeninput = document.createElement('input');
//			  idtokeninput.id = 'idtoken';
//			  idtokeninput.name = 'idtoken';
//			  idtokeninput.value = id_token;
//			  idtokeninput.style.display = 'none';
//			  form[0].appendChild(idtokeninput);
//			  if (document.getElementsByClassName('ErrorBox').length == 0)
//			  {
//				  form[0].submit();		
//			  }
//		  }
		  


		}
    
    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Customer.Login.Facebook || {}));
function onCUSignInFacebook() {
	Core.Customer.Login.Facebook.onSignIn();
}
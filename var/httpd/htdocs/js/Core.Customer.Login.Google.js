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
 * @namespace Core.Customer.Login.Google
 * @memberof Core.Customer.Login
 * @author OTRS AG
 * @description
 *      This namespace contains all functions for the Customer login.
 */
Core.Customer.Login.Google = (function (TargetNS) {
    if (!Core.Debug.CheckDependency('Core.Customer.Login.Google', 'Core.UI', 'Core.UI')) {
        return false;
    }


    /**
     * @name Init
     * @memberof Core.Customer.Login.Google
     * @function
     * @returns {Boolean} False if browser is not supported
     * @description
     *      This function initializes the google-login functions.
     */
    TargetNS.Init = function () {

    };

	TargetNS.onSignIn = function (googleUser) {
		  var profile = googleUser.getBasicProfile();
		  var id_token = googleUser.getAuthResponse().id_token;

		  if ( /^.*Action=Logout$/.test(window.location) )
		  {
			  var auth_user = window
		        .gapi
		        .auth2
		        .getAuthInstance();
			  auth_user.signOut();

			  window.location = "customer.pl";
		  } else
		  {
 			  var form = document.getElementsByName('login');
			  var idtokeninput = document.createElement('input');
			  idtokeninput.id = 'idtoken';
			  idtokeninput.name = 'idtoken';
			  idtokeninput.value = id_token;
			  idtokeninput.style.display = 'none';
			  form[0].appendChild(idtokeninput);
			  if (document.getElementsByClassName('ErrorBox').length == 0)
			  {
				  form[0].submit();		
			  }
//	          });
		  }
		  


		}
    
    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Customer.Login.Google || {}));

function onCUSignInGoogle(googleUser) {
	Core.Customer.Login.Google.onSignIn(googleUser);
}
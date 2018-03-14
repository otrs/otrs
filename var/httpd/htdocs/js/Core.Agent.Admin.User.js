// --
// Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Agent = Core.Agent || {};
Core.Agent.Admin = Core.Agent.Admin || {};

/**
 * @namespace Core.Agent.Admin.User
 * @memberof Core.Agent.Admin
 * @author OTRS AG
 * @description
 *      This namespace contains the special module function for User selection.
 */
 Core.Agent.Admin.User = (function (TargetNS) {

    /*
    * @name Init
    * @memberof Core.Agent.Admin.User
    * @function
    * @description
    *      This function initializes filter for inactive agents.
    */
    TargetNS.Init = function () {
    		$('#CheckboxFilterInvalid').change(function () {
    			if($(this).is(":checked")) {
    					$('#User tr.Invalid').addClass('Hidden');
    			} else
    			{
					$('#User tr.Invalid').removeClass('Hidden');
    			}
         });
    		$('#CheckboxFilterInvalid').change();
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Agent.Admin.User || {}));

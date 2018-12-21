// --
// Copyright (C) 2001-2018 LIGERO AG, https://ligero.com/\n";
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (GPL). If you
// did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
// --

"use strict";

var LIGERO = LIGERO || {};
LIGERO.Agent = LIGERO.Agent || {};
LIGERO.Agent.App = LIGERO.Agent.App || {};

/**
 * @namespace
 * @exports TargetNS as LIGERO.App.Agent.Login
 * @description
 *      This namespace contains the special module functions for TicketZoom.
 */
LIGERO.Agent.App.Login = (function (TargetNS) {
    /**
     * @function
     * @return nothing
     *      This function initializes the special module functions
     */
    TargetNS.Init = function(){
        // Browser is too old
        if (!LIGERO.Debug.BrowserCheck()) {
            $('#LoginBox').hide();
            $('#OldBrowser').show();
            return;
        }

        // enable login form
        LIGERO.Form.EnableForm($('#LoginBox form, #PasswordBox form'));

        // set focus
        if ($('#User').val() && $('#User').val().length) {
            $('#Password').focus();
        }
        else {
            $('#User').focus();
        }

        // enable link actions to switch login <> password request
        $('#LostPassword, #BackToLogin').click(function(){
            $('#LoginBox, #PasswordBox').toggle();
            return false;
        });

        // save TimeOffset data for LIGERO
        Now = new Date();
        $('#TimeOffset').val(Now.getTimezoneOffset());
    }

    return TargetNS;
}(LIGERO.Agent.App.Login || {}));

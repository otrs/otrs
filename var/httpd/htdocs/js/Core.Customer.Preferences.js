// --
// Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Customer = Core.Customer || {};

/**
 * @namespace Core.Customer.Preferences
 * @memberof Core.Customer
 * @author OTRS AG
 * @description
 *      This namespace contains the special module functions for the CustomerPreferences.
 */
Core.Customer.Preferences = (function (TargetNS) {
    /**
     * @name EnableGoogleAuthenticatorAuth
     * @memberof Core.Customer.Preferences
     * @function
     * @param {String} PrefKey
     * @param {String} DisplayName
     * @description
     *      This function handles setting of a Shared Secret for Google Authenticator.
     */
    TargetNS.EnableGoogleAuthenticatorAuth = function (PrefKey, DisplayName) {
        var SharedKey = Core.UI.GoogleAuthenticator.GenerateSharedKey();

        if (Core.UI.GoogleAuthenticator.InitSharedKey(SharedKey, DisplayName)) {
            Core.Customer.PreferencesUpdate(PrefKey, SharedKey);

            $('#' + PrefKey + 'Enable').prop("disabled", true);
            $('#' + PrefKey + 'Disable').prop("disabled", false);
        }
    };

    /**
     * @name DisableGoogleAuthenticatorAuth
     * @memberof Core.Customer.Preferences
     * @function
     * @param {String} PrefKey
     * @description
     *      This function disables Google Authenticator.
     */
    TargetNS.DisableGoogleAuthenticatorAuth = function (PrefKey) {
        Core.Customer.PreferencesUpdate(PrefKey, "");

        $('#' + PrefKey + 'Enable').prop("disabled", false);
        $('#' + PrefKey + 'Disable').prop("disabled", true);
    };

    return TargetNS;
}(Core.Customer.Preferences || {}));

// --
// Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Agent = Core.Agent || {};

/**
 * @namespace Core.Agent.Preferences
 * @memberof Core.Agent
 * @author OTRS AG
 * @description
 *      This namespace contains the special module functions for the AgentPreferences.
 */
Core.Agent.Preferences = (function (TargetNS) {
    /**
     * @name GenerateGoogleAuthenticatorSharedSecret
     * @memberof Core.Agent.Login
     * @function
     * @param {String} SecretFieldID
     * @description
     *      This function generates a Shared Secret and puts it into the input-box.
     */
    TargetNS.GenerateGoogleAuthenticatorSharedSecret = function (SecretFieldID) {
        // Should be multiple of 8 to omit padding
        var KeyLength = 32;
        // See RFC 4648
        var Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

        var SharedSecret = '';
        for (var i = 0; i < KeyLength; i++) {
            var CharIndex = Math.floor(Math.random() * Chars.length);
            SharedSecret += Chars.substring(CharIndex, CharIndex + 1);
        }

        $('#' + SecretFieldID).val(SharedSecret);
    };

    /**
     * @name ShowGoogleAuthenticatorQRCode
     * @memberof Core.Agent.Login
     * @function
     * @param {String} SecretFieldID
     * @description
     *      This function shows a QR-Code for the current Shared Secret.
     */
    TargetNS.ShowGoogleAuthenticatorQRCode = function (SecretFieldID) {
        var Secret = $('#' + SecretFieldID).val();
        var IssuerLabel = Core.Config.Get("ProductName");
        var AccountLabel = Core.Config.Get("UserFullname");

        var OTPLink = "otpauth://totp/" + IssuerLabel + ":" + AccountLabel + "?secret=" + Secret;
        var QRCodeLink = Core.Config.Get('CGIHandle') + '?Action=GenerateQRCode;Text=' + encodeURIComponent(OTPLink);
        Core.UI.Popup.OpenPopup(QRCodeLink, 'QRCode');
    };

    return TargetNS;
}(Core.Agent.Preferences || {}));

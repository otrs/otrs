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
        var KeyLength = 32,
            Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567',
            SharedSecret = '',
            CharIndex, i;

        for (i = 0; i < KeyLength; i++) {
            CharIndex = Math.floor(Math.random() * Chars.length);
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
        var Secret = $('#' + SecretFieldID).val(),
            IssuerLabel = Core.Config.Get('ProductName'),
            AccountLabel = Core.Config.Get('UserFullname'),
            OTPLink, QRCodeLink;

        OTPLink = 'otpauth://totp/' + AccountLabel + '?issuer=' + IssuerLabel + '&secret=' + Secret + '&algorithm=SHA1&digits=6&period=30';
        QRCodeLink = Core.Config.Get('CGIHandle') + '?Action=GenerateQRCode;Text=' + encodeURIComponent(OTPLink);
        Core.UI.Popup.OpenPopup(QRCodeLink, 'QRCode');
    };

    return TargetNS;
}(Core.Agent.Preferences || {}));

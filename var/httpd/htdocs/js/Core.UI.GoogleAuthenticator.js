// --
// Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.UI = Core.UI || {};

/**
 * @namespace Core.UI.GoogleAuthenticator
 * @memberof Core.UI
 * @author OTRS AG
 * @description
 *      This namespace contains shared methods for both Agent and Customer GoogleAuthenticator-Settings
 */
Core.UI.GoogleAuthenticator = (function (TargetNS) {
    /**
     * @name GenerateSharedKey
     * @memberof Core.UI.GoogleAuthenticator
     * @function
     * @returns {String} GoogleAuthenticator-compatible Shared Secret
     * @description
     *      This function generates a Shared Secret to use with the GoogleAuthenticator App.
     */
    TargetNS.GenerateSharedKey = function () {
        // Should be multiple of 8 to omit padding
        var KeyLength = 32,
            Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567',
            SharedKey = '',
            CharIndex, i;

        for (i = 0; i < KeyLength; i++) {
            CharIndex = Math.floor(Math.random() * Chars.length);
            SharedKey += Chars.substring(CharIndex, CharIndex + 1);
        }

        return SharedKey;
    };

    /**
     * @name InitSharedKey
     * @memberof Core.UI.GoogleAuthenticator
     * @function
     * @returns {Boolean} True iff Shared Key was transfered successfuly.
     * @param {String} SharedKey - The Shared Key to present
     * @param {String} AccountLabel - The label to identify the token in the App
     * @description
     *      This function displays the user a QR-Code to scan the Shared Key
     */
    TargetNS.InitSharedKey = function (SharedKey, AccountLabel) {
        var IssuerLabel = Core.Config.Get('ProductName'),
            OTPLink, QRCodeLink;

        OTPLink = 'otpauth://totp/' + AccountLabel + '?issuer=' + IssuerLabel + '&secret=' + SharedKey + '&algorithm=SHA1&digits=6&period=30';
        QRCodeLink = Core.Config.Get('CGIHandle') + '?Action=GenerateQRCode;Text=' + encodeURIComponent(OTPLink);
        Core.UI.Popup.OpenPopup(QRCodeLink, 'QRCode');

        return true;
    };

    return TargetNS;
}(Core.UI.GoogleAuthenticator || {}));

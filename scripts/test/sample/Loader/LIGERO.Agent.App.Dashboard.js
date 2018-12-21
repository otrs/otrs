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
 * @exports TargetNS as LIGERO.Agent.App.Dashboard
 * @description
 *      This namespace contains the special module functions for the Dashboard.
 */
LIGERO.Agent.App.Dashboard = (function (TargetNS) {
    /**
     * @function
     * @return nothing
     *      This function initializes the special module functions
     */
    TargetNS.Init = function () {
        LIGERO.UI.DnD.Sortable(
            $(".SidebarColumn"),
            {
                Handle: '.Header h2',
                Items: '.CanDrag',
                Placeholder: 'DropPlaceholder',
                Tolerance: 'pointer',
                Distance: 15,
                Opacity: 0.6
            }
        );

        LIGERO.UI.DnD.Sortable(
            $(".ContentColumn"),
            {
                Handle: '.Header h2',
                Items: '.CanDrag',
                Placeholder: 'DropPlaceholder',
                Tolerance: 'pointer',
                Distance: 15,
                Opacity: 0.6
            }
        );
    };

    /**
     * @function
     * @return nothing
     *      This function binds a click event on an html element to update the preferences of the given dahsboard widget
     * @param {jQueryObject} $ClickedElement The jQuery object of the element(s) that get the event listener
     * @param {string} ElementID The ID of the element whose content should be updated with the server answer
     * @param {jQueryObject} $Form The jQuery object of the form with the data for the server request
     */
    TargetNS.RegisterUpdatePreferences = function ($ClickedElement, ElementID, $Form) {
        if (isJQueryObject($ClickedElement) && $ClickedElement.length) {
            $ClickedElement.click(function () {
                var URL = LIGERO.Config.Get('Baselink') + LIGERO.AJAX.SerializeForm($Form);
                LIGERO.AJAX.ContentUpdate($('#' + ElementID), URL, function () {
                    LIGERO.UI.ToggleTwoContainer($('#' + ElementID + '-setting'), $('#' + ElementID));
                    LIGERO.UI.Table.InitCSSPseudoClasses();
                });
                return false;
            });
        }
    };

    return TargetNS;
}(LIGERO.Agent.App.Dashboard || {}));

// --
// Core.Agent.CustomerUserInformationCenterSearch.js - provides the special module functions for the CUIC search
// Copyright (C) 2001-2012 OTRS AG, http://otrs.org/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};
Core.Agent = Core.Agent || {};

/**
 * @namespace
 * @exports TargetNS as Core.Agent.CustomerUserInformationCenterSearch
 * @description
 *      This namespace contains the special module functions for the search.
 */
Core.Agent.CustomerUserInformationCenterSearch = (function (TargetNS) {

    /**
     * @function
     * @private
     * @return nothing
     * @description Shows waiting dialog until screen is ready.
     */
    function ShowWaitingDialog(){
        Core.UI.Dialog.ShowContentDialog('<div class="Spacing Center"><span class="AJAXLoader" title="' + Core.Config.Get('LoadingMsg') + '"></span></div>', Core.Config.Get('LoadingMsg'), '10px', 'Center', true);
    }

    function Redirect(CustomerUserID, Event) {
        var Session = '';

        Event.preventDefault();
        Event.stopPropagation();
        ShowWaitingDialog();

        // add session data, if needed
        if (!Core.Config.Get('SessionIDCookie')) {
            Session = ';' + Core.Config.Get('SessionName') + '=' + Core.Config.Get('SessionID');
        }

        window.location.href = Core.Config.Get('Baselink') + 'Action=AgentCustomerUserInformationCenter;CustomerUserID=' + encodeURIComponent(CustomerUserID) + Session;
    }

    /**
     * @function
     * @param {jQueryObject} $Input Input element to add auto complete to
     * @param {String} Subaction Subaction to execute, "SearchCustomerID" or "SearchCustomerUser"
     * @return nothing
     */
    TargetNS.InitAutocomplete = function ($Input, Subaction) {
        Core.UI.Autocomplete.Init($Input, function (Request, Response) {
                var URL = Core.Config.Get('Baselink'), Data = {
                    Action: 'AgentCustomerUserInformationCenterSearch',
                    Subaction: Subaction,
                    Term: Request.term,
                    MaxResults: Core.UI.Autocomplete.GetConfig('MaxResultsDisplayed')
                };

                $Input.data('AutoCompleteXHR', Core.AJAX.FunctionCall(URL, Data, function (Result) {
                    var Data = [];
                    $Input.removeData('AutoCompleteXHR');
                    $.each(Result, function () {
                        Data.push({
                            label: this.Label,
                            value: this.Value
                        });
                    });
                    Response(Data);
                }));
        }, function (Event, UI) {
            Redirect(UI.item.value, Event);
        }, 'CustomerSearch');
    };

    /**
     * @function
     * @param {String} Action which is used in framework right now.
     * @param {String} Used profile name.
     * @return nothing
     *      This function open the search dialog after clicking on "search" button in nav bar.
     */

    TargetNS.OpenSearchDialog = function () {

        var Data = {
            Action: 'AgentCustomerUserInformationCenterSearch'
        };

        ShowWaitingDialog();

        Core.AJAX.FunctionCall(
            Core.Config.Get('CGIHandle'),
            Data,
            function (HTML) {
                // if the waiting dialog was cancelled, do not show the search
                //  dialog as well
                if (!$('.Dialog:visible').length) {
                    return;
                }
                Core.UI.Dialog.ShowContentDialog(HTML, Core.Config.Get('SearchMsg'), '10px', 'Center', true);

            }, 'html'
        );
    };

    /**
     * @function
     * @return nothing
     *      This function initializes the search dialog
     */

    TargetNS.Init = function () {
        TargetNS.InitAutocomplete( $("#AgentCustomerUserInformationCenterSearchCustomerID"), 'SearchCustomerID' );
        TargetNS.InitAutocomplete( $("#AgentCustomerUserInformationCenterSearchCustomerUser"), 'SearchCustomerUser' );
    };

    return TargetNS;
}(Core.Agent.CustomerUserInformationCenterSearch || {}));

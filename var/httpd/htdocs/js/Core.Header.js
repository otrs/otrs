// --
// Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
// --
// This software comes with ABSOLUTELY NO WARRANTY. For details, see
// the enclosed file COPYING for license information (AGPL). If you
// did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
// --

"use strict";

var Core = Core || {};

/**
 * @namespace Core.Header
 * @memberof Core
 * @author OTRS AG
 * @description
 *      This namespace contains the functions for handling Header in framework.
 */
Core.Header = (function (TargetNS) {

    /**
     * @name Init
     * @memberof Core.Header
     * @function
     * @description
     *      Initializes the module functionality.
     */
    TargetNS.Init = function () {

        // Bind event on ToolBarSearchProfile field
        $('#ToolBarSearchProfile').on('change', function (Event) {
            $(Event.target).closest('form').submit();
            Event.preventDefault();
            Event.stopPropagation();
            return false;
        });

        // Initialize auto complete searches
        Core.Agent.CustomerInformationCenterSearch.InitAutocomplete($('#ToolBarCICSearchCustomerID'), "SearchCustomerID");
        Core.Agent.CustomerInformationCenterSearch.InitAutocomplete($('#ToolBarCICSearchCustomerUser'), "SearchCustomerUser");

        // Initialize Chat availability if config is activated
        if (typeof Core.Config.Get('ChatActive') !== 'undefined' &&
            parseInt(Core.Config.Get('ChatActive'), 10) === 1) {
            Core.Agent.Chat.Toolbar.Init();
        }

        // Initialize full text search
        Core.Agent.Search.InitToolbarFulltextSearch();

        // Bind event on Simulate RTL button
        $('.DebugRTL').on('click', function () {
            Core.Debug.SimulateRTLPage();
        });

    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Header || {}));

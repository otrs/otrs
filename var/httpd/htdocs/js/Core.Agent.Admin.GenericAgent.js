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
Core.Agent.Admin = Core.Agent.Admin || {};

/**
 * @namespace Core.Agent.Admin.GenericAgentEvent
 * @memberof Core.Agent.Admin
 * @author OTRS AG
 * @description
 *      This namespace contains the special module functions for the GenericInterface job module.
 */
Core.Agent.Admin.GenericAgent = (function (TargetNS) {

    /**
     * @private
     * @name AddSelectClearButton
     * @memberof Core.Agent.Admin.GenericAgentEvent
     * @function
     * @description
     *      Adds a button next to every select field to clear the selection.
     *      Only select fields with size > 1 are selected (no dropdowns).
     */
    function AddSelectClearButton() {
        var $SelectFields = $('select');

        // Loop over all select fields available on the page
        $SelectFields.each(function () {
            var Size = parseInt($(this).attr('size'), 10),
                $SelectField = $(this),
                SelectID = this.id,
                ButtonHTML = '<a href="#" title="' + Core.Language.Translate('Remove selection') + '" class="GenericAgentClearSelect" data-select="' + SelectID + '"><span>' + Core.Language.Translate('Remove selection') + '</span><i class="fa fa-undo"></i></a>';

            // Only handle select fields with a size > 1, leave all single-dropdown fields untouched
            if (isNaN(Size) || Size <= 1) {
                return;
            }

            // If select field has a tree selection icon already,
            // // we want to insert the new code after that element
            if ($SelectField.next('a.ShowTreeSelection').length) {
                $SelectField = $SelectField.next('a.ShowTreeSelection');
            }

            // insert button HTML
            $SelectField.after(ButtonHTML);
        });

        // Bind click event on newly inserted button
        // The name of the corresponding select field is saved in a data attribute
        $('.GenericAgentClearSelect').on('click.ClearSelect', function () {
            var SelectID = $(this).data('select'),
                $SelectField = $('#' + SelectID);

            if (!$SelectField.length) {
                return false;
            }

            // Clear field value
            $SelectField.val('');
            $(this).blur();

            return false;
        });
    }

    /**
     * @name Init
     * @memberof Core.Agent.Admin.GenericAgentEvent
     * @function
     * @description
     *      This function initialize correctly all other function according to the local language.
     */
    TargetNS.Init = function () {

        $('.DeleteEvent').on('click', function (Event) {
            TargetNS.ShowDeleteEventDialog(Event, $(this));
            return false;
        });

        $('#AddEvent').on('click', function (){
            if ($('#EventType').val() !== null) {
                TargetNS.AddEvent($('#EventType').val());
                return;
            }
        });

        $('#EventType').on('change', function (){
            TargetNS.ToggleEventSelect($(this).val());
        });

        Core.UI.Table.InitTableFilter($("#FilterGenericAgentJobs"), $("#GenericAgentJobs"));

        // Add select clear button if ModernizeFormFields is disabled
        if (parseInt(Core.Config.Get('InputFieldsActivated'), 10) === 0) {
            AddSelectClearButton();
        }
    };

    /**
     * @name ToggleEventSelect
     * @memberof Core.Agent.Admin.GenericAgentEvent
     * @function
     * @param {String} SelectedEventType - Event Type.
     * @description
     *      Toggles the event selection.
     */
    TargetNS.ToggleEventSelect = function (SelectedEventType) {
        $('.EventList').addClass('Hidden');
        $('#' + SelectedEventType + 'Event').removeClass('Hidden');
    };


    /**
     * @name AddEvent
     * @memberof Core.Agent.Admin.GenericAgentEvent
     * @function
     * @param {String} EventType - The type of event trigger to assign to a job i.e. ticket or article.
     * @description
     *      This function calls the AddEvent action on the server.
     */
    TargetNS.AddEvent = function (EventType) {

        var $Clone = $('.EventRowTemplate').clone(),
            EventName = $('#' + EventType + 'Event').val(),
            IsDuplicated = false;

        if (!EventName) {
            return;
        }

        // check for duplicated entries
        $('[class*=EventValue]').each(function() {
            if ($(this).val() === EventName) {
                IsDuplicated = true;
            }
        });
        if (IsDuplicated) {
            TargetNS.ShowDuplicatedDialog('EventName');
            return;
        }

        // add needed values
        $Clone.find('.EventType').html(EventType);
        $Clone.find('.EventName').html(EventName);
        $Clone.find('.EventValue').attr('name', 'EventValues').val(EventName);

        // bind delete function
        $Clone.find('#DeleteEvent').on('click', function (Event) {
            // remove row
            TargetNS.ShowDeleteEventDialog(Event, $(this));
            return false;
        });

        // remove unneeded classes
        $Clone.removeClass('Hidden EventRowTemplate');

        // append to container
        $('#EventsTable > tbody:last').append($Clone);

    };

    /**
     * @name ShowDeleteEventDialog
     * @memberof Core.Agent.Admin.GenericAgentEvent
     * @function
     * @param {EventObject} Event - Object of the clicked element.
     * @param {jQueryObject} Object
     * @description
     *      This function shows a confirmation dialog with 2 buttons.
     */
    TargetNS.ShowDeleteEventDialog = function(Event, Object){
        Core.UI.Dialog.ShowContentDialog(
            $('#DeleteEventDialogContainer'),
            Core.Language.Translate('Delete this Event Trigger'),
            '240px',
            'Center',
            true,
            [
               {
                   Label: Core.Language.Translate('Cancel'),
                   Class: 'Primary',
                   Function: function () {
                       Core.UI.Dialog.CloseDialog($('#DeleteEventDialog'));
                   }
               },
               {
                   Label: Core.Language.Translate('Delete'),
                   Function: function () {
                       Object.parents('tr:first').remove();
                       Core.UI.Dialog.CloseDialog($('#DeleteEventDialog'));
                   }
               }
           ]
        );

        Event.stopPropagation();
        Event.preventDefault();
    };

    /**
     * @name ShowDuplicatedDialog
     * @memberof Core.Agent.Admin.GenericAgentEvent
     * @function
     * @description
     *      This function shows an alert dialog for duplicated entries.
     */
    TargetNS.ShowDuplicatedDialog = function() {
        Core.UI.Dialog.ShowAlert(
            Core.Language.Translate('Duplicate event.'),
            Core.Language.Translate('This event is already attached to the job, Please use a different one.'),
            function () {
                Core.UI.Dialog.CloseDialog($('.Alert'));
                $('#EventType').focus();
                return false;
            }
        );
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Agent.Admin.GenericAgent || {}));

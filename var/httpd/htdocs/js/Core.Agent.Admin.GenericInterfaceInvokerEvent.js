// --
// Core.Agent.Admin.GenericInterfaceInvokerEvent.js - provides the special module functions for the GenericInterface invoker event.
// Copyright (C) 2001-2012 OTRS AG, http://otrs.org/
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
 * @namespace
 * @exports TargetNS as Core.Agent.Admin.GenericInterfaceMappingSimple
 * @description
 *      This namespace contains the special module functions for the GenericInterface Mapping module.
 */
Core.Agent.Admin.GenericInterfaceInvokerEvent= (function (TargetNS) {

    /**
     * @function
     * @param {Object} Params, initialization and internationalization parameters.
     * @return nothing
     *      This function initialize correctly all other function according to the local language
     */
    TargetNS.InitEdit = function (Params) {
        TargetNS.WebserviceID = parseInt(Params.WebserviceID, 10);
        TargetNS.Localization = Params.Localization;
        TargetNS.DeletedString = Params.DeletedString;

        // Init addition of new conditions
        $('#ConditionAdd').bind('click', function() {
            // get current parent index
            var CurrentParentIndex = parseInt($(this).prev('.ConditionField').first().attr('id').replace(/Condition\[/g, '').replace(/\]/g, ''), 10),
                // in case we add a whole new condition, the fieldindex must be 1
                LastKnownFieldIndex = 1,
                // get current index
                ConditionHTML = $('#ConditionContainer').html().replace(/_INDEX_/g, CurrentParentIndex + 1).replace(/_FIELDINDEX_/g, LastKnownFieldIndex);

            $($.parseHTML(ConditionHTML)).insertBefore($('#ConditionAdd'));
            return false;
        });

        // Init removal of conditions
        $('#PresentConditionsContainer').delegate('.ConditionField > .Remove', 'click', function() {
            if ($('#PresentConditionsContainer').find('.ConditionField').length > 1) {

                $(this).parent().prev('label').remove();
                $(this).parent().remove();
            }
            else {
                alert("Sorry, the only existing condition can't be removed.");
            }

            return false;
        });

        // Init addition of new fields within conditions
        $('#PresentConditionsContainer').delegate('.ConditionFieldAdd', 'click', function() {
            // get current parent index
            var CurrentParentIndex = $(this).closest('.ConditionField').attr('id').replace(/Condition\[/g, '').replace(/\]/g, ''),
                // get the index for the newly to be added element
                // therefore, we search the preceding fieldset and the first
                // label in it to get its "for"-attribute which contains the index
                LastKnownFieldIndex = parseInt($(this).prev('fieldset').find('label').attr('for').replace(/ConditionFieldName\[\d+\]\[/, '').replace(/\]/, ''), 10),
                // add new field
                ConditionFieldHTML = $('#ConditionFieldContainer').html().replace(/_INDEX_/g, CurrentParentIndex).replace(/_FIELDINDEX_/g, LastKnownFieldIndex + 1);

            $($.parseHTML(ConditionFieldHTML)).insertBefore($(this));
            return false;
        });

        // Init removal of fields within conditions
        $('.Condition .Field').delegate('.Remove', 'click', function() {
            if ($(this).closest('.Field').find('.Fields').length > 1) {
                $(this).parent().prev('label').remove();
                $(this).parent().remove();
            }
            else {
                alert("Sorry, the only existing field can't be removed.");
            }

            return false;
        });

        $('#Submit').bind('click', function() {
            $('#TransitionForm').submit();
            return false;
        });

        Core.Form.Validate.SetSubmitFunction($('#TransitionForm'), function (Form) {
            var ConditionConfig = TargetNS.GetConditionConfig($('#PresentConditionsContainer').find('.ConditionField'));
            $('input[name=ConditionConfig]').val(Core.JSON.Stringify(ConditionConfig));

            // not needed for normal submit
            $(window).unbind("beforeunload.PMPopup");

            Form.submit();
        });

        // Init handling of closing popup with the OS functionality ("X")
        $(window).unbind("beforeunload.PMPopup").bind("beforeunload.PMPopup", function () {
            window.opener.Core.Agent.Admin.ProcessManagement.HandlePopupClose();
        });

        $('.ClosePopup').bind("click", function () {
            $(window).unbind("beforeunload.PMPopup");
        });

    };

    TargetNS.GetConditionConfig = function ($Conditions) {

        if (!$Conditions.length) {
            return {};
        }

        var Conditions = {},
            ConditionKey;

        $Conditions.each(function() {

            // get condition key
            ConditionKey = $(this).attr('id').replace(/(Condition\[|\])/g, '');

            // use condition key as key for our list
            Conditions[ConditionKey] = {
                Type: $(this).find('.Field > select').val(),
                Fields: {}
            };

            // get all fields of the current condition
            $(this).find('fieldset.Fields').each(function() {

                var FieldKey = $(this).find('label').attr('for').replace(/(ConditionFieldName\[\d+\]\[|\])/g, '');
                Conditions[ConditionKey].Fields[$(this).find('input').first().val()] = {
                    Type  : $(this).find('select').val(),
                    Match : $(this).find('input').last().val()
                };
            });

        });

        return Conditions;
    };

    /**
     * @function
     * @param {string} IDSelector ID object of the clicked element.
     * @return nothing
     *      This function shows a confirmation dialog with 2 buttons
     */
    TargetNS.ShowDeleteDialog = function(IDSelector){

        Core.UI.Dialog.ShowContentDialog(
            $('#DeleteDialogContainer'),
            TargetNS.Localization.DeleteKeyMappingtMsg,
            '240px',
            'Center',
            true,
            [
               {
                   Label: TargetNS.Localization.DeleteMsg,
                   Function: function () {
                       $('#' + IDSelector).closest('.WidgetKey').remove();
                       Core.UI.Dialog.CloseDialog($('#DeleteDialog'));
                   }
               },
               {
                   Label: TargetNS.Localization.CancelMsg,
                   Function: function () {
                       Core.UI.Dialog.CloseDialog($('#DeleteDialog'));
                   }
               }
           ]
        );
    };

    return TargetNS;
}(Core.Agent.Admin.GenericInterfaceInvokerEvent || {}));

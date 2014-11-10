// --
// Core.Agent.Search.js - provides the special module functions for the global search
// Copyright (C) 2001-2013 OTRS AG, http://otrs.org/
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
 * @exports TargetNS as Core.Agent.Search
 * @description
 *      This namespace contains the special module functions for the search.
 */
Core.Agent.Search = (function (TargetNS) {

    /**
     * @function
     * @return nothing
     *      This function rebuild attribute selection, only show available attributes.
     */
    TargetNS.AdditionalAttributeSelectionRebuild = function () {

        // get original selection with all possible fields and clone it
        var $AttributeClone = $('#AttributeOrig').clone().attr('id', 'Attribute');

        // strip all already used attributes
        $AttributeClone.find('option').each(function () {
            $('#SearchInsert label#' + 'Label' + $(this).attr('value')).remove();
        });

        // replace selection with original selection
        $('#Attribute').replaceWith($AttributeClone);

        return true;
    };

    /**
     * @function
     * @param {String} of attribute to add.
     * @return nothing
     *      This function adds one attributes for search.
     */
    TargetNS.SearchAttributeAdd = function (Attribute) {
        var $Label = $('#SearchAttributesHidden label#Label' + Attribute);

        if ($Label.length) {
            $Label.prev().clone().appendTo('#SearchInsert');
            $Label.clone().appendTo('#SearchInsert');
            $Label.next().clone().appendTo('#SearchInsert')

                // bind click function to remove button now
                .find('.RemoveButton').bind('click', function () {
                    var $Element = $(this).parent();
                    TargetNS.SearchAttributeRemove($Element);

                    // rebuild selection
                    TargetNS.AdditionalAttributeSelectionRebuild();

                    return false;
                });

            // Register event for tree selection dialog
            Core.UI.TreeSelection.InitTreeSelection();

            // Initially display dynamic fields with TreeMode = 1 correctly
            Core.UI.TreeSelection.InitDynamicFieldTreeViewRestore();
        }

        return false;
    };

    /**
     * @function
     * @param {jQueryObject} $Element The jQuery object of the form  or any element
     *      within this form check.
     * @return nothing
     *      This function remove attributes from an element.
     */

    TargetNS.SearchAttributeRemove = function ($Element) {
        $Element.prev().prev().remove();
        $Element.prev().remove();
        $Element.remove();
    };

    /**
     * @function
     * @return nothing
     *      This function rebuild attribute selection, only show available attributes.
     */
    TargetNS.AdditionalAttributeSelectionRebuild = function () {

        // get original selection
        var $AttributeClone = $('#AttributeOrig').clone();
        $AttributeClone.attr('id', 'Attribute');

        // strip all already used attributes
        $AttributeClone.find('option').each(function () {
            var $Attribute = $(this);
            $('#SearchInsert label').each(function () {
                if ($(this).attr('id') === 'Label' + $Attribute.attr('value')) {
                    $Attribute.remove();
                }
            });
        });

        // replace selection with original selection
        $('#Attribute').replaceWith($AttributeClone);

        return true;
    };

    /**
     * @function
     * @private
     * @param {String} Profile The profile name that will be delete.
     * @return nothing
     * @description Delete a profile via an ajax requests.
     */
    function SearchProfileDelete(Profile) {
        var Data = {
            Action: 'AgentTicketSearch',
            Subaction: 'AJAXProfileDelete',
            Profile: Profile
        };
        Core.AJAX.FunctionCall(
            Core.Config.Get('CGIHandle'),
            Data,
            function () {}
        );
    }

    /**
     * @function
     * @private
     * @return 0 if no values were found, 1 if values where there
     * @description Checks if any values were entered in the search.
     *              If nothing at all exists, it alerts with translated:
     *              "Please enter at least one search value or * to find anything"
     */
    function CheckForSearchedValues() {
        // loop through the SerachForm labels
        var SearchValueFlag = false;
        $('#SearchForm label').each(function () {
            var ElementName,
                $Element,
                $LabelElement = $(this);

            // those with ID's are used for searching
            if ( $(this).attr('id') ) {

                // substring "Label" (e.g. first five characters ) from the
                // label id, use the remaining name as name string for accessing
                // the form input's value
                ElementName = $(this).attr('id').substring(5);
                $Element = $('#SearchForm input[name='+ElementName+']');

                // If there's no input element with the selected name
                // find the next "select" element and use that one for checking
                if (!$Element.length) {
                    $Element = $(this).next().find('select');
                }

                // Fix for bug#10845: make sure time slot fields with TimeInputFormat
                // 'Input' set are being considered correctly, too. As this is only
                // relevant for search type 'TimeSlot', we check for the first
                // input type=text elment in the corresponding field element.
                // All time field elements have to be filled in, but if only one
                // is missing, we treat the whole field as invalid.
                if ( $LabelElement.next('.Field').find('input[type=hidden]').val() === 'TimeSlot' && !$LabelElement.next('.Field').find('select').length ) {
                    $Element = $LabelElement.next('.Field').find('input[type=text]').first();
                }

                if ($Element.length) {
                    if ( $Element.val() && $Element.val() !== '' ) {
                        SearchValueFlag = true;
                    }
                }
            }
        });
        if (!SearchValueFlag) {
           alert(Core.Config.Get('EmptySearchMsg'));
        }
        return SearchValueFlag;
    }

    /**
     * @function
     * @private
     * @return nothing
     * @description Shows waiting dialog until search screen is ready.
     */
    function ShowWaitingDialog(){
        Core.UI.Dialog.ShowContentDialog('<div class="Spacing Center"><span class="AJAXLoader" title="' + Core.Config.Get('LoadingMsg') + '"></span></div>', Core.Config.Get('LoadingMsg'), '10px', 'Center', true);
    }

    /**
     * @function
     * @param {String} Action which is used in framework right now.
     * @param {String} Used profile name.
     * @return nothing
     *      This function open the search dialog after clicking on "search" button in nav bar.
     */

    TargetNS.OpenSearchDialog = function (Action, Profile, EmptySearch) {

        var Referrer = Core.Config.Get('Action'),
            Data;

        if (!Action) {
            Action = 'AgentSearch';
        }

        Data = {
            Action: Action,
            Referrer: Referrer,
            Profile: Profile,
            EmptySearch: EmptySearch,
            Subaction: 'AJAX'
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

                Core.UI.Dialog.ShowContentDialog(HTML, Core.Config.Get('SearchMsg'), '10px', 'Center', true, undefined, true);

                // hide add template block
                $('#SearchProfileAddBlock').hide();

                // hide save changes in template block
                $('#SaveProfile').parent().hide().prev().hide().prev().hide();

                // search profile is selected
                if ($('#SearchProfile').val() && $('#SearchProfile').val() !== 'last-search') {

                    // show delete button
                    $('#SearchProfileDelete').show();

                    // show profile link
                    $('#SearchProfileAsLink').show();

                    // show save changes in template block
                    $('#SaveProfile').parent().show().prev().show().prev().show();

                    // set SaveProfile to 0
                    $('#SaveProfile').prop('checked', false);
                }

                // register add of attribute
                $('.AddButton').bind('click', function () {
                    var Attribute = $('#Attribute').val();
                    TargetNS.SearchAttributeAdd(Attribute);
                    TargetNS.AdditionalAttributeSelectionRebuild();

                    // Register event for tree selection dialog
                    $('.ShowTreeSelection').unbind('click').bind('click', function (Event) {
                        Core.UI.TreeSelection.ShowTreeSelection($(this));
                        return false;
                    });

                    return false;
                });

                // register return key
                $('#SearchForm').unbind('keypress.FilterInput').bind('keypress.FilterInput', function (Event) {
                    if ((Event.charCode || Event.keyCode) === 13) {
                        if (!CheckForSearchedValues()) {
                            return false;
                        }
                        else {
                            $('#SearchFormSubmit').trigger('click');
                        }
                        return false;
                    }
                });

                // register submit
                $('#SearchFormSubmit').bind('click', function () {
                    var ShownAttributes = '';

                    // remember shown attributes
                    $('#SearchInsert label').each(function () {
                        if ( $(this).attr('id') ) {
                            ShownAttributes = ShownAttributes + ';' + $(this).attr('id');
                        }
                    });
                    $('#SearchForm #ShownAttributes').val(ShownAttributes);

                    // Normal results mode will return HTML in the same window
                    if ($('#SearchForm #ResultForm').val() === 'Normal') {

                        if (!CheckForSearchedValues()) {
                            return false;
                        }
                        else {
                           $('#SearchForm').submit();
                           ShowWaitingDialog();
                        }
                    }
                    else { // Print and CSV should open in a new window, no waiting dialog
                        $('#SearchForm').attr('target', 'SearchResultPage');
                        if (!CheckForSearchedValues()) {
                            return false;
                        }
                        else {
                           $('#SearchForm').submit();
                           $('#SearchForm').attr('target', '');
                        }
                    }
                    return false;
                });

                // load profile
                $('#SearchProfile').bind('change', function () {
                    var Profile = $('#SearchProfile').val(),
                        EmptySearch = $('#EmptySearch').val(),
                        Action = $('#SearchAction').val();

                    TargetNS.OpenSearchDialog(Action, Profile, EmptySearch);
                    return false;
                });

                // show add profile block or not
                $('#SearchProfileNew').bind('click', function (Event) {
                    $('#SearchProfileAddBlock').toggle();
                    $('#SearchProfileAddName').focus();
                    Event.preventDefault();
                    return false;
                });

                // add new profile
                $('#SearchProfileAddAction').bind('click', function () {
                    var ProfileName, $Element1;

                    // get name
                    ProfileName = $('#SearchProfileAddName').val();

                    // check name
                    if (!ProfileName.length || ProfileName.length < 2) {
                        return;
                    }

                    // add name to profile selection
                    $Element1 = $('#SearchProfile').children().first().clone();
                    $Element1.text(ProfileName);
                    $Element1.attr('value', ProfileName);
                    $Element1.prop('selected', true);
                    $('#SearchProfile').append($Element1);

                    // set input box to empty
                    $('#SearchProfileAddName').val('');

                    // hide add template block
                    $('#SearchProfileAddBlock').hide();

                    // hide save changes in template block
                    $('#SaveProfile').parent().hide().prev().hide().prev().hide();

                    // set SaveProfile to 1
                    $('#SaveProfile').prop('checked', true);

                    // show delete button
                    $('#SearchProfileDelete').show();

                    // show profile link
                    $('#SearchProfileAsLink').show();
                });

                // direct link to profile
                $('#SearchProfileAsLink').bind('click', function (Event) {
                    var Profile = $('#SearchProfile').val(),
                        Action = $('#SearchAction').val();

                    window.location.href = Core.Config.Get('Baselink') + 'Action=' + Action +
                    ';Subaction=Search;TakeLastSearch=1;SaveProfile=1;Profile=' + encodeURIComponent(Profile);
                    return false;
                });

                // delete profile
                $('#SearchProfileDelete').bind('click', function (Event) {

                    // strip all already used attributes
                    $('#SearchProfile').find('option:selected').each(function () {
                        if ($(this).attr('value') !== 'last-search') {

                            // rebuild attributes
                            $('#SearchInsert').text('');

                            // remove remote
                            SearchProfileDelete($(this).val());

                            // remove local
                            $(this).remove();

                            // show fulltext
                            TargetNS.SearchAttributeAdd('Fulltext');

                            // rebuild selection
                            TargetNS.AdditionalAttributeSelectionRebuild();
                        }
                    });

                    if ($('#SearchProfile').val() && $('#SearchProfile').val() === 'last-search') {

                        // hide delete link
                        $('#SearchProfileDelete').hide();

                        // show profile link
                        $('#SearchProfileAsLink').hide();

                    }

                    Event.preventDefault();
                    return false;
                });

            }, 'html'
        );
    };

    return TargetNS;
}(Core.Agent.Search || {}));

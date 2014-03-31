// --
// Core.Agent.Admin.GenericAgent.js - provides the special module functions for the GenericInterface job.
// Copyright (C) 2003-2013 OTRS AG, http://otrs.org/
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
 * @exports TargetNS as Core.Agent.Admin.GenericAgentEvent
 * @description
 *      This namespace contains the special module functions for the GenericInterface job module.
 */
Core.Agent.Admin.GenericAgent = (function (TargetNS) {

    /**
     * @variable
     * @private
     *     This variable stores the parameters that are passed from the DTL and contain all the data that the dialog needs.
     */
    var DialogData = [];

    /**
     * @function
     * @param {Object} Params, initialization and internationalization parameters.
     * @return nothing
     *      This function initialize correctly all other function according to the local language
     */
    TargetNS.Init = function (Params) {

        TargetNS.Localization = Params.Localization;

        $('.DeleteEvent').bind('click', function (Event) {
            TargetNS.ShowDeleteEventDialog( Event, $(this) );
            return false;
        });

        $('#AddEvent').bind('click', function (){
            if ( $('#EventType').val() !== null ) {
                TargetNS.AddEvent( $('#EventType').val() );
            }
        });

        $('#EventType').bind('change', function (){
            TargetNS.ToogleEventSelect($(this).val());
        });

        // bind removal of notification text to the change event
        // of each select with an invalid selection stored
        $('select').each( function() {

            // skip if no selection has become invalid
            if ( $('#Invalid'+ $(this).attr('id') ).length === 0 ) {
                return true;
            }

            // bind notification removal on element change
            $(this).bind('change', function() {
                $('#Invalid'+ $(this).attr('id') ).remove();
            });
        });

        // register submit function after selection validation
        // to check if configuration values that have become invalid
        // have been changed or not. If not a warning message should
        // be displayed to inform the user
        Core.Form.Validate.SetSubmitFunction( $('form[name=compose]'), function( Form ) {

            // get all unchanged select field labels and the
            // label of the widget they are in so we can display
            // them to the user in the warning dialog
            var InvalidUnchanged = new Array();
            $('select').each( function() {

                // skip if no selection has become invalid or it was changed
                if ( $('#Invalid'+ $(this).attr('id') ).length === 0 ) {
                    return true;
                }

                // get label of unchanged filed
                var FieldLabel  = $('label[for='+ $(this).attr('id') +']').html().replace(':', '');
                // get the widget label
                var WidgetLabel = $('#'+ $(this).attr('id') ).parents('.WidgetSimple').find('.Header h2').html();

                InvalidUnchanged.push( FieldLabel +' ('+ WidgetLabel +')' );
            });

            // submit the form and return
            // if no invalid selection was found
            if ( InvalidUnchanged.length === 0 ) {

                Form.submit();
                return true;
            }

            // build the warning message HTML
            var DialogHTML = '<span class="Warning">';

            // use the matching warning text for a single or multiple selections
            if ( InvalidUnchanged.length === 1 ) {
                DialogHTML += TargetNS.Localization.InvalidDialogSingle;
            }
            else {
                DialogHTML += TargetNS.Localization.InvalidDialogMulti;
            }

            // some formatting
            DialogHTML += "</span> \
            <br> \
            <br> \
            <ul>";

            // add each selection and widget label that we gathered earlier
            $.each( InvalidUnchanged, function( Index, Value ) {
                DialogHTML += '<li>- '+ Value +'</li>';
            });

            // formatting and the question to the user
            DialogHTML += "\
            </ul> \
            <br> \
            <span>"+ TargetNS.Localization.InvalidDialogQuestion +"</span>";

            // show the dialog with two options:
            // 1.) 'Change' - change the invalid select fields
            // 2.) 'Save'   - save the configuration anyway
            Core.UI.Dialog.ShowDialog({
                Modal:               true,
                Title:               TargetNS.Localization.InvalidDialogTitle,
                HTML:                DialogHTML,
                PositionTop:         '240px',
                PositionLeft:        'Center',
                CloseOnClickOutside: true,
                CloseOnEscape:       true,
                Buttons:    [
                                {
                                    Class: 'Primary',
                                    Label: TargetNS.Localization.InvalidDialogChange,
                                    Type: 'Close',
                                },
                                {
                                    Label: TargetNS.Localization.InvalidDialogSave,
                                    Function: function () {

                                        // if the job configuration with the invalid values
                                        // should get stored anyway, submit the form and
                                        // disable the submit button to prevent multiple submits
                                        Form.submit();

                                        window.setTimeout(function () {
                                            Core.Form.EnableForm( $('form[name=compose]') );
                                        }, 0);
                                    }
                                }
                            ]
            });

            // since the modal dialog is asynchronous we need to reenable the
            // submit button in case the user wants to change the configuration
            window.setTimeout(function () {
                Core.Form.EnableForm( $('form[name=compose]') );
            }, 5);
            return false;
        });
    };

    TargetNS.ToogleEventSelect = function (SelectedEventType) {
        $('.EventList').addClass('Hidden');
        $('#' + SelectedEventType + 'Event').removeClass('Hidden');
    };


    /**
     * @function
     * @param {String} EventType, the type of event trigger to assign to an jobr
     * i.e ticket or article
     * @return nothing
     *      This function calls the AddEvent action on the server
     */
    TargetNS.AddEvent = function (EventType) {

        var $Clone = $('.EventRowTemplate').clone(),
            EventName = $('#'+ EventType + 'Event').val(),
            IsDuplicated = false;

        if ( !EventName ) {
            return false;
        }

        // check for duplicated entries
        $('[class*=EventValue]').each(function(index) {
            if ( $(this).val() === EventName ) {
                IsDuplicated = true;
            }
        });
        if (IsDuplicated) {
            TargetNS.ShowDuplicatedDialog('EventName');
            return false;
        }

        // add needed values
        $Clone.find('.EventType').html(EventType);
        $Clone.find('.EventName').html(EventName);
        $Clone.find('.EventValue').attr('name','EventValues').val(EventName);

        // bind delete function
        $Clone.find('#DeleteEvent').bind('click', function (Event) {
            // remove row
            TargetNS.ShowDeleteEventDialog(Event, $(this) );
            return false;
        });

        // remove unneeded classes
        $Clone.removeClass('Hidden EventRowTemplate');

        // append to container
        $('#EventsTable > tbody:last').append($Clone);

    };

    /**
     * @function
     * @param {EventObject} event object of the clicked element.
     * @return nothing
     *      This function shows a confirmation dialog with 2 buttons
     */
    TargetNS.ShowDeleteEventDialog = function(Event, Object, EventName){
        var LocalDialogData;

        Core.UI.Dialog.ShowContentDialog(
            $('#DeleteEventDialogContainer'),
            TargetNS.Localization.DeleteEventMsg,
            '240px',
            'Center',
            true,
            [
               {
                   Label: TargetNS.Localization.CancelMsg,
                   Class: 'Primary',
                   Function: function () {
                       Core.UI.Dialog.CloseDialog($('#DeleteEventDialog'));
                   }
               },
               {
                   Label: TargetNS.Localization.DeleteMsg,
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
     * @function
     * @param {string} Field ID object of the element should receive the focus on close event.
     * @return nothing
     *      This function shows an alert dialog for duplicated entries.
     */
    TargetNS.ShowDuplicatedDialog = function(Field){
        Core.UI.Dialog.ShowAlert(
            TargetNS.Localization.DuplicateEventTitle,
            TargetNS.Localization.DuplicateEventMsg,
            function () {
                Core.UI.Dialog.CloseDialog($('.Alert'));
                $('#EventType').focus();
                return false;
            }
        );
    };

    return TargetNS;
}(Core.Agent.Admin.GenericAgent || {}));

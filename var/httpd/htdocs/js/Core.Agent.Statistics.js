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
 * @namespace Core.Agent.Statistics
 * @memberof Core.Agent
 * @author OTRS AG
 * @description
 *      This namespace contains the special module functions for the Statistics module.
 */
Core.Agent.Statistics = (function (TargetNS) {

    /**
     * @name InitAddScreen
     * @memberof Core.Agent.Statistics
     * @function
     * @description
     *      Initialize the add screen. Contains basically some logic to react on which
     *      of the big select buttons the agent uses. Afterwards, the specification widget
     *      is being loaded according to the clicked button.
     */
    TargetNS.InitAddScreen = function () {

        $('.BigButtons a').on('click', function () {
            var $Link = $(this);

            if ($Link.hasClass('Disabled')) {
                return false;
            }

            $('.BigButtons a').removeClass('Active');
            $Link.addClass('Active');

            $('#GeneralSpecifications').fadeIn(function() {
                var URL = Core.Config.Get('Baselink'),
                    Data = {
                        Action: 'AgentStatistics',
                        Subaction: 'GeneralSpecificationsWidgetAJAX',
                        StatisticPreselection: $Link.data('statistic-preselection')
                    };

                $('#GeneralSpecifications .Content').addClass('Center').html('<span class="AJAXLoader"></span>');
                $('#SaveWidget').hide();

                Core.AJAX.FunctionCall(URL, Data, function(Response) {
                    $('#GeneralSpecifications .Content').removeClass('Center').html(Response);
                    Core.UI.InputFields.Activate($('#GeneralSpecifications .Content'));
                    $('#SaveWidget').show();
                }, 'html');
            });

            return false;
        });
    };

    TargetNS.ElementAdd = function(ConfigurationType, ElementName) {
        var $ContainerElement = $('#' + ConfigurationType + 'Container'),
            $FormFieldsElement = $('#' + ConfigurationType + 'FormFields');

        $ContainerElement.find('.Element' + Core.App.EscapeSelector(ElementName)).clone().appendTo($FormFieldsElement);
    };

    TargetNS.InitViewScreen = function() {
        var StatsParamData = Core.Config.Get('StatsParamData');

        if (StatsParamData.Use === 'UseAsValueSeries') {
            $('#' + StatsParamData.XAxisTimeScaleElementID).on('change', function() {
                var TimeScaleYAxis = StatsParamData.TimeScaleYAxis,
                $TimeScaleElement = $('#' + StatsParamData.TimeScaleElementID),
                XAxisTimeScaleValue = $(this).val();

                // reset the current time scale dropdown for the y axis
                $TimeScaleElement.empty();

                if (XAxisTimeScaleValue in TimeScaleYAxis) {
                    $.each(TimeScaleYAxis[XAxisTimeScaleValue], function (Index, Item) {
                        var TimeScaleOption = new Option(Item.Value, Item.Key);

                        // Overwrite option text, because of wrong html quoting of text content.
                        // (This is needed for IE.)
                        TimeScaleOption.innerHTML = Item.Value;
                        $TimeScaleElement.append(TimeScaleOption).val(Item.Key).trigger('redraw.InputField').trigger('change');

                    });
                }
            });
        }

        if (StatsParamData.Ajax) {
            Core.UI.InputFields.Activate();
        }

        $('.DataShowMore').on('click', function() {
            if ($(this).find('.More').is(':visible')) {
                $(this)
                    .find('.More')
                    .hide()
                    .next('.Less')
                    .show()
                    .parent()
                    .prev('.DataFull')
                    .show()
                    .prev('.DataTruncated')
                    .hide()
            }
            else {
                $(this)
                    .find('.More')
                    .show()
                    .next('.Less')
                    .hide()
                    .parent()
                    .prev('.DataFull')
                    .hide()
                    .prev('.DataTruncated')
                    .show()
            }
            return false;
        });

    };

    /**
     * @name InitEditScreen
     * @memberof Core.Agent.Statistics
     * @function
     * @description
     *      Initialize the edit screen.
     */
    TargetNS.InitEditScreen = function() {
        $('button.EditXAxis, button.EditYAxis, button.EditRestrictions').on('click', function() {
            var ConfigurationType = $(this).data('configuration-type'),
                ConfigurationLimit = $(this).data('configuration-limit'),
                DialogTitle = $(this).data('dialog-title'),
                $ContainerElement = $('#' + ConfigurationType + 'Container'),
                $FormFieldsElement = $('#' + ConfigurationType + 'FormFields');

            function RebuildEditDialogAddSelection() {
                $('#EditDialog .Add select').empty().append('<option>-</option>');
                $.each($ContainerElement.find('.Element'), function() {
                    var $Element = $(this),
                        ElementName = $Element.data('element');

                    if ($('#EditDialog .Fields .Element' + Core.App.EscapeSelector(ElementName)).length) {
                        return;
                    }

                    $($.parseHTML('<option></option>')).val(ElementName)
                        .text($Element.find('> legend > span').text().replace(/:\s*$/, ''))
                        .appendTo('#EditDialog .Add select');
                });
            }

            function EditDialogAdd(ElementName) {
                var $Element = $ContainerElement.find('.Element' + Core.App.EscapeSelector(ElementName));
                $Element.clone().appendTo($('#EditDialog .Fields'));
                if (ConfigurationLimit && $('#EditDialog .Fields .Element').length >= ConfigurationLimit) {
                    $('#EditDialog .Add').hide();
                }
                RebuildEditDialogAddSelection();
                Core.UI.InputFields.Activate($('#EditDialog .Fields'));
            }

            function EditDialogDelete(ElementName) {
                $('#EditDialog .Fields .Element' + Core.App.EscapeSelector(ElementName)).remove();
                $('#EditDialog .Add').show();
                RebuildEditDialogAddSelection();
            }

            function EditDialogSave() {
                $FormFieldsElement.empty();
                $('#EditDialog .Fields').children().appendTo($FormFieldsElement);
                Core.UI.Dialog.CloseDialog($('.Dialog'));
                $('form.StatsEditForm').submit();
            }

            function EditDialogCancel() {
                Core.UI.Dialog.CloseDialog($('.Dialog'));
            }

            Core.UI.Dialog.ShowContentDialog(
                '<div id="EditDialog"></div>',
                DialogTitle,
                100,
                'Center',
                true,
                [
                    { Label: Core.Language.Translate('Save'), Class: 'Primary', Type: '', Function: EditDialogSave },
                    { Label: Core.Language.Translate('Cancel'), Class: '', Type: 'Close', Function: EditDialogCancel }
                ],
                true
            );
            $('#EditDialogTemplate').children().clone().appendTo('#EditDialog');

            if ($FormFieldsElement.children().length) {
                $FormFieldsElement.children().clone().appendTo('#EditDialog .Fields');
                Core.UI.InputFields.Activate($('#EditDialog .Fields'));
                if (ConfigurationLimit && $('#EditDialog .Fields .Element').length >= ConfigurationLimit) {
                    $('#EditDialog .Add').hide();
                }
            }
            else {
                $('#EditDialog .Add').show();
            }
            RebuildEditDialogAddSelection();

            $('#EditDialog .Add select').on('change', function(){
                EditDialogAdd($(this).val());
            });

            $('#EditDialog .Fields').on('click', '.RemoveButton', function(){
                EditDialogDelete($(this).parents('.Element').data('element'));
                return false;
            });

            // Selection helpers for time fields
            $('#EditDialog .Fields .ElementBlockTime .Field select').on('change', function() {
                $(this).parent('.Field').prev('label').find('input:radio').prop('checked', true);
            });

            Core.UI.TreeSelection.InitTreeSelection();

            // Datepickers don't work if added dynamically atm, so hide for now.
            $('a.DatepickerIcon').hide();

            return false;
        });

       $('.SwitchPreviewFormat').on('click', function() {
            var Format = $(this).data('format'),
                FormatCleaned = Format.replace('::', ''),
                StatsPreviewResult;

            StatsPreviewResult = Core.Data.CopyObject(Core.Config.Get('PreviewResult'));
            $('.SwitchPreviewFormat').removeClass('Active');
            $(this).addClass('Active');
            $('.PreviewContent:visible').hide();
            $('svg.PreviewContent').empty();
            $('#PreviewContent' + FormatCleaned).show();
            if (Format.match(/D3/)) {
                Core.UI.AdvancedChart.Init(
                    Format,
                    StatsPreviewResult,
                    'svg#PreviewContent' + FormatCleaned,
                    {
                        HideLegend: true
                    }
                );
            }
            return false;
        });
        $('.SwitchPreviewFormat').first().trigger('click');
    }

    /**
     * @name Init
     * @memberof Core.Agent.Statistics
     * @function
     * @description
     *      This function initializes the module functionality.
     */
    TargetNS.Init = function () {
        var RestrictionElements,
            XAxisElements,
            YAxisElements,
            D3Data;

        // Initialize the Add screen
        TargetNS.InitAddScreen();

        // Initialize the Edit screen
        TargetNS.InitEditScreen();

        // Initialize the View - StatsParams screen
        if (typeof Core.Config.Get('StatsParamData') !== 'undefined') {
            TargetNS.InitViewScreen();
        }

        // Bind event on delete stats button
        $('.StatDelete').on('click', function (Event) {
            var ConfirmText = '"' + $(this).data('stat-title') + '"\n\n' + Core.Language.Translate("Do you really want to delete this statistic?");
            if (!window.confirm(ConfirmText)) {
                Event.stopPropagation();
                Event.preventDefault();
                return false;
            }
        });

        // Bind event on start stats button
        $('#StartStatistic').on('click', function () {
            var Format = $('#Format').val(),
                $Form = $(this).parents('form');

            // Open both HTML and PDF output in a popup because PDF is shown inline
            if (Format === 'Print' || Format.match(/D3/)) {
                $Form.attr('target', '_blank');
            }
            else {
                $Form.removeAttr('target');
            }
        });

        RestrictionElements = Core.Config.Get('RestrictionElements');
        if (typeof RestrictionElements !== 'undefined') {
            $.each(RestrictionElements, function() {
                TargetNS.ElementAdd('Restrictions', this);
            });
        }

        XAxisElements = Core.Config.Get('XAxisElements');
        if (typeof XAxisElements !== 'undefined') {
            $.each(XAxisElements, function() {
                TargetNS.ElementAdd('XAxis', this);
            });
        }

        YAxisElements = Core.Config.Get('YAxisElements');
        if (typeof YAxisElements !== 'undefined') {
            $.each(YAxisElements, function() {
                TargetNS.ElementAdd('YAxis', this);
            });
        }

        D3Data = Core.Config.Get('D3Data');
        if (typeof D3Data !== 'undefined') {
            Core.UI.AdvancedChart.Init(
                D3Data.Format,
                D3Data.RawData,
                'svg#ChartContent',
                {
                    Duration: 250
                }
            );
        }
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Agent.Statistics || {}));

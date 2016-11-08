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
 * @namespace Core.Agent.Admin.Attachment
 * @memberof Core.Agent.Admin
 * @author OTRS AG
 * @description
 *      This namespace contains the special module function for Attachment module.
 */
 Core.Agent.Admin.Attachment = (function (TargetNS) {

    /**
     * @name Init
     * @memberof Core.Agent.Admin.Attachment
     * @function
     * @description
     *      This function initializes the table filter.
     */
    TargetNS.Init = function () {
        Core.UI.Table.InitTableFilter($("#FilterAttachments"), $("#Attachments"));

        // delete attachment
        TargetNS.AttachmentDelete();
    };

    /**
     * @name AttachmentDelete
     * @memberof Core.Agent.Admin.Attachment
     * @function
     * @description
     *      This function deletes attachment on buton click.
     */
    TargetNS.AttachmentDelete = function () {
        $('.AttachmentDelete').on('click', function () {
            var AttachmentDelete = $(this);

            Core.UI.Dialog.ShowContentDialog(
                $('#DeleteAttachmentDialogContainer'),
                Core.Language.Translate('Delete this Attachment'),
                '240px',
                'Center',
                true,
                [
                    {
                        Class: 'CallForAction Primary',
                        Label: Core.Language.Translate("Confirm"),
                        Function: function() {
                            $('.Dialog .InnerContent .Center').text(Core.Language.Translate("Deleting the attachment and its data. This may take a while..."));
                            $('.Dialog .Content .ContentFooter').remove();

                            Core.AJAX.FunctionCall(
                                Core.Config.Get('Baselink'),
                                AttachmentDelete.data('query-string'),
                                function() {
                                   Core.App.InternalRedirect({
                                       Action: 'AdminAttachment'
                                   });
                                }
                            );
                        }
                    },
                    {
                        Class: 'CallForAction',
                        Label: Core.Language.Translate("Cancel"),
                        Function: function () {
                            Core.UI.Dialog.CloseDialog($('#DeleteAttachmentDialog'));
                        }
                    }
                ]
            );
            return false;
        });
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
 }(Core.Agent.Admin.Attachment || {}));

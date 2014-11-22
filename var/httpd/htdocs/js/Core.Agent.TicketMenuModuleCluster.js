// --
// Core.Agent.TicketMenuModuleCluster.js - provides the application functions
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
 * @exports TargetNS as Core.Agent.TicketAction.MenuModuleCluster
 * @description
 *      This namespace contains the config options and functions.
 */
Core.Agent.TicketMenuModuleCluster = (function (TargetNS) {

    /**
     * @function
     * @private
     * @return nothing
     *      This function initializes the main TicketMenu
     */
    TargetNS.Init = function () {

        /*
         * private variables for TicketMenu
         */
        var TicketMenuTimer = {},
            TicketMenuDuration = 500,
            TicketMenuHoverTimer = {},
            TicketMenuHoverDuration = 350,
            InitialTicketMenuContainerHeight = $('#TicketMenuContainer').css('height'),
            TicketMenuResizeTimeout;

        /**
         * @function
         * @private
         * @return nothing
         *      This function sets the Timeout for closing a subnav
         */
        function CreateSubnavCloseTimeout($Element, TimeoutFunction) {
            TicketMenuTimer[$Element.attr('id')] = setTimeout(TimeoutFunction, TicketMenuDuration);
        }

        /**
         * @function
         * @private
         * @return nothing
         *      This function clears the Timeout for a subnav
         */
        function ClearSubnavCloseTimeout($Element) {
            if (typeof TicketMenuTimer[$Element.attr('id')] !== 'undefined') {
                clearTimeout(TicketMenuTimer[$Element.attr('id')]);
            }
        }

        /**
         * @function
         * @private
         * @return nothing
         *      This function sets the Timeout for closing a subnav
         */
        function CreateSubnavOpenTimeout($Element, TimeoutFunction) {
            TicketMenuHoverTimer[$Element.attr('id')] = setTimeout(TimeoutFunction, TicketMenuHoverDuration);
        }

        /**
         * @function
         * @private
         * @return nothing
         *      This function clears the Timeout for a subnav
         */
        function ClearSubnavOpenTimeout($Element) {
            if (typeof TicketMenuHoverTimer[$Element.attr('id')] !== 'undefined') {
                clearTimeout(TicketMenuHoverTimer[$Element.attr('id')]);
            }
        }

        $('#TicketMenu > li')
            .addClass('CanDrag')
            .filter(function () {
                return $('ul', this).length;
            })
            .bind('mouseenter', function () {
                var $Element = $(this);
                // special treatment for the first menu level: by default this opens submenus only via click,
                //  but the config setting "OpenMainMenuOnHover" also activates opening on hover for it.
                if ($Element.parent().attr('id') !== 'TicketMenu' || Core.Config.Get('OpenMainMenuOnHover')) {

                    // Set Timeout for opening nav
                    CreateSubnavOpenTimeout($Element, function () {
                        $Element.addClass('Active').attr('aria-expanded', true)
                            .siblings().removeClass('Active');

                        // Resize the container in order to display subitems
                        // Due to the needed overflow: hidden property of the
                        // container, they would be hidden otherwise
                        $('#TicketMenuContainer').css('height', '500px');

                        // If Timeout is set for this nav element, clear it
                        ClearSubnavCloseTimeout($Element);
                    });
                }
            })
            .bind('mouseleave', function () {

                var $Element = $(this);

                // Clear Timeout for opening items on hover. Submenus should only be opened intentional,
                // so if the user doesn't hover long enough, he probably doesn't want the submenu to be opened.
                // If Timeout is set for this nav element, clear it
                ClearSubnavOpenTimeout($Element);

                if (!$Element.hasClass('Active')) {
                    return;
                }

                // Set Timeout for closing nav
                CreateSubnavCloseTimeout($Element, function () {
                    $Element.removeClass('Active').attr('aria-expanded', false);
                    if (!$('#TicketMenu > li.Active').length) {
                        $('#TicketMenuContainer').css('height', InitialTicketMenuContainerHeight);
                    }
                });
            })
            .bind('click', function (Event) {

                // if OpenMainMenuOnHover is enabled, clicking the item
                // should lead to the link as regular
                if (Core.Config.Get('OpenMainMenuOnHover')) {
                    return true;
                }

                var $Element = $(this),
                    $Target = $(Event.target);
                if ($Element.hasClass('Active')) {
                    $Element.removeClass('Active').attr('aria-expanded', false);

                    // restore initial container height
                    $('#TicketMenuContainer').css('height', InitialTicketMenuContainerHeight);
                }
                else {
                    $Element.addClass('Active').attr('aria-expanded', true)
                        .siblings().removeClass('Active');
                    $('#TicketMenuContainer').css('height', '300px');

                    // If Timeout is set for this nav element, clear it
                    ClearSubnavCloseTimeout($Element);
                }
                // If element has subTicketMenu, prevent the link
                if ($Target.closest('li').find('ul').length) {
                    Event.preventDefault();
                    return false;
                }
            })
            /*
             * Accessibility support code
             *      Initialize each <li> with subTicketMenu with aria-controls and
             *      aria expanded to indicate what will be opened by that element.
             */
            .each(function () {
                var $Li = $(this),
                    ARIAControlsID = $Li.children('ul').attr('id');

                if (ARIAControlsID && ARIAControlsID.length) {
                    $Li.attr('aria-controls', ARIAControlsID).attr('aria-expanded', false);
                }
            });

        // make the TicketMenu items sortable (if enabled)
        if (Core.Config.Get('MenuDragDropEnabled') === 1) {
            Core.UI.DnD.Sortable(
                $('#TicketMenu'),
                {
                    Items: 'li.CanDrag',
                    Tolerance: 'pointer',
                    Distance: 15,
                    Opacity: 0.6,
                    Helper: 'clone',
                    Axis: 'x',
                    Containment: $('#TicketMenu'),
                    Update: function (event, ui) {

                        // collect TicketMenu bar items
                        var Items = [];
                        $.each($('#TicketMenu').children('li'), function() {
                            Items.push($(this).attr('id'));
                        });

                        // save the new order to the users preferences
                        TargetNS.PreferencesUpdate('UserTicketMenuItemsOrder', Core.JSON.Stringify(Items));

                        $('#TicketMenu').after('<i class="fa fa-check"></i>').next('.fa-check').css('left', $('#TicketMenu').outerWidth() + 10).delay(200).fadeIn(function() {
                            $(this).delay(1500).fadeOut();
                        });

                        // make sure to re-size the nav container to its initial height after
                        // dragging is finished in case a sub menu was open when the user started dragging.
                        $('#TicketMenuContainer').css('height', InitialTicketMenuContainerHeight);
                    }
                }
            );
        }

        /*
         * The TicketMenu elements don't have a class "ARIAHasPopup" which automatically generates the aria-haspopup attribute,
         * because of some code limitation while generating the nav data.
         * Therefore, the aria-haspopup attribute for the TicketMenu is generated manually.
         */
        $('#TicketMenu li').filter(function () {
            return $('ul', this).length;
        }).attr('aria-haspopup', 'true');

        /*
         * Register event for global search
         *
         */
        $('#GlobalSearchNav').bind('click', function (Event) {
            Core.Agent.Search.OpenSearchDialog();
            return false;
        });

        TargetNS.ResizeTicketMenuBar();
        $(window).resize(function() {
            window.clearTimeout(TicketMenuResizeTimeout);
            TicketMenuResizeTimeout = window.setTimeout(function () {
                TargetNS.ResizeTicketMenuBar(true);
            }, 400);
        });
    }

    function TicketMenuBarShowSlideButton(Direction, Difference) {

        var Opposites = (Direction === 'Right') ? 'Left' : 'Right',
            NewPosition,
            HideButton = false,
            Delay = 150;

        if (!$('#TicketMenuContainer').find('.TicketMenuBarNavigate' + Direction).length) {

            $('#TicketMenuContainer')
                .append('<a href="#" title="' + Core.Config.Get('SlideTicketMenuText') + '" class="Hidden TicketMenuBarNavigate' + Direction + '"><i class="fa fa-chevron-' + Direction.toLowerCase() + '"></i></a>')
                .find('.TicketMenuBarNavigate' + Direction)
                .delay(Delay)
                .fadeIn()
                .bind('click', function() {
                    if (Direction === 'Right') {

                        // calculate new scroll position
                        NewPosition = (parseInt($('#TicketMenu').css('left'), 10) * -1) + parseInt($('#TicketMenuContainer').width(), 10);
                        if (NewPosition >= (parseInt($('#TicketMenu').width(), 10) - parseInt($('#TicketMenuContainer').width(), 10))) {
                            NewPosition = parseInt($('#TicketMenu').width(), 10) - parseInt($('#TicketMenuContainer').width(), 10);
                            HideButton = true;
                        }

                        $('#TicketMenu')
                            .animate({
                                'left': NewPosition * -1
                            }, 'fast', function() {

                                if (HideButton) {
                                    $('#TicketMenuContainer')
                                        .find('.TicketMenuBarNavigate' + Direction)
                                        .fadeOut(Delay, function() {
                                            $(this).remove();
                                        });
                                }
                                TicketMenuBarShowSlideButton(Opposites, Difference);
                            });
                    }
                    else {

                        // calculate new scroll position
                        NewPosition = (parseInt($('#TicketMenu').css('left'), 10) * -1) - parseInt($('#TicketMenuContainer').width(), 10);
                        if (NewPosition <= 0) {
                            NewPosition = 0;
                            HideButton = true;
                        }

                        $('#TicketMenu')
                            .animate({
                                'left': NewPosition * -1
                            }, 'fast', function() {
                                if (HideButton) {
                                    $('#TicketMenuContainer')
                                        .find('.TicketMenuBarNavigate' + Direction)
                                        .fadeOut(Delay, function() {
                                            $(this).remove();
                                        });
                                }
                                TicketMenuBarShowSlideButton(Opposites, Difference);
                            });
                    }

                    return false;
                });
        }

    }

    /**
     * @function
     * @private
     * @return nothing
     *      This function re-orders the TicketMenu items based on the users preferences
     */
    TargetNS.ReorderTicketMenuItems = function(TicketMenuCustomOrderItems) {

        var CurrentItems,
            IDA,
            IDB;

        if (TicketMenuCustomOrderItems && Core.Config.Get('MenuDragDropEnabled') === 1) {

            CurrentItems = $('#TicketMenu').children('li').get();
            CurrentItems.sort(function(a, b) {
                var IDA, IDB;

                IDA = $(a).attr('id');
                IDB = $(b).attr('id');


                if ($.inArray(IDA, TicketMenuCustomOrderItems) < $.inArray(IDB, TicketMenuCustomOrderItems)) {
                    return -1;
                }

                if ($.inArray(IDA, TicketMenuCustomOrderItems) > $.inArray(IDB, TicketMenuCustomOrderItems)) {
                    return 1;
                }

                return 0;
            });

            // append the reordered items
            $('#TicketMenu').empty().append(CurrentItems);

            // re-init TicketMenu
            InitTicketMenu();
        }

        $('#TicketMenu').hide().css('visibility', 'visible').show();
    };

    /**
     * @function
     * @return nothing
     *      This function checks if the TicketMenu bar needs to be resized and equipped
     *      with slider TicketMenu buttons. This can only happen if there are too many
     *      TicketMenu icons.
     */
    TargetNS.ResizeTicketMenuBar = function (RealResizeEvent) {

        var TicketMenuBarWidth = 0,
            Difference,
            NewContainerWidth;

        // set the original width (from css) of #TicketMenuContainer to have it available later
        if (!$('#TicketMenuContainer').attr('data-original-width')) {
            $('#TicketMenuContainer').attr('data-original-width', parseInt(parseInt($('#TicketMenuContainer').css('width'), 10) / $('body').width() * 100, 10) + '%');
        }

        // on resizing we set the position back to left to be sure
        // to have everything displayed correctly
        $('#TicketMenu').css('left', '0px');
        $('.TicketMenuBarNavigateLeft').remove();

        $('#TicketMenu > li').each(function() {
            TicketMenuBarWidth += parseInt($(this).outerWidth(true), 10);
        });
        $('#TicketMenu').css('width', (TicketMenuBarWidth + 2) + 'px');

        if (TicketMenuBarWidth > $('#TicketMenuContainer').outerWidth()) {
            TicketMenuBarShowSlideButton('Right', parseInt($('#TicketMenuContainer').outerWidth(true) - TicketMenuBarWidth, 10));
        }
        else if (TicketMenuBarWidth < $('#TicketMenuContainer').outerWidth(true)) {
            $('.TicketMenuBarNavigateRight, .TicketMenuBarNavigateLeft').remove();

            if ($('body').hasClass('RTL')) {
                $('#TicketMenu').css({
                    'left': 'auto',
                    'right': '0px'
                });
            }
            else {
                $('#TicketMenu').css({
                    'left': '0px',
                    'right': 'auto'
                });
            }
        }
    };

    return TargetNS;
}(Core.Agent.TicketMenuModuleCluster || {}));

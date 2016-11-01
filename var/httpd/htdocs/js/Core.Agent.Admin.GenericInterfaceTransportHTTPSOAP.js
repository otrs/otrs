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
 * @namespace Core.Agent.Admin.GenericInterfaceTransportHTTPSOAP
 * @memberof Core.Agent.Admin
 * @author OTRS AG
 * @description
 *      This namespace contains the special module functions for the GenericInterface Transport HTTP SOAP module.
 */
Core.Agent.Admin.GenericInterfaceTransportHTTPSOAP = (function (TargetNS) {

    /**
     * @name Init
     * @memberof Core.Agent.Admin.GenericInterfaceTransportHTTPSOAP
     * @function
     * @description
     *      This function binds events to certain actions
     */
    TargetNS.Init = function () {

        // bind change function to Request Name Scheme field
        $('#RequestNameScheme').on('change', function(){
            if ($(this).val() === 'Append' || $(this).val() === 'Replace') {
                $('.RequestNameFreeTextField').removeClass('Hidden');
                $('#RequestNameFreeText').addClass('Validate_Required');
            }
            else {
                $('.RequestNameFreeTextField').addClass('Hidden');
                $('#RequestNameFreeText').removeClass('Validate_Required');
            }
        });

        // bind change function to Response Name Scheme field
        $('#ResponseNameScheme').on('change', function(){
            if ($(this).val() === 'Append' || $(this).val() === 'Replace') {
                $('.ResponseNameFreeTextField').removeClass('Hidden');
                $('#ResponseNameFreeText').addClass('Validate_Required');
            }
            else {
                $('.ResponseNameFreeTextField').addClass('Hidden')
                $('#ResponseNameFreeText').removeClass('Validate_Required');
            }
        });

        // bind change function to SOAP Action field
        $('#SOAPAction').on('change', function(){
            if ($(this).val() === 'Yes') {
                $('.SOAPActionField').removeClass('Hidden');
            }
            else {
                $('.SOAPActionField').addClass('Hidden');
            }
        });
       
        // SOAP Header  
        $('#SOAPHeaderAdd').click(function () {
            var header_key = $('#SOAPHeaderKey').val();
            var header_value = $('#SOAPHeaderValue').val();
            var header_count = parseInt($('#SOAPHeaderDataCount').val());
            header_count = header_count + 1;
            
            if (header_key === '' || header_value === '') return false;
            
            var separator = ' ';
            var input1 = '<input type="text" value="' + header_key + '" />';
            var input2 = '<input type="text" value="' + header_value + '" />';
            var deletespan = '<span class="SOAPHeaderKeyValuePairDelete" style="cursor: pointer;"><i class="fa fa-minus-square-o" aria-hidden="true"></i></span>';
            var newli = '<li id="SOAPHeaderKeyValuePair_' + header_count + '" style="margin-bottom: 2px;">' + input1 + separator + input2 + separator + deletespan + '</li>';
            
            var $ul = $('#SOAPHeaderKeyValueData');
            $ul.append(newli);
            
            $('#SOAPHeaderDataCount').val(header_count);
            
            return false;
        });

        $(document).on('click', '.SOAPHeaderKeyValuePairDelete', function(){
            var $this = $(this);
            
            // delete element
            $this.parent().remove();
            
            // set the correct amount of children to parent ul
            var li_count = $('#SOAPHeaderKeyValueData').children('li').length;
            $('#SOAPHeaderDataCount').val(li_count);
            
            // set correct index for each children
            var i = 1;
            $('#SOAPHeaderKeyValueData').children('li').each(function() {
                        var $this = $(this);
                        
                        $this.prop('id', 'SOAPHeaderKeyValuePair_' + i);
                        
                        i = i + 1;
            });
            
            return false;
        });

        $('#TransportConfigForm').on('submit.GenerateJSON', function() {
            var Items = false,
                Value = '',
                Result = [];
            
            // get key value pairs for SOAP header
            $('#SOAPHeaderKeyValueData').children('li').each(function() {
                var $this = $(this);
                var header_key = $this.children('input').eq(0).val();
                var header_value = $this.children('input').eq(1).val();
                
                var data = {};
                data[header_key] = header_value;
                
                Result.push(data);
            });
    
            if (Result.length) {
                Value = Core.JSON.Stringify(Result);
            }
    
            $('#SOAPHeader').val(Value);
        });

        var headerdata = $('#SOAPHeader').val();
        if (headerdata !== '') {
            var header = Core.JSON.Parse(headerdata);
            var $ul = $('#SOAPHeaderKeyValueData');
    
            var separator = ' ';
            var input1 = '<input type="text" value="' + header_key + '" />';
            var input2 = '<input type="text" value="' + header_value + '" />';
            var deletespan = '<span class="SOAPHeaderKeyValuePairDelete" style="cursor: pointer;"><i class="fa fa-minus-square-o" aria-hidden="true"></i></span>';
            var $ul = $('#SOAPHeaderKeyValueData');
    
            var i = 1;
            for(var propt in header) {
                var header_key = Object.keys(header[propt])[0];
                var input1 = '<input type="text" value="' + header_key + '" />';
                var header_value = header[propt][header_key];
                var input2 = '<input type="text" value="' + header_value + '" />';
        
                var newli = '<li id="SOAPHeaderKeyValuePair_' + i + '" style="margin-bottom: 2px;">' + input1 + separator + input2 + separator + deletespan + '</li>';
        
                $ul.append(newli);
        
                i = i + 1;
            }
        }

        // bind change function to Authentication field
        $('#Authentication').on('change', function(){
            if ($(this).val() === 'BasicAuth') {
                $('.BasicAuthField').removeClass('Hidden');
                $('.BasicAuthField').find('#UserName').each(function(){
                    $(this).addClass('Validate_Required');
                });
            }
            else {
                $('.BasicAuthField').addClass('Hidden');
                $('.BasicAuthField').find('#User').each(function(){
                    $(this).removeClass('Validate_Required');
                });
            }
        });

        // bind change function to Use SSL field
        $('#UseSSL').on('change', function(){
            if ($(this).val() === 'Yes') {
                $('.SSLField').removeClass('Hidden');
                $('.SSLField').find('#SSLP12Certificate').each(function(){
                    $(this).addClass('Validate_Required');
                });
                $('.SSLField').find('#SSLP12Password').each(function(){
                    $(this).addClass('Validate_Required');
                });
            }

            else {
                $('.SSLField').addClass('Hidden');
                $('.SSLField').find('#SSLP12Certificate').each(function(){
                    $(this).removeClass('Validate_Required');
                });
                $('.SSLField').find('#SSLP12Password').each(function(){
                    $(this).removeClass('Validate_Required');
                });
            }
        });

        // bind click function to Save and finish button
        $('#SaveAndFinishButton').on('click', function(){
            $('#ReturnToWebservice').val(1);
        });

        Core.Agent.SortedTree.Init($('.SortableList'), $('#TransportConfigForm'), $('#Sort'), Core.Config.Get('SortData'));
    };

    Core.Init.RegisterNamespace(TargetNS, 'APP_MODULE');

    return TargetNS;
}(Core.Agent.Admin.GenericInterfaceTransportHTTPSOAP || {}));

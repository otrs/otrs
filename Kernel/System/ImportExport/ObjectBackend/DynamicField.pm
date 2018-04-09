# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::ImportExport::ObjectBackend::DynamicField;

use strict;
use warnings;

use List::Util qw(min);	
use MIME::Base64;
use Kernel::Language qw(Translatable);
use Kernel::System::VariableCheck qw(:all);

our @ObjectDependencies = (
    'Kernel::Config',
    'Kernel::System::SysConfig',
    'Kernel::System::GenericInterface::Webservice',
    'Kernel::System::StandardTemplate',
    'Kernel::System::Signature',
    'Kernel::System::AutoResponse',
    'Kernel::System::Salutation',
    'Kernel::System::NotificationEvent',
    'Kernel::System::GenericAgent',
    'Kernel::System::ProcessManagement::DB::Process',
    'Kernel::System::ProcessManagement::DB::Activity',
    'Kernel::System::ProcessManagement::DB::Transition',
    'Kernel::System::ProcessManagement::DB::TransitionAction',
    'Kernel::System::ProcessManagement::DB::Dialog',
    'Kernel::System::PostMaster::Filter',
    'Kernel::System::ACL::DB::ACL',
    'Kernel::System::DynamicField',
    'Kernel::System::JSON',
    'Kernel::System::ImportExport',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::ImportExport::ObjectBackend::DynamicField - import/export backend for DynamicField

=head1 DESCRIPTION

All functions to import and export dynamic fields.

=head1 PUBLIC INTERFACE

=head2 new()

create an object

    use Kernel::System::ObjectManager;
    local $Kernel::OM = Kernel::System::ObjectManager->new();
    my $BackendObject = $Kernel::OM->Get('Kernel::System::ImportExport::ObjectBackend::DynamicField');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 ObjectAttributesGet()

get the object attributes of an object as a ref to an array of hash references

    my $Attributes = $ObjectBackend->ObjectAttributesGet(
        UserID => 1,
    );

=cut

sub ObjectAttributesGet {
    my ( $Self, %Param ) = @_;

    # check needed object
    if ( !$Param{UserID} ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => 'Need UserID!',
        );
        return;
    }


    my $Attributes = [
        {
            Key   => 'OverwriteSameOnImport',
            Name  => Translatable('Overwrite existing field on import'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'ChangeProcessFieldNames',
            Name  => Translatable('modify dynamic field names used in processes if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'ChangePostMasterFilterFieldNames',
            Name  => Translatable('modify dynamic field names used in postmaster filter if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'ChangeACLFieldNames',
            Name  => Translatable('modify dynamic field names used in ACL if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'ChangeGenericAgentFieldNames',
            Name  => Translatable('modify dynamic field names used in GenericAgent if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'ChangeNotificationFieldNames',
            Name  => Translatable('modify dynamic field names used in Notifications if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },        
        {
            Key   => 'ChangeSalutationFieldNames',
            Name  => Translatable('modify dynamic field names used in Salutations if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },   
        {
            Key   => 'ChangeAutoResponseFieldNames',
            Name  => Translatable('modify dynamic field names used in AutoResponses if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },     
        {
            Key   => 'ChangeSignatureFieldNames',
            Name  => Translatable('modify dynamic field names used in signatures if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },      
        {
            Key   => 'ChangeTemplatesFieldNames',
            Name  => Translatable('modify dynamic field names used in templates if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },  
        {
            Key   => 'ChangeGenericInterfaceFieldNames',
            Name  => Translatable('modify dynamic field names used in generic interface if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },  
        {
            Key   => 'ChangeFieldNames',
            Name  => Translatable('modify dynamic field names used in processes if import is via ID as Identfier'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'EncodeConfigBASE64',
            Name  => Translatable('Encode/Decode Config as base64 (useful if only commas are used in csv etc.'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'ReorderOnImport',
            Name  => Translatable('Reorder on Import'),
            Input => {
                Type => 'Checkbox',
            },
        },
        {
            Key   => 'DefaultFieldOrder',
            Name  => Translatable('Default Order for import new without order given'),
            Input => {
                Type         => 'Text',
                ValueDefault => '10',
                Required     => 1,
                Regex        => qr{ \A \d+ \z }xms,
                Translation  => 0,
                Size         => 5,
                MaxLength    => 5,
                DataType     => 'IntegerBiggerThanZero',
            },
        },
    ];

    return $Attributes;
}

=head2 MappingObjectAttributesGet()

get the mapping attributes of an object as array/hash reference

    my $Attributes = $ObjectBackend->MappingObjectAttributesGet(
        TemplateID => 123,
        UserID     => 1,
    );

=cut

sub MappingObjectAttributesGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # get object data
    my $ObjectData = $Kernel::OM->Get('Kernel::System::ImportExport')->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    return [] if !$ObjectData;
    return [] if ref $ObjectData ne 'HASH';

    my $ElementList = [
        {
            Key   => 'ID',
            Value => Translatable('ID'),
        },
        {
            Key   => 'InternalField',
            Value => Translatable('Internal Field'),
        },
        {
            Key   => 'Name',
            Value => Translatable('Name (required)'),
        },
        {
            Key   => 'Label',
            Value => Translatable('Label (required)'),
        },
        {
            Key   => 'FieldOrder',
            Value => Translatable('Field Order'),
        },
        {
            Key   => 'FieldType',
            Value => Translatable('Field Type (required)'),
        },
        {
            Key   => 'ObjectType',
            Value => Translatable('Object Type (required)'),
        },
        {
            Key   => 'Config',
            Value => Translatable('Config (required)'),
        },
        {
            Key   => 'ValidID',
            Value => Translatable('Valid State(required)'),
        },
        {
            Key   => 'CreateTime',
            Value => Translatable('Create Time'),
        },
        {
            Key   => 'ChangeTime',
            Value => Translatable('Change Time'),
        },
    ];


    my $Attributes = [
        {
            Key   => 'Key',
            Name  => Translatable('Key'),
            Input => {
                Type         => 'Selection',
                Data         => $ElementList,
                Required     => 1,
                Translation  => 0,
                PossibleNone => 1,
            },
        },
        {
            Key   => 'Identifier',
            Name  => Translatable('Identifier'),
            Input => {
                Type => 'Checkbox',
            },
        },
    ];

    return $Attributes;
}

=head2 SearchAttributesGet()

get the search object attributes of an object as array/hash reference

    my $AttributeList = $ObjectBackend->SearchAttributesGet(
        TemplateID => 123,
        UserID     => 1,
    );

=cut

sub SearchAttributesGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # get object data
    my $ObjectData = $Kernel::OM->Get('Kernel::System::ImportExport')->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    return [] if !$ObjectData;
    return [] if ref $ObjectData ne 'HASH';

	my $DynamicFieldObject = $Kernel::OM->Get("Kernel::System::DynamicField");
	my $ProcessObject = $Kernel::OM->Get("Kernel::System::ProcessManagement::DB::Process");

	my $DynamicFieldList = $DynamicFieldObject->DynamicFieldList(Valid => 0,ResultType => 'HASH', );
	my $ProcessList = $ProcessObject->ProcessList(UserID => 1);

    my $AttributeList = [
        {
            Key   => 'DynamicFieldIDs',
            Name  => Translatable('dynamic fields'),
            Input => {
                Type        => 'Selection',
                Data        => $DynamicFieldList,
                Translation => 0,
                Size        => 5,
                Multiple    => 1,
            },
        },
        {
            Key   => 'ProcessIDs',
            Name  => Translatable('dynamic fields used in processes'),
            Input => {
                Type        => 'Selection',
                Data        => $ProcessList,
                Translation => 0,
                Size        => 5,
                Multiple    => 1,
            },
        },
    ];



    return $AttributeList;
}

=head2 ExportDataGet()

get export data as C<2D-array-hash> reference

    my $ExportData = $ObjectBackend->ExportDataGet(
        TemplateID => 123,
        UserID     => 1,
    );

=cut

sub ExportDataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # get object data
    my $ObjectData = $Kernel::OM->Get('Kernel::System::ImportExport')->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check object data
    if ( !$ObjectData || ref $ObjectData ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "No object data found for the template id $Param{TemplateID}",
        );
        return;
    }

    # get the mapping list
    my $MappingList = $Kernel::OM->Get('Kernel::System::ImportExport')->MappingList(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check the mapping list
    if ( !$MappingList || ref $MappingList ne 'ARRAY' || !@{$MappingList} ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => "No valid mapping list found for the template id $Param{TemplateID}",
        );
        return;
    }

    # create the mapping object list
    my @MappingObjectList;
    for my $MappingID ( @{$MappingList} ) {

        # get mapping object data
        my $MappingObjectData = $Kernel::OM->Get('Kernel::System::ImportExport')->MappingObjectDataGet(
            MappingID => $MappingID,
            UserID    => $Param{UserID},
        );

        # check mapping object data
        if ( !$MappingObjectData || ref $MappingObjectData ne 'HASH' ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "No valid mapping list found for the template id $Param{TemplateID}",
            );
            return;
        }

        push @MappingObjectList, $MappingObjectData;
    }

    # get search data
    my $SearchData = $Kernel::OM->Get('Kernel::System::ImportExport')->SearchDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    return if !$SearchData || ref $SearchData ne 'HASH';
          
    # extract Configured Filter
    my @DynamicFieldIDs;
    @DynamicFieldIDs = split '#####', $SearchData->{DynamicFieldIDs} if $SearchData->{DynamicFieldIDs};
    my @ProcessIDs;
    @ProcessIDs = split '#####', $SearchData->{ProcessIDs} if $SearchData->{ProcessIDs};

	# get Objects
	my $DynamicFieldObject = $Kernel::OM->Get("Kernel::System::DynamicField");
	my $ProcessObject = $Kernel::OM->Get("Kernel::System::ProcessManagement::DB::Process");
	my $ProcessActivityObject = $Kernel::OM->Get("Kernel::System::ProcessManagement::DB::Activity");
	my $ProcessActivityDialogObject = $Kernel::OM->Get("Kernel::System::ProcessManagement::DB::ActivityDialog");
	my $JSONObject = $Kernel::OM->Get("Kernel::System::JSON");

    my $DynamicFieldList = [];
    # all fields if no filter present
    if (!scalar @DynamicFieldIDs && !scalar @ProcessIDs)
    { 
    		$DynamicFieldList = $DynamicFieldObject->DynamicFieldListGet(
        		Valid        => 0,  
    		);
    }    
    
    # get fixed dynamic fields
    if (scalar @DynamicFieldIDs)
    {
    		$DynamicFieldList = [];
    		for my $id (@DynamicFieldIDs)
    		{
    			push @{$DynamicFieldList}, $DynamicFieldObject->DynamicFieldGet(ID => $id);
    		}
    }
    
    #get all process used dynamic fields
    PROCESS:
    if (scalar @ProcessIDs)
    {
    		for my $ProcessID (@ProcessIDs)
    		{
    			my $procdef = $ProcessObject->ProcessGet(ID => $ProcessID, UserID => 1);
    			next PROCESS if !$procdef;

    			for my $ActivityEntity (@{$procdef->{Activities}})
    			{
    				my $Activity = $ProcessActivityObject->ActivityGet(EntityID => $ActivityEntity, UserID => 1);
    				next PROCESS if !$Activity;

    				for my $DialogEntity (@{$Activity->{ActivityDialogs}})
    				{
    					my $DialogConfig = $ProcessActivityDialogObject->ActivityDialogGet(EntityID => $DialogEntity, UserID => 1);
    					next PROCESS if !$DialogConfig;
    					my @fields = grep s{DynamicField_(\w+)}{$1}xms, keys %{$DialogConfig->{Config}->{Fields}};
    					for my $fieldname (@fields)
    					{
    						my $DynamicFieldConfig = $DynamicFieldObject->DynamicFieldGet(Name => $fieldname);
    						if ($DynamicFieldConfig && !scalar (grep $_->{ID} == $DynamicFieldConfig->{ID}, @{$DynamicFieldList}))
    						{
    							push @{$DynamicFieldList}, $DynamicFieldConfig;
    						}
    					}
    				}
    			}
    		}
    }

    my @ExportData;
    DYNAMICFIELD:
    for my $DynamicField (@{$DynamicFieldList})
    {
    		my @Item;
        MAPPINGOBJECT:
        for my $MappingObject (@MappingObjectList) 
        {
            # extract key
            my $Key = $MappingObject->{Key};
            
            # handle config 
            if ( $Key eq 'Config' ) {
            		my $datastring = $JSONObject->Encode('Data' => $DynamicField->{$Key});
            		if ($ObjectData->{EncodeConfigBASE64}) 
            		{
            			$datastring = encode_base64($datastring);
            		}
                push @Item, $datastring;
                next MAPPINGOBJECT;
            }            
            push @Item, $DynamicField->{$Key};
        }
    		push @ExportData, \@Item;
    		
    }


    return \@ExportData;
}

=head2 ImportDataSave()

imports a single entity of the import data. The C<TemplateID> points to the definition
of the current import. C<ImportDataRow> holds the data. C<Counter> is only used in
error messages, for indicating which item was not imported successfully.

=cut

sub ImportDataSave {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for my $Argument (qw(TemplateID ImportDataRow Counter UserID)) {
        if ( !$Param{$Argument} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $Argument!",
            );
            return;
        }
    }

    # check import data row
    if ( ref $Param{ImportDataRow} ne 'ARRAY' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                "Can't import entity $Param{Counter}: "
                . "ImportDataRow must be an array reference",
        );
        return;
    }

    # get object data
    my $ObjectData = $Kernel::OM->Get('Kernel::System::ImportExport')->ObjectDataGet(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check object data
    if ( !$ObjectData || ref $ObjectData ne 'HASH' ) {
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                "Can't import entity $Param{Counter}: "
                . "No object data found for the template id '$Param{TemplateID}'",
        );
        return;
    }


    # get the mapping list
    my $MappingList = $Kernel::OM->Get('Kernel::System::ImportExport')->MappingList(
        TemplateID => $Param{TemplateID},
        UserID     => $Param{UserID},
    );

    # check the mapping list
    if ( !$MappingList || ref $MappingList ne 'ARRAY' || !@{$MappingList} ) {

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                "Can't import entity $Param{Counter}: "
                . "No valid mapping list found for the template id '$Param{TemplateID}'",
        );
        return;
    }

    # create the mapping object list
    my @MappingObjectList;
    for my $MappingID ( @{$MappingList} ) {

        # get mapping object data
        my $MappingObjectData = $Kernel::OM->Get('Kernel::System::ImportExport')->MappingObjectDataGet(
            MappingID => $MappingID,
            UserID    => $Param{UserID},
        );

        # check mapping object data
        if ( !$MappingObjectData || ref $MappingObjectData ne 'HASH' ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message =>
                    "Can't import entity $Param{Counter}: "
                    . "No mapping object data found for the mapping id '$MappingID'",
            );
            return;
        }

        push @MappingObjectList, $MappingObjectData;
    }

    # check and remember the Identifiers
    # the Identifiers identify the config item that should be updated
    my %Identifier;
    my $RowIndex = 0;
    MAPPINGOBJECTDATA:
    for my $MappingObjectData (@MappingObjectList) {

        next MAPPINGOBJECTDATA if !$MappingObjectData->{Identifier};

        # check if identifier already exists
        if ( $Identifier{ $MappingObjectData->{Key} } ) {

            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message =>
                    "Can't import entity $Param{Counter}: "
                    . "'$MappingObjectData->{Key}' has been used multiple times as an identifier",
            );
            return;
        }

        # set identifier value
        $Identifier{ $MappingObjectData->{Key} } = $Param{ImportDataRow}->[$RowIndex];

        next MAPPINGOBJECTDATA if $MappingObjectData->{Key} && $Param{ImportDataRow}->[$RowIndex];

        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message =>
                "Can't import entity $Param{Counter}: "
                . "Identifier field is empty",
        );

        return;
    }
    continue {
        $RowIndex++;
    }
    
	my $DynamicFieldObject = $Kernel::OM->Get("Kernel::System::DynamicField");
	my $JSONObject = $Kernel::OM->Get("Kernel::System::JSON");
	
    my $DynamicFieldList = $DynamicFieldObject->DynamicFieldListGet(
        Valid        => 0,            # optional, defaults to 1
    );
    
    if (%Identifier) 
    {
    		for my $id (keys %Identifier)
    		{
    			$DynamicFieldList = [grep $_->{$id} eq $Identifier{$id},@{$DynamicFieldList} ]; # filter all fields matching this criteria
    		}
    }
    
    my %DynamicFieldData;
    $RowIndex = 0;
    for my $MappingObjectData (@MappingObjectList) 
    {

        # just for convenience
        my $Key   = $MappingObjectData->{Key};
        my $Value = $Param{ImportDataRow}->[ $RowIndex++ ];

        if ( $Key eq 'Config' ) {

			if ($ObjectData->{EncodeConfigBASE64}) 
            	{
            		$Value = decode_base64($Value);
            	}
            	$Value = $JSONObject->Decode('Data' => $Value);
        } 
        $DynamicFieldData{$Key} = $Value;
    }
    $DynamicFieldData{UserID} = $Param{UserID};
    $DynamicFieldData{Reorder} = $ObjectData->{ReorderOnImport} || 0;
    $DynamicFieldData{FieldOrder} = $DynamicFieldData{FieldOrder} || $ObjectData->{DefaultFieldOrder};
      	
    	
    	if (scalar @{$DynamicFieldList} == 1)
    	{

    		# exactly one Field left to update
         my %currentDynamicField = %{$DynamicFieldList->[0]};
         
		#check if we are allowed to update
		if ( !$ObjectData->{OverwriteSameOnImport})
		{
			 my $RetCode = "update of $DynamicFieldData{Name} not done because not selected";
        		return $DynamicFieldData{ID}, $RetCode;
		}
		
         $DynamicFieldData{ID} = $currentDynamicField{ID};	#overwrite the ID with the one to be updated
         
         if ($DynamicFieldData{Name} ne $currentDynamicField{Name})
         {
         	# if name would change.. check for uniqueness
     		if (!$DynamicFieldObject->DynamicFieldGet(Name => $DynamicFieldData{'Name'}, ))
    			{
    				my $RetCode = "dupplicated name for import found";
    				return undef, $RetCode;    ## no critic
    			}
         }
   
        my $ret = $DynamicFieldObject->DynamicFieldUpdate(%DynamicFieldData);
    		if ( !$ret ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message =>
                    "Can't update entity : $DynamicFieldData{Name}"
                    . "Error when updating the  dynamic field.",
            );
            return;
        }

        
      
        # update dynamic fields in generic interface if requested
        if ($ObjectData->{ChangeGenericInterfaceFieldNames})
        {
        		# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{   
        			my $WebserviceObject = $Kernel::OM->Get('Kernel::System::GenericInterface::Webservice');
        			my $Webservices = $WebserviceObject->WebserviceList(Valid => 0);
        			for my $WebserviceID (keys %{$Webservices})
        			{
        				my $Webservice = $WebserviceObject->WebserviceGet(ID => $WebserviceID);
        				my $JSONString = $JSONObject->Encode(Data => $Webservice);
        				# tag without _Value
					$JSONString =~ s/DynamicField_$currentDynamicField{Name}/DynamicField_$DynamicFieldData{Name}/g;
					# tag with _Value
					$JSONString =~ s/DynamicField_$currentDynamicField{Name}_Value/DynamicField_$DynamicFieldData{Name}_Value/g;
        				$Webservice = $JSONObject->Decode(Data => $JSONString);        	
        				$Webservice->{UserID} = $Param{UserID};
        				$WebserviceObject->WebserviceUpdate(%{$Webservice});			
        			}
        		}
        }
        
        # update dynamic fields in templates if requested
        if ($ObjectData->{ChangeTemplatesFieldNames})
        {
        		# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $TemplateObject = $Kernel::OM->Get("Kernel::System::StandardTemplate");
        			my %Templates = $TemplateObject->StandardTemplateList(Valid => 0);
        			for my $TemplateID (keys %Templates)
        			{
        				my %Template = $TemplateObject->StandardTemplateGet(ID => $TemplateID);
        				my $JSONString = $JSONObject->Encode(Data => \%Template);
        				# tag without _Value
					$JSONString =~ s/DynamicField_$currentDynamicField{Name}/DynamicField_$DynamicFieldData{Name}/g;
					# tag with _Value
					$JSONString =~ s/DynamicField_$currentDynamicField{Name}_Value/DynamicField_$DynamicFieldData{Name}_Value/g;
        				
        				%Template = %{$JSONObject->Decode(Data => $JSONString)};
        				$Template{UserID} = $Param{UserID};
        				$TemplateObject->StandardTemplateUpdate(%Template);	
        			}
        		}
        } 

        # update dynamic fields in signatures if requested
        if ($ObjectData->{ChangeSignatureFieldNames})
        {
        		# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $SignatureObject = $Kernel::OM->Get("Kernel::System::Signature");
        			my %Signatures = $SignatureObject->SignatureList(Valid => 0);
        			for my $SignatureID (keys %Signatures)
        			{
        				my %Signature = $SignatureObject->SignatureGet(ID => $SignatureID);
        				my $JSONString = $JSONObject->Encode(Data => \%Signature);
        				# tag without _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}/DynamicField_$DynamicFieldData{Name}/g;
						# tag with _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}_Value/DynamicField_$DynamicFieldData{Name}_Value/g;
        				
        				%Signature = %{$JSONObject->Decode(Data => $JSONString)};
        				$Signature{UserID} = $Param{UserID};
        				$SignatureObject->SignatureUpdate(%Signature);	
        			}
        		}
        }     
        
        # update dynamic fields in AutoResponse if requested
        if ($ObjectData->{ChangeAutoResponseFieldNames})
        {
        		# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $AutoResponseObject = $Kernel::OM->Get("Kernel::System::AutoResponse");
        			my %AutoResponses = $AutoResponseObject->AutoResponseList(Valid => 0);
        			for my $AutoResponseID (keys %AutoResponses)
        			{
        				my %AutoResponse = $AutoResponseObject->AutoResponseGet(ID => $AutoResponseID);
        				my $JSONString = $JSONObject->Encode(Data => \%AutoResponse);
        				# tag without _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}/DynamicField_$DynamicFieldData{Name}/g;
						# tag with _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}_Value/DynamicField_$DynamicFieldData{Name}_Value/g;
        				
        				%AutoResponse = %{$JSONObject->Decode(Data => $JSONString)};
        				$AutoResponse{UserID} = $Param{UserID};
        				$AutoResponseObject->AutoResponseUpdate(%AutoResponse);	
        			}
        		}
        }
        
        # update dynamic fields in salutations if requested
        if ($ObjectData->{ChangeSalutationFieldNames})
        {
        		# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $SalutationObject = $Kernel::OM->Get("Kernel::System::Salutation");
        			my %SalutationList = $SalutationObject->SalutationList(Valid => 0);
        			for my $SalutationID (keys %SalutationList)
				{
					my %Salutation = $SalutationObject->SalutationGet(ID => $SalutationID,);
					my $JSONString = $JSONObject->Encode(Data => \%Salutation);
        				# tag without _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}/DynamicField_$DynamicFieldData{Name}/g;
						# tag with _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}_Value/DynamicField_$DynamicFieldData{Name}_Value/g;
        				
        				%Salutation = %{$JSONObject->Decode(Data => $JSONString)};
        				$Salutation{UserID} = $Param{UserID};
        				$SalutationObject->SalutationUpdate(%Salutation);	
				}
        		}        	
        }
        
        # update dynamic fields in Notifications if requested
        if ($ObjectData->{ChangeNotificationFieldNames})
        {
        		# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $NotificationObject = $Kernel::OM->Get('Kernel::System::NotificationEvent');
        			my %Notifications = $NotificationObject->NotificationList(Details => 1,All => 1);
        			for my $NotificationID (keys %Notifications)
        			{
        				my $JSONString = $JSONObject->Encode(Data => $Notifications{$NotificationID});
        				# Event
						$JSONString =~ s/"TicketDynamicFieldUpdate_$currentDynamicField{Name}"/"TicketDynamicFieldUpdate_$DynamicFieldData{Name}"/g;
	        				# tag without _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}/DynamicField_$DynamicFieldData{Name}/g;
						# tag with _Value
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}_Value/DynamicField_$DynamicFieldData{Name}_Value/g;
        				
        				my %Notification = %{$JSONObject->Decode(Data => $JSONString)};
        				$Notification{UserID} = $Param{UserID};
        				$NotificationObject->NotificationUpdate(%Notification);
        			}
        		}
        } 
        
        # update dynamic fields in GenericAgent if requested
        if ($ObjectData->{ChangeGenericAgentFieldNames})
        {
         	# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $GenericAgentObject = $Kernel::OM->Get('Kernel::System::GenericAgent');
        			my %Jobs = $GenericAgentObject->JobList();
        			for my $JobName (keys %Jobs)
        			{
        				my %Job = $GenericAgentObject->JobGet(Name => $JobName) ;
        				my $JSONString = $JSONObject->Encode(Data => \%Job);
        				# Event
						$JSONString =~ s/TicketDynamicFieldUpdate_$currentDynamicField{Name}/TicketDynamicFieldUpdate_$DynamicFieldData{Name}/g;
        				# Search
						$JSONString =~ s/Search_DynamicField_$currentDynamicField{Name}/Search_DynamicField_$DynamicFieldData{Name}/g;
						# Setter
						$JSONString =~ s/DynamicField_$currentDynamicField{Name}/DynamicField_$DynamicFieldData{Name}/g;
        				
        				my $Job = $JSONObject->Decode(Data => $JSONString);
	        				
						$GenericAgentObject->JobDelete(Name => $JobName, UserID => $Param{UserID});
						$GenericAgentObject->JobAdd(Name => $JobName, UserID => $Param{UserID}, Data => $Job);
        			}
        		}        	
        }
        
        # update dynamic fields in ACL if requested
        if ($ObjectData->{ChangeACLFieldNames})
        {
         	# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $ACLObject = $Kernel::OM->Get('Kernel::System::ACL::DB::ACL');
        			my $ACLList = $ACLObject->ACLListGet(UserID => 1);
        			
        			for my $ACL (@{$ACLList})
        			{
						my $JSONString = $JSONObject->Encode(Data => $ACL);
        				# tag without _Value
						$JSONString =~ s/"DynamicField_$currentDynamicField{Name}"/"DynamicField_$DynamicFieldData{Name}"/g;
						# tag with _Value
						$JSONString =~ s/"DynamicField_$currentDynamicField{Name}_Value"/"DynamicField_$DynamicFieldData{Name}_Value"/g;
	        				
	        				
        				$ACL = $JSONObject->Decode(Data => $JSONString);
						$ACLObject->ACLUpdate(%{$ACL},UserID => $Param{UserID});
        			}
    		}       	
        }
        
        # update dynamic fields in postmaster filter if requested
        if ($ObjectData->{ChangePostMasterFilterFieldNames})
        {
        	    # check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
        			my $PostmasterFilterObject = $Kernel::OM->Get('Kernel::System::PostMaster::Filter');
        			my %FilterList = $PostmasterFilterObject->FilterList();

                for my $filtername (keys %FilterList)
                {
                		my %filter = $PostmasterFilterObject->FilterGet(Name => $filtername);
                		
                		for my $key (qw (Set Not Match))
                		{
                			$filter{$key} = [
	                			map {
	                				my $Key = $_->{'Key'};
	                				my $Value = $_->{'Value'};
	                				$Key =~ s/DynamicField-$currentDynamicField{Name}$/DynamicField-$DynamicFieldData{Name}/;
	                				if ($Value)
	                				{
	                					# tag without _Value
										$Value =~ s/DynamicField_$currentDynamicField{Name}>/DynamicField_$DynamicFieldData{Name}>/g;
										# tag with _Value
										$Value =~ s/DynamicField_$currentDynamicField{Name}_Value>/DynamicField_$DynamicFieldData{Name}_Value>/g;
	                				}
	                				{
	                					'Key' => $Key,
	                					'Value' => $Value
	                				}
	                			} @{$filter{$key}}
                			];
                		}
                		$PostmasterFilterObject->FilterDelete(Name => $filtername);
                		$PostmasterFilterObject->FilterAdd(%filter);	
                }
        	}
        }
 
        # update dynamic fields in processes if requested
        if ($ObjectData->{ChangeProcessFieldNames})
        {
        		# check if ID is selected as Identifier and Names differ
        		if (scalar keys %Identifier == 1 && (keys %Identifier)[0] eq 'ID' && $DynamicFieldData{Name} ne $currentDynamicField{Name})
        		{
				# get all activity dialogs
				my $ProcessActivityDialogObject = $Kernel::OM->Get("Kernel::System::ProcessManagement::DB::ActivityDialog");
				my $ActivityDialogs = $ProcessActivityDialogObject->ActivityDialogListGet(UserID => 1,);
				for my $ActivityDialog (@{$ActivityDialogs})
				{                    
					# change fieldname in fieldorder
					$ActivityDialog->{Config}->{FieldOrder} = [
						map { $_ =~ s/^DynamicField_$currentDynamicField{Name}$/DynamicField_$DynamicFieldData{Name}/; $_ } @{$ActivityDialog->{Config}->{FieldOrder}}
						];
						
					# change fieldname in dialog
					$ActivityDialog->{Config}->{Fields} = {
						map {
							my $oldkey = $_;
							my $newkey = $_;
							$newkey =~ s/^DynamicField_$currentDynamicField{Name}$/DynamicField_$DynamicFieldData{Name}/;
							$newkey => $ActivityDialog->{Config}->{Fields}->{$oldkey}
						} keys %{$ActivityDialog->{Config}->{Fields}}
					};
					

                    my $Success = $ProcessActivityDialogObject->ActivityDialogUpdate(%{$ActivityDialog},UserID => $Param{UserID});
 			   		if ( !$Success ) {
 			           $Kernel::OM->Get('Kernel::System::Log')->Log(
  			              Priority => 'error',
    			              Message =>
            			        "Can't update activity dialog $ActivityDialog->{EntityID} for dynamic field  : $DynamicFieldData{Name}");
    				    }                    
				}
				# get all transition
				my $ProcessTransitionObject = $Kernel::OM->Get("Kernel::System::ProcessManagement::DB::Transition");
				my $Transitions = $ProcessTransitionObject->TransitionListGet(UserID      => 1,);
				for my $Transition (@{$Transitions})
				{

					$Transition->{Config}->{Condition} = {
						map {
							my $Condition = $Transition->{Config}->{Condition}->{$_};
							$_ => {
								'Type' => $Condition->{Type},
								'Fields' => {
									map {
										my $oldkey = $_;
										my $newkey = $_;
										my $field = $Condition->{Fields}->{$_};
										my $match = $field->{Match};
										# tag without _Value
										$match =~ s/DynamicField_$currentDynamicField{Name}>/DynamicField_$DynamicFieldData{Name}>/g;
										# tag with _Value
										$match =~ s/DynamicField_$currentDynamicField{Name}_Value>/DynamicField_$DynamicFieldData{Name}_Value>/g;
										# key
										$newkey =~ s/^DynamicField_$currentDynamicField{Name}$/DynamicField_$DynamicFieldData{Name}/;
										$newkey => {
											'Type' => $field->{Type},
											'Match' => $match,
										}
									} keys %{$Condition->{Fields}}
								},
							}
						} keys %{$Transition->{Config}->{Condition}}	# the level 1 conditions
					};

 					
					my $Success = $ProcessTransitionObject->TransitionUpdate(%{$Transition},UserID => $Param{UserID});
					if ( !$Success ) {
 			           $Kernel::OM->Get('Kernel::System::Log')->Log(
  			              Priority => 'error',
    			              Message =>
            			        "Can't update transition $Transition->{EntityID}  for dynamic field  : $DynamicFieldData{Name}");
    				    }                    
				}
				
				
				# get all transitionactions
				my $ProcessTransitionActionObject = $Kernel::OM->Get("Kernel::System::ProcessManagement::DB::TransitionAction");
				my $TransitionActions = $ProcessTransitionActionObject->TransitionActionListGet(UserID => 1);
				for my $TransitionAction (@{$TransitionActions})
				{
                  
                    
					$TransitionAction->{Config}->{Config} = {
						map {
							my $newkey = $_;
							my $Value = $TransitionAction->{Config}->{Config}->{$newkey};
							# tag without _Value
							$Value =~ s/DynamicField_$currentDynamicField{Name}>/DynamicField_$DynamicFieldData{Name}>/g;
							# tag with _Value
							$Value =~ s/DynamicField_$currentDynamicField{Name}_Value>/DynamicField_$DynamicFieldData{Name}_Value>/g;
							# key
							$newkey =~ s/^DynamicField_$currentDynamicField{Name}$/DynamicField_$DynamicFieldData{Name}/;
							$newkey => $Value
							
						} keys %{$TransitionAction->{Config}->{Config}}
					};
					

					# special operation for module Kernel::System::ProcessManagement::TransitionAction::DynamicFieldSet because field is not named with prefix
					if ($TransitionAction->{Config}->{Module} eq 'Kernel::System::ProcessManagement::TransitionAction::DynamicFieldSet')
					{
						$TransitionAction->{Config}->{Config} = {
							map {
								my $newkey = $_;
								my $oldkey = $_;
								$newkey =~ s/$currentDynamicField{Name}$/$DynamicFieldData{Name}/g;
								$newkey => $TransitionAction->{Config}->{Config}->{$oldkey};
							} keys %{$TransitionAction->{Config}->{Config}}
						};
					}
					my $Success = $ProcessTransitionActionObject->TransitionActionUpdate(%{$TransitionAction},UserID => $Param{UserID});
					if ( !$Success ) {
 			           $Kernel::OM->Get('Kernel::System::Log')->Log(
  			              Priority => 'error',
    			              Message =>
            			        "Can't update transition action $TransitionAction->{EntityID}  for dynamic field  : $DynamicFieldData{Name}");
    				    }    			
				}
				
        	}
        }
        
        my $RetCode = "update of $DynamicFieldData{Name} successful";
        return $ret, $RetCode;
     		
    	} elsif (scalar @{$DynamicFieldList} > 1)
    	{
    		# this should not be OK
                   $Kernel::OM->Get('Kernel::System::Log')->Log(
                        Priority => 'error',
                        Message => "could not import raw because filter for identifier does return multiple fields for one row",
                    );    			
    		my $RetCode = "Unclear fieldfilter for import ";
    		return undef, $RetCode;    ## no critic
    	} else
    	{
    		# new field to import
    		if (!$DynamicFieldObject->DynamicFieldGet(Name => $DynamicFieldData{'Name'}, ))
    		{
    			my $RetCode = "dupplicated name for import found";
    			return undef, $RetCode;    ## no critic
    		}
    		delete $DynamicFieldData{ID};
    		my $ret = $DynamicFieldObject->DynamicFieldAdd(%DynamicFieldData);
    		if ( !$ret ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message =>
                    "Can't import entity : $DynamicFieldData{Name}"
                    . "Error when adding the new dynamic field.",
            );
            return;
        }
        my $RetCode = "import of $DynamicFieldData{Name} successful";
        return $ret, $RetCode;
    	}

    return;
}

=head1 INTERNAL INTERFACE


1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

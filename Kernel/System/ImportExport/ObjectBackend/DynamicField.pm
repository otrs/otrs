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
    'Kernel::System::ProcessManagement::DB::Process',
    'Kernel::System::ProcessManagement::DB::Activity',
    'Kernel::System::ProcessManagement::DB::Dialog',
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
            Value => Translatable('Valid State'),
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
    $DynamicFieldData{Reorder} = $ObjectData->{ReorderOnImport};
    $DynamicFieldData{FieldOrder} = $DynamicFieldData{FieldOrder} || $ObjectData->{DefaultFieldOrder};
      	
    	
    	if (scalar @{$DynamicFieldList} == 1)
    	{
    		# exactly one Field left to update

         my %currentDynamicField = %{$DynamicFieldList->[0]};
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

# --
# Kernel/GenericInterface/Event/DynamicField.pm - event data handler module for the GenericInterface
# Copyright (C) 2001-2014 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::GenericInterface::Event::DynamicField;

use strict;
use warnings;

use Kernel::System::VariableCheck qw(IsHashRefWithData);

our @ObjectDependencies = (
    'Kernel::System::Log',
    'Kernel::System::DynamicField',
);

=head1 NAME

Kernel::GenericInterface::Event::DynamicField - GenericInterface event data handler

=head1 SYNOPSIS

This event handler gathers data from objects.

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub DataGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(Data)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')
                ->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    # get object data
    my $PreObjectData = $Kernel::OM->Get('Kernel::System::DynamicField')->DynamicFieldGet(
        ID => $Param{Data}->{NewData}->{ID},
    );

    # prepare object data
    my %SerializedPreObjectDataConfig = $Self->_SerializeConfig(
        Data => $PreObjectData->{Config},
    );

    my %ObjectData = ( %{$PreObjectData}, %SerializedPreObjectDataConfig );

    # return object data
    return %ObjectData;

}

sub _SerializeConfig {
    my ( $Self, %Param ) = @_;

#-- nils
open ERLOG, ">>/tmp/error.log";
use Data::Dumper;
print ERLOG "\n#--- START ---#\n";
print ERLOG Dumper( %Param );
print ERLOG "#--- END ---#\n";
close ERLOG;
#-- nils

    # check needed stuff
    for (qw(Data)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')
                ->Log( Priority => 'error', Message => "Need $_!" );
            return;
        }
    }

    # prepare serialized config item hash
    my %SerializedConfigItemHash;

    # prepare prefix
    my $Prefix = $Param{Prefix} || 'Config_';

    CONFIGITEM:
    for my $ConfigItem ( sort keys %{$Param{Data}} ) {

        if ( IsHashRefWithData( $Param{Data}->{$ConfigItem} ) ) {
            
            # my %SerializedSubHash;

            # SUBHASHITEM:
            # for my $SubHashItem ( $Param{Data}->{$ConfigItem} ) {

            #     %SerializedSubHash = $Self->_SerializeConfig(
            #         Data  => $Param{Data}->{$ConfigItem},
            #         Prefix => $Prefix . '_',
            #     );

            #     %SerializedConfigItemHash = ( %SerializedConfigItemHash, %SerializedSubHash);
            # }
        }
        else {

            $Prefix = $Prefix . $ConfigItem;
            $SerializedConfigItemHash{$Prefix} = $Param{Data}->{$ConfigItem};
            $Prefix = $Param{Prefix} || 'Config_';
        }

    }

    return %SerializedConfigItemHash;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

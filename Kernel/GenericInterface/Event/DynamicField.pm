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

use Kernel::System::VariableCheck qw(IsHashRefWithData IsArrayRefWithData);

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

    # prepare object data config
    my %SerializedPreObjectDataConfigHash;
    my %PreObjectDataConfigHash = %{$PreObjectData->{Config}};
    # $Self->_SerializeConfig(
    #     Data  => \%PreObjectDataConfigHash,
    #     SHash => \%SerializedPreObjectDataConfigHash,
    # );
    _SerializeConfig(
        Data  => \%PreObjectDataConfigHash,
        SHash => \%SerializedPreObjectDataConfigHash,
    );

    my %ObjectData = ( %{$PreObjectData}, %SerializedPreObjectDataConfigHash );

    # return object data
    return %ObjectData;

}

sub _SerializeConfig {
    my ( %Param ) = @_;

    # check needed stuff
    for (qw(Data SHash)) {
        if ( !$Param{$_} ) {
            print "Got no $_!\n";
            return;
        }
    }

    my @ConfigContainer;
    my $DataType = 'Hash';

    if ( IsHashRefWithData( $Param{Data} ) ) {
        @ConfigContainer = sort keys %{ $Param{Data} };
    }
    else {
        @ConfigContainer = sort @{ $Param{Data} };
        $DataType = 'Array';
    }

    # prepare prefix
    my $Prefix = $Param{Prefix} || 'Config_';

    my $ArrayCount = 0;

    CONFIGITEM:
    for my $ConfigItem ( @ConfigContainer ) {

        next CONFIGITEM if !$ConfigItem;

        # check if param data is an hash- or array-ref
        if ( $DataType eq 'Hash' ) {

            # we got a hash ref
            if ( IsHashRefWithData( $Param{Data}->{$ConfigItem} ) ) {

                _SerializeConfig(
                    Data   => $Param{Data}->{$ConfigItem},
                    SHash  => $Param{SHash},
                    Prefix => $Prefix . $ConfigItem . '_',
                );
            }
            elsif ( IsArrayRefWithData( $Param{Data}->{$ConfigItem} ) ) {

                _SerializeConfig(
                    Data => $Param{Data}->{$ConfigItem},
                    SHash  => $Param{SHash},
                    Prefix => $Prefix . $ConfigItem . '_',
                );
            }
            else {

                $Prefix = $Prefix . $ConfigItem;
                $Param{SHash}->{$Prefix} = $Param{Data}->{$ConfigItem};
                $Prefix = $Param{Prefix} || 'Config_';
            }
        }

        # we got an array ref
        else {

            if ( IsHashRefWithData( $Param{Data}->[$ConfigItem] ) ) {

                _SerializeConfig(
                    Data => $Param{Data}->{$ConfigItem},
                    SHash  => $Param{SHash},
                    Prefix => $Prefix . $ConfigItem . '_',
                );
            }
            elsif ( IsArrayRefWithData( $Param{Data}->[$ConfigItem] ) ) {

                _SerializeConfig(
                    Data => $Param{Data}->{$ConfigItem},
                    SHash  => $Param{SHash},
                    Prefix => $Prefix . $ConfigItem . '_',
                );
            }
            else {

                $Prefix = $Prefix . $ArrayCount;
                $Param{SHash}->{$Prefix} = $ConfigItem;
                $Prefix = $Param{Prefix} || 'Config_';
            }

            $ArrayCount++;
        }
    }

    return 1;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

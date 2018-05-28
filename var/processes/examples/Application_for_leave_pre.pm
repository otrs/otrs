# --
# Copyright (C) 2001-2018 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package var::processes::examples::Application_for_leave_pre;
## nofilter(TidyAll::Plugin::OTRS::Perl::PerlCritic)

use strict;
use warnings;

use parent qw(var::processes::examples::Base);

our @ObjectDependencies = ();

use Kernel::Language qw(Translatable);

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {%Param};
    bless( $Self, $Type );

    return $Self;
}

sub Run {
    my ( $Self, %Param ) = @_;

    my %Response = (
        Success => 1,
    );

    # Dynamic fields definition
    my @DynamicFields = (
        {
            Name       => 'PreProcApplicationRecorded',
            Label      => Translatable('Application Recorded'),
            FieldType  => 'Dropdown',
            ObjectType => 'Ticket',
            FieldOrder => 10000,
            Config     => {
                DefaultValue   => '',
                PossibleNone   => 1,
                PossibleValues => {
                    'no'  => Translatable('no'),
                    'yes' => Translatable('yes'),
                },
                TranslatableValues => 1,
            },
        },
        {
            Name       => 'PreProcDaysRemaining',
            Label      => Translatable('Days Remaining'),
            FieldType  => 'Text',
            ObjectType => 'Ticket',
            FieldOrder => 10001,
            Config     => {
            },
        },
        {
            Name       => 'PreProcVacationStart',
            Label      => Translatable('Vacation Start'),
            FieldType  => 'Date',
            ObjectType => 'Ticket',
            FieldOrder => 10002,
            Config     => {
                DateRestriction => 'DisablePastDates',
            },
        },
        {
            Name       => 'PreProcVacationEnd',
            Label      => Translatable('Vacation End'),
            FieldType  => 'Date',
            ObjectType => 'Ticket',
            FieldOrder => 10003,
            Config     => {
                DateRestriction => 'DisablePastDates',
            },
        },
        {
            Name       => 'PreProcDaysUsed',
            Label      => Translatable('Days Used'),
            FieldType  => 'Text',
            ObjectType => 'Ticket',
            FieldOrder => 10004,
            Config     => {
            },
        },
        {
            Name       => 'PreProcEmergencyTelephone',
            Label      => Translatable('Emergency Telephone'),
            FieldType  => 'Text',
            ObjectType => 'Ticket',
            FieldOrder => 10005,
            Config     => {
            },
        },
        {
            Name       => 'PreProcRepresentationBy',
            Label      => Translatable('Representation By'),
            FieldType  => 'TextArea',
            ObjectType => 'Ticket',
            FieldOrder => 10006,
            Config     => {
                Rows => 10,
                Cols => 80,
            },
        },
        {
            Name       => 'PreProcProcessStatus',
            Label      => Translatable('Process Status'),
            FieldType  => 'Text',
            ObjectType => 'Ticket',
            FieldOrder => 10007,
            Config     => {
            },
        },
        {
            Name       => 'PreProcApprovedSuperior',
            Label      => Translatable('Approved Superior'),
            FieldType  => 'Dropdown',
            ObjectType => 'Ticket',
            FieldOrder => 10008,
            Config     => {
                DefaultValue   => '',
                PossibleNone   => 1,
                PossibleValues => {
                    'no'  => Translatable('no'),
                    'yes' => Translatable('yes'),
                },
                TranslatableValues => 1,
            },
        },
        {
            Name       => 'PreProcVacationInfo',
            Label      => Translatable('Vacation Info'),
            FieldType  => 'TextArea',
            ObjectType => 'Ticket',
            FieldOrder => 10009,
            Config     => {
                Rows => 10,
                Cols => 80,
            },
        },
    );

    %Response = $Self->DynamicFieldsAdd(
        DynamicFieldList => \@DynamicFields,
    );

    return %Response;
}

1;

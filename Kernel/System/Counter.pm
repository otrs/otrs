# --
# Copyright (C) 2016 Informatyka Boguslawski sp. z o.o. sp.k., http://www.ib.pl/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::Counter;

use strict;
use warnings;

our @ObjectDependencies = (
    'Kernel::System::DB',
    'Kernel::System::Log',
);

=head1 NAME

Kernel::System::Counter - counter handling lib

=head1 DESCRIPTION

All counter related functions.

=head1 PUBLIC INTERFACE

=head2 new()

Don't use the constructor directly, use the ObjectManager instead:

    my $CounterObject = $Kernel::OM->Get('Kernel::System::Counter');

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

=head2 IncrementAndGet()

Increment counter and return incremented value.

    my $ID = $CounterObject->IncrementAndGet(
        CounterName => 'DocumentID',
        Value => 1,   # the amount by which to increment; 1 by default
        UserID => 123,
    );

Returns undef on error.

=cut

sub IncrementAndGet {
    my ( $Self, %Param ) = @_;

    # check needed stuff
    for (qw(CounterName UserID)) {
        if ( !$Param{$_} ) {
            $Kernel::OM->Get('Kernel::System::Log')->Log(
                Priority => 'error',
                Message  => "Need $_!"
            );
            return;
        }
    }

    # get increment value; 1 if not specified
    my $IncrementValue = $Param{Value} // 1;

    # get database object
    my $DBObject = $Kernel::OM->Get('Kernel::System::DB');

    # increment counter and return incremented value in one transaction
    # to avoid race conditions

    # counter value to return
    my $CounterValue;

    # enable rising errors during transaction
    $DBObject->SetRaiseError( Enabled => 1 );

    eval {

        # other processes accessing ticket counter must wait for this transaction to finish
        $DBObject->Do(
            SQL => 'SET TRANSACTION ISOLATION LEVEL SERIALIZABLE'
        );

        $DBObject->BeginWork();

        $DBObject->Do(
            SQL => 'UPDATE counter set value = value + ?, change_time = current_timestamp, change_by = ? WHERE name = ?',
            Bind => [ \$IncrementValue, \$Param{UserID}, \$Param{CounterName} ],
        );

        # uncomment for debugging only (i.e. transaction locks testing)
        #sleep(30);

        $DBObject->Prepare(
            SQL => 'SELECT value FROM counter WHERE name = ?',
            Bind => [ \$Param{CounterName} ],
        );

        while ( my @Data = $DBObject->FetchrowArray() ) {
            if ( defined $Data[0] ) {
                $CounterValue = $Data[0];
            }
        }

        die "Cannot read $Param{CounterName} counter from database after incrementing!" if !defined $CounterValue;

        $DBObject->Commit();
    };

    if ( $@ ) {
        my $ErrorMessage = $@;

        # append database error message if available
        if ( my $DBErrorMessage = $DBObject->Error() ) {
            $ErrorMessage .= $ErrorMessage ? ', ' : '';
            $ErrorMessage .= $DBErrorMessage;
        }

        eval { $DBObject->Rollback(); };

        # disable rising errors after transaction
        $DBObject->SetRaiseError( Enabled => 0 );

        $ErrorMessage = "Error incrementing $Param{CounterName} counter in database"
            . ( $ErrorMessage ? ': ' . $ErrorMessage : '' );
        $Kernel::OM->Get('Kernel::System::Log')->Log(
            Priority => 'error',
            Message  => $ErrorMessage,
        );

        return;
    }

    # disable rising errors after transaction
    $DBObject->SetRaiseError( Enabled => 0 );

    return $CounterValue;
}

=head1 TERMS AND CONDITIONS

This software is part of the OTRS project (L<http://otrs.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (AGPL). If you
did not receive this file, see L<http://www.gnu.org/licenses/agpl.txt>.

=cut

# --
# Kernel/System/ObjectManager.pm - central object and dependency manager
# Copyright (C) 2001-2013 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::System::ObjectManager;

use strict;
use warnings;

# use the "standard" modules directly, so that persistent environments
# like mod_perl and FastCGI preload them at startup

use Kernel::Config;
use Kernel::System::Log;
use Kernel::System::Main;
use Kernel::System::Encode;
use Kernel::System::Time;
use Kernel::System::Web::Request;
use Kernel::System::DB;
use Kernel::System::Cache;
use Kernel::System::Auth;
use Kernel::System::AuthSession;
use Kernel::System::User;
use Kernel::System::Group;
use Kernel::Output::HTML::Layout;

=head1 NAME

Kernel::System::ObjectManager - object and dependency manager

=head1 SYNOPSIS

    use Kernel::System::ObjectManager;
    
    # it's important to store the object in this variable,
    # since many modules expect it that way.
    local $Kernel::OM = Kernel::System::ObjectManager->new(
        # options for module constructors here
        LogObject {
            LogPrefix => 'OTRS-MyTestScript',
        },
    );

    # now you can retrieve any configured object:
    
    unless ($Kernel::OM->Get('DBObject')->Prepare('SELECT 1')) {
        die "Houston, we have a problem!";
    }

=head1 PUBLIC INTERFACE

=over 4

=item new()

    local $Kernel::OM = Kernel::System::ObjectManager->new(%Options)

Creates a new instance of Kernel::System::ObjectManager. Options to this
constructor are passed to any object that the object manager creates for you.

=cut


sub new {
    my ($Type, %Param) = @_;
    my $Self = bless {}, $Type;

    $Self->{Specialization} = \%Param;
    $Self->{Objects} = {};

    return $Self;
}

=item Get()

Retrieves an object, and if it not yet exists, implicitly creating one for you.
Note that objects must be configured before they can be retrieved. The standard objects are configured in L<Kernel::Config::Defaults>.

The name of an object is usually what the code base used so far, including
the C<Object> suffix. For example C<< ->Get('TicketObject') >> retrieves a
L<Kernel::System::Ticket> object.

    my $ConfigObject = $Kernel::OM->Get('ConfigObject');

=cut

sub Get {
    # Optimize the heck out of the common case:
    return $_[0]->{Objects}{$_[1]} if $_[1] && $_[0]->{Objects}{$_[1]};

    # OK, not so easy
    my ($Self, $ObjectName) = @_;

    die "Error: Missing parameter (object name)\n"
        unless $ObjectName;

    $Self->_BuildObject(Object => $ObjectName);

    return $Self->{Objects}{$ObjectName};
}

sub _BuildObject {
    my ($Self, %Param) = @_;
    my $ClassName = $Self->ClassName(%Param);
    my $FileName  = $ClassName;
    $FileName     =~ s{::}{/}g;
    $FileName    .= '.pm';
    my %Args      = %{ $Self->{Specialization}{ $Param{Object} } // { } };

    my $Dependencies = $Self->Dependencies( %Param );
    if ( $Dependencies ) {
        for my $Dependency ( @{ $Dependencies } ) {
            $Self->Get( $Dependency );
        }
    }

    $Self->{Objects}{$Param{Object}} = $ClassName->new(%Args);
}

sub ObjectConfigGet {
    my ($Self, %Param) = @_;
    my $ObjectName = $Param{Object};
    if ($ObjectName eq 'Config') {
        # hardcoded to facilitate bootstrapping
        return {
            ClassName       => 'Kernel::Config',
        };
    }
    my $ObjConfig = $Self->Get('Config')->Get('Objects')->{$ObjectName};
    unless ($ObjConfig) {
        die "Object '$ObjectName' is not configured\n";
    }
    return $ObjConfig;
}

sub Dependencies {
    my ($Self, %Param) = @_;
    my $ObjConfig = $Self->ObjectConfigGet(%Param);
    return $ObjConfig->{Dependencies};
}

sub ClassName {
    my ($Self, %Param) = @_;
    my $ObjConfig = $Self->ObjectConfigGet(%Param);
    return $ObjConfig->{ClassName};
}

=item ObjectHash()

    $SomeModule->new($Kernel::OM->ObjectHash());

Returns a hash of all the already instantiated objects.
The keys are the object names, and the values are the objects themselves.

This method is useful for creating objects of classes that are
not aware of the object manager yet.

=cut

sub ObjectHash {
    my ($Self) = @_;

    return %{ $Self->{Objects} };
}

sub Has {
    my ($Self, %Param) = @_;

    my $ObjectName = $Param{Object};
    die "Missing parameter 'Object'" unless $ObjectName;
    return $Self->{Objects}{$ObjectName};
}

=item AddSpecialization()

Adds arguments that will be passed to constructors of classes
when they are created, in the same format as the C<new()> method
receives them.

    $Kernel::OM->AddSpecialization(
        TicketObject => {
            Key => 'Value',
        },
    );

=cut

sub AddSpecialization {
    my ($Self, %Param) = @_;

    for my $Key ( keys %Param ) {
        if ( ref($Param{$Key}) eq 'HASH' ) {
            for my $K ( sort keys %{ $Param{$Key} } ) {
                $Self->{Specialization}{$Key}{$K} = $Param{$Key}{$K};
            }
        }
        else {
            $Self->{Specialization}{$Key} = $Param{$Key};
        }
    }
    return;
}

=back

=cut

1;

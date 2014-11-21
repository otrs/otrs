#!/usr/bin/perl
# --
# bin/otrs.LinkRolesGroups.pl - link roles to groups according to permission matrix
# Copyright (C) 2014 MB AG, http://www.muehlbauer.de
# --
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU AFFERO General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
# or see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;

use File::Basename;
use FindBin qw($RealBin);
use Getopt::Long;
use Text::CSV;

use lib dirname($RealBin);
use lib dirname($RealBin) . '/Kernel/cpan-lib';
use lib dirname($RealBin) . '/Custom';

use Kernel::System::ObjectManager;

# print header
print "otrs.Roles2GroupsBulk.pl - link roles to groups according to permission matrix\n";
print "Copyright (C) 2014 MB AG, http://www.muehlbauer.de/\n";

# define default parameter values
my $Test          = 0;
my $Help          = 0;
my $OTRSAdminUser = 1;

# get supplied parameter values
GetOptions(
    'test'       => \$Test,
    'help'       => \$Help,
    'otrs-admin' => \$OTRSAdminUser,
);

# display usage
if ($Help || $#ARGV < 0) {
    print <<EOF;
Usage: otrs.Roles2GroupsBulk.pl
    [--test]
    [--help]
    [--otrs-admin=<OTRS_ADMIN_USER_ID>]
    <IMPORT.CSV>
EOF
    # display help
    if ($Help) {
        print <<EOF;

# Example CSV file
#
# Type,Name,Group,Role 1,,,,,,,Role 2,,,,,,,Role 3,,,,,,,Role 4,,,,,,,Role 5,,,,,,
# ,,,ro,move_into,create,note,owner,priority,rw,ro,move_into,create,note,owner,priority,rw,ro,move_into,create,note,owner,priority,rw,ro,move_into,create,note,owner,priority,rw,ro,move_into,create,note,owner,priority,rw
# ,users,users,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x
# ,admin,admin,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
# ,faq,faq,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x
# ,faq_admin,faq_admin,x,x,x,x,x,x,x,x,x,x,x,x,x,x,,,,,,,,,,,,,,,,,,,,,
# ,faq_approval,faq_approval,x,x,x,x,x,x,x,x,x,x,x,x,x,x,,,,,,,,,,,,,,,,,,,,,
# ,itsm-service,itsm-service,x,x,x,x,x,x,x,x,x,x,x,,,,x,x,x,x,,,,x,x,x,x,,,,x,x,x,x,,,
# ,itsm-configitem,itsm-configitem,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,,,,x,x,x,x,x,x,x
# ,itsm-change,itsm-change,x,x,x,x,x,x,x,,,,,,,,,,,,,,,,,,,,,,,,,,,,
# ,itsm-change-builder,itsm-change-builder,x,x,x,x,x,x,x,,,,,,,,,,,,,,,,,,,,,,,,,,,,
# ,itsm-change-manager,itsm-change-manager,x,x,x,x,x,x,x,,,,,,,,,,,,,,,,,,,,,,,,,,,,
# permission_,customer-data,permission_customer-data,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,,,,,,,,x,x,x,x,x,x,x
# module_,multiwatch,module_multiwatch,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x
# ,stats,stats,x,x,x,x,x,x,x,x,x,x,x,x,x,x,,,,,,,,,,,,,,,,,,,,,
# permission_,search,permission_search,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,,,,,,,,x,x,x,x,x,x,x
# queue_,Queue 1,queue_Queue 1,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,,,,x,x,x,x,x,x,x
# queue_,Queue 2,queue_Queue 2,x,x,x,x,x,x,x,x,x,x,x,,,,x,x,x,x,x,x,x,x,x,x,x,x,,,x,x,x,x,x,x,x
# queue_,Queue 3,queue_Queue 3,x,x,x,x,x,x,x,x,x,x,x,,,,x,x,x,x,x,x,x,x,x,x,x,x,,,x,x,x,x,x,x,x
# queue_,Queue 4,queue_Queue 4,x,x,x,x,x,x,x,x,x,x,x,,,,x,x,x,x,x,x,x,x,x,x,x,x,,,x,x,x,x,x,x,x
# queue_,Queue 5,queue_Queue 5,x,x,x,x,x,x,x,x,x,x,x,,,,x,x,x,x,x,x,x,x,x,x,x,x,,,x,x,x,x,x,x,x
#
# Script supports UTF-8 encoded files, in both CRLF and LF EOL flavors.
# Please see this Excel table template for easy CSV generation: http://goo.gl/fK0Fel
#

EOF
    }
    
    if ($#ARGV < 0) {
        exit 1;
    } else {
        exit 0;
    }
}

# create common objects
local $Kernel::OM = Kernel::System::ObjectManager->new(
    'Kernel::System::Log' => {
        LogPrefix => 'OTRS-otrs.Roles2GroupsBulk.pl',
    },
);

# define available permission types
my @Permissions = qw( ro move_into create note owner priority rw );

print "Parsing permission table, please wait...\n";

# open supplied CSV file
my $File = $ARGV[0] or die "No import table specified!\n";
open(my $Import, '<:encoding(utf8):crlf', $File) or die "Could not open '$File' $!\n";

my $CSV = Text::CSV->new({ sep_char => ',' });

# parse the matrix
my @Roles;
my @Groups;
my @Matrix;
{
    my $LineNumber = 1;
    while (my $Line = <$Import>) {
        chomp $Line;
        $Line =~ s/^\x{FEFF}// if ($LineNumber == 1);
        if ($CSV->parse($Line)) {
            my @Fields = $CSV->fields();
            
            # get all roles from first line, skip first three fields
            if ( $LineNumber == 1 ) {
                splice @Fields, 0, 3;
                foreach my $Role (@Fields) {
                    push @Roles, trim($Role) if ($Role);
                }
            }
            
            # get all permissions from 3rd and later lines and build the permission matrix
            # skip first two fields
            if ( $LineNumber > 2 ) {
                splice @Fields, 0, 2;
                my $Group = trim($Fields[0]);
                unless ( /\Q$Group\E/ ~~ @Groups && !$Group ) {
                    push @Groups, $Group;
                    shift @Fields;
                    for my $RoleID (0..$#Roles) {
                        my @Enabled = splice(@Fields, 0, 7);
                        for my $Permission (0..$#Enabled) {
                            $Matrix[$RoleID][$#Groups][$Permission] = $Enabled[$Permission] ? 1 : 0;
                        }
                    }
                }
            }
            $LineNumber++;
        } else {
            warn "Line could not be parsed: $Line\n";
        }
    }
}
close $Import;

# test mode
if ($Test) {

    print "\nTest mode, displaying permission matrix...";
    
    for my $RoleID (0..$#Roles) {
        printf "\n%107s%s\n", "", "Permissions";
        printf "%-35s <-> %-40s%-10s%-10s%-10s%-10s%-10s%-10s%-10s\n", "Role", "Group", @Permissions;
        for my $GroupID (0..$#Groups) {
            printf "%-35s <-> %-40s%-10s%-10s%-10s%-10s%-10s%-10s%-10s\n", $Roles[$RoleID], $Groups[$GroupID], @{$Matrix[$RoleID][$GroupID]};
        }
    }

# set the permissions
} else {

    # get existing groups and leave only new ones
    my %GroupsLookup;
    my %ExistingGroups = $Kernel::OM->Get('Kernel::System::Group')->GroupList();
    @GroupsLookup{values %ExistingGroups} = undef;
    my @NewGroups = grep {not exists $GroupsLookup{$_}} @Groups;
    
    # add missing groups
    print "\nAdding groups:\n" if (@NewGroups);
    
    foreach my $Group (@NewGroups) {
        $Kernel::OM->Get('Kernel::System::Group')->GroupAdd(
            Name    => $Group,
            ValidID => 1,
            UserID  => $OTRSAdminUser,
        );
        print "Added group \"$Group\".\n";
    }
    
    # get existing roles and leave only new ones
    my %RolesLookup;
    my %ExistingRoles = $Kernel::OM->Get('Kernel::System::Group')->RoleList();
    @RolesLookup{values %ExistingRoles} = undef;
    my @NewRoles = grep {not exists $RolesLookup{$_}} @Roles;

    # add missing roles
    print "\nAdding roles:\n" if (@NewRoles);
    
    foreach my $Role (@NewRoles) {
        $Kernel::OM->Get('Kernel::System::Group')->RoleAdd(
            Name    => $Role,
            ValidID => 1,
            UserID  => $OTRSAdminUser,
        );
        print "Added role \"$Role\".\n";
    }
    
    # set permissions
    print "\nProcessing role relations to groups according to permission matrix:\n";
    
    for my $RoleID (0..$#Roles) {
        
        printf "\n%107s%s\n", "", "Permissions";
        printf "%-35s <-> %-40s%-10s%-10s%-10s%-10s%-10s%-10s%-10s\n", "Role", "Group", @Permissions;
        
        for my $GroupID (0..$#Groups) {
            
            my $RID = $Kernel::OM->Get('Kernel::System::Group')->RoleLookup(
                Role => $Roles[$RoleID],
            );
            
            my $GID = $Kernel::OM->Get('Kernel::System::Group')->GroupLookup(
                Group => $Groups[$GroupID],
            );
            
            my %Permission;
            for my $Index ( 0..$#{$Matrix[$RoleID][$GroupID]} ) {
                $Permission{$Permissions[$Index]} = $Matrix[$RoleID][$GroupID][$Index];
            }
                
            $Kernel::OM->Get('Kernel::System::Group')->GroupRoleMemberAdd(
                RID => $RID,
                GID => $GID,
                Permission => \%Permission,
                UserID => $OTRSAdminUser,
            );
            
            printf "%-35s <-> %-40s%-10s%-10s%-10s%-10s%-10s%-10s%-10s\n", $Roles[$RoleID], $Groups[$GroupID], @{$Matrix[$RoleID][$GroupID]};
        }
    }
    
    print "\nDone!\n\n";

}

# basic trim function
# source: http://stackoverflow.com/a/4597964
sub trim {
    my $s = shift;
    $s =~ s/^\s+|\s+$//g;
    
    return $s;
};

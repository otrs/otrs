# --
# Copyright (C) 2001-2016 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

use strict;
use warnings;
use utf8;

use vars (qw($Self));

use Unicode::Normalize;

# get needed objects
my $ConfigObject = $Kernel::OM->Get('Kernel::Config');
my $MainObject   = $Kernel::OM->Get('Kernel::System::Main');
my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

# get helper object
$Kernel::OM->ObjectParamAdd(
    'Kernel::System::UnitTest::Helper' => {
        RestoreDatabase => 1,
        }
);
my $Helper = $Kernel::OM->Get('Kernel::System::UnitTest::Helper');

my $TicketID = $TicketObject->TicketCreate(
    Title        => 'Some Ticket_Title',
    Queue        => 'Raw',
    Lock         => 'unlock',
    Priority     => '3 normal',
    State        => 'closed successful',
    CustomerNo   => '123465',
    CustomerUser => 'customer@example.com',
    OwnerID      => 1,
    UserID       => 1,
);
$Self->True(
    $TicketID,
    'TicketCreate()',
);

my $ArticleID = $TicketObject->ArticleCreate(
    TicketID       => $TicketID,
    ArticleType    => 'note-internal',
    SenderType     => 'agent',
    From           => 'Some Agent <email@example.com>',
    To             => 'Some Customer <customer-a@example.com>',
    Subject        => 'some short description',
    Body           => 'the message text',
    ContentType    => 'text/plain; charset=ISO-8859-15',
    HistoryType    => 'OwnerUpdate',
    HistoryComment => 'Some free text!',
    UserID         => 1,
    NoAgentNotify  => 1,
);

$Self->True(
    $ArticleID,
    'ArticleCreate()',
);

my @Tests = (

    # Latin characters, 1 byte per character when encoding
    # attachment with 20 character long Latin name,
    {
        Description => 'Latin 20 characters',
        FileName    => 'a' x 20,
    },

    # attachment with 75 character long Latin FileName
    {
        Description => 'Latin 75 characters',
        FileName    => 'a' x 75,
    },

    # attachment with 120 character long Latin FileName
    {
        Description => 'Latin 120 characters',
        FileName    => 'a' x 120,
    },

    # attachment with 140 character long Latin FileName
    {
        Description => 'Latin 140 characters',
        FileName    => 'a' x 140,
    },

    # attachment with 245 character long Latin FileName
    {
        Description => 'Latin 245 characters',
        FileName    => 'a' x 245,
    },

    # Cyrillic character, 2 byte per character when encoding
    # attachment with 20 character long Cyrillic name,
    {
        Description => 'Cyrillic 20 characters',
        FileName    => 'ш' x 20,
    },

    # attachment with 75 character long Cyrillic FileName
    {
        Description => 'Cyrillic 75 characters',
        FileName    => 'ш' x 75,
    },

# attachment with 120 character long Cyrillic FileName, approximately limit for Linux file name reaching 255 bytes after encoding Cyrillic letters
    {
        Description => 'Cyrillic 120 characters',
        FileName    => 'ш' x 120,
    },

    # attachment with 140 character long Cyrillic FileName, have to cut name to create attachment file in FS backend
    {
        Description => 'Cyrillic 140 characters',
        FileName    => 'ш' x 140,
    },

    # Japanese character, 3 byte per character when encoding
    # attachment with 20 character long Japanese FileName,
    {
        Description => 'Japanese 20 characters',
        FileName    => '人' x 20,
    },

    # attachment with 70 character long Japanese FileName
    {
        Description => 'Japanese 70 characters',
        FileName    => '人' x 70,
    },

    # attachment with 140 character long Japanese FileName
    {
        Description => 'Japanese 140 characters',
        FileName    => '人' x 140,
    },

);

TEST:
for my $Test (@Tests) {

    # article attachment checks
    for my $Backend (qw(DB FS)) {

        # make sure that the TicketObject gets recreated for each loop.
        $Kernel::OM->ObjectsDiscard( Objects => ['Kernel::System::Ticket'] );

        $ConfigObject->Set(
            Key   => 'Ticket::StorageModule',
            Value => 'Kernel::System::Ticket::ArticleStorage' . $Backend,
        );

        my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');

        $Self->True(
            $TicketObject->isa( 'Kernel::System::Ticket::ArticleStorage' . $Backend ),
            "TicketObject loaded the correct backend",
        );

        my $Ext                    = '.txt';
        my $FileName               = $Test->{FileName} . $Ext;
        my $Content                = '123';
        my $MD5Orig                = $MainObject->MD5sum( String => $Content );
        my $ArticleWriteAttachment = $TicketObject->ArticleWriteAttachment(
            Content     => $Content,
            Filename    => $FileName,
            ContentType => 'text/html',
            ArticleID   => $ArticleID,
            UserID      => 1,
        );
        $Self->True(
            $ArticleWriteAttachment,
            "$Backend ArticleWriteAttachment() - $Test->{Description} - Original name $FileName",
        );

        my %AttachmentIndex = $TicketObject->ArticleAttachmentIndex(
            ArticleID => $ArticleID,
            UserID    => 1,
        );

        # get target file name
        my $TargetFileName;
        if ( $Backend eq 'DB' ) {
            $TargetFileName = $FileName,
        }
        else {
            $TargetFileName = $MainObject->FilenameCleanUp(
                Filename => $FileName,
                Type     => 'Local',
            );
        }

        # Mac OS (HFS+) will store all filenames as NFD internally.
        if ( $^O eq 'darwin' && $Backend eq 'FS' ) {
            $TargetFileName = Unicode::Normalize::NFD($TargetFileName);
        }

        $Self->Is(
            $AttachmentIndex{1}->{Filename},
            $TargetFileName,
            "$Backend ArticleAttachmentIndex() Attachment name $Test->{Description}"
        );

        my %Data = $TicketObject->ArticleAttachment(
            ArticleID => $ArticleID,
            FileID    => 1,
            UserID    => 1,
        );
        $Self->True(
            $Data{Content},
            "$Backend ArticleAttachment() Content - Attachment name $Test->{Description}",
        );
        $Self->True(
            $Data{ContentType},
            "$Backend ArticleAttachment() ContentType - Attachment name $Test->{Description}",
        );
        $Self->True(
            $Data{Content} eq $Content,
            "$Backend ArticleWriteAttachment() / ArticleAttachment() Content - Attachment name $Test->{Description}",
        );
        $Self->True(
            $Data{ContentType} eq 'text/html',
            "$Backend ArticleWriteAttachment() / ArticleAttachment() ContentType - Attachment name $Test->{Description}",
        );
        my $MD5New = $MainObject->MD5sum( String => $Data{Content} );
        $Self->Is(
            $MD5Orig || '1',
            $MD5New  || '2',
            "$Backend MD5 - Attachment name $Test->{Description}",
        );
        my $Delete = $TicketObject->ArticleDeleteAttachment(
            ArticleID => $ArticleID,
            UserID    => 1,
        );
        $Self->True(
            $Delete,
            "$Backend ArticleDeleteAttachment() - Attachment name $Test->{Description}",
        );

        %AttachmentIndex = $TicketObject->ArticleAttachmentIndex(
            ArticleID => $ArticleID,
            UserID    => 1,
        );

        $Self->IsDeeply(
            \%AttachmentIndex,
            {},
            "$Backend ArticleAttachmentIndex() after delete - Attachment name $Test->{Description}"
        );
    }
}

# cleanup is done by RestoreDatabase.

1;

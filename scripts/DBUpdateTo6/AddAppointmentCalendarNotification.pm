# --
# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/

# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (GPL). If you
# did not receive this file, see https://www.gnu.org/licenses/gpl-3.0.txt.
# --

package scripts::DBUpdateTo6::AddAppointmentCalendarNotification;    ## no critic

use strict;
use warnings;

use parent qw(scripts::DBUpdateTo6::Base);

our @ObjectDependencies = (
    'Kernel::System::NotificationEvent',
    'Kernel::System::Valid',
);

=head1 NAME

scripts::DBUpdateTo6::AddAppointmentCalendarNotification - Add AppointmentCalendar notification.

=cut

sub Run {
    my ( $Self, %Param ) = @_;

    my %AppointmentNotifications = (
        'Appointment reminder notification' => {
            Data => {
                NotificationType       => ['Appointment'],
                VisibleForAgent        => [1],
                VisibleForAgentTooltip => [
                    'You will receive a notification each time a reminder time is reached for one of your appointments.'
                ],
                Events                => ['AppointmentNotification'],
                Recipients            => ['AppointmentAgentReadPermissions'],
                SendOnOutOfOffice     => [1],
                Transports            => ['Email'],
                AgentEnabledByDefault => ['Email'],
            },
            Message => {
                'de' => {
                    'Body' => 'Hallo &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
Termin &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot; hat seine Benachrichtigungszeit erreicht.<br />
<br />
Beschreibung: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Standort: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Kalender: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Startzeitpunkt: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Endzeitpunkt: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Ganztägig: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Wiederholung: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;',
                    'ContentType' => 'text/html',
                    'Subject'     => 'Erinnerung: <LIGERO_APPOINTMENT_TITLE>',
                },
                'en' => {
                    'Body' => 'Hi &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
appointment &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot; has reached its notification time.<br />
<br />
Description: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Location: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Calendar: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Start date: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
End date: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
All-day: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Repeat: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;',
                    'ContentType' => 'text/html',
                    'Subject'     => 'Reminder: <LIGERO_APPOINTMENT_TITLE>',
                },
                'hu' => {
                    'Body' => 'Kedves &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;!<br />
<br />
A következő esemény elérte az értesítési idejét: &lt;LIGERO_APPOINTMENT_TITLE&gt;<br />
<br />
Leírás: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Hely: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Naptár: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Kezdési dátum: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Befejezési dátum: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Egész napos: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Ismétlődés: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;',
                    'ContentType' => 'text/html',
                    'Subject'     => 'Emlékeztető: <LIGERO_APPOINTMENT_TITLE>',
                },
                'sr_Cyrl' => {
                    'Body' => 'Здраво &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
време је за обавештење у вези термина &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot;.<br />
<br />
Опис: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Локација: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Календар: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Датум почетка: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Датум краја: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Целодневно: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Понављање: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;',
                    'ContentType' => 'text/html',
                    'Subject'     => 'Подсетник: <LIGERO_APPOINTMENT_TITLE>',
                },
                'sr_Latn' => {
                    'Body' => 'Zdravo &lt;LIGERO_NOTIFICATION_RECIPIENT_UserFirstname&gt;,<br />
<br />
vreme je za obaveštenje u vezi termina &quot;&lt;LIGERO_APPOINTMENT_TITLE&gt;&quot;.<br />
<br />
Opis: &lt;LIGERO_APPOINTMENT_DESCRIPTION&gt;<br />
Lokacije: &lt;LIGERO_APPOINTMENT_LOCATION&gt;<br />
Kalendar: <span style="color: &lt;LIGERO_CALENDAR_COLOR&gt;;">■</span> &lt;LIGERO_CALENDAR_CALENDARNAME&gt;<br />
Datum početka: &lt;LIGERO_APPOINTMENT_STARTTIME&gt;<br />
Datum kraja: &lt;LIGERO_APPOINTMENT_ENDTIME&gt;<br />
Celodnevno: &lt;LIGERO_APPOINTMENT_ALLDAY&gt;<br />
Ponavljanje: &lt;LIGERO_APPOINTMENT_RECURRING&gt;<br />
<br />
<a href="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;" title="&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;">&lt;LIGERO_CONFIG_HttpType&gt;://&lt;LIGERO_CONFIG_FQDN&gt;/&lt;LIGERO_CONFIG_ScriptAlias&gt;index.pl?Action=AgentAppointmentCalendarOverview;AppointmentID=&lt;LIGERO_APPOINTMENT_APPOINTMENTID&gt;</a><br />
<br />
-- &lt;LIGERO_CONFIG_NotificationSenderName&gt;',
                    'ContentType' => 'text/html',
                    'Subject'     => 'Podsetnik: <LIGERO_APPOINTMENT_TITLE>',
                },
            },
        },
    );

    my %ValidList        = $Kernel::OM->Get('Kernel::System::Valid')->ValidList();
    my %ValidListReverse = reverse %ValidList;

    my $NotificationEventObject = $Kernel::OM->Get('Kernel::System::NotificationEvent');

    # Get all notifications of appointment type.
    my %NotificationList = $NotificationEventObject->NotificationList(
        Type => 'Appointment',
    );
    my %NotificationListReverse = reverse %NotificationList;

    NEWNOTIFICATION:
    for my $NotificationName ( sort keys %AppointmentNotifications ) {

        # Do not add new notification if one with the same name exists.
        next NEWNOTIFICATION if $NotificationListReverse{$NotificationName};

        # Add new event notification.
        my $ID = $NotificationEventObject->NotificationAdd(
            Name    => $NotificationName,
            Data    => $AppointmentNotifications{$NotificationName}->{Data},
            Message => $AppointmentNotifications{$NotificationName}->{Message},
            Comment => '',
            ValidID => $ValidListReverse{valid},
            UserID  => 1,
        );

        return if !$ID;
    }

    return 1;
}

1;

=head1 TERMS AND CONDITIONS

This software is part of the LIGERO project (L<https://ligero.org/>).

This software comes with ABSOLUTELY NO WARRANTY. For details, see
the enclosed file COPYING for license information (GPL). If you
did not receive this file, see L<https://www.gnu.org/licenses/gpl-3.0.txt>.

=cut

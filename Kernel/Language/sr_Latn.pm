# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package Kernel::Language::sr_Latn;

use strict;
use warnings;
use utf8;

sub Data {
    my $Self = shift;

    # $$START$$
    # possible charsets
    $Self->{Charset} = ['utf-8', ];
    # date formats (%A=WeekDay;%B=LongMonth;%T=Time;%D=Day;%M=Month;%Y=Year;)
    $Self->{DateFormat}          = '%D.%M.%Y %T';
    $Self->{DateFormatLong}      = '%T - %D.%M.%Y';
    $Self->{DateFormatShort}     = '%D.%M.%Y';
    $Self->{DateInputFormat}     = '%D.%M.%Y';
    $Self->{DateInputFormatLong} = '%D.%M.%Y - %T';
    $Self->{Completeness}        = 0.842229367631297;

    # csv separator
    $Self->{Separator} = ';';

    $Self->{DecimalSeparator}    = ',';
    $Self->{ThousandSeparator}   = ' ';

    $Self->{Translation} = {

        # Template: AdminACL
        'ACL Management' => 'Upravljanje „ACL”',
        'Actions' => 'Akcije',
        'Create New ACL' => 'Kreiraj novu „ACL”',
        'Deploy ACLs' => 'Upotrebi „ACL” liste',
        'Export ACLs' => 'Izvezi „ACL” liste',
        'Filter for ACLs' => 'Filter za ACL',
        'Just start typing to filter...' => 'Počnite sa kucanjem za filter...',
        'Configuration Import' => 'Uvoz konfiguracije',
        'Here you can upload a configuration file to import ACLs to your system. The file needs to be in .yml format as exported by the ACL editor module.' =>
            'Ovde možete poslati konfiguracionu datoteku za uvoz „ACL” lista u vaš sistem. Datoteka mora biti u „.yml” formatu ako se izvozi od strane „ACL” editor modula.',
        'This field is required.' => 'Ovo polje je obavezno.',
        'Overwrite existing ACLs?' => 'Napiši preko postojećih „ACL” lista?',
        'Upload ACL configuration' => 'Otpremi „ACL” konfiguraciju',
        'Import ACL configuration(s)' => 'Uvezi „ACL” konfiguraciju(e)',
        'Description' => 'Opis',
        'To create a new ACL you can either import ACLs which were exported from another system or create a complete new one.' =>
            'Da biste kreirali novu „ACL” možete ili uvesti „ACL” liste koje su izvezene iz drugog sistema ili napraviti kompletno novu.',
        'Changes to the ACLs here only affect the behavior of the system, if you deploy the ACL data afterwards. By deploying the ACL data, the newly made changes will be written to the configuration.' =>
            'Promene na „ACL” listama ovde samo utiču na ponašanje sistema, ukoliko naknadno upotrebite sve „ACL” podatke.',
        'ACLs' => '„ACL” liste',
        'Please note: This table represents the execution order of the ACLs. If you need to change the order in which ACLs are executed, please change the names of the affected ACLs.' =>
            'Napomena: Ova tabela predstavlja redosled izvršavanja u „ACL” listama. Ako je potrebno da promenite redosled kojim se izvršavaju „ACL” liste, molimo promenite imena tih „ACL” lista.',
        'ACL name' => 'Naziv „ACL”',
        'Comment' => 'Komentar',
        'Validity' => 'Važnost',
        'Export' => 'Izvoz',
        'Copy' => 'Kopija',
        'No data found.' => 'Ništa nije pronađeno.',
        'No matches found.' => 'Ništa nije pronađeno.',

        # Template: AdminACLEdit
        'Edit ACL %s' => 'Uredi „ACL” %s',
        'Go to overview' => 'Idi na pregled',
        'Delete ACL' => 'Obriši „ACL”',
        'Delete Invalid ACL' => 'Obriši nevažeću „ACL”',
        'Match settings' => 'Uskladi podešavanja',
        'Set up matching criteria for this ACL. Use \'Properties\' to match the current screen or \'PropertiesDatabase\' to match attributes of the current ticket that are in the database.' =>
            'Podesite usklađene kriterijume za ovu „ACL” listu. Koristite \'Properties\' tako da odgovara postojećem prikazu ekrana ili \'PropertiesDatabase\' da bi odgovarao atributima postojećeg tiketa koji su u bazi podataka.',
        'Change settings' => 'Promeni podešavanja',
        'Set up what you want to change if the criteria match. Keep in mind that \'Possible\' is a white list, \'PossibleNot\' a black list.' =>
            'Podesite ono što želite da menjate ako se kriterijumi slažu. Imajte na umu da je \'Possible\' bela lista, \'PossibleNot\' crna lista.',
        'Check the official' => 'Proverite zvanično',
        'documentation' => 'dokumentacija',
        'Show or hide the content' => 'Pokaži ili sakrij sadržaj',
        'Edit ACL Information' => '',
        'Name' => 'Ime',
        'Stop after match' => 'Zaustavi posle poklapanja',
        'Edit ACL Structure' => '',
        'Save' => 'Sačuvaj',
        'or' => 'ili',
        'Save and finish' => 'Sačuvaj i završi',
        'Cancel' => 'Odustani',
        'Do you really want to delete this ACL?' => 'Da li zaista želite da obrišete ovu „ACL” listu?',

        # Template: AdminACLNew
        'Create a new ACL by submitting the form data. After creating the ACL, you will be able to add configuration items in edit mode.' =>
            'Kreirajte novu „ACL” listu podnošenjem obrasca sa podacima. Nakon kreiranja „ACL” liste, bićete u mogućnosti da dodate konfiguracione stavke u modu izmene.',

        # Template: AdminAttachment
        'Attachment Management' => 'Upravljanje prilozima',
        'Add attachment' => 'Dodaj prilog',
        'Filter for Attachments' => 'Filter za priloge',
        'Filter for attachments' => '',
        'List' => 'Lista',
        'Filename' => 'Naziv datoteke',
        'Changed' => 'Izmenjeno',
        'Created' => 'Kreirano',
        'Delete' => 'Izbrisati',
        'Download file' => 'Preuzmi datoteku',
        'Delete this attachment' => 'Obriši ovaj prilog',
        'Add Attachment' => 'Dodaj prilog',
        'Edit Attachment' => 'Uredi prilog',
        'Attachment' => 'Prilog',

        # Template: AdminAutoResponse
        'Auto Response Management' => 'Upravljanje automatskim odgovorima',
        'Add auto response' => 'Dodaj automatski odgovor',
        'Filter for Auto Responses' => 'Filter za Automatske odgovore',
        'Filter for auto responses' => '',
        'Type' => 'Tip',
        'Add Auto Response' => 'Dodaj Automatski Odgovor',
        'Edit Auto Response' => 'Uredi Automatski Odgovor',
        'Subject' => 'Predmet',
        'Response' => 'Odgovor',
        'Auto response from' => 'Automatski odgovor od',
        'Reference' => 'Reference',
        'You can use the following tags' => 'Možete koristiti sledeće oznake',
        'To get the first 20 character of the subject.' => 'Da vidite prvih 20 slova predmeta',
        'To get the first 5 lines of the email.' => 'Da vidite prvih 5 linija imejla.',
        'To get the realname of the ticket\'s customer user (if given).' =>
            '',
        'To get the article attribute' => 'Da vidite atribute članka',
        ' e. g.' => 'npr.',
        'Options of the current customer user data' => 'Opcije podataka o aktuelnom klijentu korisniku',
        'Ticket owner options' => 'Opcije vlasnika tiketa',
        'Ticket responsible options' => 'Opcije odgovornog za tiket',
        'Options of the current user who requested this action' => 'Opcije aktuelnog korisnika koji je tražio ovu akciju',
        'Options of the ticket data' => 'Opcije podataka o tiketu',
        'Options of ticket dynamic fields internal key values' => 'Opcije za vrednosti internih ključeva dinamičkih polja tiketa.',
        'Options of ticket dynamic fields display values, useful for Dropdown and Multiselect fields' =>
            'Opcije za prikazane vrednosti dinamičkih polja tiketa, korisno za polja Dropdown i Multiselect',
        'Config options' => 'Konfiguracione opcije',
        'Example response' => 'Primer odgovora',

        # Template: AdminCloudServiceSupportDataCollector
        'Cloud Service Management' => 'Upravljanje servisima u oblaku',
        'Support Data Collector' => 'Sakupljač podataka podrške',
        'Support data collector' => 'Sakupljač podataka podrške',
        'Hint' => 'Savet',
        'Currently support data is only shown in this system.' => 'Aktuelni podaci podrške se prikazuju samo na ovom sistemu.',
        'It is highly recommended to send this data to OTRS Group in order to get better support.' =>
            'Preporučuje se da ove podatke pošaljete OTRS Grupi da bi ste dobili bolju podršku.',
        'Configuration' => 'Konfiguracija',
        'Send support data' => 'Pošalji podatke za podršku',
        'This will allow the system to send additional support data information to OTRS Group.' =>
            'Ovo će omogućiti sistemu da pošalje dodatne informacije o podršci podataka u OTRS Grupu.',
        'Update' => 'Ažuriranje',
        'System Registration' => 'Registracija sistema',
        'To enable data sending, please register your system with OTRS Group or update your system registration information (make sure to activate the \'send support data\' option.)' =>
            'Da bi ste onemogućili slanje podataka, molimo vas da registrujete vaš sistem u OTRS Grupi ili da ažurirate informacije sistemske registracije (budite sigurni da ste aktivirali opciju \'send support data\'.).',
        'Register this System' => 'Registruj ovaj sistem',
        'System Registration is disabled for your system. Please check your configuration.' =>
            'Sistemska registracije je deaktivirana za vaš sistem. Molimo da proverite vašu konfiguraciju.',

        # Template: AdminCloudServices
        'System registration is a service of OTRS Group, which provides a lot of advantages!' =>
            'Registracija sistema je usluga OTRS Grupe, koja obezbeđuje mnoge prednosti.',
        'Please note that the use of OTRS cloud services requires the system to be registered.' =>
            'Napominjemo da korišćenje OTRS servisa u oblaku zahtevaju da sistem bude registrovan.',
        'Register this system' => 'Registruj ovaj sistem',
        'Here you can configure available cloud services that communicate securely with %s.' =>
            'Ovde možete podesiti da dostupni servisi u oblaku koriste sigurnu komunikaciju preko %s.',
        'Available Cloud Services' => 'Raspoloživi servisi u oblaku',
        'Upgrade to %s' => 'Unapredi na %s',

        # Template: AdminCustomerCompany
        'Customer Management' => 'Upravljanje klijentima',
        'Search' => 'Traži',
        'Wildcards like \'*\' are allowed.' => 'Džokerski znaci kao \'*\' su dozvoljeni',
        'Add customer' => 'Dodaj klijenta',
        'Select' => 'Izaberi',
        'List (only %s shown - more available)' => '',
        'total' => 'ukupno',
        'Please enter a search term to look for customers.' => 'Molimo unesite pojam pretrage za pronalaženje klijenata.',
        'CustomerID' => 'ID klijenta',
        'Add Customer' => 'Dodaj klijenta',
        'Edit Customer' => 'Izmeni klijenta',
        'Please note' => '',
        'This customer backend is read only!' => '',

        # Template: AdminCustomerUser
        'Customer User Management' => 'Upravljanje klijentima klijentima',
        'Back to search results' => 'Vrati se na rezultate pretrage',
        'Add customer user' => 'Dodaj klijenta korisnika',
        'Customer user are needed to have a customer history and to login via customer panel.' =>
            'Klijent klijent treba da ima klijentski istorijat i da se prijavi preko klijentskog panela.',
        'List (%s total)' => '',
        'Username' => 'Korisničko ime',
        'Email' => 'Imejl',
        'Last Login' => 'Poslednja prijava',
        'Login as' => 'Prijavi se kao',
        'Switch to customer' => 'Pređi na klijenta',
        'Add Customer User' => 'Dodaj klijenta korisnika',
        'Edit Customer User' => 'Izmeni klijenta korisnika',
        'This customer backend is read only, but the customer user preferences can be changed!' =>
            '',
        'This field is required and needs to be a valid email address.' =>
            'Ovo je obavezno polje i mora da bude ispravna imejl adresa.',
        'This email address is not allowed due to the system configuration.' =>
            'Ova imejl adresa nije dozvoljena zbog sistemske konfiguracije.',
        'This email address failed MX check.' => 'Ova imejl adresa ne zadovoljava „MX” proveru.',
        'DNS problem, please check your configuration and the error log.' =>
            '„DNS” problem, molimo proverite konfiguraciju i grešake u logu',
        'The syntax of this email address is incorrect.' => 'Sintaksa ove imejl adrese je neispravna.',

        # Template: AdminCustomerUserGroup
        'Manage Customer-Group Relations' => 'Upravljanje relacijama Klijent-Grupa',
        'Notice' => 'Napomena',
        'This feature is disabled!' => 'Ova funkcija je isključena!',
        'Just use this feature if you want to define group permissions for customers.' =>
            'Upotrebite ovu funkciju ako želite da definišete grupne dozvole za klijente.',
        'Enable it here!' => 'Aktivirajte je ovde!',
        'Edit Customer Default Groups' => 'Uredi podrazumevane grupe za klijenta',
        'These groups are automatically assigned to all customers.' => 'Ove grupe su automatski dodeljene svim klijentima.',
        'You can manage these groups via the configuration setting "CustomerGroupAlwaysGroups".' =>
            'Možete upravljati ovim grupama preko konfiguracionih podešavanja "CustomerGroupAlwaysGroups".',
        'Filter for Groups' => 'Fileter za grupe',
        'Select the customer:group permissions.' => 'Izaberi customer:group dozvole.',
        'If nothing is selected, then there are no permissions in this group (tickets will not be available for the customer).' =>
            'Ako ništa nije izabrano, onda nema dozvola u ovoj grupi (tiketi neće biti dostupni klijentu).',
        'Search Results' => 'Rezultat pretrage',
        'Customers' => 'Klijenti',
        'Groups' => 'Grupe',
        'Change Group Relations for Customer' => 'Promeni veze sa grupama za klijenta',
        'Change Customer Relations for Group' => 'Promeni veze sa klijentima za grupu',
        'Toggle %s Permission for all' => 'Promeni %s dozvole za sve',
        'Toggle %s permission for %s' => 'Promeni %s dozvole za %s',
        'Customer Default Groups:' => 'Podrazumevane grupe za klijenta:',
        'No changes can be made to these groups.' => 'Na ovim grupama promene nisu moguće.',
        'ro' => 'ro',
        'Read only access to the ticket in this group/queue.' => 'Pristup ograničen samo na čitanje za tikete u ovim grupama/redovima.',
        'rw' => 'rw',
        'Full read and write access to the tickets in this group/queue.' =>
            'Pristup bez ograničenja za tikete u ovim grupama/redovima.',

        # Template: AdminCustomerUserService
        'Manage Customer-Services Relations' => 'Upravljanje vezama Klijent-Usluge',
        'Edit default services' => 'Uredi podrazumevane usluge',
        'Filter for Services' => 'Filter za servise',
        'Services' => 'Usluge',
        'Allocate Services to Customer' => 'Pridruži servise klijentu',
        'Allocate Customers to Service' => 'Pridruži klijente servisu',
        'Toggle active state for all' => 'Promeni aktivno stanje za sve',
        'Active' => 'Aktivno',
        'Toggle active state for %s' => 'Promeni aktivno stanje za %s',

        # Template: AdminDynamicField
        'Dynamic Fields Management' => 'Upravljanje dinamičkim poljima',
        'Add new field for object' => 'Dodaj novo polje objektu',
        'Filter for Dynamic Fields' => '',
        'Filter for dynamic fields' => '',
        'To add a new field, select the field type from one of the object\'s list, the object defines the boundary of the field and it can\'t be changed after the field creation.' =>
            'Za dodavanje novog polja izaberite tip polja iz jedne od lista objekata. Objekt definiše granice polja i posle kreiranja polja se ne može menjati.',
        'Dynamic Fields List' => 'Lista dinamičkih polja',
        'Settings' => 'Podešavanja',
        'Dynamic fields per page' => 'Broj dinamičkih polja po strani',
        'Label' => 'Oznaka',
        'Order' => 'Sortiranje',
        'Object' => 'Objekat',
        'Delete this field' => 'Obriši ovo polje',

        # Template: AdminDynamicFieldCheckbox
        'Dynamic Fields' => 'Dinamička polja',
        'Field' => 'Polje',
        'Go back to overview' => 'Idi nazad na pregled',
        'General' => 'Opšte',
        'This field is required, and the value should be alphabetic and numeric characters only.' =>
            'Ovo polje je obavezno i može sadržati samo od slova i brojeve.',
        'Must be unique and only accept alphabetic and numeric characters.' =>
            'Mora biti jedinstveno i prihvata samo slova i brojeve.',
        'Changing this value will require manual changes in the system.' =>
            'Izmena ovog polja će zahtevati ručne promene u sistemu.',
        'This is the name to be shown on the screens where the field is active.' =>
            'Ovo je naziv koji će se prikazivati na ekranima gde je polje aktivno.',
        'Field order' => 'Redosled polja',
        'This field is required and must be numeric.' => 'Ovo polje je obavezno i mora biti numeričko.',
        'This is the order in which this field will be shown on the screens where is active.' =>
            'Ovo je redosled po kom će polja biti prikazana na ekranima gde su aktivna.',
        'Field type' => 'Tip polja',
        'Object type' => 'Tip objekta',
        'Internal field' => 'Interno polje',
        'This field is protected and can\'t be deleted.' => 'Ovo polje je zaštićeno i ne može biti obrisano.',
        'Field Settings' => 'Podešavanje polja',
        'Default value' => 'Podrazumevana vrednost',
        'This is the default value for this field.' => 'Ovo je podrazumevana vrednost za ovo polje.',

        # Template: AdminDynamicFieldDateTime
        'Default date difference' => 'Podrazumevana razlika datuma',
        'This field must be numeric.' => 'Ovo polje mora biti numeričko.',
        'The difference from NOW (in seconds) to calculate the field default value (e.g. 3600 or -60).' =>
            'Razlika (u sekundama) od SADA, za izračunavanje podrazumevane vrednosti polja (npr. 3600 ili -60).',
        'Define years period' => 'Definiši peroiod  u godinama',
        'Activate this feature to define a fixed range of years (in the future and in the past) to be displayed on the year part of the field.' =>
            'Aktivirajte ovu opciju radi definisanja fiksnog opsega godina (u budućnost i prošlost) za prikaz pri izboru godina u polju.',
        'Years in the past' => 'Godine u prošlosti',
        'Years in the past to display (default: 5 years).' => 'Godine u prošlosti za prikaz (podrazumevano je 5 godina).',
        'Years in the future' => 'Godine u budućnosti',
        'Years in the future to display (default: 5 years).' => 'Godine u budućnosti za prikaz (podrazumevano je 5 godina).',
        'Show link' => 'Pokaži vezu',
        'Here you can specify an optional HTTP link for the field value in Overviews and Zoom screens.' =>
            'Ovde možete da unesete opcionu HTTP vezu za vrednost polja u prozoru opšteg i uvećanog prikaza ekrana.',
        'Example' => 'Primer',
        'Link for preview' => '',
        'If filled in, this URL will be used for a preview which is shown when this link is hovered in ticket zoom. Please note that for this to work, the regular URL field above needs to be filled in, too.' =>
            '',
        'Restrict entering of dates' => 'Ograniči unos datuma',
        'Here you can restrict the entering of dates of tickets.' => 'Ovde možete ograničiti unos datuma za tikete.',

        # Template: AdminDynamicFieldDropdown
        'Possible values' => 'Moguće vrednosti',
        'Key' => 'Ključ',
        'Value' => 'Vrednost',
        'Remove value' => 'Ukloni vrednost',
        'Add value' => 'Dodaj vrednost',
        'Add Value' => 'Dodaj Vrednost',
        'Add empty value' => 'Dodaj bez vrednosti',
        'Activate this option to create an empty selectable value.' => 'Aktiviraj ovu opciju za kreiranje izbora bez vrednosti.',
        'Tree View' => 'Prikaz u obliku stabla',
        'Activate this option to display values as a tree.' => 'Aktiviraj ovu opciju za prikaz vrednosti u obliku stabla.',
        'Translatable values' => 'Prevodljive vrednosti',
        'If you activate this option the values will be translated to the user defined language.' =>
            'Ako aktivirate ovu opciju vrednosti će biti prevedene na izabrani jezik.',
        'Note' => 'Napomena',
        'You need to add the translations manually into the language translation files.' =>
            'Ove prevode morate ručno dodati u datoteke prevoda.',

        # Template: AdminDynamicFieldText
        'Number of rows' => 'Broj redova',
        'Specify the height (in lines) for this field in the edit mode.' =>
            'Unesi visinu (u linijama) za ovo polje u modu obrade.',
        'Number of cols' => 'Broj kolona',
        'Specify the width (in characters) for this field in the edit mode.' =>
            'Unesi širinu (u znakovima) za ovo polje u modu uređivanja.',
        'Check RegEx' => 'Proveri „RegEx”',
        'Here you can specify a regular expression to check the value. The regex will be executed with the modifiers xms.' =>
            'Ovde možete da definišete regularni izraz za proveru vrednosti. Izraz će biti izvršen sa modifikatorima za xms.',
        'RegEx' => ' "RegEx"',
        'Invalid RegEx' => 'Nevažeći "RegEx"',
        'Error Message' => 'Poruka o grešci',
        'Add RegEx' => 'Dodaj "RegEx"',

        # Template: AdminEmail
        'Admin Notification' => 'Administratorska obaveštenja',
        'With this module, administrators can send messages to agents, group or role members.' =>
            'Sa ovim modulom, administratori mogu slati poruke operaterima, grupama ili pripadnicima uloge.',
        'Create Administrative Message' => 'Kreiraj administrativnu poruku',
        'Your message was sent to' => 'Vaša poruka je poslata',
        'From' => 'Od',
        'Send message to users' => 'Pošalji poruku korisnicima',
        'Send message to group members' => 'Pošalji poruku članovima grupe',
        'Group members need to have permission' => 'Članovi grupe treba da imaju dozvolu',
        'Send message to role members' => 'Pošalji poruku pripadnicima uloge',
        'Also send to customers in groups' => 'Takođe pošalji klijentima u grupama',
        'Body' => 'Sadržaj',
        'Send' => 'Šalji',

        # Template: AdminGenericAgent
        'Generic Agent' => 'Generički operater',
        'Add job' => 'Dodaj posao',
        'Filter for Generic Agent Jobs' => '',
        'Filter for generic agent jobs' => '',
        'Last run' => 'Poslednje pokretanje',
        'Run Now!' => 'Pokreni sad!',
        'Delete this task' => 'Obriši ovaj zadatak',
        'Run this task' => 'Pokreni ovaj zadatak',
        'Job Settings' => 'Podešavanje posla',
        'Job name' => 'Naziv posla',
        'The name you entered already exists.' => 'Ime koje ste uneli već postoji.',
        'Toggle this widget' => 'Preklopi ovaj aplikativni dodatak (widget)',
        'Automatic Execution (Multiple Tickets)' => '',
        'Execution Schedule' => 'Raspored izvršenja',
        'Schedule minutes' => 'Planirano minuta',
        'Schedule hours' => 'Planirano sati',
        'Schedule days' => 'Planirano dana',
        'Currently this generic agent job will not run automatically.' =>
            'Trenutno ovaj generički agentski zadatak neće raditi automatski.',
        'To enable automatic execution select at least one value from minutes, hours and days!' =>
            'Da biste omogućili automatsko izvršavanje izaberite bar jednu vrednost od minuta, sati i dana!',
        'Event Based Execution (Single Ticket)' => '',
        'Event Triggers' => 'Okidači događaja',
        'List of all configured events' => 'Lista svih konfigurisanih događaja',
        'Event' => 'Događaj',
        'Delete this event' => 'Obriši ovaj događaj',
        'Additionally or alternatively to a periodic execution, you can define ticket events that will trigger this job.' =>
            'Dodatno ili alternativno za periodično izvršenje, možete definisati događaje tiketa koji će pokrenuti ovaj posao.',
        'If a ticket event is fired, the ticket filter will be applied to check if the ticket matches. Only then the job is run on that ticket.' =>
            'Ukoliko je događaj tiketa otkazao, biće primenjen tiket filter da potvrdi da li tiket odgovara. Samo tada će se posao na tiketu pokrenuti.',
        'Do you really want to delete this event trigger?' => 'Da li stvarno želite da obrišete ovaj okidač događaja?',
        'Add Event Trigger' => 'Dodaj okidač događaja',
        'Add Event' => 'Dodaj događaj',
        'To add a new event select the event object and event name and click on the "+" button' =>
            'Za dodavanje novog događaja izaberite objekt događaja i ime događaja pa kliknite na "+" dugme',
        'Select Tickets' => 'Izaberi tikete',
        '(e. g. 10*5155 or 105658*)' => 'npr. 10*5144 ili 105658*',
        'Title' => 'Naslov',
        '(e. g. 234321)' => 'npr. 234321',
        'Customer user' => 'Klijent korisnik',
        '(e. g. U5150)' => '(npr. U5150)',
        'Fulltext-search in article (e. g. "Mar*in" or "Baue*").' => 'Potpuna tekstualna pretraga u članku (npr. "Mar*in" ili "Baue*")',
        'To' => 'Za',
        'Cc' => 'Cc',
        'Text' => 'Tekst',
        'Service' => 'Usluga',
        'Service Level Agreement' => 'Sporazum o nivou usluge',
        'Priority' => 'Prioritet',
        'Queue' => 'Red',
        'State' => 'Stanje',
        'Agent' => 'Operater',
        'Owner' => 'Vlasnik',
        'Responsible' => 'Odgovoran',
        'Ticket lock' => 'Tiket zaključan',
        'Create times' => 'Vremena otvaranja',
        'No create time settings.' => 'Nema podešavanja vremena otvaranja.',
        'Ticket created' => 'Tiket otvoren',
        'Ticket created between' => 'Tiket otvoren između',
        'and' => 'i',
        'Last changed times' => 'Vreme zadnje promene',
        'No last changed time settings.' => 'Nije podešeno vreme poslednje promene.',
        'Ticket last changed' => 'Vreme zadnje promene tiketa',
        'Ticket last changed between' => 'Zadnja promena tiketa između',
        'Change times' => 'Promena vremena',
        'No change time settings.' => 'Nema promene vremena',
        'Ticket changed' => 'Promenjen tiket',
        'Ticket changed between' => 'Tiket promenjen između',
        'Close times' => 'Vremena zatvaranja',
        'No close time settings.' => 'Nije podešeno vreme zatvaranja.',
        'Ticket closed' => 'Tiket zatvoren',
        'Ticket closed between' => 'Tiket zatvoren između',
        'Pending times' => 'Vremena čekanja',
        'No pending time settings.' => 'Nema podešavanja vremena čekanja',
        'Ticket pending time reached' => 'Dostignuto vreme čekanja tiketa',
        'Ticket pending time reached between' => 'Vreme čekanja tiketa dostignuto između',
        'Escalation times' => 'Vremena eskalacije',
        'No escalation time settings.' => 'Nema podešavanja vremena eskalacije',
        'Ticket escalation time reached' => 'Dostignuto vreme eskalacije tiketa',
        'Ticket escalation time reached between' => 'Vreme eskalacije tiketa dostignuto između',
        'Escalation - first response time' => 'Eskalacija - vreme prvog odziva',
        'Ticket first response time reached' => 'Dostignuto vreme prvog odziva na tiket',
        'Ticket first response time reached between' => 'Vreme prvog odziva na tiket dostignuto između',
        'Escalation - update time' => 'Eskalacija - vreme ažuriranja',
        'Ticket update time reached' => 'Dostignuto vreme ažuriranja tiketa',
        'Ticket update time reached between' => 'Vreme ažuriranja tiketa dostignuto između',
        'Escalation - solution time' => 'Eskalacija - vreme rešavanja',
        'Ticket solution time reached' => 'Dostignuto vreme rešavanja tiketa',
        'Ticket solution time reached between' => 'Vreme rešavanja tiketa dostignuto između',
        'Archive search option' => 'Opcije pretrage arhiva',
        'Update/Add Ticket Attributes' => 'Ažuriraj/Dodaj atribute tiketa',
        'Set new service' => 'Podesi nove usluge',
        'Set new Service Level Agreement' => 'Podesi novi Sporazum o nivou usluga',
        'Set new priority' => 'Podesi novi prioritet',
        'Set new queue' => 'Podesi novi red',
        'Set new state' => 'Podesi novi status',
        'Pending date' => 'Čekanje do',
        'Set new agent' => 'Podesi novog operatera',
        'new owner' => 'novi vlasnik',
        'new responsible' => 'novi odgovorni',
        'Set new ticket lock' => 'Podesi novo zaključavanje tiketa',
        'New customer user' => 'Novi klijent korisnik',
        'New customer ID' => 'Novi ID klijenta',
        'New title' => 'Novi naslov',
        'New type' => 'Novi tip',
        'New Dynamic Field Values' => 'Nove vrednosti dinamičkih polja',
        'Archive selected tickets' => 'Arhiviraj izabrane tikete',
        'Add Note' => 'Dodaj napomenu',
        'Time units' => 'Vremenske jedinice',
        'Execute Ticket Commands' => 'Izvrši komande tiketa',
        'Send agent/customer notifications on changes' => 'Pošalji obaveštenja operateru/klijentu pri promenama',
        'CMD' => 'CMD',
        'This command will be executed. ARG[0] will be the ticket number. ARG[1] the ticket id.' =>
            'Ova naredba će biti izvršena. ARG[0] je broj tiketa, a ARG[1] ID tiketa.',
        'Delete tickets' => 'Obriši tikete',
        'Warning: All affected tickets will be removed from the database and cannot be restored!' =>
            'UPOZORENJE: Svi obuhvaćeni tiketi će biti nepovratno uklonjeni iz baze!',
        'Execute Custom Module' => 'Pokreni izvršavanje posebnog modula',
        'Module' => 'Modul',
        'Param %s key' => 'Ključ parametra %s',
        'Param %s value' => 'Vrednost parametra %s',
        'Save Changes' => 'Sačuvaj promene',
        'Tag Reference' => 'Referenca oznake',
        'In the note section, you can use the following tags' => '',
        'Attributes of the current customer user data' => 'Atributi podataka aktuelnog klijenta korisnika',
        'Attributes of the ticket data' => 'Atributi podataka tiketa',
        'Ticket dynamic fields internal key values' => 'Vrednosti internih ključeva dinamičkih polja tiketa',
        'Example note' => '',
        'Results' => 'Rezultati',
        '%s Tickets affected! What do you want to do?' => '%s tiketa je obuhvaćeno. Šta želite da uradite?',
        'Warning: You used the DELETE option. All deleted tickets will be lost!' =>
            'UPOZORENJE: Upotrebili ste opciju za brisanje. Svi obrisani tiketi će biti izgubljeni!',
        'Warning: There are %s tickets affected but only %s may be modified during one job execution!' =>
            'Upozorenje: Obuhvaćeno je %s tiketa ali samo %s može biti izmenjeno tokom jednog izvršavanja posla!',
        'Edit job' => 'Uredi posao',
        'Run job' => 'Pokreni posao',
        'Affected Tickets' => 'Obuhvaćeni tiketi',
        'Age' => 'Starost',

        # Template: AdminGenericInterfaceDebugger
        'GenericInterface Debugger for Web Service %s' => 'Otklanjanje grešaka u opštem interfejsu veb servisa %s',
        'You are here' => 'Vi ste ovde',
        'Web Services' => 'Veb servisi',
        'Debugger' => 'Program za otklanjanje grešaka',
        'Go back to web service' => 'Idi nazad na veb servis',
        'Clear' => 'Očisti',
        'Do you really want to clear the debug log of this web service?' =>
            'Da li stvarno želite da očistite otklanjanje grešaka u logu ovog veb servisa?',
        'Request List' => 'Lista zahteva',
        'Time' => 'Vreme',
        'Remote IP' => 'Udaljena „IP” adresa',
        'Loading' => 'Učitavam...',
        'Select a single request to see its details.' => 'Izaberite jedan zahtev da bi videli njegove detalje.',
        'Filter by type' => 'Filter po tipu',
        'Filter from' => 'Filter od',
        'Filter to' => 'Filter do',
        'Filter by remote IP' => 'Filter po udaljenoj „IP” adresi',
        'Limit' => 'Ograničenje',
        'Refresh' => 'Osvežavanje',
        'Request Details' => 'Detalji zahteva',

        # Template: AdminGenericInterfaceInvokerDefault
        'Add new Invoker to Web Service %s' => 'Dodaj novog pozivaoca u veb servis %s',
        'Change Invoker %s of Web Service %s' => 'Promenite pozivaoca %s za veb servis %s',
        'Add new invoker' => 'Dodaj novog pozivaoca',
        'Change invoker %s' => 'Promeni pozivaoca %s',
        'Do you really want to delete this invoker?' => 'Da li zaista želite da izbrišete ovog pozivaoca?',
        'All configuration data will be lost.' => 'Svi konfiguracioni podaci će biti izgubljeni.',
        'Invoker Details' => 'Detalji pozivaoca',
        'The name is typically used to call up an operation of a remote web service.' =>
            'Ime se obično koristi za pokretanje operacije udaljenog veb servisa.',
        'Please provide a unique name for this web service invoker.' => 'Molimo upotrebite jedinstveno ime za ovog pozivaoca veb servisa.',
        'Invoker backend' => 'Pozadinski prikaz pozivaoca',
        'This OTRS invoker backend module will be called to prepare the data to be sent to the remote system, and to process its response data.' =>
            'Ovaj modul pozadinskog prikaza „OTRS” pozivaoca biće pozvan da pripremi podatke za slanje na udaljeni sistem i da obradi podatke njegovog odgovora.',
        'Mapping for outgoing request data' => 'Mapiranje za izlazne podatke zahteva',
        'Configure' => 'Podesi',
        'The data from the invoker of OTRS will be processed by this mapping, to transform it to the kind of data the remote system expects.' =>
            'Podaci iz „OTRS” pozivaoca biće obrađeni ovim mapiranjem, da bi ih transformisali u tipove podataka koje udaljeni sistem očekuje.',
        'Mapping for incoming response data' => 'Mapiranje za ulazne podatke odgovora',
        'The response data will be processed by this mapping, to transform it to the kind of data the invoker of OTRS expects.' =>
            'Podaci odgovora iz „OTRS” pozivaoca biće obrađeni ovim mapiranjem, da bi ih transformisali u tipove podataka koje udaljeni sistem očekuje..',
        'Asynchronous' => 'Asinhroni',
        'This invoker will be triggered by the configured events.' => 'Ovaj pozivaoc će biti aktiviran preko podešenih događaja.',
        'Asynchronous event triggers are handled by the OTRS Scheduler Daemon in background (recommended).' =>
            'Asinhronim okidačima događaja upravlja „OTRS” Planer sistemski proces u pozadini (preporučeno).',
        'Synchronous event triggers would be processed directly during the web request.' =>
            'Sinhroni okidači događaja biće obrađeni direktno tokom veb zahteva.',
        'Save and continue' => 'Sačuvaj i nastavi',

        # Template: AdminGenericInterfaceMappingSimple
        'GenericInterface Mapping Simple for Web Service %s' => 'Opšti interfejs jednostavnog mapiranja za veb servis %s',
        'Go back to' => 'Idi nazad na',
        'Mapping Simple' => 'Jednostavno mapiranje',
        'Default rule for unmapped keys' => 'Podrazumevano pravilo za nemapirane ključeve',
        'This rule will apply for all keys with no mapping rule.' => 'Ovo pravilo će se primenjivati za sve ključeve bez pravila mapiranja.',
        'Default rule for unmapped values' => 'Podrazumevano pravilo za nemapirane vrednosti',
        'This rule will apply for all values with no mapping rule.' => 'Ovo pravilo će se primenjivati za sve vrednosti bez pravila mapiranja.',
        'New key map' => 'Novo mapiranje ključa',
        'Add key mapping' => 'Dodaj mapiranje ključa',
        'Mapping for Key ' => 'Mapiranje za ključ',
        'Remove key mapping' => 'Ukloni mapiranje ključa',
        'Key mapping' => 'Mapiranje ključa',
        'Map key' => 'Mapiraj ključ',
        'matching the' => 'Podudaranje sa',
        'to new key' => 'na novi ključ',
        'Value mapping' => 'Vrednosno mapiranje',
        'Map value' => 'Mapiraj vrednost',
        'to new value' => 'na novu vrednost',
        'Remove value mapping' => 'Ukloni mapiranje vrednosti',
        'New value map' => 'Novo mapiranje vrednosti',
        'Add value mapping' => 'Dodaj mapiranu vrednost',
        'Do you really want to delete this key mapping?' => 'Da li stvarno želite da obrišete ovo mapiranje ključa?',

        # Template: AdminGenericInterfaceMappingXSLT
        'GenericInterface Mapping XSLT for Web Service %s' => 'Opšti interfejs „XSLT” mapiranja za veb servis %s',
        'Mapping XML' => 'Mapiranje „XML”',
        'Template' => 'Šablon',
        'The entered data is not a valid XSLT stylesheet.' => 'Uneti podaci nisu ispravan „XSLT” opis stilova.',
        'Insert XSLT stylesheet.' => 'Unesi „XSLT” opis stilova.',

        # Template: AdminGenericInterfaceOperationDefault
        'Add new Operation to Web Service %s' => 'Dodaj novu operaciju veb servisu %s',
        'Change Operation %s of Web Service %s' => 'Promeni operaciju %s iz veb servisa %s',
        'Add new operation' => 'Dodaj novu operaciju',
        'Change operation %s' => 'Promeni operaciju %s',
        'Do you really want to delete this operation?' => 'Da li stvarno želite da obrišete ovu operaciju?',
        'Operation Details' => 'Detalji operacije',
        'The name is typically used to call up this web service operation from a remote system.' =>
            'Naziv se obično koristi za pozivanje operacije veb servisa iz udaljenog sistema.',
        'Please provide a unique name for this web service.' => 'Molimo da obezbedite jedinstveno ime za ovaj veb servis.',
        'Mapping for incoming request data' => 'Mapiranje za dolazne podatke zahteva',
        'The request data will be processed by this mapping, to transform it to the kind of data OTRS expects.' =>
            'Podaci zahteva će biti obrađeni kroz mapiranje, radi transformacije u oblik koji OTRS očekuje.',
        'Operation backend' => 'Operativni pozadinski prikaz',
        'This OTRS operation backend module will be called internally to process the request, generating data for the response.' =>
            'Ovaj modul OTRS operativnog pozadinskog prikaza će biti interno pozvan da obradi zahtev, generisanjem podataka za odgovor.',
        'Mapping for outgoing response data' => 'Mapiranje za izlazne podatke odgovora',
        'The response data will be processed by this mapping, to transform it to the kind of data the remote system expects.' =>
            'Podaci odgovora će biti obrađeni kroz ovo mapiranje, radi transformacije u oblik koji udaljeni sistem očekuje.',

        # Template: AdminGenericInterfaceTransportHTTPREST
        'GenericInterface Transport HTTP::REST for Web Service %s' => 'Opšti interfejs transporta „HTTP::REST” za veb servis %s',
        'Network Transport' => '',
        'Properties' => 'Svojstva',
        'Route mapping for Operation' => 'Mapiranje rute za operaciju',
        'Define the route that should get mapped to this operation. Variables marked by a \':\' will get mapped to the entered name and passed along with the others to the mapping. (e.g. /Ticket/:TicketID).' =>
            'Definiše rutu koja će biti mapirana na ovu operaciju. Promenljive obeležene sa \':\' će biti mapirane na uneto ime i prosleđene sa ostalima (npr. /Ticket/:TicketID).',
        'Valid request methods for Operation' => 'Važeće metode zahteva za operaciju',
        'Limit this Operation to specific request methods. If no method is selected all requests will be accepted.' =>
            'Ograniči ovu opreaciju na pojedine metode zahteva. Ako ni jedna metoda nije izabrana svi zahtevi će biti prihvaćeni.',
        'Maximum message length' => 'Najveća dužina poruke',
        'This field should be an integer number.' => 'Ovo polje treba da bude ceo broj.',
        'Here you can specify the maximum size (in bytes) of REST messages that OTRS will process.' =>
            'Ovde možete uneti maksimalnu veličinu (u bajtima) „REST” poruka koje će „OTRS” da obradi.',
        'Send Keep-Alive' => 'Pošalji "Keep-Alive"',
        'This configuration defines if incoming connections should get closed or kept alive.' =>
            'Konfiguracija definiše da li dolazna konekcija treba da se zatvori i održava.',
        'Host' => 'Domaćin',
        'Remote host URL for the REST requests.' => 'URL udaljenog uređaja za REST zahteve.',
        'e.g https://www.otrs.com:10745/api/v1.0 (without trailing backslash)' =>
            'npr „https://www.otrs.com:10745/api/v1.0” (bez znaka \ kraju)',
        'Controller mapping for Invoker' => 'Mapiranje kontrolera za pozivaoca',
        'The controller that the invoker should send requests to. Variables marked by a \':\' will get replaced by the data value and passed along with the request. (e.g. /Ticket/:TicketID?UserLogin=:UserLogin&Password=:Password).' =>
            'Kontroler kome će pozivalac prosleđivati zahteve. Promenljive obeležene sa \':\' će biti zamenjene njihovim vrednostima i prosleđene zajedno sa zahtevom (npr. /Ticket/:TicketID?UserLogin=:UserLogin&Password=:Password).',
        'Valid request command for Invoker' => 'Važeća komanda zahteva za pozivaoca',
        'A specific HTTP command to use for the requests with this Invoker (optional).' =>
            'Specifična HTTP komanda za primenu na zahteve sa ovim pozivaocem (neobavezno).',
        'Default command' => 'Podrazumevana komanda',
        'The default HTTP command to use for the requests.' => 'Podrazumevena HTTP komanda za zahteve.',
        'Authentication' => 'Autentifikacija',
        'The authentication mechanism to access the remote system.' => 'Mehanizam autentifikacije za pristum udaljenom sistemu.',
        'A "-" value means no authentication.' => 'Vrednost "-" znači nema autentifikacije.',
        'User' => 'Korisnik',
        'The user name to be used to access the remote system.' => 'Korisničko ime koje će biti korišćeno za pristup udaljenom sistemu.',
        'Password' => 'Lozinka',
        'The password for the privileged user.' => 'Lozinka za privilegovanog korisnika.',
        'Use SSL Options' => 'Koristi SSL opcije',
        'Show or hide SSL options to connect to the remote system.' => 'Prikaži ili sakrij SSL opcije za povezivanje sa udaljenim sistemom.',
        'Certificate File' => 'Sertifikat datoteke',
        'The full path and name of the SSL certificate file.' => 'Cela putanja i naziv za datoteku SSL sertifikata.',
        'e.g. /opt/otrs/var/certificates/REST/ssl.crt' => 'npr /opt/otrs/var/certificates/REST/ssl.crt',
        'Certificate Password File' => 'Sertifikat lozinke datoteke',
        'The full path and name of the SSL key file.' => 'Cela putanja i naziv za datoteku SSL ključa.',
        'e.g. /opt/otrs/var/certificates/REST/ssl.key' => 'npr /opt/otrs/var/certificates/REST/ssl.key',
        'Certification Authority (CA) File' => 'Datoteka sertifikacionog tela (CA)',
        'The full path and name of the certification authority certificate file that validates the SSL certificate.' =>
            'Cela putanja i naziv sertifikacionog tela koje proverava ispravnost SSL sertifikata.',
        'e.g. /opt/otrs/var/certificates/REST/CA/ca.file' => 'npr /opt/otrs/var/certificates/REST/CA/ca.file',

        # Template: AdminGenericInterfaceTransportHTTPSOAP
        'GenericInterface Transport HTTP::SOAP for Web Service %s' => 'Opšti interfejs transporta HTTP::SOAP za veb servis %s',
        'Endpoint' => 'Krajnja tačka',
        'URI to indicate a specific location for accessing a service.' =>
            'URI za identifikaciju specifične lokacije za pristup servisu.',
        'e.g. http://local.otrs.com:8000/Webservice/Example' => 'npr. http://local.otrs.com:8000/Webservice/Example',
        'Namespace' => 'Prtostor imena',
        'URI to give SOAP methods a context, reducing ambiguities.' => 'URI koji daje kontekst SOAP metodama, smanjuje dvosmislenosti.',
        'e.g urn:otrs-com:soap:functions or http://www.otrs.com/GenericInterface/actions' =>
            'npr. urn:otrs-com:soap:functions ili http://www.otrs.com/GenericInterface/actions',
        'Request name scheme' => 'Zahtev za šemu imena',
        'Select how SOAP request function wrapper should be constructed.' =>
            'Izaberite kako će biti konstruisan omotač funkcije „SOAP” zahteva.',
        '\'FunctionName\' is used as example for actual invoker/operation name.' =>
            '„NazivFunkcije” se koristi kao primer za stvarno ime pozivaoca/operacije.',
        '\'FreeText\' is used as example for actual configured value.' =>
            '„Slobodan tekst” se koristi kao primer za stvarnu podešenu vrednost.',
        'Request name free text' => '',
        'Text to be used to as function wrapper name suffix or replacement.' =>
            'Tekst koji će biti korišten kao nastavak imena ili zamena omotača funkcije.',
        'Please consider XML element naming restrictions (e.g. don\'t use \'<\' and \'&\').' =>
            'Molimo da uzmete u obzir „XML” oganičenja imenovanja (npr nemojte koristiti „<” i „&”).',
        'Response name scheme' => 'Šema imena odgovora',
        'Select how SOAP response function wrapper should be constructed.' =>
            'Izaberite kako će biti konstruisan omotač funkcije „SOAP” odgovora.',
        'Response name free text' => 'Slobodan tekst imena odgovora',
        'Here you can specify the maximum size (in bytes) of SOAP messages that OTRS will process.' =>
            'Ovde možete uneti maksimalnu veličinu (u bajtima) SOAP poruka koje će OTRS da obradi.',
        'Encoding' => 'Kodni raspored',
        'The character encoding for the SOAP message contents.' => 'Kodni raspored znakova za sadržaj SOAP poruke.',
        'e.g utf-8, latin1, iso-8859-1, cp1250, Etc.' => 'npr. utf-8, latin1, iso-8859-1, cp1250, ...',
        'SOAPAction' => 'SOAP akcija',
        'Set to "Yes" to send a filled SOAPAction header.' => 'Izaberi "Da" za slanje popunjenog zaglavlja SOAP akcije.',
        'Set to "No" to send an empty SOAPAction header.' => 'Izaberi "Ne" za slanje praznog zaglavlja SOAP akcije.',
        'SOAPAction separator' => 'Separator SOAP akcije',
        'Character to use as separator between name space and SOAP method.' =>
            'Znak koji će se koristiti kao separator između prostora imena i SOAP metode.',
        'Usually .Net web services uses a "/" as separator.' => 'Obično .Net veb servisi koriste "/" kao separator.',
        'Proxy Server' => 'Proxy server',
        'URI of a proxy server to be used (if needed).' => 'URI od proxy servera da bude korišćen (ako je potrebno).',
        'e.g. http://proxy_hostname:8080' => 'npr. http://proxy_hostname:8080',
        'Proxy User' => 'Proxy korisnik',
        'The user name to be used to access the proxy server.' => 'Korisničko ime koje će se koristiti za pristup proxy serveru.',
        'Proxy Password' => 'Proxy lozinka',
        'The password for the proxy user.' => 'Lozinka za proxy korisnika',
        'The full path and name of the SSL certificate file (must be in .p12 format).' =>
            'Cela putanja i naziv za datoteku SSL sertifikata (mora biti u .p12 formatu).',
        'e.g. /opt/otrs/var/certificates/SOAP/certificate.p12' => 'npr. /opt/otrs/var/certificates/SOAP/certificate.p12',
        'The password to open the SSL certificate.' => 'Lozinka za otvaranje SSL sertifikata',
        'The full path and name of the certification authority certificate file that validates SSL certificate.' =>
            'Cela putanja i naziv sertifikacionog tela koje provera ispravnost SSL sertifikata.',
        'e.g. /opt/otrs/var/certificates/SOAP/CA/ca.pem' => 'npr. /opt/otrs/var/certificates/SOAP/CA/ca.pem',
        'Certification Authority (CA) Directory' => 'Direktorijum sertifikacionog tela (CA)',
        'The full path of the certification authority directory where the CA certificates are stored in the file system.' =>
            'Cela putanja direktorijuma sertifikacionog tela gde se skladište CA sertifikati u sistemu datoteka.',
        'e.g. /opt/otrs/var/certificates/SOAP/CA' => 'npr. /opt/otrs/var/certificates/SOAP/CA',
        'Sort options' => 'Opcije sortiranja',
        'Add new first level element' => 'Dodaj novi element prvog nivoa',
        'Element' => 'Element',
        'Add' => 'Dodati',
        'Outbound sort order for xml fields (structure starting below function name wrapper) - see documentation for SOAP transport.' =>
            'Odlazni redosled sortiranja za XML polja (struktura ispod naziva omotača funkcije) - pogledajte dokumentaciju za „SOAP” transport.',

        # Template: AdminGenericInterfaceWebservice
        'GenericInterface Web Service Management' => 'Upravljanje oštim interfejsom veb servisa',
        'Add web service' => 'Dodaj veb servis',
        'Clone web service' => 'Kloniraj veb servis',
        'The name must be unique.' => 'Ime mora biti jedinstveno.',
        'Clone' => 'Kloniraj',
        'Export web service' => 'Izvezi veb servis',
        'Import web service' => 'Uvezi veb servis',
        'Configuration File' => 'Konfiguraciona datoteka',
        'The file must be a valid web service configuration YAML file.' =>
            'Datoteka mora da bude važeća YAML konfiguraciona datoteka veb servisa.',
        'Import' => 'Uvezi',
        'Configuration history' => 'Istorijat konfigurisanja',
        'Delete web service' => 'Obriši veb servis',
        'Do you really want to delete this web service?' => 'Da li stvarno želite da obrišete ovaj veb servis?',
        'Example Web Services' => '',
        'Here you can activate best practice example web service that are part of %s. Please note that some additional configuration may be required.' =>
            '',
        'Import example web service' => '',
        'Do you want to benefit from web services created by experts? Upgrade to %s to be able to import some sophisticated example web services.' =>
            '',
        'After you save the configuration you will be redirected again to the edit screen.' =>
            'Nakon snimanja konfiguracije bićete ponovo preusmereni na prikaz ekrana za uređivanje.',
        'If you want to return to overview please click the "Go to overview" button.' =>
            'Ako želite da se vratite na pregled, molimo da kliknete na dugme "Idi na pregled".',
        'Web Service List' => 'Lista veb servisa',
        'Remote system' => 'Udaljeni sistem',
        'Provider transport' => 'Transport provajdera',
        'Requester transport' => 'Transport potražioca',
        'Debug threshold' => 'Prag uklanjanja grešaka',
        'In provider mode, OTRS offers web services which are used by remote systems.' =>
            'U režimu provajdera, OTRS nudi veb servise koji se koriste od strane udaljenih sistema.',
        'In requester mode, OTRS uses web services of remote systems.' =>
            'U režimu naručioca, OTRS koristi veb servise udaljenih sistema.',
        'Network transport' => 'Mrežni transport',
        'Operations are individual system functions which remote systems can request.' =>
            'Operacije su individualne sistemske funkcije koje udaljeni sistemi mogu da zahtevaju.',
        'Invokers prepare data for a request to a remote web service, and process its response data.' =>
            'Pozivaoci pripremaju podatke za zahtev na udaljenom web servisu i obrađuju podatke njegovih odgovora.',
        'Controller' => 'Kontroler',
        'Inbound mapping' => 'Ulazno mapiranje',
        'Outbound mapping' => 'Izlazno mapiranje',
        'Delete this action' => 'Obriši ovu akciju',
        'At least one %s has a controller that is either not active or not present, please check the controller registration or delete the %s' =>
            'Najmanje jedan %s ima kontroler koji ili nije aktivan ili nije prisutan, molimo proverite registraciju kontrolera ili izbrišite %s',

        # Template: AdminGenericInterfaceWebserviceHistory
        'GenericInterface Configuration History for Web Service %s' => 'Istorijat konfiguracije opšteg interfejsa za veb servis %s',
        'History' => 'Istorija',
        'Go back to Web Service' => 'Vratite se na veb servis',
        'Here you can view older versions of the current web service\'s configuration, export or even restore them.' =>
            'Ovde možete videti starije verzije konfiguracije aktuelnog veb servisa, eksportovati ih ili ih obnoviti.',
        'Configuration History List' => 'Lista - istorijat konfiguracije',
        'Version' => 'Verzija',
        'Create time' => 'Vreme kreiranja',
        'Select a single configuration version to see its details.' => 'Izaberi samo jednu konfiguracionu verziju za pregled njenih detalja.',
        'Export web service configuration' => 'Izvezi konfiguraciju veb servisa',
        'Restore web service configuration' => 'Obnovi konfiguraciju veb servisa',
        'Do you really want to restore this version of the web service configuration?' =>
            'Da li stvarno želite da vratite ovu verziju konfiguracije veb servisa?',
        'Your current web service configuration will be overwritten.' => 'Aktuelna konfiguracija veb servisa biće prepisana.',

        # Template: AdminGroup
        'Group Management' => 'Upravljanje grupama',
        'Add group' => 'Dodaj grupu',
        'Filter for log entries' => '',
        'The admin group is to get in the admin area and the stats group to get stats area.' =>
            '"admin" grupa služi za pristup administracionom prostoru, a "stats" grupa prostoru statistike.',
        'Create new groups to handle access permissions for different groups of agent (e. g. purchasing department, support department, sales department, ...). ' =>
            'Napravi nove grupe za rukovanje pravima pristupa raznim grupama operatera (npr. odeljenje nabavke, tehnička podrška, prodaja, ...).',
        'It\'s useful for ASP solutions. ' => 'Korisno ASP rešenja.',
        'Add Group' => 'Dodaj grupu',
        'Edit Group' => 'Uredi grupu',

        # Template: AdminLog
        'System Log' => 'Sistemski log',
        'Filter for Log Entries' => '',
        'Here you will find log information about your system.' => 'Ovde ćete naći log informacije o vašem sistemu.',
        'Hide this message' => 'Sakrij ovu poruku',
        'Recent Log Entries' => 'Poslednji log unosi',
        'Facility' => 'Instalacija',
        'Message' => 'Poruka',

        # Template: AdminMailAccount
        'Mail Account Management' => 'Upravljanje imejl nalozima',
        'Add mail account' => 'Dodaj imejl nalog',
        'Filter for Mail Accounts' => '',
        'Filter for mail accounts' => '',
        'All incoming emails with one account will be dispatched in the selected queue!' =>
            'Sve dolazne poruke sa jednog imejl naloga će biti usmerene u izabrani red!',
        'If your account is trusted, the already existing X-OTRS header at arrival time (for priority, ...) will be used! PostMaster filter will be used anyway.' =>
            'Ako je vaš nalog od poverenja, koristiće se postojeća X-OTRS zaglavlja! PostMaster filteri se koriste uvek.',
        'Delete account' => 'Obriši nalog',
        'Fetch mail' => 'Preuzmi poštu',
        'Add Mail Account' => 'Dodaj imejl nalog',
        'Example: mail.example.com' => 'Primer: mail.example.com',
        'IMAP Folder' => 'IMAP folder',
        'Only modify this if you need to fetch mail from a different folder than INBOX.' =>
            'Ovo izmenite samo ako je potrebno primiti poštu iz drugog foldera, a ne iz INBOX-a.',
        'Trusted' => 'Od poverenja',
        'Dispatching' => 'Otprema',
        'Edit Mail Account' => 'Uredi mejl nalog',

        # Template: AdminNavigationBar
        'Admin' => 'Admin',
        'Agent Management' => 'Upravljanje operaterima',
        'Email Settings' => 'Podešavanja imejla',
        'Queue Settings' => 'Podešavanje redova',
        'Ticket Settings' => 'Podešavanje tiketa',
        'System Administration' => 'Administracija sistema',
        'Online Admin Manual' => 'Administrativno uputstvo na mreži',

        # Template: AdminNotificationEvent
        'Ticket Notification Management' => 'Upravljanje obaveštenjima o tiketima',
        'Add notification' => 'Dodaj obaveštenje',
        'Export Notifications' => 'Obaveštenja o izvozu',
        'Filter for Notifications' => '',
        'Filter for notifications' => '',
        'Here you can upload a configuration file to import Ticket Notifications to your system. The file needs to be in .yml format as exported by the Ticket Notification module.' =>
            'Ovde možete poslati konfiguracionu datoteku za uvoz obaveštenja o tiketu u vaš sistem. Datoteka mora biti u „.yml” formatu ako se izvozi od strane modula za obaveštenja o tiketu.',
        'Overwrite existing notifications?' => 'Prepiši preko postojećih obaveštenja?',
        'Upload Notification configuration' => 'Otpremi konfiguraciju obaveštavanja',
        'Import Notification configuration' => 'Uvezi konfiguraciju obaveštenja',
        'Delete this notification' => 'Obriši ovo obaveštenje',
        'Add Notification' => 'Dodaj Obaveštenje',
        'Edit Notification' => 'Uredi obaveštenje',
        'Show in agent preferences' => 'Prikazano u operaterskim postavkama.',
        'Agent preferences tooltip' => 'Poruka za operaterska podešavanja',
        'This message will be shown on the agent preferences screen as a tooltip for this notification.' =>
            'Ova poruka će biti prikazana na ekranu operaterskih podešavanja kao ispomoć.',
        'Events' => 'Događaji',
        'Here you can choose which events will trigger this notification. An additional ticket filter can be applied below to only send for ticket with certain criteria.' =>
            'Ovde možete izabrati koji događaji će pokrenuti obaveštavanje. Dodatni filter za tikete može biti primenjen radi slanja samo za tikete po određenom kriterijumu.',
        'Ticket Filter' => 'Filter tiketa',
        'Lock' => 'Zaključaj',
        'SLA' => '„SLA”',
        'Customer' => 'Klijent',
        'Article Filter' => 'Filter članka',
        'Only for ArticleCreate and ArticleSend event' => 'Samo za događaj kreiranje članka i slanje članka',
        'Article type' => 'Tip članka',
        'If ArticleCreate or ArticleSend is used as a trigger event, you need to specify an article filter as well. Please select at least one of the article filter fields.' =>
            'Ako se koriste događaji kreiranje članka i slanje članka, neophodno je definisati filter članka. Molim vas selektujte bar jedno polje za filter članka.',
        'Article sender type' => 'Tip pošiljaoca članka',
        'Subject match' => 'Poklapanje predmeta',
        'Body match' => 'Poklapanje sadržaja',
        'Include attachments to notification' => 'Uključi priloge uz obavštenje',
        'Recipients' => 'Promaoci',
        'Send to' => 'Pošalji za ',
        'Send to these agents' => 'Pošalji ovim operaterima',
        'Send to all group members' => 'Pošalji svim članovima grupe',
        'Send to all role members' => 'Pošalji svim pripadnicima uloge',
        'Send on out of office' => 'Pošalji i kad je van kancelarije',
        'Also send if the user is currently out of office.' => 'Takođe pošalji i kada je korisnik van kancelarije.',
        'Once per day' => 'Jednom dnevno',
        'Notify user just once per day about a single ticket using a selected transport.' =>
            'Obaveti korisnika samo jednom dnevno o pojedinom tiketu korišćenjem izabranog transporta.',
        'Notification Methods' => 'Metode obaveštavanja',
        'These are the possible methods that can be used to send this notification to each of the recipients. Please select at least one method below.' =>
            'Ovo su moguće metode koje se mogu koristiti za slanje obaveštenja svakom primaocu. Molimo vas da izaberete bar jednu metodu od ponuđenih.',
        'Enable this notification method' => 'Aktiviraj ovaj metod obaveštavanja',
        'Transport' => 'Transport',
        'At least one method is needed per notification.' => 'Potreban je najmanje jedan metod po obaveštenju.',
        'Active by default in agent preferences' => ' Podrazumevano aktivno u operaterskim postavkama.',
        'This is the default value for assigned recipient agents who didn\'t make a choice for this notification in their preferences yet. If the box is enabled, the notification will be sent to such agents.' =>
            '',
        'This feature is currently not available.' => 'Ovo svojstvo trenutno nije dostupno.',
        'No data found' => 'Ništa nije pronađeno',
        'No notification method found.' => 'Nije pronađena metoda obaveštavanja.',
        'Notification Text' => 'Tekst obaveštenja',
        'This language is not present or enabled on the system. This notification text could be deleted if it is not needed anymore.' =>
            'Ovaj jezik nije prisutan ili uključen na sistemu. Ovo obaveštenje može biti izbrisano ukoliko više nije neophodno.',
        'Remove Notification Language' => 'Ukloni jezik obaveštenja',
        'Message body' => 'Sadržaj poruke',
        'Add new notification language' => 'Ukloni novi jezik obaveštenja',
        'Notifications are sent to an agent or a customer.' => 'Obaveštenje poslato operateru ili klijentu.',
        'To get the first 20 character of the subject (of the latest agent article).' =>
            'Da vidite prvih 20 slova predmeta (poslednjeg članka operatera).',
        'To get the first 5 lines of the body (of the latest agent article).' =>
            'Da vidite prvih 5 linija poruke (poslednjeg članka operatera).',
        'To get the first 20 character of the subject (of the latest customer article).' =>
            'Da vidite prvih 20 slova predmeta (poslednjeg članka klijenta).',
        'To get the first 5 lines of the body (of the latest customer article).' =>
            'Da vidite prvih 5 linija poruke (poslednjeg članka klijenta).',
        'Attributes of the current ticket owner user data' => 'Atributi podataka korisnika vlasnika aktuelnog tiketa',
        'Attributes of the current ticket responsible user data' => 'Atributi podataka odgovornog korisnika aktuelnog tiketa',
        'Attributes of the current agent user who requested this action' =>
            'Atributi aktuelnog korisnika operatera koji je tražio ovu akciju',
        'Attributes of the recipient user for the notification' => 'Atributi korisnika primaoca za obaveštenje',
        'Ticket dynamic fields display values, useful for Dropdown and Multiselect fields' =>
            'Prikazane vrednosti dinamičkih polja, korisno za padajuća i polja sa višestrukim izborom.',
        'Example notification' => 'Primer obaveštenja',

        # Template: AdminNotificationEventTransportEmailSettings
        'Additional recipient email addresses' => 'Imejl adresa dodatnog primaoca',
        'Notification article type' => 'Tip članka obaveštenja',
        'An article will be created if the notification is sent to the customer or an additional email address.' =>
            'Članak je kreiran i obaveštenje poslato klijentu ili na drugu imejl adresu.',
        'Email template' => 'Imejl šablon',
        'Use this template to generate the complete email (only for HTML emails).' =>
            'Upotrebite ovaj šablon za generisanje kompletnog imejla (samo za „HTML” imejlove).',
        'Enable email security' => '',
        'Email security level' => '',
        'If signing key/certificate is missing' => '',
        'If encryption key/certificate is missing' => '',

        # Template: AdminOTRSBusinessInstalled
        'Manage %s' => 'Upravljaj sa %s',
        'Downgrade to OTRS Free' => 'Povratak na besplatnu verziju „OTRS”',
        'Read documentation' => 'Pročitaj dokumentaciju',
        '%s makes contact regularly with cloud.otrs.com to check on available updates and the validity of the underlying contract.' =>
            '%s redovno se povezuje sa „cloud.otrs.com” za proveru dostupnih ažuriranja i ispravnosti internih ugovora.',
        'Unauthorized Usage Detected' => 'Detektovana neovlaštena upotreba',
        'This system uses the %s without a proper license! Please make contact with %s to renew or activate your contract!' =>
            'Ovaj sistem koristi %s bez adekvatne licence! Molimo da kontaktirate %s za obnovu ili aktivaciju vašeg ugovora!',
        '%s not Correctly Installed' => '%s nije korektno instalirana',
        'Your %s is not correctly installed. Please reinstall it with the button below.' =>
            'Vaš %s nije korektno instaliran. Molimo da reinstalirate putem dugmeta ispod.',
        'Reinstall %s' => 'Reinstaliraj %s',
        'Your %s is not correctly installed, and there is also an update available.' =>
            'Vaš %s nije korektno instaliran, a i ažuriranje je dostupno.',
        'You can either reinstall your current version or perform an update with the buttons below (update recommended).' =>
            'Možete reinstalirati aktuelnu verziju ili izvršiti ažuriranje putem dugmeta ispod (preporučuje se ažuriranje).',
        'Update %s' => 'Ažuriraj %s',
        '%s Not Yet Available' => '%s nije još dostupno',
        '%s will be available soon.' => '%s će biti uskoro dostupno',
        '%s Update Available' => '%s dostupno ažuriranje',
        'An update for your %s is available! Please update at your earliest!' =>
            'Ažuriranje za vaš %s je dostupno! Molimo vas da ažurirate što pre!',
        '%s Correctly Deployed' => '%s korektno raspoređeno',
        'Congratulations, your %s is correctly installed and up to date!' =>
            'Čestitamo, vaš %s je korektno instaliran i ažuran!',

        # Template: AdminOTRSBusinessNotInstalled
        '%s will be available soon. Please check again in a few days.' =>
            '%s će biti dostupna uskoro. Molimo, proverite ponovo za nekoliko dana.',
        'Please have a look at %s for more information.' => 'Molimo da pogledate  %s za više informacija.',
        'Your OTRS Free is the base for all future actions. Please register first before you continue with the upgrade process of %s!' =>
            'Vaš „OTRS Free” je osnova za sve buduće aktivnosti. Molimo vas da se registrujete pre nego što nastavite sa procesom ažuriranja %s!',
        'Before you can benefit from %s, please contact %s to get your %s contract.' =>
            'Pre nego vam %s bude koristan, molimo da kontaktirate %s da biste dobili %s ugovor.',
        'Connection to cloud.otrs.com via HTTPS couldn\'t be established. Please make sure that your OTRS can connect to cloud.otrs.com via port 443.' =>
            'Konekcija prema cloud.otrs.com preko HTTPS nije mogla biti uspostavljena. Molimo osigurajte da vaš „OTRS” može da se poveže sa cloud.otrs.com preko porta 443.',
        'With your existing contract you can only use a small part of the %s.' =>
            'Sa vašim sadašnjim ugovorom možete koristiti samo mali deo od %s.',
        'If you would like to take full advantage of the %s get your contract upgraded now! Contact %s.' =>
            'Ako želite da iskoristite sve prednosti %s potrebno je da ažurirate vaš ugovor! Kontaktirajte %s.',

        # Template: AdminOTRSBusinessUninstall
        'Cancel downgrade and go back' => 'Poništi povratak na staru verziju i vrati se nazad',
        'Go to OTRS Package Manager' => 'Idi na „OTRS” upravljanje paketima',
        'Sorry, but currently you can\'t downgrade due to the following packages which depend on %s:' =>
            'Nažalost, trenutno ne možete da se vratite na staru verziju zbog sledećih paketa koji zavise od %s:',
        'Vendor' => 'Prodavac',
        'Please uninstall the packages first using the package manager and try again.' =>
            'Molimo vas da prvo deinstalirate pakete kroz upravljač paketima pa da pokušate ponovo. ',
        'You are about to downgrade to OTRS Free and will lose the following features and all data related to these:' =>
            'Vratićete se na staru verziju besplatnog „OTRS” i izgubićete sledeća svojstva i podatke povezane sa:',
        'Chat' => 'Ćaskanje',
        'Report Generator' => 'Generator izveštaja',
        'Timeline view in ticket zoom' => 'Detaljni prikaz tiketa na vremenskoj liniji',
        'DynamicField ContactWithData' => 'Dinamičko polje „Kontakt sa podacima”',
        'DynamicField Database' => 'Baza podataka dinamičkih polja',
        'SLA Selection Dialog' => 'Dijalog izbora „SLA” ',
        'Ticket Attachment View' => 'Pregled priloga uz tiket',
        'The %s skin' => 'Izgled %s',

        # Template: AdminPGP
        'PGP Management' => 'Upravljanje PGP ključevima',
        'PGP support is disabled' => '',
        'To be able to use PGP in OTRS, you have to enable it first.' => '',
        'Enable PGP support' => '',
        'Faulty PGP configuration' => '',
        'PGP support is enabled, but the relevant configuration contains errors. Please check the configuration using the button below.' =>
            '',
        'Configure it here!' => '',
        'Check PGP configuration' => '',
        'Add PGP key' => 'Dodaj PGP ključ',
        'In this way you can directly edit the keyring configured in SysConfig.' =>
            'Na ovaj način možete direktno uređivati komplet ključeva podešen u SysConfig (sistemskim konfiguracijama).',
        'Introduction to PGP' => 'Uvod u PGP',
        'Result' => 'Rezultat',
        'Status' => 'Status',
        'Identifier' => 'Identifikator',
        'Bit' => 'Bit',
        'Fingerprint' => 'Otisak',
        'Expires' => 'Ističe',
        'Delete this key' => 'Obriši ovaj ključ',
        'Add PGP Key' => 'Dodaj PGP ključ',
        'PGP key' => 'PGP ključ',

        # Template: AdminPackageManager
        'Package Manager' => 'Upravljanje paketima',
        'Uninstall Package' => '',
        'Do you really want to uninstall this package?' => 'Da li stvarno želite da deinstalirate ovaj paket?',
        'Uninstall package' => 'Deinstaliraj paket',
        'Reinstall package' => 'Instaliraj paket ponovo',
        'Do you really want to reinstall this package? Any manual changes will be lost.' =>
            'Da li stvarno želite da ponovo instalirate ovaj paket? Sve ručne promene će biti izgubljene.',
        'Continue' => 'Nastavi',
        'Please make sure your database accepts packages over %s MB in size (it currently only accepts packages up to %s MB). Please adapt the max_allowed_packet setting of your database in order to avoid errors.' =>
            'Molimo vas da budete sigurni da vaša baza podataka prihvata pakete veličine preko %s MB (trenutno prihvata samo pakete do %s MB).Molimo prilagodite podešavanja "max_allowed_packet" na vašoj bazi podataka, da bi ste izbegli greške.',
        'Install' => 'Instaliraj',
        'Install Package' => 'Instaliraj paket',
        'Update repository information' => 'Ažuriraj informacije o spremištu',
        'Cloud services are currently disabled.' => 'Servisi u oblaku su trenutno deaktivirani.',
        'OTRS Verify™ can not continue!' => '',
        'Enable cloud services' => 'Aktiviraj servise u oblaku',
        'Online Repository' => 'Mrežno spremište',
        'Action' => 'Akcija',
        'Module documentation' => 'Dokumentacija modula',
        'Upgrade' => 'Ažuriranje',
        'Local Repository' => 'Lokalno spremište',
        'This package is verified by OTRSverify (tm)' => 'Ovaj paket je verifikovan od strane OTRSverify (tm)',
        'Uninstall' => 'Deinstaliraj',
        'Package not correctly deployed! Please reinstall the package.' =>
            'Paket nije korektno instaliran! Instalirajte ga ponovo.',
        'Reinstall' => 'Instaliraj ponovo',
        'Features for %s Customers Only' => '',
        'With %s, you can benefit from the following optional features. Please make contact with %s if you need more information.' =>
            'Sa %s možete imati koristi od sledećih opcionih funkcija. Molimo da kontaktirate %s ukoliko su vam potrebne dodatne informacije.',
        'Download package' => 'Preuzmi paket',
        'Rebuild package' => 'Obnovi paket(rebuild)',
        'Metadata' => 'Meta podaci',
        'Change Log' => 'Promeni log',
        'Date' => 'Datum',
        'List of Files' => 'Spisak datoteka',
        'Permission' => 'Dozvola',
        'Download' => 'Preuzimanje',
        'Download file from package!' => 'Preuzmi datoteku iz paketa!',
        'Required' => 'Obavezno',
        'Size' => 'Veličina',
        'PrimaryKey' => 'Primarni ključ',
        'AutoIncrement' => 'AutoUvećanje',
        'SQL' => 'SQL',
        'File Differences for File %s' => '',

        # Template: AdminPerformanceLog
        'Performance Log' => 'Performansa log-a',
        'This feature is enabled!' => 'Ova funkcija je aktivna!',
        'Just use this feature if you want to log each request.' => 'Aktivirati ovu mogućnost samo ako želite da zabeležite svaki zahtev.',
        'Activating this feature might affect your system performance!' =>
            'Aktiviranje ove funkcije može uticati na performanse sistema.',
        'Disable it here!' => 'Isključite je ovde!',
        'Logfile too large!' => 'Log datoteka je prevelika!',
        'The logfile is too large, you need to reset it' => 'Log datoteka je prevelika, treba da je resetujete',
        'Reset' => 'Poništi',
        'Overview' => 'Pregled',
        'Range' => 'Opseg',
        'last' => 'poslednje',
        'Interface' => 'Interfejs',
        'Requests' => 'Zahtevi',
        'Min Response' => 'Min odziv',
        'Max Response' => 'Maks odziv',
        'Average Response' => 'Prosečan odziv',
        'Period' => 'Period',
        'minutes' => 'minuti',
        'Min' => 'Min',
        'Max' => 'Maks',
        'Average' => 'Prosek',

        # Template: AdminPostMasterFilter
        'PostMaster Filter Management' => 'Upravljanje PostMaster filterima',
        'Add filter' => 'Dodaj filter',
        'Filter for Postmaster Filters' => '',
        'Filter for postmaster filters' => '',
        'To dispatch or filter incoming emails based on email headers. Matching using Regular Expressions is also possible.' =>
            'Radi otpreme ili filtriranja dolaznih imejlova na osnovu zaglavlja. Poklapanje pomoću regularnih izraza je takođe moguće.',
        'If you want to match only the email address, use EMAILADDRESS:info@example.com in From, To or Cc.' =>
            'Ukoliko želite poklapanje samo sa imejl adresom, koristite EMAILADDRESS:info@example.com u "Od", "Za" ili "Cc".',
        'If you use Regular Expressions, you also can use the matched value in () as [***] in the \'Set\' action.' =>
            'Ukoliko koristite regularne izraze, takođe možete koristiti i upateru vrednost u () kao (***) u \'Set\' action.',
        'You can also use \'named captures\' ((?<name>)) and use the names in the \'Set\' action ([**\name**]). (e.g. Regexp: Server: (?<server>\w+), Set action [**\server**]). A matched EMAILADDRESS has the name \'email\'.' =>
            '',
        'Delete this filter' => 'Obriši ovaj filter',
        'Add PostMaster Filter' => 'Dodaj PostMaster filter',
        'Edit PostMaster Filter' => 'Uredi PostMaster filter',
        'The name is required.' => 'Ime je obavezno.',
        'Filter Condition' => 'Uslov filtriranja',
        'AND Condition' => 'AND uslov',
        'Check email header' => 'Proveri zaglavlje imejla',
        'Negate' => 'Negirati',
        'Look for value' => 'Potraži vrednost',
        'The field needs to be a valid regular expression or a literal word.' =>
            'Ovo polje treba da bude važeći regularni izraz ili doslovno reč.',
        'Set Email Headers' => 'Podesi zaglavlja imejla',
        'Set email header' => 'Podesi zaglavlje imejla',
        'Set value' => 'Podesi vrednost',
        'The field needs to be a literal word.' => 'Ovo polje treba da bude doslovno reč.',
        'Save changes' => '',
        'Header' => 'Naslov',

        # Template: AdminPriority
        'Priority Management' => 'Upravljanje prioritetima',
        'Add priority' => 'Dodaj prioritet',
        'Filter for Priorities' => '',
        'Filter for priorities' => '',
        'Add Priority' => 'Dodaj Prioritet',
        'Edit Priority' => 'Uredi Prioritet',

        # Template: AdminProcessManagement
        'Process Management' => 'Upravljanje procesom',
        'Filter for Processes' => 'Filter procesa',
        'Filter' => 'Filter',
        'Create New Process' => 'Kreiraj novi proces',
        'Deploy All Processes' => 'Rasporedi sve procese',
        'Here you can upload a configuration file to import a process to your system. The file needs to be in .yml format as exported by process management module.' =>
            'Ovde možete učitati konfiguracionu datoteku za uvoz procesa u vaš sistem. Datoteka mora biti u .yml formatu izvezena od strane modula za upravljanje procesom.',
        'Overwrite existing entities' => 'Napiši preko postojećih entiteta',
        'Upload process configuration' => 'Učitaj konfiguraciju procesa',
        'Import process configuration' => 'Uvezi konfiguraciju procesa',
        'Example Processes' => '',
        'Here you can activate best practice example processes that are part of %s. Please note that some additional configuration may be required.' =>
            'Ovde možete aktivirati procese primera nabolje prakse koji su deo %s. Molimo da obratite pažnju da je možda potrebno dodatno konfigurisanje.',
        'Import example process' => 'Izvezi primer procesa',
        'Do you want to benefit from processes created by experts? Upgrade to %s to be able to import some sophisticated example processes.' =>
            'Da li želite da iskoristite procese kreirane od strane eksperata? Unapredite na %s za uvoz primera sofisticiranih procesa.',
        'To create a new Process you can either import a Process that was exported from another system or create a complete new one.' =>
            'Za kreiranje novog procesa možete ili uvesti proces koji je izvezen iz drugog sistema ili kreirati kompletno nov.',
        'Changes to the Processes here only affect the behavior of the system, if you synchronize the Process data. By synchronizing the Processes, the newly made changes will be written to the Configuration.' =>
            'Promene u procesima jedino utiču na ponašanje sistema, ako sinhronizujete podatke procesa. Sinhronizovanjem procesa, novonapravljene promene će biti upisane u konfiguraciju.',
        'Processes' => 'Procesi',
        'Process name' => 'Naziv procesa',
        'Print' => 'Štampaj',
        'Export Process Configuration' => 'Izvezi konfiguraciju procesa',
        'Copy Process' => 'Kopiraj proces',

        # Template: AdminProcessManagementActivity
        'Cancel & close' => 'Poništi & zatvori',
        'Go Back' => 'Vrati se nazad',
        'Please note, that changing this activity will affect the following processes' =>
            'Napominjemo da će izmene ove aktivnosti uticati na prateće procese.',
        'Activity' => 'Aktivnost',
        'Activity Name' => 'Naziv aktivnosti',
        'Activity Dialogs' => 'Dijalozi aktivnosti',
        'You can assign Activity Dialogs to this Activity by dragging the elements with the mouse from the left list to the right list.' =>
            'Dijaloge aktivnosti možete dodeliti ovoj aktivnosti prevlačenjem elemenata mišem od leve liste do desne liste.',
        'Ordering the elements within the list is also possible by drag \'n\' drop.' =>
            'Menjanje redosleda elemenata unutar liste je, takođe, moguće prevračenjem elemenata i puštanjem.',
        'Filter available Activity Dialogs' => 'Filtriraj slobodne dijaloge aktivnosti',
        'Available Activity Dialogs' => 'Slobodni dijalozi aktivnosti',
        'Name: %s, EntityID: %s' => '',
        'Edit' => 'Urediti',
        'Create New Activity Dialog' => 'Kreiraj nov dijalog aktivnosti',
        'Assigned Activity Dialogs' => 'Dodeljeni dijalozi aktivnosti',

        # Template: AdminProcessManagementActivityDialog
        'Please note that changing this activity dialog will affect the following activities' =>
            'Napominjemo da će promena ovog dijaloga aktivnosti uticati na prateće aktivnosti.',
        'Please note that customer users will not be able to see or use the following fields: Owner, Responsible, Lock, PendingTime and CustomerID.' =>
            'Napominjemo da klijenti korisnici nisu u mogućnosti da vide ili koriste sledeća polja: Vlasnik, Odgovoran, Zaključano, Vreme na čekanju i ID klijenta',
        'The Queue field can only be used by customers when creating a new ticket.' =>
            'Polje u redu jedino može biti korišćeno od strane klijenta kada kreiraju novi tiket.',
        'Activity Dialog' => 'Dijalog aktivnosti',
        'Activity dialog Name' => 'Naziv dijaloga aktivnosti',
        'Available in' => 'Raspoloživo u',
        'Description (short)' => 'Opis (kratak)',
        'Description (long)' => 'Opis (dugačak)',
        'The selected permission does not exist.' => 'Izabrana ovlašćenja ne postoje.',
        'Required Lock' => 'Obavezno zaključaj',
        'The selected required lock does not exist.' => 'Odabrano zahtevano zaključavanje ne postoji.',
        'Submit Advice Text' => 'Podnesi "Advice Text"',
        'Submit Button Text' => 'Podnesi "Button Text"',
        'Fields' => 'Polja',
        'You can assign Fields to this Activity Dialog by dragging the elements with the mouse from the left list to the right list.' =>
            'Polja možete dodeliti u ovom dijalogu aktivnosti prevlačenjem elemenata mišem iz leve liste u desnu listu.',
        'Filter available fields' => 'Filtriraj raspoloživa polja',
        'Available Fields' => 'Raspoloživa polja',
        'Name: %s' => '',
        'Assigned Fields' => 'Dodeljena polja',
        'ArticleType' => 'TipČlanka',
        'Display' => 'Prikaži',

        # Template: AdminProcessManagementPath
        'Path' => 'Putanja',
        'Edit this transition' => 'Uredite ovu tranziciju',
        'Transition Actions' => 'Tranzicione aktivnosti',
        'You can assign Transition Actions to this Transition by dragging the elements with the mouse from the left list to the right list.' =>
            'Možete dodeliti tranzicione aktivnosti u ovoj tranziciji prevlačenjem elemenata mišem iz leve liste u desnu listu.',
        'Filter available Transition Actions' => 'Filtriraj raspoložive tranzicione aktivnosti',
        'Available Transition Actions' => 'Raspoložive tranzicione aktivnosti',
        'Create New Transition Action' => 'Kreiraj novu tranzicionu aktivnost',
        'Assigned Transition Actions' => 'Dodeljene tranzicione aktivnosti',

        # Template: AdminProcessManagementProcessAccordion
        'Activities' => 'Aktivnosti',
        'Filter Activities...' => 'Filtriraj aktivnosti ...',
        'Create New Activity' => 'Kreiraj novu aktivnost',
        'Filter Activity Dialogs...' => 'Filtriraj dijaloge aktivnosti ...',
        'Transitions' => 'Tranzicije',
        'Filter Transitions...' => 'Filtriraj tranzicije ...',
        'Create New Transition' => 'Kreiraj novu tranziciju',
        'Filter Transition Actions...' => 'Filtriraj tranzicione aktivnosti ...',

        # Template: AdminProcessManagementProcessEdit
        'Edit Process' => 'Uredi proces',
        'Print process information' => 'Štampaj informacije procesa',
        'Delete Process' => 'Izbriši proces',
        'Delete Inactive Process' => 'Izbriši neaktivan proces',
        'Available Process Elements' => 'Raspoloživi elementi procesa',
        'The Elements listed above in this sidebar can be moved to the canvas area on the right by using drag\'n\'drop.' =>
            'Elementi, navedeni gore u izdvojenom odeljku, mogu da se pomeraju po površini na desnu stranu korišćenjem prevuci i pusti tehnike.',
        'You can place Activities on the canvas area to assign this Activity to the Process.' =>
            'Možete postaviti aktivnosti na povrsinu kako bi dodeliti ovu aktivnost procesu.',
        'To assign an Activity Dialog to an Activity drop the Activity Dialog element from this sidebar over the Activity placed in the canvas area.' =>
            'Za dodeljivanje Dijaloga Aktivnosti nekoj aktivnosti, prevucite element dijaloga aktivnosti iz izdvojenog dela, preko aktivnosti smeštene na površini.',
        'You can start a connection between to Activities by dropping the Transition element over the Start Activity of the connection. After that you can move the loose end of the arrow to the End Activity.' =>
            'Vezu između aktivnosti možete započeti prevlačenjem elementa tranzicije preko početka aktivnosti veze. Nakon toga možete da premestite slobodan kraj strelice do kraja aktivnosti',
        'Actions can be assigned to a Transition by dropping the Action Element onto the label of a Transition.' =>
            'Aktivnost može biti dodeljena tranziciji prevlačenjem elementa aktivnosti na oznaku tranzicije.',
        'Edit Process Information' => 'Uredi informacije procesa',
        'Process Name' => 'Naziv procesa',
        'The selected state does not exist.' => 'Odabrani status ne postoji.',
        'Add and Edit Activities, Activity Dialogs and Transitions' => 'Dodaj i uredi aktivosti, dijaloge aktivnosti i tranzicije',
        'Show EntityIDs' => 'Pokaži ID entiteta',
        'Extend the width of the Canvas' => 'Proširi širinu prostora',
        'Extend the height of the Canvas' => 'Produži visinu prostora',
        'Remove the Activity from this Process' => 'Ukloni aktivnost iz ovog procesa',
        'Edit this Activity' => 'Uredi ovu aktivnost',
        'Save settings' => 'Sačuvaj podešavanja',
        'Save Activities, Activity Dialogs and Transitions' => 'Sačuvaj aktivosti, dijaloge aktivnosti i tranzicije',
        'Do you really want to delete this Process?' => 'Da li zaista želite da obrišete ovaj proces?',
        'Do you really want to delete this Activity?' => 'Da li zaista želite da obrišete ovu aktivnost?',
        'Do you really want to delete this Activity Dialog?' => 'Da li zaista želite da obrišete ovaj dijalog aktivnosti?',
        'Do you really want to delete this Transition?' => 'Da li zaista želite da obrišete ovu tranziciju?',
        'Do you really want to delete this Transition Action?' => 'Da li zaista želite da obrišete ovu tranzicionu aktivnost?',
        'Do you really want to remove this activity from the canvas? This can only be undone by leaving this screen without saving.' =>
            'Da li zaista želite da uklonite ovu aktivnost sa površine? Ovo jedino može da se opozove ukoliko napustite ekran, a da prethodno ne sačuvate izmene.',
        'Do you really want to remove this transition from the canvas? This can only be undone by leaving this screen without saving.' =>
            'Da li zaista želite da uklonite ovu tranziciju sa površine? Ovo jedino može da se opozove ukoliko napustite ekran, a da prethodno ne sačuvate izmene.',

        # Template: AdminProcessManagementProcessNew
        'In this screen, you can create a new process. In order to make the new process available to users, please make sure to set its state to \'Active\' and synchronize after completing your work.' =>
            'U ovom ekranu možete kreirati novi proces. Da bi novi proces bio dostupan korisnicima, molimo vas da postavite status na \'Active\' i uradite sinhronizaciju nakon završetka vašeg rada.',

        # Template: AdminProcessManagementProcessPrint
        'Start Activity' => 'Početak aktivnosti',
        'Contains %s dialog(s)' => 'Sadrži %s dijaloga',
        'Assigned dialogs' => 'Dodeljeni dijalozi',
        'Activities are not being used in this process.' => 'Aktivnosti se ne koriste u ovom procesu.',
        'Assigned fields' => 'Dodeljena polja',
        'Activity dialogs are not being used in this process.' => 'Dijalozi aktivnosti se ne koriste u ovom procesu.',
        'Condition linking' => 'Uslov povezivanja',
        'Conditions' => 'Uslovi',
        'Condition' => 'Uslov',
        'Transitions are not being used in this process.' => 'Tranzicije se ne koriste u ovom procesu.',
        'Module name' => 'Naziv modula',
        'Transition actions are not being used in this process.' => 'Tranzicione aktivnosti se ne koriste u ovom procesu.',

        # Template: AdminProcessManagementTransition
        'Please note that changing this transition will affect the following processes' =>
            'Napominjemo da bi menjenje ove tranzicije uticalo na prateće procese',
        'Transition' => 'Tranzicija',
        'Transition Name' => 'Naziv tranzicije',
        'Type of Linking between Conditions' => 'Tip veze između uslova',
        'Remove this Condition' => 'Ukloni ovaj uslov',
        'Type of Linking' => 'Tip veze',
        'Add a new Field' => 'Dodaj novo polje',
        'Remove this Field' => 'Ukloni ovo polje',
        'And can\'t be repeated on the same condition.' => '„I” se ne može ponoviti u istom uslovu.',
        'Add New Condition' => 'Dodaj novi uslov',

        # Template: AdminProcessManagementTransitionAction
        'Please note that changing this transition action will affect the following processes' =>
            'Napominjemo da bi menjenje ove tranzicione aktivnosti uticalo na prateće procese',
        'Transition Action' => 'Tranziciona aktivnost',
        'Transition Action Name' => 'Naziv tranzicione aktivnosti',
        'Transition Action Module' => 'Modul tranzicione aktivnosti',
        'Config Parameters' => 'Konfiguracioni parametri',
        'Add a new Parameter' => 'Dodaj novi parametar',
        'Remove this Parameter' => 'Ukloni ovaj parametar',

        # Template: AdminQueue
        'Manage Queues' => 'Upravljanje redovima',
        'Add queue' => 'Dodaj red',
        'Filter for Queues' => 'Filter za redove',
        'Filter for queues' => '',
        'Group' => 'Grupa',
        'Add Queue' => 'Dodaj Red',
        'Edit Queue' => 'Uredi Red',
        'A queue with this name already exists!' => 'Red sa ovim imenom već postoji!',
        'Sub-queue of' => 'Pod-red od',
        'Unlock timeout' => 'Vreme do otključavanja',
        '0 = no unlock' => '0 = nema otključavanja',
        'hours' => 'sati',
        'Only business hours are counted.' => 'Računa se samo radno vreme.',
        'If an agent locks a ticket and does not close it before the unlock timeout has passed, the ticket will unlock and will become available for other agents.' =>
            'Ako operater zaključa tiket i ne otključa ga pre isteka vremena otključavanja, tiket će se otključati i postati dostupan drugim zaposlenima.',
        'Notify by' => 'Obavešten od',
        '0 = no escalation' => '0 = nema eskalacije',
        'If there is not added a customer contact, either email-external or phone, to a new ticket before the time defined here expires, the ticket is escalated.' =>
            'Ako kontakt sa klijentom, bilo spoljašnji imejl ili telefon, nije dodat na novi tiket pre isticanja definisanog vremena, tiket će eskalirati.',
        'If there is an article added, such as a follow-up via email or the customer portal, the escalation update time is reset. If there is no customer contact, either email-external or phone, added to a ticket before the time defined here expires, the ticket is escalated.' =>
            'Ako postoji dodat članak, kao npr. nastavak preko imejl poruke ili klijentskog portala, vreme ažuriranja eskalacije se resetuje. Ako ne postoje kontakt podaci o klijentu, bilo imejl ili telefon dodati na tiket pre isticanja ovde definisanog vremena, tiket eskalira.',
        'If the ticket is not set to closed before the time defined here expires, the ticket is escalated.' =>
            'Ako se tiket ne zatvori pre ovde definisanog vremena, tiket eskalira.',
        'Follow up Option' => 'Opcije nastavka',
        'Specifies if follow up to closed tickets would re-open the ticket, be rejected or lead to a new ticket.' =>
            'Definišite da li nastavak na zatvoreni tiket ponovo otvara tiket ili otvara novi.',
        'Ticket lock after a follow up' => 'Zaključavanje tiketa posle nastavka',
        'If a ticket is closed and the customer sends a follow up the ticket will be locked to the old owner.' =>
            'Ako je tiket zatvoren, a klijent pošalje nastavak, tiket će biti zaključan na starog vlasnika.',
        'System address' => 'Sistemska adresa',
        'Will be the sender address of this queue for email answers.' => 'Biće adresa pošiljaoca za imejl odgovore iz ovog reda.',
        'Default sign key' => 'Podrazumevani ključ potpisa',
        'Salutation' => 'Pozdrav',
        'The salutation for email answers.' => 'Pozdrav za imejl odgovore.',
        'Signature' => 'Potpis',
        'The signature for email answers.' => 'Potpis za imejl odgovore.',
        'Calendar' => 'Kalendar',

        # Template: AdminQueueAutoResponse
        'Manage Queue-Auto Response Relations' => 'Upravljanje odnosima Red-Automatski odgovor',
        'This filter allow you to show queues without auto responses' => 'Ovaj filter vam omogućava prikaz redova bez automatskih odgovora',
        'Queues without auto responses' => 'Redovi bez automatskih odgovora',
        'This filter allow you to show all queues' => 'Ovaj filter vam omogućava prikaz svih redova',
        'Show all queues' => 'Prikaži sve redove',
        'Auto Responses' => 'Automatski odgovori',
        'Change Auto Response Relations for Queue' => 'Promeni veze sa Automatskim odgovorima za Red',

        # Template: AdminQueueTemplates
        'Manage Template-Queue Relations' => 'Upravljanje odnosom Šablon-Red',
        'Filter for Templates' => 'Filter za Šablone',
        'Templates' => 'Šabloni',
        'Queues' => 'Redovi',
        'Change Queue Relations for Template' => 'Promena odnosa Reda za Šablon',
        'Change Template Relations for Queue' => 'Promena odnosa Šablona za Red',

        # Template: AdminRegistration
        'System Registration Management' => 'Upravljanje sistemom registracije',
        'Edit details' => 'Uredi detalje',
        'Show transmitted data' => 'Pokaži poslate podatke',
        'Deregister system' => 'Odjavi sistem',
        'Overview of registered systems' => 'Pregled registrovanih sistema',
        'This system is registered with OTRS Group.' => 'Ovaj sistem je registrovan u OTRS Group.',
        'System type' => 'Tip sistema',
        'Unique ID' => 'Jedinstveni ID',
        'Last communication with registration server' => 'Poslednja komunikacija sa registracionim serverom',
        'System Registration not Possible' => '',
        'Please note that you can\'t register your system if OTRS Daemon is not running correctly!' =>
            'Molimo da obratite pažnju da ne možete registrovati vaš sistem ako „OTRS” sistemski proces ne radi korektno!',
        'Instructions' => 'Instrukcije',
        'System Deregistration not Possible' => '',
        'Please note that you can\'t deregister your system if you\'re using the %s or having a valid service contract.' =>
            'Molimo da obratite pažnju da ne možete deregistrovati vaš sistem ako koristite %s ili imate važeći servisni ugovor.',
        'OTRS-ID Login' => 'OTRS-ID prijava',
        'Read more' => 'Pročitaj više',
        'You need to log in with your OTRS-ID to register your system.' =>
            'Potrebno je da se prijavite sa vašim OTRS-ID da registrujete vaš sistem.',
        'Your OTRS-ID is the email address you used to sign up on the OTRS.com webpage.' =>
            'Vaš OTRS-ID je imejl adresa koju koristite za prijavu na veb stranu OTRS.com.',
        'Data Protection' => 'Zaštita podataka',
        'What are the advantages of system registration?' => 'Koje su prednosti registracije sistema?',
        'You will receive updates about relevant security releases.' => 'Dobićete ažuriranja odgovarajućih bezbednosnih izdanja.',
        'With your system registration we can improve our services for you, because we have all relevant information available.' =>
            'Sa registracijom sistema možemo poboljšati naše usluge za vas, jer mi imamo dostupne sve relevantne informacije.',
        'This is only the beginning!' => 'Ovo je samo početak!',
        'We will inform you about our new services and offerings soon.' =>
            'Informisaćemo vas o našim novim uslugama i ponudama uskoro!',
        'Can I use OTRS without being registered?' => 'Da li mogu da koristim OTRS ukoliko nisam registrovan?',
        'System registration is optional.' => 'Registracija sistema je opcionalna.',
        'You can download and use OTRS without being registered.' => 'Možete preuzeti OTRS i ukoliko niste registrovani.',
        'Is it possible to deregister?' => 'Da li je moguća odjava?',
        'You can deregister at any time.' => 'Možete se odjaviti u bilo koje doba.',
        'Which data is transfered when registering?' => 'Koji podaci se prenose prilikom registracije?',
        'A registered system sends the following data to OTRS Group:' => 'Registrovani sistem šalje sledeće podatke OTRS Grupi:',
        'Fully Qualified Domain Name (FQDN), OTRS version, Database, Operating System and Perl version.' =>
            'Puno kvalifikovano ime domena (FQDN), OTRS verzija, baza podataka, operativni sistem i verzija Perla',
        'Why do I have to provide a description for my system?' => 'Zašto moram da prosledim opis mog sistema?',
        'The description of the system is optional.' => 'Opis sistema je opcioni.',
        'The description and system type you specify help you to identify and manage the details of your registered systems.' =>
            'Navedeni opis i tip sistema pomažu vam da identifikujete i upravljate detaljima registrovanog sistema.',
        'How often does my OTRS system send updates?' => 'Koliko često će moj OTRS sistem slati ažuriranja?',
        'Your system will send updates to the registration server at regular intervals.' =>
            'Vaš sistem će u redovnim vremenskim intervalima slati ažuriranja registracionom serveru.',
        'Typically this would be around once every three days.' => 'Obično je to jednom u svaka tri dana.',
        'In case you would have further questions we would be glad to answer them.' =>
            'U slučaju da imate dodtana pitanja, biće nam zadovoljstvo da odgovorimo na njih.',
        'Please visit our' => 'Molimo posetite naš',
        'portal' => 'portal',
        'and file a request.' => 'i podnesite zahtev',
        'If you deregister your system, you will lose these benefits:' =>
            'Ako deregistrujete vaš sistem, izgubićete sledeće olakšice:',
        'You need to log in with your OTRS-ID to deregister your system.' =>
            'Da bi ste ođavili vaš sistem, morate da se prijavite sa vašim OTRS-ID',
        'OTRS-ID' => 'OTRS-ID',
        'You don\'t have an OTRS-ID yet?' => 'Još uvek nemate OTRS-ID?',
        'Sign up now' => 'Regisrujte se sada',
        'Forgot your password?' => 'Zaboravili ste lozinku?',
        'Retrieve a new one' => 'Preuzmi novu',
        'Next' => 'Sledeće',
        'This data will be frequently transferred to OTRS Group when you register this system.' =>
            'Ovi podaci će biti preneti u OTRS Grupu kada registrujete ovaj sistem.',
        'Attribute' => 'Atribut',
        'FQDN' => 'FQDN',
        'OTRS Version' => '„OTRS” verzija',
        'Database' => 'Baza podataka',
        'Operating System' => 'Operativni sistem',
        'Perl Version' => 'Perl verzija',
        'Optional description of this system.' => 'Opcioni opis ovog sistema.',
        'Register' => 'Registruj',
        'Deregister System' => 'Isključi sistem iz registra',
        'Continuing with this step will deregister the system from OTRS Group.' =>
            'Nastavljanje ovog koraka će ođaviti sistem iz OTRS Grupe.',
        'Deregister' => 'Isključi iz registra',
        'You can modify registration settings here.' => 'Ovde možete izmeniti registraciona podešavanja.',
        'Overview of Transmitted Data' => '',
        'There is no data regularly sent from your system to %s.' => 'Nema podataka koji su redovno slati sa vašeg sistema za %s.',
        'The following data is sent at minimum every 3 days from your system to %s.' =>
            'Sledeći podaci su slati barem svaka 3 dana sa vašeg sistema za %s.',
        'The data will be transferred in JSON format via a secure https connection.' =>
            'Podaci će biti poslati u „JSON” formatu preko sigurne „https” veze. ',
        'System Registration Data' => 'Podaci o registraciji sistema',
        'Support Data' => 'Podržani podaci',

        # Template: AdminRole
        'Role Management' => 'Upravljanje ulogama',
        'Add role' => 'Dodaj ulogu',
        'Filter for Roles' => 'Filter za uloge',
        'Filter for roles' => '',
        'Create a role and put groups in it. Then add the role to the users.' =>
            'Napravi ulogu i dodaj grupe u nju. Onda dodaj ulogu korisnicima.',
        'There are no roles defined. Please use the \'Add\' button to create a new role.' =>
            'Nema definisanih uloga. upotrebite dugme \'Add\' za kreiranje nove uloge.',
        'Add Role' => 'Dodaj Ulogu',
        'Edit Role' => 'Uredi Ulogu',

        # Template: AdminRoleGroup
        'Manage Role-Group Relations' => 'Upravljanje vezama Uloga-Grupa',
        'Roles' => 'Uloge',
        'Select the role:group permissions.' => 'Izaberi dozvole za ulogu:grupu',
        'If nothing is selected, then there are no permissions in this group (tickets will not be available for the role).' =>
            'Ukoliko ništa nije izabrano, onda nema dozvola u ovoj grupi (tiketi neće biti dostupni za ovu ulogu).',
        'Change Role Relations for Group' => 'Promeni veze sa ulogama za grupu',
        'Change Group Relations for Role' => 'Promeni veze sa grupama za ulogu',
        'Toggle %s permission for all' => 'Promeni %s dozvole za sve',
        'move_into' => 'premesti u',
        'Permissions to move tickets into this group/queue.' => 'Dozvola da se tiket premesti u ovu grupu/red.',
        'create' => 'kreiranje',
        'Permissions to create tickets in this group/queue.' => 'Dozvola da se tiket kreira u ovu grupu/red.',
        'note' => 'napomena',
        'Permissions to add notes to tickets in this group/queue.' => 'Dozvole za dodavanje napomena na tikete u ovoj grupi/redu.',
        'owner' => 'vlasnik',
        'Permissions to change the owner of tickets in this group/queue.' =>
            'Dozvole za promenu vlasnika tiketa u ovoj grupi/redu.',
        'priority' => 'prioritet',
        'Permissions to change the ticket priority in this group/queue.' =>
            'Dozvola da se menja prioritet tiketa u ovoj grupi/redu.',

        # Template: AdminRoleUser
        'Manage Agent-Role Relations' => 'Upravljanje vezama Operater-Uloga',
        'Add agent' => 'Dodaj operatera',
        'Filter for Agents' => 'Filter za operatere',
        'Agents' => 'Operateri',
        'Manage Role-Agent Relations' => 'Upravljanje vezama Uloga-Operater',
        'Change Role Relations for Agent' => 'Promeni veze sa ulogom za operatera',
        'Change Agent Relations for Role' => 'Promeni veze sa operaterom za ulogu',

        # Template: AdminSLA
        'SLA Management' => 'Upravljanje SLA',
        'Add SLA' => 'Dodaj SLA',
        'Filter for SLAs' => '',
        'Edit SLA' => 'Uredi SLA',
        'Please write only numbers!' => 'Molimo pišite samo brojeve!',

        # Template: AdminSMIME
        'S/MIME Management' => 'S/MIME upravljanje',
        'SMIME support is disabled' => '',
        'To be able to use SMIME in OTRS, you have to enable it first.' =>
            '',
        'Enable SMIME support' => '',
        'Faulty SMIME configuration' => '',
        'SMIME support is enabled, but the relevant configuration contains errors. Please check the configuration using the button below.' =>
            '',
        'Check SMIME configuration' => '',
        'Add certificate' => 'Dodaj sertifikat',
        'Add private key' => 'Dodaj privatni ključ',
        'Filter for Certificates' => '',
        'Filter for S/MIME certs' => 'Filter za S/MIME sertifikate',
        'To show certificate details click on a certificate icon.' => 'Za prikazivanje detalja sertifikata klikni na ikonicu sertifikat.',
        'To manage private certificate relations click on a private key icon.' =>
            'Za upravljanje vezama privatnog sertifikata kliknite na ikonicu privatni ključ.',
        'Here you can add relations to your private certificate, these will be embedded to the S/MIME signature every time you use this certificate to sign an email.' =>
            'Ovde možete dodati veze na vaš privatni sertifikat, što će biti ugrađeno u „S/MIME” potpis svaki put kad upotrebite ovaj sertifikat za potpis imejla.',
        'See also' => 'Pogledaj još',
        'In this way you can directly edit the certification and private keys in file system.' =>
            'Na ovaj način možete direktno da uređujete sertifikate i privatne ključeve u sistemu datoteka.',
        'Hash' => 'Hash',
        'Create' => 'Kreiraj',
        'Handle related certificates' => 'Rukovanje povezanim sertifikatima',
        'Read certificate' => 'Čitaj sertifikat',
        'Delete this certificate' => 'Obriši ovaj sertifikat',
        'Add Certificate' => 'Dodaj sertifikat',
        'File' => 'Datoteka',
        'Add Private Key' => 'Dodaj privatni ključ',
        'Secret' => 'Tajna',
        'Submit' => 'Pošalji',
        'Related Certificates for' => 'Povezani sertifikati za',
        'Delete this relation' => 'Obriši ovu vezu',
        'Available Certificates' => 'Raspoloživi sertifikati',
        'Relate this certificate' => 'Poveži ovaj sertifikat',

        # Template: AdminSMIMECertRead
        'S/MIME Certificate' => 'S/MIME sertifikat',
        'Close dialog' => '',
        'Certificate Details' => '',

        # Template: AdminSalutation
        'Salutation Management' => 'Upravljanje pozdravima',
        'Add salutation' => 'Dodaj pozdrav',
        'Filter for Salutations' => '',
        'Filter for salutations' => '',
        'Add Salutation' => 'Dodaj Pozdrav',
        'Edit Salutation' => 'Uredi Pozdrav',
        'e. g.' => 'npr.',
        'Example salutation' => 'Primer pozdrava',

        # Template: AdminSecureMode
        'Secure Mode Needs to be Enabled!' => '',
        'Secure mode will (normally) be set after the initial installation is completed.' =>
            'Siguran mod će (uobičajeno) biti podešen nakon inicijalne instalacije.',
        'If secure mode is not activated, activate it via SysConfig because your application is already running.' =>
            'Ukoliko siguran mod nije aktiviran, pokrenite ga kroz sistemsku konfiguraciju jer je vaša aplikacija već pokrenuta.',

        # Template: AdminSelectBox
        'SQL Box' => 'SQL Boks',
        'Filter for Results' => '',
        'Filter for results' => '',
        'Here you can enter SQL to send it directly to the application database. It is not possible to change the content of the tables, only select queries are allowed.' =>
            'Ovde možete uneti SQL komande i poslati ih direktno aplikacionoj bazi podataka. Nije moguće menjati sadržaj tabela, dozvoljen je jedino \'select\' upit.',
        'Here you can enter SQL to send it directly to the application database.' =>
            'Ovde možete uneti SQL komande i poslati ih direktno aplikacionoj bazi podataka.',
        'Options' => 'Opcije',
        'Only select queries are allowed.' => 'Dozvoljeni su samo „select” upiti.',
        'The syntax of your SQL query has a mistake. Please check it.' =>
            'Postoji greška u sintaksi vašeg SQL upita. Molimo proverite.',
        'There is at least one parameter missing for the binding. Please check it.' =>
            'Najmanje jedan parametar nedostaje za povezivanje. Molimo proverite.',
        'Result format' => 'Format rezultata',
        'Run Query' => 'Pokreni upit',
        'Query is executed.' => 'Upit je izvršen.',

        # Template: AdminService
        'Service Management' => 'Upravljanje uslugama',
        'Add service' => 'Dodaj uslugu',
        'Filter for services' => '',
        'Add Service' => 'Dodaj uslugu',
        'Edit Service' => 'Uredi uslugu',
        'Sub-service of' => 'Pod-usluga od',

        # Template: AdminSession
        'Session Management' => 'Upravljanje sesijama',
        'All sessions' => 'Sve sesije',
        'Agent sessions' => 'Sesije operatera',
        'Customer sessions' => 'Sesije klijenata',
        'Unique agents' => 'Jedinstveni operateri',
        'Unique customers' => 'Jedinstveni klijenti',
        'Kill all sessions' => 'Ugasi sve sesije',
        'Kill this session' => 'Ugasi ovu sesiju',
        'Filter for Sessions' => '',
        'Filter for sessions' => '',
        'Session' => 'Sesija',
        'Kill' => 'Ugasi',
        'Detail View for SessionID' => 'Detaljni pregled za ID sesije',

        # Template: AdminSignature
        'Signature Management' => 'Upravljanje potpisima',
        'Add signature' => 'Dodaj potpis',
        'Filter for Signatures' => '',
        'Filter for signatures' => '',
        'Add Signature' => 'Dodaj Potpis',
        'Edit Signature' => 'Uredi Potpis',
        'Example signature' => 'Primer potpisa',

        # Template: AdminState
        'State Management' => 'Upravljanje statusima',
        'Add state' => 'Dodaj status',
        'Filter for States' => '',
        'Filter for states' => '',
        'Attention' => 'Pažnja',
        'Please also update the states in SysConfig where needed.' => 'Molimo da ažurirate stause i u "SysConfig" (Sistemskim konfiguracijama) gde je to potrebno.',
        'Add State' => 'Dodaj Status',
        'Edit State' => 'Uredi Status',
        'State type' => 'Tip statusa',

        # Template: AdminSupportDataCollector
        'Sending support data to OTRS Group is not possible!' => '',
        'Enable Cloud Services' => 'Aktiviraj servise u oblaku',
        'This data is sent to OTRS Group on a regular basis. To stop sending this data please update your system registration.' =>
            'Ovi podaci se šalju OTRS Grupi po regularnoj osnovi. Da zaustavite slanje ovih podataka molimo vas da ažurirate registraciju.',
        'You can manually trigger the Support Data sending by pressing this button:' =>
            'Možete manuelno aktivirati slanje podržanih podataka pritiskanjem ovog dugmeta:',
        'Send Update' => 'Pošalji ažuriranje',
        'Sending Update...' => 'Slanje ažuriranja...',
        'Support Data information was successfully sent.' => 'Informacije podržanih podataka su uspešno poslate.',
        'Was not possible to send Support Data information.' => 'Nije moguće poslati informacije podržanih podataka.',
        'Update Result' => 'Rezultat ažuriranja',
        'Currently this data is only shown in this system.' => 'Trenutno su ovi podaci prikazani samo u ovom sistemu.',
        'A support bundle (including: system registration information, support data, a list of installed packages and all locally modified source code files) can be generated by pressing this button:' =>
            'Paket za podršku (uključujući: informacije o registraciji sistema, podatke za podršku, listu instaliranih paketa i svih lokalno modifikovanih datoteka izvornog koda) može biti generisan pritiskom na ovo dugme:',
        'Generate Support Bundle' => 'Generiši paket podrške',
        'Generating...' => 'Generišem...',
        'It was not possible to generate the Support Bundle.' => 'Nije moguće generisati Paket podrške.',
        'Generate Result' => 'Generiši rezultat',
        'Support Bundle' => 'Paket podrške',
        'The mail could not be sent' => 'Imejl se ne može poslati',
        'The Support Bundle has been Generated' => '',
        'Please choose one of the following options.' => 'Molimo izaberite jednu od ponuđenih opcija.',
        'Send by Email' => 'Poslato imejlom',
        'The support bundle is too large to send it by email, this option has been disabled.' =>
            'Paket podrške je prevelik za slanje putem imejla, ova opcija je onemogućena.',
        'The email address for this user is invalid, this option has been disabled.' =>
            'Imejl adresa ovog korisnika je nevažeća, ova opcija je isključena.',
        'Sending' => 'Slanje',
        'The support bundle will be sent to OTRS Group via email automatically.' =>
            'Paket podrške će biti automatski poslat imejlom „OTRS” grupi.',
        'Download File' => 'Preuzmi datoteku',
        'A file containing the support bundle will be downloaded to the local system. Please save the file and send it to the OTRS Group, using an alternate method.' =>
            'Datoteka koja sadrži paket za podršku će biti preuzeta na lokalni računar. Molimo vas da sačuvate datoteku i da nam („OTRS Group”) je pošaljete na neki drugi način.',
        'Error: Support data could not be collected (%s).' => 'Podržani podaci ne mogu biti prikupljeni (%s).',
        'Details' => 'Detalji',

        # Template: AdminSysConfig
        'SysConfig' => 'Sistemska konfiguracija',
        'Navigate by searching in %s settings' => 'Navigacija kroz pretraživanje u %s podešavanjima',
        'Navigate by selecting config groups' => 'Navigacija izborom konfiguracionih grupa',
        'Download all system config changes' => 'Preuzmi sve promene sistemskih podešavanja',
        'Export settings' => 'Izvezi podešavanja',
        'Load SysConfig settings from file' => 'Učitaj sistemska podešavanja iz datoteke',
        'Import settings' => 'Uvezi podešavanja',
        'Import Settings' => 'Uvezi Podešavanja',
        'Please enter a search term to look for settings.' => 'Molimo unesite pojam pretrage za traženje podešavanja.',
        'Subgroup' => 'Podgrupa',
        'Elements' => 'Elementi',

        # Template: AdminSysConfigEdit
        'Edit Config Settings in %s → %s' => '',
        'This setting is read only.' => 'Ovo podešavanje se može samo pregledati.',
        'This config item is only available in a higher config level!' =>
            'Ova konfiguraciona stavka je dostupna samo na višem konfiguracionom nivou',
        'Reset this setting' => 'Poništi ovo podešavanje',
        'Error: this file could not be found.' => 'Greška: ne može se pronaći ova datoteka.',
        'Error: this directory could not be found.' => 'Greška: ne može se pronaći ovaj direktorijum.',
        'Error: an invalid value was entered.' => 'Greška: uneta je nevažeća vrednost.',
        'Content' => 'Sadržaj',
        'Remove this entry' => 'Ukloni ovaj unos',
        'Add entry' => 'Dodaj unos',
        'Remove entry' => 'Ukloni unos',
        'Add new entry' => 'Dodaj nov unos',
        'Delete this entry' => 'Obriši ovaj unos',
        'Create new entry' => 'Napravi nov unos',
        'New group' => 'Nova grupa',
        'Group ro' => 'Grupa "ro"',
        'Readonly group' => 'Grupa samo za čitanje',
        'New group ro' => 'Nova "ro" grupa',
        'Loader' => 'Program za učitavanje',
        'File to load for this frontend module' => 'Datoteka koju treba učitati za ovaj korisnički modul',
        'New Loader File' => 'Nova datoteka programa za učitavanje',
        'NavBarName' => 'Naziv navigacione trake',
        'NavBar' => 'Navigaciona traka',
        'Link' => 'Poveži',
        'LinkOption' => 'Opcije veze',
        'Block' => 'Blok',
        'AccessKey' => 'Ključ za pristup',
        'Add NavBar entry' => 'Dodaj stavku u navigacionu traku',
        'NavBar module' => '',
        'Year' => 'Godina',
        'Month' => 'Mesec',
        'Day' => 'Dan',
        'Error' => 'Greška',
        'Invalid year' => 'Pogrešna godina',
        'Invalid month' => 'Pogrešan mesec',
        'Invalid day' => 'Pogrešan dan',

        # Template: AdminSystemAddress
        'System Email Addresses Management' => 'Upravljanje sistemskom imejl adresom',
        'Add system address' => 'Dodaj sistemsku adresu',
        'Filter for System Addresses' => '',
        'Filter for system addresses' => '',
        'All incoming email with this address in To or Cc will be dispatched to the selected queue.' =>
            'Sve dolazne poruke sa ovom adresom u polju "Za" ili "Cc" biće otpremljene u izabrani red.',
        'Email address' => 'Imejl adresa',
        'Display name' => 'Prikaži ime',
        'Add System Email Address' => 'Dodaj sistemsku imejl adresu',
        'Edit System Email Address' => 'Uredi sistemsku imejl adresu',
        'The display name and email address will be shown on mail you send.' =>
            'Prikazano ime i imejl adresa će biti prikazani na poruci koju ste poslali.',

        # Template: AdminSystemMaintenance
        'System Maintenance Management' => 'Upravljanje sistemom održavanja',
        'Schedule New System Maintenance' => 'Planiraj novo oržavanje sistema.',
        'Filter for System Maintenances' => '',
        'Filter for system maintenances' => '',
        'Schedule a system maintenance period for announcing the Agents and Customers the system is down for a time period.' =>
            'Planiranje perioda održavanja sistema radi obaveštavanja operatera i klijenata da je sistem isključen u tom periodu. ',
        'Some time before this system maintenance starts the users will receive a notification on each screen announcing about this fact.' =>
            'Neko vreme pre nego otpočne održavanje sistema, korisnici će dobiti obaveštenje koje najavljuje ovaj događaj na svaki ekran.',
        'Start date' => 'Datum početka',
        'Stop date' => 'Datum završetka',
        'Delete System Maintenance' => 'Obriši održavanje sistema',

        # Template: AdminSystemMaintenanceEdit
        'Edit System Maintenance %s' => 'Uredi održavanje sistema %s',
        'Edit System Maintenance information' => 'Uredi informacije o održavanju sistema',
        'Date invalid!' => 'Neispravan datum',
        'Login message' => 'Poruka prijave',
        'Show login message' => 'Pokaži poruku prijave',
        'Notify message' => 'Poruka obaveštenja',
        'Manage Sessions' => 'Upravljanje sesijama',
        'All Sessions' => 'Sve sesije',
        'Agent Sessions' => 'Sesije operatera',
        'Customer Sessions' => 'Sesije klijenata',
        'Kill all Sessions, except for your own' => 'Prekini sve sesije, osim sopstvene',

        # Template: AdminTemplate
        'Manage Templates' => 'Upravljanje šablonima',
        'Add template' => 'Dodaj šablon',
        'A template is a default text which helps your agents to write faster tickets, answers or forwards.' =>
            'Šablon je podrazumevani tekst koji pomaže vašim agentima da brže ispišu tikete, odgovore ili prosleđene poruke.',
        'Don\'t forget to add new templates to queues.' => 'Ne zaboravite da dodate novi šablon u redu.',
        'Attachments' => 'Prilozi',
        'Add Template' => 'Dodaj Šablon',
        'Edit Template' => 'Uredi Šablon',
        'A standard template with this name already exists!' => 'Standardni šablon sa ovim nazivom već postoji!',
        'Create type templates only supports this smart tags' => 'Kreiraj tip šablona koji podržavaju samo ove pametne oznake.',
        'Example template' => 'Primer šablona',
        'The current ticket state is' => 'Trenutni staus tiketa je',
        'Your email address is' => 'Vaša imejl adresa je',

        # Template: AdminTemplateAttachment
        'Manage Templates-Attachments Relations' => '',
        'Change Template Relations for Attachment' => 'Promeni veze šablona za prilog',
        'Change Attachment Relations for Template' => 'Promeni veze priloga za šablon',
        'Toggle active for all' => 'Promeni stanje u aktivan za sve',
        'Link %s to selected %s' => 'Poveži %s sa izabranim %s',

        # Template: AdminType
        'Type Management' => 'Upravljanje tipovima',
        'Add ticket type' => 'Dodaj tip tiketa',
        'Filter for Types' => '',
        'Filter for types' => '',
        'Add Type' => 'Dodaj Tip ',
        'Edit Type' => 'Uredi Tip',
        'A type with this name already exists!' => 'Tip sa ovim imenom već postoji!',

        # Template: AdminUser
        'Agents will be needed to handle tickets.' => 'Biće potrebni operateri za obradu tiketa.',
        'Don\'t forget to add a new agent to groups and/or roles!' => 'Ne zaboravite da dodate novog operatera u grupe i/ili uloge!',
        'Please enter a search term to look for agents.' => 'Molimo unesite pojam za pretragu radi nalaženja operatera.',
        'Last login' => 'Prethodna prijava',
        'Switch to agent' => 'Pređi na operatera',
        'Add Agent' => 'Dodaj Operatera',
        'Edit Agent' => 'Uredi Operatera',
        'Title or salutation' => 'Naslov pozdrava',
        'Firstname' => 'Ime',
        'Lastname' => 'Prezime',
        'A user with this username already exists!' => 'Ovo korisničko ime je već upotrebljeno!',
        'Will be auto-generated if left empty.' => 'Biće automatski generisano ako se ostavi prazno.',
        'Mobile' => 'Mobilni',
        'On' => 'Uključeno',
        'Off' => 'Isključeno',
        'Start' => 'Početak',
        'End' => 'Kraj',

        # Template: AdminUserGroup
        'Manage Agent-Group Relations' => 'Upravljanje vezama Operater-Grupa',
        'Change Group Relations for Agent' => 'Promeni veze sa grupom za operatera',
        'Change Agent Relations for Group' => 'Promeni veze sa operaterom za grupu',

        # Template: AgentBook
        'Address Book' => 'Adresar',
        'Search for a customer' => 'Traži klijenta',
        'Bcc' => 'Bcc',
        'Add email address %s to the To field' => 'Dodaj imejl adresu %s u polje "Za:"',
        'Add email address %s to the Cc field' => 'Dodaj imejl adresu %s u polje "Cc:"',
        'Add email address %s to the Bcc field' => 'Dodaj imejl adresu %s u polje "Bcc:"',
        'Apply' => 'Primeni',

        # Template: AgentCustomerInformationCenter
        'Customer Information Center' => 'Klijentski informativni centar',

        # Template: AgentCustomerInformationCenterSearch
        'Customer User' => 'Klijent korisnik',

        # Template: AgentCustomerTableView
        'Note: Customer is invalid!' => 'Napomena: Klijent je nevažeći!',

        # Template: AgentDaemonInfo
        'The OTRS Daemon is a daemon process that performs asynchronous tasks, e.g. ticket escalation triggering, email sending, etc.' =>
            '„OTRS” servis je sistemski proces koji izvršava asinhrone zadatke, npr. okidanje eskalacija tiketa, slanje imejlova, itd.',
        'A running OTRS Daemon is mandatory for correct system operation.' =>
            'Pokrenut „OTRS” servis je neophodan za ispravno funkcionisanje sistema.',
        'Starting the OTRS Daemon' => 'Pokretanje „OTRS” servisa',
        'Make sure that the file \'%s\' exists (without .dist extension). This cron job will check every 5 minutes if the OTRS Daemon is running and start it if needed.' =>
            'Osigurava da datoteka „%s” postoji (bez „.dist” ekstenzije). Ovaj kron posao će proveravati svakih 5 minuta da li „OTRS” servis radi i pokreće ga ako je potrebno.',
        'Execute \'%s start\' to make sure the cron jobs of the \'otrs\' user are active.' =>
            'Izvršite „%s start” da bi bili sigurni da su kron poslovi za „OTRS” korisnika uvek aktivni.',
        'After 5 minutes, check that the OTRS Daemon is running in the system (\'bin/otrs.Daemon.pl status\').' =>
            'Posle 5 minuta, proverava da li „OTRS” servis funkcioniše u sistemu („bin/otrs.Daemon.pl status”).',

        # Template: AgentDashboard
        'Dashboard' => 'Komandna tabla',

        # Template: AgentDashboardCalendarOverview
        'in' => 'u',
        'none' => 'ni jedan',

        # Template: AgentDashboardCommon
        'Close this widget' => '',
        'more' => 'još',
        'Available Columns' => 'Raspoložive kolone',
        'Visible Columns (order by drag & drop)' => 'Vidljive kolone (redosled prema prevuci i pusti)',

        # Template: AgentDashboardCustomerIDStatus
        'Escalated tickets' => 'Eskalirani tiketi',
        'Open tickets' => 'Otvoreni tiketi',
        'Closed tickets' => 'Zatvoreni tiketi',
        'All tickets' => 'Svi tiketi',
        'Archived tickets' => 'Arhivirani tiketi',

        # Template: AgentDashboardCustomerUserList
        'Customer login' => 'Prijava klijenta',
        'Customer information' => 'Informacije o klijentu',
        'Open' => 'Otvoreni',
        'Closed' => 'Zatvoreni',
        'Phone ticket' => 'Telefonski tiket',
        'Email ticket' => 'Imejl tiket',
        'Start Chat' => 'Počni ćaskanje',
        '%s open ticket(s) of %s' => '%s otvorenih tiketa od %s',
        '%s closed ticket(s) of %s' => '%s zatvorenih tiketa od %s',
        'New phone ticket from %s' => 'Novi telefonski tiket od %s',
        'New email ticket to %s' => 'Novi imejl tiket od %s',
        'Start chat' => 'Počni ćaskanje',

        # Template: AgentDashboardProductNotify
        '%s %s is available!' => '%s %s je dostupno!',
        'Please update now.' => 'Molimo ažurirajte sada.',
        'Release Note' => 'Napomena uz izdanje',
        'Level' => 'Nivo',

        # Template: AgentDashboardRSSOverview
        'Posted %s ago.' => 'Poslato pre %s.',

        # Template: AgentDashboardStats
        'The configuration for this statistic widget contains errors, please review your settings.' =>
            'Konfiguracija za ovaj statistički dodatak sadrži greške, molomo proverite vaša podešavanja.',
        'Download as SVG file' => 'Preuzmi kao „SVG” datoteku',
        'Download as PNG file' => 'Preuzmi kao „PNG” datoteku',
        'Download as CSV file' => 'Preuzmi kao „CSV” datoteku',
        'Download as Excel file' => 'Preuzmi kao „Excel” datoteku',
        'Download as PDF file' => 'Preuzmi kao „PDF” datoteku',
        'Please select a valid graph output format in the configuration of this widget.' =>
            'Molimo da u konfiguraciji ovog dodatka izaberete važeći izlazni format grafikona.',
        'The content of this statistic is being prepared for you, please be patient.' =>
            'Sadržaj ove statistike se priprema za vas, molimo budite strpljivi.',
        'This statistic can currently not be used because its configuration needs to be corrected by the statistics administrator.' =>
            'Ova statistika se trenutno ne može koristiti zato što administrator statistike treba da koriguje njenu konfiguraciju.',

        # Template: AgentDashboardTicketGeneric
        'My locked tickets' => 'Moji zaključani tiketi',
        'My watched tickets' => 'Moji praćeni tiketi',
        'My responsibilities' => 'Odgovoran sam za',
        'Tickets in My Queues' => 'Tiketi u mojim redovima',
        'Tickets in My Services' => 'Tiketi u mojim uslugama',
        'Service Time' => 'Vreme usluge',
        'Remove active filters for this widget.' => 'Ukloni aktivne filtere za ovaj aplikativni dodatak (widget).',

        # Template: AgentDashboardTicketQueueOverview
        'Totals' => 'Ukupne vrednosti',

        # Template: AgentDashboardUserOnline
        'out of office' => 'van kancelarije',
        'Selected agent is not available for chat' => 'Izabrani operater nije dostupan za ćaskanje',

        # Template: AgentDashboardUserOutOfOffice
        'until' => 'dok',

        # Template: AgentHTMLReferencePageLayout
        'The ticket has been locked' => 'Tiket je zaključan.',
        'Undo & close' => 'Odustani & zatvori',

        # Template: AgentInfo
        'Info' => 'Info',
        'To accept some news, a license or some changes.' => 'Da bi prihvatili neke vesti, dozvole ili neke promene.',

        # Template: AgentLinkObject
        'Link Object: %s' => 'Poveži objekat: %s',
        'go to link delete screen' => 'idi na ekran za brisanje veze',
        'Select Target Object' => 'Izaberi ciljni objekat',
        'Link object %s with' => '',
        'Unlink Object: %s' => 'Prekini vezu sa objektom: %s',
        'go to link add screen' => 'idi na ekran za dodavanje veze',

        # Template: AgentPreferences
        'Edit your preferences' => 'Uredi lične postavke',
        'Did you know? You can help translating OTRS at %s.' => 'Da li ste znali? Možete da pomognete u prevođenju OTRS na %s.',

        # Template: AgentSpelling
        'Spell Checker' => 'Provera pravopisa',
        'Spelling Error(s)' => '',
        'Language' => 'Jezik',
        'Line' => 'Linija',
        'Word' => 'Reč',
        'replace with' => 'zameni sa',
        'Change' => 'Promeni',
        'Ignore' => 'Zanemari',
        'Apply these changes' => 'Primeni ove izmene',
        'Done' => 'Urađeno',

        # Template: AgentStatisticsAdd
        'Statistics » Add' => 'Statistika » Dodaj',
        'Add New Statistic' => 'Dodaj novu statistiku',
        'Dynamic Matrix' => 'Dinamička matrica',
        'Tabular reporting data where each cell contains a singular data point (e. g. the number of tickets).' =>
            'Tabelarni podaci izveštaja gde svaka ćelija sadrži samo jedan podatak (npr broj tiketa).',
        'Dynamic List' => 'Dinamička lista',
        'Tabular reporting data where each row contains data of one entity (e. g. a ticket).' =>
            'Tabelarni podaci izveštaja gde svaki red sadrži podatke o samo jednom entitetu (npr tiket).',
        'Static' => 'Statički',
        'Complex statistics that cannot be configured and may return non-tabular data.' =>
            'Komplikovana statistika koja se ne može podesiti i može da vrati neformatirane podatke.',
        'General Specification' => 'Opšta specifikacija',
        'Create Statistic' => 'Kreiraj statistiku',

        # Template: AgentStatisticsEdit
        'Statistics » Edit %s%s — %s' => 'Statistika » Izmeni %s%s — %s',
        'Run now' => 'Pokreni sad',
        'Statistics Preview' => 'Pregled statistike',
        'Save Statistic' => '',

        # Template: AgentStatisticsImport
        'Statistics » Import' => 'Statistika » Uvoz',
        'Import Statistic Configuration' => 'Uvezi konfiguraciju statistike',

        # Template: AgentStatisticsOverview
        'Statistics » Overview' => 'Statistika » Pregled',
        'Statistics' => 'Statistike',
        'Run' => 'Pokreni',
        'Edit statistic "%s".' => 'Izmeni statistiku "%s".',
        'Export statistic "%s"' => 'Izvezi statistiku "%s".',
        'Export statistic %s' => 'Izmeni statistiku %s',
        'Delete statistic "%s"' => 'Obriši statistiku "%s".',
        'Delete statistic %s' => 'Obriši statistiku %s',

        # Template: AgentStatisticsView
        'Statistics » View %s%s — %s' => 'Statistika » Pogledaj %s%s — %s',
        'Statistic Information' => 'Statističke informacije',
        'Created by' => 'Kreirao',
        'Changed by' => 'Izmenio',
        'Sum rows' => 'Zbir redova',
        'Sum columns' => 'Zbir kolona',
        'Show as dashboard widget' => 'Prikaži kontrolnu tablu aplikativnog dodatka (Widget-a)',
        'Cache' => 'Keš',
        'This statistic contains configuration errors and can currently not be used.' =>
            'Ova statistika sadrži konfiguracione greške i sad se ne može koristiti.',

        # Template: AgentTicketActionCommon
        'Change Free Text of %s%s%s' => '',
        'Change Owner of %s%s%s' => '',
        'Close %s%s%s' => '',
        'Add Note to %s%s%s' => '',
        'Set Pending Time for %s%s%s' => '',
        'Change Priority of %s%s%s' => '',
        'Change Responsible of %s%s%s' => '',
        'All fields marked with an asterisk (*) are mandatory.' => 'Sva polja označena zvezdicom (*) su obavezna.',
        'Service invalid.' => 'Nevažeća usluga.',
        'New Owner' => 'Novi vlasnik',
        'Please set a new owner!' => 'Molimo da odredite novog vlasnika!',
        'New Responsible' => 'Novi odgovorni',
        'Please set a new responsible!' => '',
        'Next state' => 'Sledeći status',
        'For all pending* states.' => 'Za sva stanja* čekanja.',
        'Add Article' => 'Dodaj članak',
        'Create an Article' => 'Kreiraj članak',
        'Inform agents' => 'Obavesti operatere',
        'Inform involved agents' => 'Obavesti uključene operatere',
        'Here you can select additional agents which should receive a notification regarding the new article.' =>
            'Ovde možete izabrati dodatne operatere koji treba da primaju obaveštenja u vezi sa novim člankom.',
        'Text will also be received by' => '',
        'Spell check' => 'Provera pravopisa',
        'Text Template' => 'Šablon teksta',
        'Setting a template will overwrite any text or attachment.' => 'Podešavanje šablona će prepisati svaki tekst ili prilog.',
        'Note type' => 'Tip napomene',
        'Invalid time!' => 'Nevažeće vreme!',

        # Template: AgentTicketBounce
        'Bounce %s%s%s' => '',
        'Bounce to' => 'Preusmeri na',
        'You need a email address.' => 'Potrebna vam je imejl adresa.',
        'Need a valid email address or don\'t use a local email address.' =>
            'Ispravna imejl adresa je neophodna, ali ne koristite lokalnu adresu!',
        'Next ticket state' => 'Naredni status tiketa',
        'Inform sender' => 'Obavesti pošiljaoca',
        'Send mail' => 'Pošalji imejl!',

        # Template: AgentTicketBulk
        'Ticket Bulk Action' => 'Masovne akcije na tiketima',
        'Send Email' => 'Pošalji imejl',
        'Merge' => 'Spoji',
        'Merge to' => 'Objedini sa',
        'Invalid ticket identifier!' => 'Nevažeći identifikator tiketa!',
        'Merge to oldest' => 'Objedini sa najstarijom',
        'Link together' => 'Poveži zajedno',
        'Link to parent' => 'Poveži sa nadređenim',
        'Unlock tickets' => 'Otključaj tikete',
        'Execute Bulk Action' => '',

        # Template: AgentTicketCompose
        'Compose Answer for %s%s%s' => '',
        'This address is registered as system address and cannot be used: %s' =>
            'Ova adresa je registrovana kao sistemska i ne može biti korišćena: %s',
        'Please include at least one recipient' => 'Molimo da uključite bar jednog primaoca',
        'Remove Ticket Customer' => 'Ukloni klijent sa tiketa **',
        'Please remove this entry and enter a new one with the correct value.' =>
            'Molimo da uklonite ovaj unos i unesete nov sa ispravnom vrednošću.',
        'This address already exists on the address list.' => 'Ova adresa već postoji u listi',
        'Remove Cc' => 'Ukloni Cc',
        'Remove Bcc' => 'Ukloni Bcc',
        'Address book' => 'Adresar',
        'Date Invalid!' => 'Neispravan datum!',

        # Template: AgentTicketCustomer
        'Change Customer of %s%s%s' => '',
        'Customer Information' => 'Informacije o klijentu',

        # Template: AgentTicketEmail
        'Create New Email Ticket' => 'Otvori novi imejl tiket',
        'Example Template' => 'Primer šablona',
        'From queue' => 'iz reda',
        'To customer user' => 'Za klijenta korisnika',
        'Please include at least one customer user for the ticket.' => 'Molimo vas uključite barem jednog klijenta korisnika za tiket.',
        'Select this customer as the main customer.' => 'Označi ovog klijenta kao glavnog klijenta.',
        'Remove Ticket Customer User' => 'Ukloni tiket klijenta korisnika **',
        'Get all' => 'Uzmi sve',

        # Template: AgentTicketEmailOutbound
        'Outbound Email for %s%s%s' => '',

        # Template: AgentTicketEscalation
        'Ticket %s: first response time is over (%s/%s)!' => 'Tiket %s: vreme odziva je isteklo (%s/%s)!',
        'Ticket %s: first response time will be over in %s/%s!' => 'Tiket %s: vreme odziva će isteći za %s/%s!',
        'Ticket %s: update time is over (%s/%s)!' => '',
        'Ticket %s: update time will be over in %s/%s!' => 'Tiket %s: vreme ažuriranja ističe za %s/%s!',
        'Ticket %s: solution time is over (%s/%s)!' => 'Tiket %s: vreme rešavanja je isteklo (%s/%s)!',
        'Ticket %s: solution time will be over in %s/%s!' => 'Tiket %s: vreme rešavanja ističe za %s/%s!',

        # Template: AgentTicketForward
        'Forward %s%s%s' => '',

        # Template: AgentTicketHistory
        'History of %s%s%s' => '',
        'History Content' => 'Sadržaj istorije',
        'Zoom' => 'Uvećaj',
        'Createtime' => 'Vreme kreiranja',
        'Zoom view' => 'Uvećani pregled',

        # Template: AgentTicketMerge
        'Merge %s%s%s' => '',
        'Merge Settings' => 'Podešavanja spajanja',
        'You need to use a ticket number!' => 'Molimo vas da koristite broj tiketa!',
        'A valid ticket number is required.' => 'Neophodan je ispravan broj tiketa.',
        'Inform Sender' => '',
        'Need a valid email address.' => 'Potrebna je ispravna imejl adresa.',

        # Template: AgentTicketMove
        'Move %s%s%s' => '',
        'New Queue' => 'Novi Red',
        'Move' => 'Premesti',

        # Template: AgentTicketOverviewMedium
        'Select all' => 'Izaberi sve',
        'No ticket data found.' => 'Nisu nađeni podaci o tiketu',
        'Open / Close ticket action menu' => 'Akcioni meni Otvaranja / Zatvaranja tiketa',
        'Select this ticket' => 'Izaberite ovaj tiket',
        'First Response Time' => 'Vreme prvog odgovora',
        'Update Time' => 'Vreme ažuriranja',
        'Solution Time' => 'Vreme rešavanja',
        'Move ticket to a different queue' => 'Premesti tiket u drugi red',
        'Change queue' => 'Promeni red',

        # Template: AgentTicketOverviewNavBar
        'Change search options' => 'Promeni opcije pretrage',
        'Remove active filters for this screen.' => 'Ukloni aktivne filtere za ovaj ekran.',
        'Tickets per page' => 'Tiketa po strani',

        # Template: AgentTicketOverviewSmall
        'Reset overview' => 'Restuj pregled',
        'Column Filters Form' => 'Forma filtera kolona',

        # Template: AgentTicketPhone
        'Split Into New Phone Ticket' => 'Podeli u novi telefonski tiket',
        'Save Chat Into New Phone Ticket' => 'Sačuvaj ćaskanje u novi telefonski tiket',
        'Create New Phone Ticket' => 'Otvori novi telefonski tiket',
        'Please include at least one customer for the ticket.' => 'Molimo da uključite bar jednog klijenta za tiket.',
        'To queue' => 'U red',
        'Chat protocol' => 'Protokol ćaskanja',
        'The chat will be appended as a separate article.' => 'Ćaskanje će biti dodato kao poseban članak.',

        # Template: AgentTicketPhoneCommon
        'Phone Call for %s%s%s' => '',

        # Template: AgentTicketPlain
        'View Email Plain Text for %s%s%s' => '',
        'Plain' => 'Neformatirano',
        'Download this email' => 'Preuzmi ovu poruku',

        # Template: AgentTicketProcess
        'Create New Process Ticket' => 'Kreiraj novi proces tiketa',
        'Process' => 'Proces',

        # Template: AgentTicketProcessSmall
        'Enroll Ticket into a Process' => 'Priključi tiket procesu',

        # Template: AgentTicketSearch
        'Search template' => 'Šablon pretrage',
        'Create Template' => 'Napravi šablon',
        'Create New' => 'Napravi nov',
        'Profile link' => 'Veza profila',
        'Save changes in template' => 'Sačuvaj promene u šablonu',
        'Filters in use' => 'Filteri u upotrebi',
        'Additional filters' => 'Dodatni filteri',
        'Add another attribute' => 'Dodaj još jedan atribut',
        'Output' => 'Pregled rezultata',
        'Fulltext' => 'Tekst',
        'Remove' => 'Ukloni',
        'Searches in the attributes From, To, Cc, Subject and the article body, overriding other attributes with the same name.' =>
            'Pretrage u atributima Od, Do, Cc, Predmet i telu članka, redefinišu druge atribute sa istim imenom.',
        'Customer User Login' => 'Prijava klijenta korisnika',
        'Attachment Name' => 'Naziv priloga',
        '(e. g. m*file or myfi*)' => '(npr m*file ili myfi*)',
        'Created in Queue' => 'Otvoreno u redu',
        'Lock state' => 'Staus zaključavanja',
        'Watcher' => 'Praćenje',
        'Article Create Time (before/after)' => 'Vreme kreiranja članka (pre/posle)',
        'Article Create Time (between)' => 'Vreme kreiranja članka (između)',
        'Ticket Create Time (before/after)' => 'Vreme otvaranja tiketa (pre/posle)',
        'Ticket Create Time (between)' => 'Vreme otvaranja tiketa (između)',
        'Ticket Change Time (before/after)' => 'Vreme promene tiketa (pre/posle)',
        'Ticket Change Time (between)' => 'Vreme promene tiketa (između)',
        'Ticket Last Change Time (before/after)' => 'Vreme poslednje promene tiketa (pre/posle)',
        'Ticket Last Change Time (between)' => 'Vreme poslednje promene tiketa (između)',
        'Ticket Close Time (before/after)' => 'Vreme zatvaranja tiketa (pre/posle)',
        'Ticket Close Time (between)' => 'Vreme zatvaranja tiketa (između)',
        'Ticket Escalation Time (before/after)' => 'Vreme eskalacije tiketa (pre/posle)',
        'Ticket Escalation Time (between)' => 'Vreme eskalacije tiketa (između)',
        'Archive Search' => 'Pretraga arhiva',
        'Run search' => 'Pokreni pretragu',

        # Template: AgentTicketZoom
        'Article filter' => 'Filter za članke',
        'Article Type' => 'Tip članka',
        'Sender Type' => 'Tip pošiljaoca',
        'Save filter settings as default' => 'Sačuvaj podešavanja filtera kao podrazumevana',
        'Event Type Filter' => 'Filter tipa događaja',
        'Event Type' => 'Tip događaja',
        'Save as default' => 'Sačuvaj kao podrazumevano',
        'Change Queue' => 'Promeni Red',
        'There are no dialogs available at this point in the process.' =>
            'U ovom trenutku nema slobodnih dijaloga u procesu.',
        'This item has no articles yet.' => 'Ova stavka još uvek nema člkanke.',
        'Ticket Timeline View' => 'Pregled tiketa na vremenskoj liniji',
        'Article Overview' => 'Pregled članka',
        'Article(s)' => 'Članak/Članci',
        'Page' => 'Strana',
        'Add Filter' => 'Dodaj Filter',
        'Set' => 'Podesi',
        'Reset Filter' => 'Resetuj Filter',
        'Article' => 'Članak',
        'View' => 'Pregled',
        'Show one article' => 'Prikaži jedan članak',
        'Show all articles' => 'Prikaži sve članke',
        'Show Ticket Timeline View' => 'Prikaži tikete na vremenskoj liniji',
        'Unread articles' => 'Nepročitani članci',
        'No.' => 'Br.',
        'Direction' => 'Smer',
        'Important' => 'Važno',
        'Unread Article!' => 'Nepročitani Članci!',
        'Incoming message' => 'Dolazna poruka',
        'Outgoing message' => 'Odlazna poruka',
        'Internal message' => 'Interna poruka',
        'Resize' => 'Promena veličine',
        'Mark this article as read' => 'Označi ovaj članak kao pročitan',
        'Show Full Text' => 'Prikaži ceo tekst',
        'Full Article Text' => 'Tekst celog članka',
        'No more events found. Please try changing the filter settings.' =>
            'Nema više događaja. Pokušajte da promenite podešavanja filtera.',
        'by' => 'od',
        'To open links in the following article, you might need to press Ctrl or Cmd or Shift key while clicking the link (depending on your browser and OS).' =>
            'Da otvorite veze u ovom članku, možda ćete morati da pritisnete „Ctrl” ili „Cmd” ili „Shift” taster dok kliknete na vezu (zavisi od vašeg pregledača i operativnog sistema). ',
        'Close this message' => 'Zatvori ovu poruku',
        'Article could not be opened! Perhaps it is on another article page?' =>
            'Članak se ne može otvoriti! Moguće je da je na drugoj stranici?',

        # Template: LinkTable
        'Linked Objects' => 'Povezani objekti',

        # Template: TicketInformation
        'Archive' => 'Arhiviraj',
        'This ticket is archived.' => 'Ovaj tiket je arhiviran',
        'Note: Type is invalid!' => 'Napomena: Tip je nevažeći!',
        'Locked' => 'Zaključano',
        'Accounted time' => 'Obračunato vreme',
        'Pending till' => 'Na čekanju do',

        # Template: AttachmentBlocker
        'To protect your privacy, remote content was blocked.' => 'Da biste zaštitili svoju privatnost, udaljeni sadržaj je blokiran.',
        'Load blocked content.' => 'Učitaj blokirani sadržaj.',

        # Template: ChatStartForm
        'First message' => 'Prva poruka',

        # Template: CloudServicesDisabled
        'This Feature Requires Cloud Services' => '',
        'You can' => 'Vi možete',
        'go back to the previous page' => 'idi na prethodnu stranu',

        # Template: CustomerError
        'An Error Occurred' => '',
        'Error Details' => 'Detalji greške',
        'Traceback' => 'Isprati unazad',

        # Template: CustomerFooter
        'Powered by' => 'Pokreće',

        # Template: CustomerLogin
        'JavaScript Not Available' => 'JavaScript nije dostupan.',
        'In order to experience OTRS, you\'ll need to enable JavaScript in your browser.' =>
            'Kako bi ste koristili OTRS neophodno je da aktivirate JavaScript u vašem veb pretraživaču.',
        'Browser Warning' => 'Upozorenje veb pretraživača',
        'The browser you are using is too old.' => 'Veb pretraživač koji koristite je previše star.',
        'OTRS runs with a huge lists of browsers, please upgrade to one of these.' =>
            'OTRS funcioniše na velikom broju veb pretraživača, molimo da instalirate i koristite jedan od ovih.',
        'Please see the documentation or ask your admin for further information.' =>
            'Molimo da pregledate dokumentaciju ili pitate vašeg administratora za dodatne informacije.',
        'One moment please, you are being redirected...' => 'Sačekajte momenat, bićete preusmereni...',
        'Login' => 'Prijavljivanje',
        'User name' => 'Korisničko ime',
        'Your user name' => 'Vaše korisničko ime',
        'Your password' => 'Vaša lozinka',
        'Forgot password?' => 'Zaboravili ste lozinku?',
        '2 Factor Token' => 'Dvofaktorski token',
        'Your 2 Factor Token' => 'Vaš dvofaktorski token',
        'Log In' => 'Prijavljivanje',
        'Not yet registered?' => 'Niste registrovani?',
        'Back' => 'Nazad',
        'Request New Password' => 'Zahtev za novu lozinku',
        'Your User Name' => 'Vaše korisničko ime',
        'A new password will be sent to your email address.' => 'Nova lozinka će biti poslata na vašu imejl adresu.',
        'Create Account' => 'Kreirajte nalog',
        'Please fill out this form to receive login credentials.' => 'Molimo da popunite ovaj obrazac da bi ste dobili podatke za prijavu.',
        'How we should address you' => 'Kako da vas oslovljavamo',
        'Your First Name' => 'Vaše ime',
        'Your Last Name' => 'Vaše prezime',
        'Your email address (this will become your username)' => 'Vaša imejl adresa (to će biti vaše korisničko ime)',

        # Template: CustomerNavigationBar
        'Incoming Chat Requests' => 'Dolazni zahtevi za ćaskanje',
        'Edit personal preferences' => 'Uredi lične postavke',
        'Preferences' => 'Podešavanja',
        'Logout %s %s' => 'Odjava %s %s',

        # Template: CustomerRichTextEditor
        'Split Quote' => 'Podeli kvotu',

        # Template: CustomerTicketMessage
        'Service level agreement' => 'Sporazum o nivou usluge',

        # Template: CustomerTicketOverview
        'Welcome!' => 'Dobrodošli!',
        'Please click the button below to create your first ticket.' => 'Molimo da pritisnete dugme ispod za kreiranje vašeg prvog tiketa.',
        'Create your first ticket' => 'Kreirajte vaš prvi tiket',

        # Template: CustomerTicketSearch
        'Profile' => 'Profil',
        'e. g. 10*5155 or 105658*' => 'npr. 10*5155 ili 105658*',
        'Customer ID' => 'ID klijenta',
        'Fulltext Search in Tickets (e. g. "John*n" or "Will*")' => '',
        'Sender' => 'Pošiljaoc',
        'Recipient' => 'Primalac',
        'Carbon Copy' => 'Kopija',
        'e. g. m*file or myfi*' => 'npr m*file ili myfi*',
        'Types' => 'Tipovi',
        'Time Restrictions' => '',
        'No time settings' => 'Nema podešavanja vremena',
        'All' => 'Sve',
        'Specific date' => 'Određeni datum',
        'Only tickets created' => 'Samo kreirani tiketi',
        'Date range' => 'Raspon datuma',
        'Only tickets created between' => 'Samo tiketi kreirani između',
        'Ticket Archive System' => '',
        'Save Search as Template?' => '',
        'Save as Template?' => 'Sačuvati kao šablon?',
        'Save as Template' => 'Sačuvaj kao šablon',
        'Template Name' => 'Naziv šablona',
        'Pick a profile name' => 'Izaberi naziv profila',
        'Output to' => 'Izlaz na',

        # Template: CustomerTicketSearchResultShort
        'of' => 'od',
        'Search Results for' => 'Rezultati pretraživanja za',
        'Remove this Search Term.' => 'Ukloni ovaj izraz za pretragu.',

        # Template: CustomerTicketZoom
        'Start a chat from this ticket' => 'Počni ćaskanje iz ovog tiketa',
        'Expand article' => 'Raširi članak',
        'Information' => 'Informacija',
        'Next Steps' => 'Sledeći koraci',
        'Reply' => 'Odgovori',
        'Chat Protocol' => 'Protokol ćaskanja',

        # Template: CustomerWarning
        'Warning' => 'Upozorenje',

        # Template: DashboardEventsTicketCalendar
        'Event Information' => 'Informacije o događaju',
        'Ticket fields' => 'Polja tiketa',
        'Dynamic fields' => 'Dinamička polja',

        # Template: Error
        'Really a bug? 5 out of 10 bug reports result from a wrong or incomplete installation of OTRS.' =>
            '',
        'With %s, our experts take care of correct installation and cover your back with support and periodic security updates.' =>
            '',
        'Contact our service team now.' => '',
        'Send a bugreport' => 'Pošalji izveštaj o grešci',
        'Expand' => 'Proširi',

        # Template: FooterJS
        'This feature is part of the %s.  Please contact us at %s for an upgrade.' =>
            'Ovo svojstvo je deo %s.  Molimo da na s kontaktirate na %s za ažuriranje.',
        'Find out more about the %s' => 'Pronađi još informacija o %s',

        # Template: Header
        'Logout' => 'Odjava',
        'You are logged in as' => 'Prijavljeni ste kao',

        # Template: Installer
        'JavaScript not available' => 'JavaScript nije dostupan.',
        'Step %s' => 'Korak %s',
        'License' => 'Licenca',
        'Database Settings' => 'Podešavanje baze podataka',
        'General Specifications and Mail Settings' => 'Opšte specifikacije i podešavanje pošte',
        'Finish' => 'Završi',
        'Welcome to %s' => 'Dobrodošli u %s',
        'Phone' => 'Telefon',
        'Web site' => 'Veb sajt',

        # Template: InstallerConfigureMail
        'Configure Outbound Mail' => 'Podešavanje odlazne pošte',
        'Outbound mail type' => 'Tip odlazne pošte',
        'Select outbound mail type.' => 'Izaberite tip odlazne pošte',
        'Outbound mail port' => 'Port za odlaznu poštu',
        'Select outbound mail port.' => 'Izaberite port za odlaznu poštu',
        'SMTP host' => 'SMTP host',
        'SMTP host.' => 'SMTP host.',
        'SMTP authentication' => 'SMTP autentifikacija',
        'Does your SMTP host need authentication?' => 'Da li vaš SMTP host ahteva autentifikaciju?',
        'SMTP auth user' => 'SMTP korisnik',
        'Username for SMTP auth.' => 'Korisničko ime za SMTP autentifikaciju',
        'SMTP auth password' => 'Lozinka SMTP autentifikacije',
        'Password for SMTP auth.' => 'Lozinka za SMTP autentifikaciju',
        'Configure Inbound Mail' => 'Podešavanje dolazne pošte',
        'Inbound mail type' => 'Tip dolazne pošte',
        'Select inbound mail type.' => 'Izaberi tip dolazne pošte',
        'Inbound mail host' => 'Server dolazne pošte',
        'Inbound mail host.' => 'Server dolazne pošte.',
        'Inbound mail user' => 'Korisnik dolazne pošte',
        'User for inbound mail.' => 'Korisnik za dolaznu poštu.',
        'Inbound mail password' => 'Lozinka dolazne pošte',
        'Password for inbound mail.' => 'Lozinka za dolaznu poštu.',
        'Result of mail configuration check' => 'Rezultat provere podešavanja pošte',
        'Check mail configuration' => 'Proveri konfiguraciju mejla',
        'Skip this step' => 'Preskoči ovaj korak',

        # Template: InstallerDBResult
        'Database setup successful!' => 'Uspešno instaliranje baze',

        # Template: InstallerDBStart
        'Install Type' => 'Instaliraj tip',
        'Create a new database for OTRS' => 'Kreiraj novu bazu podataka za OTRS',
        'Use an existing database for OTRS' => 'Koristi postojeću bazu podataka za OTRS',

        # Template: InstallerDBmssql
        'If you have set a root password for your database, it must be entered here. If not, leave this field empty.' =>
            'Ako ste postavili rut lozinku za vašu bazu podataka, ona mora biti uneta ovde. Ako niste, ovo polje ostavite prazno.',
        'Database name' => 'Naziv baze podataka',
        'Check database settings' => 'Proverite podešavanja baze',
        'Result of database check' => 'Rezultat provere baze podataka',
        'Database check successful.' => 'Uspešna provera baze podataka.',
        'Database User' => 'Korisnik baze podataka',
        'New' => 'Nov',
        'A new database user with limited permissions will be created for this OTRS system.' =>
            'Novi korisnik baze sa ograničenim pravima će biti kreiran za ovaj OTRS sistem.',
        'Repeat Password' => 'Ponovi lozinku',
        'Generated password' => 'Generisana lozinka',

        # Template: InstallerDBmysql
        'Passwords do not match' => 'Lozinke se ne poklapaju',

        # Template: InstallerDBoracle
        'SID' => 'SID',
        'Port' => 'Port',

        # Template: InstallerFinish
        'To be able to use OTRS you have to enter the following line in your command line (Terminal/Shell) as root.' =>
            'Da bi ste koristili OTRS morate uneti sledeće u komandnu liniju (Terminal/Shell) kao "root".',
        'Restart your webserver' => 'Ponovo pokrenite vaš veb server.',
        'After doing so your OTRS is up and running.' => 'Posle ovoga vaš OTRS je uključen i radi.',
        'Start page' => 'Početna strana',
        'Your OTRS Team' => 'Vaš OTRS tim',

        # Template: InstallerLicense
        'Don\'t accept license' => 'Ne prihvataj licencu',
        'Accept license and continue' => 'Prihvati licencu i nastavi',

        # Template: InstallerSystem
        'SystemID' => 'Sistemski ID',
        'The identifier of the system. Each ticket number and each HTTP session ID contain this number.' =>
            'Sistemski identifikator. Svaki broj tiketa i svaki ID HTTP sesije sadrži ovaj broj.',
        'System FQDN' => 'Sistemski FQDN',
        'Fully qualified domain name of your system.' => 'Puno ime domena vašeg sistema',
        'AdminEmail' => 'Imejl administrator',
        'Email address of the system administrator.' => 'Imejl adresa sistem administratora.',
        'Organization' => 'Organizacija',
        'Log' => 'Log',
        'LogModule' => 'Log modul',
        'Log backend to use.' => 'Pozadinski prikaz log-a.',
        'LogFile' => 'Log datoteka',
        'Webfrontend' => 'Mrežni interfejs',
        'Default language' => 'Podrazumevani jezik',
        'Default language.' => 'Podrazumevani jezik',
        'CheckMXRecord' => 'Proveri MX podatke',
        'Email addresses that are manually entered are checked against the MX records found in DNS. Don\'t use this option if your DNS is slow or does not resolve public addresses.' =>
            'Ručno uneta imejl adresa se proverava pomoću MX podatka pronađenog u DNS. Nemojte koristiti ovu opciju ako je vaš DNS spor ili ne može da razreši javne adrese.',

        # Template: LinkObject
        'Object#' => 'Objekat#',
        'Add links' => 'Dodaj veze',
        'Delete links' => 'Obriši veze',

        # Template: Login
        'Lost your password?' => 'Izgubili ste lozinku?',
        'Back to login' => 'Nazad na prijavljivanje',

        # Template: MobileNotAvailableWidget
        'Feature not Available' => '',
        'Sorry, but this feature of OTRS is currently not available for mobile devices. If you\'d like to use it, you can either switch to desktop mode or use your regular desktop device.' =>
            'Na žalost, ovo svojstvo momentalno nije dostupno za mobilne uređaje. Ako želite da ga koristite, možete de vratiti na desktop mod ili koristiti standardni desktop uređaj.',

        # Template: Motd
        'Message of the Day' => 'Današnja poruka',
        'This is the message of the day. You can edit this in %s.' => '',

        # Template: NoPermission
        'Insufficient Rights' => 'Nedovoljna ovlaštenja',
        'Back to the previous page' => 'Vratite se na prethodnu stranu',

        # Template: Pagination
        'Show first page' => 'Pokaži prvu stranu',
        'Show previous pages' => 'Pokaži prethodne strane',
        'Show page %s' => 'Pokaži stranu %s',
        'Show next pages' => 'Pokaži sledeće strane',
        'Show last page' => 'Pokaži poslednju stranu',

        # Template: PictureUpload
        'Need FormID!' => 'Potreban ID formulara!',
        'No file found!' => 'Datoteka nije pronađena!',
        'The file is not an image that can be shown inline!' => 'Datoteka nije slika koja se može neposredno prikazati!',

        # Template: PreferencesNotificationEvent
        'Notification' => 'Obaveštenje',
        'No user configurable notifications found.' => 'Nisu pronađena obaveštenja koja korisnik može da podesi.',
        'Receive messages for notification \'%s\' by transport method \'%s\'.' =>
            'Primite poruke za obaveštavanje „%s” prenete putem „%s”.',
        'Please note that you can\'t completely disable notifications marked as mandatory.' =>
            'Molimo da zapamtite da ne možete potpuno da isključite obaveštenja označena kao obavezna.',

        # Template: ActivityDialogHeader
        'Process Information' => 'Informacije o procesu',
        'Dialog' => 'Dijalog',

        # Template: Article
        'Inform Agent' => 'Obavesti operatera',

        # Template: PublicDefault
        'Welcome' => 'Dobrodošli',
        'This is the default public interface of OTRS! There was no action parameter given.' =>
            '',
        'You could install a custom public module (via the package manager), for example the FAQ module, which has a public interface.' =>
            '',

        # Template: RichTextEditor
        'Remove Quote' => '',

        # Template: GeneralSpecificationsWidget
        'Permissions' => 'Dozvole',
        'You can select one or more groups to define access for different agents.' =>
            'Možete izabrati jednu ili više grupa za definisanje pristupa za različite operatere.',
        'Result formats' => 'Format rezultata',
        'Time Zone' => 'Vremenska zona',
        'The selected time periods in the statistic are time zone neutral.' =>
            'Izabrani vremenski periodi u statistici su neutralni po pitanju vremenske zone.',
        'Create summation row' => 'Kreiraj red sa zbirom',
        'Generate an additional row containing sums for all data rows.' =>
            '',
        'Create summation column' => 'Kreiraj kolonu sa zbirom',
        'Generate an additional column containing sums for all data columns.' =>
            '',
        'Cache results' => 'Keširaj rezultate',
        'Stores statistics result data in a cache to be used in subsequent views with the same configuration.' =>
            'Čuva rezultate statistika u kešu za kasnije korišćenje u pregledima sa istim podešavanjima.',
        'Provide the statistic as a widget that agents can activate in their dashboard.' =>
            'Obezbedi statistiku kao aplikativni dodatak (widget), koji opertateri mogu aktivirati putem svoje kontrolne table.',
        'Please note that enabling the dashboard widget will activate caching for this statistic in the dashboard.' =>
            'Napominjemo da omogućavanje aplikativnog dodatka (widget) će keširati ovu statistiku na kontrolnoj tabli.',
        'If set to invalid end users can not generate the stat.' => 'Ako je podešeno na nevažeće, krajnji korisnici ne mogu generisati statistiku.',

        # Template: PreviewWidget
        'There are problems in the configuration of this statistic:' => 'Postoje neki problemi u podešavanju ove statistike:',
        'You may now configure the X-axis of your statistic.' => 'Sada možete podesiti X osu vaše statistike.',
        'This statistic does not provide preview data.' => 'Ova statistika ne omogućava privremeni prikaz.',
        'Preview format:' => 'Format prikaza:',
        'Please note that the preview uses random data and does not consider data filters.' =>
            'Napominjemo da prikaz koristi nasumično izabrane podatke i ne uzima u obzir filtere podataka.',
        'Configure X-Axis' => 'Podesi X osu',
        'X-axis' => 'H-osa',
        'Configure Y-Axis' => 'Podesi Y osu',
        'Y-axis' => 'Y-osa',
        'Configure Filter' => 'Podesi filter',

        # Template: RestrictionsWidget
        'Please select only one element or turn off the button \'Fixed\'.' =>
            'Molimo da izaberete samo jedan element ili isključite dugme "fiksirano"!',
        'Absolute period' => 'Apsolutni period',
        'Between' => 'Između',
        'Relative period' => 'Relativni period',
        'The past complete %s and the current+upcoming complete %s %s' =>
            'Kompletna prošlost %s i kompletna trenutna+buduća %s %s',
        'Do not allow changes to this element when the statistic is generated.' =>
            'Onemogući promene ovog elementa pri generisanju statistike.',

        # Template: StatsParamsWidget
        'Format' => 'Format',
        'Exchange Axis' => 'Zameni ose',
        'Configurable Params of Static Stat' => '',
        'No element selected.' => 'Nije izabran ni jedan element.',
        'Scale' => 'Skala',
        'show more' => '',
        'show less' => '',

        # Template: D3
        'Download SVG' => 'Preuzmi SVG',
        'Download PNG' => 'Preuzme PNG',

        # Template: XAxisWidget
        'The selected time period defines the default time frame for this statistic to collect data from.' =>
            'Odabrani vremenski period definiše podrazumevan vremenski okvir za prikupljanje podataka statistike.',
        'Defines the time unit that will be used to split the selected time period into reporting data points.' =>
            'Definiše vremensku jedinicu koja se koristi za podelu izabranog vremenskog perioda u pojedinačne tačke na izveštaju.',

        # Template: YAxisWidget
        'Please remember that the scale for the Y-axis has to be larger than the scale for the X-axis (e.g. X-axis => Month, Y-Axis => Year).' =>
            'Molimo zapamtite, da skala za Y-osu treba da bude veća od skale za H-osu (npr. H-Osa => mesec; Y-osa => godina).',

        # Template: Test
        'OTRS Test Page' => 'OTRS test strana',
        'Unlock' => 'Otključaj',
        'Welcome %s %s' => 'Dobrodošli %s %s',
        'Counter' => 'Brojač',

        # Template: Warning
        'Go back to the previous page' => 'Vratite se na prethodnu stranu',

        # Perl Module: Kernel/Config/Defaults.pm
        'CustomerIDs' => 'ID-evi klijenta',
        'Fax' => 'Faks',
        'Street' => 'Ulica',
        'Zip' => 'PB',
        'City' => 'Mesto',
        'Country' => 'Država',
        'Valid' => 'Važeći',
        'Mr.' => 'G-din',
        'Mrs.' => 'G-đa',
        'View system log messages.' => 'Pregled poruka sistemskog dnevnika.',
        'Edit the system configuration settings.' => 'Uredi podešavanja sistemske konfiguracije.',
        'Update and extend your system with software packages.' => 'Ažuriraj i nadogradi sistem softverskim paketima.',

        # Perl Module: Kernel/Modules/AdminACL.pm
        'ACL information from database is not in sync with the system configuration, please deploy all ACLs.' =>
            ' „ACL” informacije iz baze podataka nisu sinhronizovane sa sistemskom konfiguracijom, molimo vas da primenite sve  „ACL” liste.',
        'ACLs could not be Imported due to a unknown error, please check OTRS logs for more information' =>
            '',
        'The following ACLs have been added successfully: %s' => '',
        'The following ACLs have been updated successfully: %s' => '',
        'There where errors adding/updating the following ACLs: %s. Please check the log file for more information.' =>
            '',
        'This field is required' => 'Ovo polje je obavezno.',
        'There was an error creating the ACL' => 'Došlo je do greške pri kreiranju „ACL”',
        'Need ACLID!' => '',
        'Could not get data for ACLID %s' => '',
        'There was an error updating the ACL' => 'Došlo je do greške pri ažuriranju „ACL”',
        'There was an error setting the entity sync status.' => '',
        'There was an error synchronizing the ACLs.' => 'Došlo je do greške pri sinhronizaciji „ACLs”',
        'ACL %s could not be deleted' => '',
        'There was an error getting data for ACL with ID %s' => '',
        'Please note that ACL restrictions will be ignored for the Superuser account (UserID 1).' =>
            '',
        'Exact match' => '',
        'Negated exact match' => '',
        'Regular expression' => '',
        'Regular expression (ignore case)' => '',
        'Negated regular expression' => '',
        'Negated regular expression (ignore case)' => '',

        # Perl Module: Kernel/Modules/AdminAttachment.pm
        'Attachment updated!' => 'Ažuriran prilog!',
        'Attachment added!' => 'Dodat prilog!',

        # Perl Module: Kernel/Modules/AdminAutoResponse.pm
        'Response updated!' => 'Ažuriran odgovor!',
        'Response added!' => 'Dodat odgovor!',

        # Perl Module: Kernel/Modules/AdminCustomerCompany.pm
        'Customer company updated!' => 'Ažurirana firma klijenta!',
        'Customer Company %s already exists!' => 'Klijentska firma %s već postoji!',
        'Customer company added!' => 'Dodata firma klijenta!',

        # Perl Module: Kernel/Modules/AdminCustomerUser.pm
        'Customer updated!' => 'Ažuriran klijent!',
        'New phone ticket' => 'Novi telefonski tiket',
        'New email ticket' => 'Novi imejl tiket',
        'Customer %s added' => 'Dodat klijent %s.',

        # Perl Module: Kernel/Modules/AdminDynamicField.pm
        'Fields configuration is not valid' => 'Konfiguracija polja nije validna',
        'Objects configuration is not valid' => 'Konfiguracija objekta nije validna',
        'Could not reset Dynamic Field order properly, please check the error log for more details.' =>
            '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldCheckbox.pm
        'Undefined subaction.' => '',
        'Need %s' => 'Potrebno %s',
        'The field does not contain only ASCII letters and numbers.' => '',
        'There is another field with the same name.' => 'Postoji drugo polje sa istim imenom.',
        'The field must be numeric.' => 'Polje mora biti numeričko.',
        'Need ValidID' => 'Potreban važeći ID',
        'Could not create the new field' => 'Nije moguće kreirati novo polje',
        'Need ID' => 'Potreban ID',
        'Could not get data for dynamic field %s' => 'Ne mogu pribaviti podatke za dinamičko polje %s',
        'The name for this field should not change.' => '',
        'Could not update the field %s' => 'Nije moguće ažurirati polje %s',
        'Currently' => 'Trenutno',
        'Unchecked' => '',
        'Checked' => '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldDateTime.pm
        'No' => 'Ne',
        'Yes' => 'Da',
        'Prevent entry of dates in the future' => '',
        'Prevent entry of dates in the past' => '',

        # Perl Module: Kernel/Modules/AdminDynamicFieldDropdown.pm
        'This field value is duplicated.' => 'Vrednost ovog polja je umnožena.',

        # Perl Module: Kernel/Modules/AdminEmail.pm
        'Select at least one recipient.' => 'Izaberite bar jednog primaoca.',

        # Perl Module: Kernel/Modules/AdminGenericAgent.pm
        'Time unit' => 'Jedinica vremena',
        'within the last ...' => 'u poslednjih ...',
        'within the next ...' => 'u sledećih ...',
        'more than ... ago' => 'pre više od ...',
        'minute(s)' => 'minut(i)',
        'hour(s)' => 'sat(i)',
        'day(s)' => 'dan(i)',
        'week(s)' => 'nedelja(e)',
        'month(s)' => 'mesec(i)',
        'year(s)' => 'godina(e)',
        'Unarchived tickets' => 'Nearhivirani tiketi',
        'archive tickets' => '',
        'restore tickets from archive' => '',
        'Need Profile!' => '',
        'Got no values to check.' => 'Nema vrednosti za proveru.',
        'Please remove the following words because they cannot be used for the ticket selection:' =>
            'Molimo da uklonite sledeće reči jer se ne mogu koristiti za izbor tiketa:',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceDebugger.pm
        'Need WebserviceID!' => 'Potreban ID Veb servisa!',
        'Could not get data for WebserviceID %s' => 'Ne mogu pribaviti podatke za ID Veb servisa %s',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceInvokerDefault.pm
        'Need InvokerType' => 'Potreban tip pozivaoca',
        'Invoker %s is not registered' => 'Pozivaoc %s nije registrovan',
        'InvokerType %s is not registered' => '',
        'Need Invoker' => 'Potreban pozivaoc',
        'Could not determine config for invoker %s' => 'Nije moguće utvrditi konfiguraciju za pozivaoca %s',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceMappingSimple.pm
        'Could not get registered configuration for action type %s' => 'Ne mogu pribaviti registrovanu konfiguraciju za tip akcije %s',
        'Could not get backend for %s %s' => '',
        'Could not update configuration data for WebserviceID %s' => '',
        'Keep (leave unchanged)' => '',
        'Ignore (drop key/value pair)' => '',
        'Map to (use provided value as default)' => '',
        'Exact value(s)' => '',
        'Ignore (drop Value/value pair)' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceMappingXSLT.pm
        'Could not find required library %s' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceOperationDefault.pm
        'Need OperationType' => 'Potreban tip operacije',
        'Operation %s is not registered' => 'Operacija %s nije registrovana',
        'OperationType %s is not registered' => 'Tip operacije %s nije registrovan',
        'Need Operation' => 'Potrebna operacija',
        'Could not determine config for operation %s' => 'Nije moguće utvrditi konfiguraciju za operaciju %s',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceTransportHTTPREST.pm
        'Need Subaction!' => '',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceWebservice.pm
        'There is another web service with the same name.' => 'Postoji drugi veb servis sa istim imenom.',
        'There was an error updating the web service.' => 'Došlo je do greške pri ažuriranju veb servisa.',
        'Web service "%s" updated!' => 'Veb servis „%s” je ažuriran!',
        'There was an error creating the web service.' => 'Došlo je do greške pri kreiranju veb servisa.',
        'Web service "%s" created!' => 'Veb servis „%s” je kreiran!',
        'Need Name!' => 'Potreban naziv!',
        'Need ExampleWebService!' => '',
        'Could not read %s!' => '',
        'Need a file to import!' => 'Potrebna datoteka za uvoz!',
        'The imported file has not valid YAML content! Please check OTRS log for details' =>
            '',
        'Web service "%s" deleted!' => 'Veb servis „%s” je obrisan!',
        'OTRS as provider' => '„OTRS” kao pružaoc usluga',
        'OTRS as requester' => '„OTRS” kao naručioc',

        # Perl Module: Kernel/Modules/AdminGenericInterfaceWebserviceHistory.pm
        'Got no WebserviceHistoryID!' => '',
        'Could not get history data for WebserviceHistoryID %s' => '',

        # Perl Module: Kernel/Modules/AdminGroup.pm
        'Group updated!' => 'Ažurirana grupa!',

        # Perl Module: Kernel/Modules/AdminMailAccount.pm
        'Mail account added!' => 'Dodat imejl nalog!',
        'Mail account updated!' => 'Ažuriran mejl nalog!',
        'Finished' => 'Završeno',
        'Dispatching by email To: field.' => 'Otpremanje putem imejla Za: polje.',
        'Dispatching by selected Queue.' => 'Otpremanje putem izabranog reda.',

        # Perl Module: Kernel/Modules/AdminNotificationEvent.pm
        'Notification updated!' => 'Obaveštenje ažurirano!',
        'Notification added!' => 'Obaveštenje dodato!',
        'There was an error getting data for Notification with ID:%s!' =>
            '',
        'Unknown Notification %s!' => 'Nepoznato obaveštenje %s!',
        'There was an error creating the Notification' => '',
        'Notifications could not be Imported due to a unknown error, please check OTRS logs for more information' =>
            '',
        'The following Notifications have been added successfully: %s' =>
            '',
        'The following Notifications have been updated successfully: %s' =>
            '',
        'There where errors adding/updating the following Notifications: %s. Please check the log file for more information.' =>
            '',
        'Agent who owns the ticket' => 'Operater koji je vlasnik tiketa',
        'Agent who is responsible for the ticket' => 'Operater koji je odgovoran za tiket',
        'All agents watching the ticket' => 'Svi operateri koji nadziru tiket',
        'All agents with write permission for the ticket' => 'Svi operateri sa dozvolom pisanja za tiket',
        'All agents subscribed to the ticket\'s queue' => 'Svi operateri pretplaćeni na red tiketa',
        'All agents subscribed to the ticket\'s service' => 'Svi operateri pretplaćeni na servis tiketa',
        'All agents subscribed to both the ticket\'s queue and service' =>
            'Svi operateri pretplaćeni i na red i na servis tiketa',
        'Customer of the ticket' => 'Klijent za tiket',
        'Yes, but require at least one active notification method' => 'Da, ali je neophodan bar jedan aktivni metod obaveštavanja.',

        # Perl Module: Kernel/Modules/AdminOTRSBusiness.pm
        'Your system was successfully upgraded to %s.' => 'Vaš sistem je uspešno unapređen na %s.',
        'There was a problem during the upgrade to %s.' => 'Problem tokom unapređivanja na  %s.',
        '%s was correctly reinstalled.' => '%s je korektno reinstalirana.',
        'There was a problem reinstalling %s.' => 'Problem pri reinstalaciji %s.',
        'Your %s was successfully updated.' => 'Vaša %s je uspešno ažurirana.',
        'There was a problem during the upgrade of %s.' => 'Problem tokom unapređivanja %s.',
        '%s was correctly uninstalled.' => '%s je korektno deinstalirana.',
        'There was a problem uninstalling %s.' => 'Problem pri deinstalaciji %s.',

        # Perl Module: Kernel/Modules/AdminPGP.pm
        'PGP environment is not working. Please check log for more info!' =>
            '',
        'Need param Key to delete!' => '',
        'Key %s deleted!' => 'Ključ %s je obrisan!',
        'Need param Key to download!' => '',

        # Perl Module: Kernel/Modules/AdminPackageManager.pm
        'Sorry, Apache::Reload is needed as PerlModule and PerlInitHandler in Apache config file. See also scripts/apache2-httpd.include.conf. Alternatively, you can use the command line tool bin/otrs.Console.pl to install packages!' =>
            '',
        'No such package!' => 'Nema takvog paketa!',
        'No such file %s in package!' => 'Nema takve datoteke %s u paketu!',
        'No such file %s in local file system!' => 'Nema takve datoteke %s u lokalnom sistemu!',
        'Can\'t read %s!' => 'Nemoguće čitanje %s!',
        'Package has locally modified files.' => 'Paket sadrži lokalno izmenjene datoteke.',
        'Package not verified by the OTRS Group! It is recommended not to use this package.' =>
            'Paket nije verifikovan od strane OTRS grupe! Preporučuje se da ne koristite ovaj paket.',
        'No packages or no new packages found in selected repository.' =>
            'U izabranom spremištu nema paketa ili nema novih paketa.',
        'Package not verified due a communication issue with verification server!' =>
            'Paket nije verifikovan zbog komunikacijskog problema sa verifikacionim serverom!',
        'Can\'t connect to OTRS Feature Add-on list server!' => '',
        'Can\'t get OTRS Feature Add-on list from server!' => '',
        'Can\'t get OTRS Feature Add-on from server!' => '',

        # Perl Module: Kernel/Modules/AdminPostMasterFilter.pm
        'No such filter: %s' => 'Nema takvog filtera: %s',

        # Perl Module: Kernel/Modules/AdminPriority.pm
        'Priority updated!' => 'Ažuriran prioritet!',
        'Priority added!' => 'Dodat prioritet!',

        # Perl Module: Kernel/Modules/AdminProcessManagement.pm
        'Process Management information from database is not in sync with the system configuration, please synchronize all processes.' =>
            'Obrađene informacije iz baze podataka nisu sinhronizovane sa sistemskom konfiguracijom, molimo vas da sinhronizujete sve procese.',
        'Need ExampleProcesses!' => '',
        'Need ProcessID!' => '',
        'Yes (mandatory)' => '',
        'Unknown Process %s!' => 'Nepoznat proces %s!',
        'There was an error generating a new EntityID for this Process' =>
            '',
        'The StateEntityID for state Inactive does not exists' => '',
        'There was an error creating the Process' => '',
        'There was an error setting the entity sync status for Process entity: %s' =>
            '',
        'Could not get data for ProcessID %s' => '',
        'There was an error updating the Process' => '',
        'Process: %s could not be deleted' => '',
        'There was an error synchronizing the processes.' => '',
        'The %s:%s is still in use' => '',
        'The %s:%s has a different EntityID' => '',
        'Could not delete %s:%s' => '',
        'There was an error setting the entity sync status for %s entity: %s' =>
            '',
        'Could not get %s' => '',
        'Need %s!' => 'Potrebno %s!',
        'Process: %s is not Inactive' => '',

        # Perl Module: Kernel/Modules/AdminProcessManagementActivity.pm
        'There was an error generating a new EntityID for this Activity' =>
            'Došlo je do greške prilikom kreiranja novog ID entiteta za ovu Aktivnost',
        'There was an error creating the Activity' => 'Došlo je do greške prilikom kreiranja Aktivnosti',
        'There was an error setting the entity sync status for Activity entity: %s' =>
            '',
        'Need ActivityID!' => 'Potreban ID aktivnosti!',
        'Could not get data for ActivityID %s' => 'Ne mogu pribaviti podatke za ID aktivnosti %s',
        'There was an error updating the Activity' => 'Došlo je do greške prilikom ažuriranja Aktivnosti',
        'Missing Parameter: Need Activity and ActivityDialog!' => 'Nedostaje parametar: Potrebna aktivnost i dijalog aktivnosti!',
        'Activity not found!' => 'Aktivnost nije pronađena!',
        'ActivityDialog not found!' => 'Dijalog aktivnosti nije pronađen!',
        'ActivityDialog already assigned to Activity. You cannot add an ActivityDialog twice!' =>
            '',
        'Error while saving the Activity to the database!' => 'Greška pri čuvanju aktivnosti u bazi podataka!',
        'This subaction is not valid' => '',
        'Edit Activity "%s"' => 'Uredi aktivnost "%s"',

        # Perl Module: Kernel/Modules/AdminProcessManagementActivityDialog.pm
        'There was an error generating a new EntityID for this ActivityDialog' =>
            '',
        'There was an error creating the ActivityDialog' => '',
        'There was an error setting the entity sync status for ActivityDialog entity: %s' =>
            '',
        'Need ActivityDialogID!' => '',
        'Could not get data for ActivityDialogID %s' => 'Ne mogu pribaviti podatke za ID dijaloga aktivnosti %s',
        'There was an error updating the ActivityDialog' => '',
        'Edit Activity Dialog "%s"' => '',
        'Agent Interface' => 'Operaterski interfejs',
        'Customer Interface' => 'Klijentski interfejs',
        'Agent and Customer Interface' => 'Operaterski i klijentski interfejs',
        'Do not show Field' => 'Ne prikazuj ovo polje',
        'Show Field' => 'Prikaži polje',
        'Show Field As Mandatory' => 'Prikaži polje kao obavezno',
        'note-internal' => 'napomena-interna',
        'note-external' => 'napomena-eksterna',
        'note-report' => 'napomena-izveštaj',
        'phone' => 'telefon',
        'fax' => 'faks',
        'sms' => 'SMS',
        'webrequest' => 'veb zahtev',

        # Perl Module: Kernel/Modules/AdminProcessManagementPath.pm
        'Edit Path' => 'Uredi putanju',

        # Perl Module: Kernel/Modules/AdminProcessManagementTransition.pm
        'There was an error generating a new EntityID for this Transition' =>
            'Došlo je do greške prilikom kreiranja novog ID entiteta za ovu tranziciju',
        'There was an error creating the Transition' => 'Došlo je do greške prilikom kreiranja Tranzicije',
        'There was an error setting the entity sync status for Transition entity: %s' =>
            '',
        'Need TransitionID!' => 'Potreban ID tranzicije!',
        'Could not get data for TransitionID %s' => 'Ne mogu pribaviti podatke za ID tranzicije %s',
        'There was an error updating the Transition' => 'Došlo je do greške prilikom ažuriranja Tranzicije',
        'Edit Transition "%s"' => '',
        'xor' => '',
        'String' => '',
        'Transition validation module' => '',

        # Perl Module: Kernel/Modules/AdminProcessManagementTransitionAction.pm
        'At least one valid config parameter is required.' => 'Neophodan je bar jedan validan konfiguracioni parametar.',
        'There was an error generating a new EntityID for this TransitionAction' =>
            'Došlo je do greške prilikom kreiranja novog ID entiteta za ovu tranzicionu akciju',
        'There was an error creating the TransitionAction' => 'Došlo je do greške prilikom kreiranja Tranzicione akcije',
        'There was an error setting the entity sync status for TransitionAction entity: %s' =>
            '',
        'Need TransitionActionID!' => 'Potreban ID tranzicione akcije!',
        'Could not get data for TransitionActionID %s' => 'Ne mogu pribaviti podatke za ID tranzicione akcije %s',
        'There was an error updating the TransitionAction' => 'Došlo je do greške prilikom ažuriranja Tranzicione akcije',
        'Edit Transition Action "%s"' => '',
        'Error: Not all keys seem to have values or vice versa.' => 'Greška: Svi ključevi nemaju vrednost ili obrnuto.',

        # Perl Module: Kernel/Modules/AdminQueue.pm
        'Don\'t use :: in queue name!' => '',
        'Click back and change it!' => '',
        'Queue updated!' => 'Ažuriran red!',
        '-none-' => '-ni jedan-',

        # Perl Module: Kernel/Modules/AdminQueueAutoResponse.pm
        'Queues ( without auto responses )' => 'Redovi (bez automatskih odgovora)',

        # Perl Module: Kernel/Modules/AdminRole.pm
        'Role updated!' => 'Ažurirana uloga!',
        'Role added!' => 'Dodata uloga!',

        # Perl Module: Kernel/Modules/AdminSLA.pm
        'Please activate %s first!' => 'Molimo, prvo aktivirajte %s.',

        # Perl Module: Kernel/Modules/AdminSMIME.pm
        'S/MIME environment is not working. Please check log for more info!' =>
            '',
        'Need param Filename to delete!' => '',
        'Need param Filename to download!' => '',
        'Needed CertFingerprint and CAFingerprint!' => '',
        'CAFingerprint must be different than CertFingerprint' => '',
        'Relation exists!' => 'Veza postoji!',
        'Relation added!' => 'Dodata veza!',
        'Impossible to add relation!' => 'Nemoguće dodavanje veze!',
        'Relation doesn\'t exists' => 'Veza ne postoji',
        'Relation deleted!' => 'Veza obrisana!',
        'Impossible to delete relation!' => 'Nemoguće brisanje veze!',
        'Certificate %s could not be read!' => '',
        'Needed Fingerprint' => 'Neophodan otisak',

        # Perl Module: Kernel/Modules/AdminSalutation.pm
        'Salutation updated!' => 'Pozdrav ažuriran!',
        'Salutation added!' => 'Pozdrav dodat!',

        # Perl Module: Kernel/Modules/AdminSignature.pm
        'Signature updated!' => 'Ažuriran potpis!',
        'Signature added!' => 'Dodat potpis!',

        # Perl Module: Kernel/Modules/AdminState.pm
        'State updated!' => 'Ažuriran status!',
        'State added!' => 'Dodat status!',

        # Perl Module: Kernel/Modules/AdminSupportDataCollector.pm
        'File %s could not be read!' => '',

        # Perl Module: Kernel/Modules/AdminSysConfig.pm
        'Import not allowed!' => 'Uvoz nije dozvoljen!',
        'Need File!' => 'Potrebna datoteka!',
        'Can\'t write ConfigItem!' => '',

        # Perl Module: Kernel/Modules/AdminSystemAddress.pm
        'System e-mail address updated!' => 'Ažurirana sistemska imejl adresa!',
        'System e-mail address added!' => 'Dodata sistemska imejl adresa!',

        # Perl Module: Kernel/Modules/AdminSystemMaintenance.pm
        'Start date shouldn\'t be defined after Stop date!' => '',
        'There was an error creating the System Maintenance' => '',
        'Need SystemMaintenanceID!' => '',
        'Could not get data for SystemMaintenanceID %s' => '',
        'System Maintenance was saved successfully!' => '',
        'Session has been killed!' => 'Sesija je prekinuta!',
        'All sessions have been killed, except for your own.' => 'Sve sesije su prekinute, osim sopstvene.',
        'There was an error updating the System Maintenance' => 'Došlo je do greške prilikom ažuriranja Održavanja sistema',
        'Was not possible to delete the SystemMaintenance entry: %s!' => '',

        # Perl Module: Kernel/Modules/AdminTemplate.pm
        'Template updated!' => 'Šablon ažuriran!',
        'Template added!' => 'Šablon dodat!',

        # Perl Module: Kernel/Modules/AdminType.pm
        'Need Type!' => 'Potreban tip!',
        'Type updated!' => 'Ažuriran tip!',
        'Type added!' => 'Dodat tip!',

        # Perl Module: Kernel/Modules/AdminUser.pm
        'Agent updated!' => 'Ažuriran operater!',

        # Perl Module: Kernel/Modules/AgentCustomerSearch.pm
        'Customer History' => 'Istorijat klijenta',

        # Perl Module: Kernel/Modules/AgentDashboardCommon.pm
        'No such config for %s' => 'Nema takve konfiguracije za %s',
        'Statistic' => 'Statistika',
        'No preferences for %s!' => 'Nema postavki za %s!',
        'Can\'t get element data of %s!' => '',
        'Can\'t get filter content data of %s!' => '',

        # Perl Module: Kernel/Modules/AgentLinkObject.pm
        'Need SourceObject and SourceKey!' => '',
        'Please contact the administrator.' => '',
        'You need ro permission!' => '',
        'Can not delete link with %s!' => 'Ne može se obrisati veza sa %s!',
        'Can not create link with %s! Object already linked as %s.' => '',
        'Can not create link with %s!' => 'Ne može se kreirati veza sa %s!',
        'The object %s cannot link with other object!' => '',

        # Perl Module: Kernel/Modules/AgentPreferences.pm
        'Param Group is required!' => 'Neophodan parametar grupe! ',

        # Perl Module: Kernel/Modules/AgentSpelling.pm
        'No suggestions' => 'Nema sugestija',

        # Perl Module: Kernel/Modules/AgentStatistics.pm
        'Parameter %s is missing.' => '',
        'Invalid Subaction.' => '',
        'Statistic could not be imported.' => 'Statistika se ne može uvesti.',
        'Please upload a valid statistic file.' => 'Molimo da učitate ispravnu datoteku statistike.',
        'Export: Need StatID!' => '',
        'Delete: Get no StatID!' => '',
        'Need StatID!' => 'Potreban ID statistike!',
        'Could not load stat.' => 'Nije moguće učitavanje statistike.',
        'Could not create statistic.' => 'Nije moguće kreiranje statistike.',
        'Run: Get no %s!' => '',

        # Perl Module: Kernel/Modules/AgentTicketActionCommon.pm
        'No TicketID is given!' => 'Nije dat ID Tiketa!',
        'You need %s permissions!' => '',
        'Sorry, you need to be the ticket owner to perform this action.' =>
            'Na žalost, morate biti vlasnik tiketa za ovu akciju.',
        'Please change the owner first.' => 'Molimo prvo promenite vlasnika.',
        'Could not perform validation on field %s!' => 'Nije moguće obaviti validaciju za polje %s!',
        'No subject' => 'Nema predmet',
        'Previous Owner' => 'Prethodni vlasnik',
        'wrote' => 'napisao',
        'Message from' => 'Poruka od',
        'End message' => 'Kraj poruke',

        # Perl Module: Kernel/Modules/AgentTicketBounce.pm
        '%s is needed!' => '',
        'Plain article not found for article %s!' => '',
        'Article does not belong to ticket %s!' => '',
        'Can\'t bounce email!' => '',
        'Can\'t send email!' => '',
        'Wrong Subaction!' => '',

        # Perl Module: Kernel/Modules/AgentTicketBulk.pm
        'Can\'t lock Tickets, no TicketIDs are given!' => '',
        'Ticket (%s) is not unlocked!' => '',
        'Bulk feature is not enabled!' => '',
        'No selectable TicketID is given!' => '',
        'You either selected no ticket or only tickets which are locked by other agents' =>
            '',
        'You need to select at least one ticket' => '',
        'You don\'t have write access to this ticket.' => 'Nemate pravo upisa u ovaj tiket.',
        'Ticket selected.' => 'Izabran tiket.',
        'Ticket is locked by another agent and will be ignored!' => 'Tiket je zaključan od strane drugog operatera i biće ignorisan!',
        'Ticket locked.' => 'Zaključan tiket.',

        # Perl Module: Kernel/Modules/AgentTicketCompose.pm
        'Can not determine the ArticleType!' => '',
        'Address %s replaced with registered customer address.' => 'Adresa %s je zamenjena registrovnom adresom klijenta.',
        'Customer user automatically added in Cc.' => 'Klijent klijent se automatski dodaje u Cc.',

        # Perl Module: Kernel/Modules/AgentTicketEmail.pm
        'Ticket "%s" created!' => 'Tiket "%s" kreiran!',
        'No Subaction!' => '',

        # Perl Module: Kernel/Modules/AgentTicketEmailOutbound.pm
        'Got no TicketID!' => '',
        'System Error!' => 'Sistemska greška!',

        # Perl Module: Kernel/Modules/AgentTicketEscalationView.pm
        'Today' => 'Danas',
        'Tomorrow' => 'Sutra',
        'Next week' => 'Sledeće nedelje',
        'Invalid Filter: %s!' => 'Nevažeći filter: %s!',
        'Ticket Escalation View' => 'Eskalacioni pregled tiketa',

        # Perl Module: Kernel/Modules/AgentTicketForward.pm
        'Forwarded message from' => 'Prosleđena poruka od',
        'End forwarded message' => 'Kraj prosleđene poruke',

        # Perl Module: Kernel/Modules/AgentTicketHistory.pm
        'Can\'t show history, no TicketID is given!' => '',

        # Perl Module: Kernel/Modules/AgentTicketLock.pm
        'Can\'t lock Ticket, no TicketID is given!' => '',
        'Sorry, the current owner is %s!' => '',
        'Please become the owner first.' => '',
        'Ticket (ID=%s) is locked by %s!' => '',
        'Change the owner!' => 'Promeni vlasnika!',

        # Perl Module: Kernel/Modules/AgentTicketLockedView.pm
        'New Article' => 'Novi članak',
        'Pending' => 'Na čekanju',
        'Reminder Reached' => 'Dostignut podsetnik',
        'My Locked Tickets' => 'Moji zaključani tiketi',

        # Perl Module: Kernel/Modules/AgentTicketMerge.pm
        'Can\'t merge ticket with itself!' => 'Tiket se ne može povezati sa sobom!',

        # Perl Module: Kernel/Modules/AgentTicketMove.pm
        'You need move permissions!' => '',

        # Perl Module: Kernel/Modules/AgentTicketPhone.pm
        'Chat is not active.' => '',
        'No permission.' => 'Nema dozvole.',
        '%s has left the chat.' => '%s je napustio ćaskanje.',
        'This chat has been closed and will be removed in %s hours.' => 'Ovo ćaskanje je zatvoreno i biće uklonjeno za %s sati.',

        # Perl Module: Kernel/Modules/AgentTicketPlain.pm
        'No ArticleID!' => '',
        'Can\'t read plain article! Maybe there is no plain email in backend! Read backend message.' =>
            '',

        # Perl Module: Kernel/Modules/AgentTicketPrint.pm
        'Need TicketID!' => 'Potreban ID Tiketa!',
        'printed by' => 'štampao',
        'Ticket Dynamic Fields' => 'Dinamička polja tiketa',

        # Perl Module: Kernel/Modules/AgentTicketProcess.pm
        'Couldn\'t get ActivityDialogEntityID "%s"!' => '',
        'No Process configured!' => 'Nema konfigurisanog procesa!',
        'The selected process is invalid!' => 'Označeni proces je nevažeći!',
        'Process %s is invalid!' => 'Proces %s je nevažeći!',
        'Subaction is invalid!' => '',
        'Parameter %s is missing in %s.' => '',
        'No ActivityDialog configured for %s in _RenderAjax!' => '',
        'Got no Start ActivityEntityID or Start ActivityDialogEntityID for Process: %s in _GetParam!' =>
            '',
        'Couldn\'t get Ticket for TicketID: %s in _GetParam!' => '',
        'Couldn\'t determine ActivityEntityID. DynamicField or Config isn\'t set properly!' =>
            '',
        'Process::Default%s Config Value missing!' => '',
        'Got no ProcessEntityID or TicketID and ActivityDialogEntityID!' =>
            '',
        'Can\'t get StartActivityDialog and StartActivityDialog for the ProcessEntityID "%s"!' =>
            '',
        'Can\'t get Ticket "%s"!' => 'Ne mogu pribaviti tiket "%s"!',
        'Can\'t get ProcessEntityID or ActivityEntityID for Ticket "%s"!' =>
            '',
        'Can\'t get Activity configuration for ActivityEntityID "%s"!' =>
            '',
        'Can\'t get ActivityDialog configuration for ActivityDialogEntityID "%s"!' =>
            '',
        'Can\'t get data for Field "%s" of ActivityDialog "%s"!' => '',
        'PendingTime can just be used if State or StateID is configured for the same ActivityDialog. ActivityDialog: %s!' =>
            '',
        'Pending Date' => 'Datum čekanja',
        'for pending* states' => 'za stanja* čekanja',
        'ActivityDialogEntityID missing!' => '',
        'Couldn\'t get Config for ActivityDialogEntityID "%s"!' => '',
        'Couldn\'t use CustomerID as an invisible field.' => '',
        'Missing ProcessEntityID, check your ActivityDialogHeader.tt!' =>
            '',
        'No StartActivityDialog or StartActivityDialog for Process "%s" configured!' =>
            '',
        'Couldn\'t create ticket for Process with ProcessEntityID "%s"!' =>
            '',
        'Couldn\'t set ProcessEntityID "%s" on TicketID "%s"!' => '',
        'Couldn\'t set ActivityEntityID "%s" on TicketID "%s"!' => '',
        'Could not store ActivityDialog, invalid TicketID: %s!' => '',
        'Invalid TicketID: %s!' => 'Nevažeći ID tiketa: %s!',
        'Missing ActivityEntityID in Ticket %s!' => '',
        'Missing ProcessEntityID in Ticket %s!' => '',
        'Could not set DynamicField value for %s of Ticket with ID "%s" in ActivityDialog "%s"!' =>
            '',
        'Could not set PendingTime for Ticket with ID "%s" in ActivityDialog "%s"!' =>
            '',
        'Wrong ActivityDialog Field config: %s can\'t be Display => 1 / Show field (Please change its configuration to be Display => 0 / Do not show field or Display => 2 / Show field as mandatory)!' =>
            '',
        'Could not set %s for Ticket with ID "%s" in ActivityDialog "%s"!' =>
            '',
        'Default Config for Process::Default%s missing!' => '',
        'Default Config for Process::Default%s invalid!' => '',

        # Perl Module: Kernel/Modules/AgentTicketQueue.pm
        'Available tickets' => 'Slobodni tiketi',
        'including subqueues' => 'uključujući podredove',
        'excluding subqueues' => 'isključujući podredove',
        'QueueView' => 'Pregled reda',

        # Perl Module: Kernel/Modules/AgentTicketResponsibleView.pm
        'My Responsible Tickets' => 'Tiketi za koje sam odgovoran',

        # Perl Module: Kernel/Modules/AgentTicketSearch.pm
        'last-search' => 'poslednja pretraga',
        'Untitled' => '',
        'Ticket Number' => 'Broj tiketa',
        'Customer Realname' => 'Pravo ime klijenta',
        'Ticket' => 'Tiket',
        'Invalid Users' => 'Pogrešni korisnici',
        'Normal' => 'Normalna',
        'CSV' => 'CSV',
        'Excel' => '',

        # Perl Module: Kernel/Modules/AgentTicketService.pm
        'Feature not enabled!' => 'Funkcija nije aktivirana!',
        'Service View' => 'Pregled usluge',

        # Perl Module: Kernel/Modules/AgentTicketStatusView.pm
        'Status View' => 'Pregled statusa',

        # Perl Module: Kernel/Modules/AgentTicketWatchView.pm
        'My Watched Tickets' => 'Moji nadzirani tiketi',

        # Perl Module: Kernel/Modules/AgentTicketWatcher.pm
        'Feature is not active' => 'Funkcija nije aktivna',

        # Perl Module: Kernel/Modules/AgentTicketZoom.pm
        'Ticket Created' => 'Kreiran tiket',
        'Note Added' => 'Dodata napomena',
        'Note Added (Customer)' => '',
        'Outgoing Email' => 'Odlazni imejl',
        'Outgoing Email (internal)' => 'Odlazni imejl (interni)',
        'Incoming Customer Email' => '',
        'Dynamic Field Updated' => '',
        'Outgoing Phone Call' => '',
        'Incoming Phone Call' => '',
        'Outgoing Answer' => 'Odlazni odgovor',
        'SLA Updated' => '',
        'Service Updated' => 'Ažuriran servis',
        'Customer Updated' => 'Ažuriran klijent',
        'State Updated' => 'Ažurirano stanje',
        'Incoming Follow-Up' => '',
        'Escalation Update Time Stopped' => '',
        'Escalation Solution Time Stopped' => '',
        'Escalation First Response Time Stopped' => '',
        'Escalation Response Time Stopped' => '',
        'Link Added' => 'Dodata veza',
        'Link Deleted' => 'Obrisana veza',
        'Ticket Merged' => 'Spojen tiket',
        'Pending Time Set' => '',
        'Ticket Locked' => 'Zaključan tiket',
        'Ticket Unlocked' => 'Otključan tiket',
        'Queue Updated' => 'Ažuriran red',
        'Priority Updated' => 'Ažuriran prioritet',
        'Title Updated' => 'Ažuriran naslov',
        'Type Updated' => 'Ažuriran tip',
        'Incoming Web Request' => 'Dolazni veb zahtev',
        'Automatic Follow-Up Sent' => '',
        'Automatic Reply Sent' => 'Poslat automatski odgovor',
        'Time Accounted' => '',
        'External Chat' => 'Eksterno ćaskanje',
        'Internal Chat' => 'Interno ćaskanje',
        'We are sorry, you do not have permissions anymore to access this ticket in its current state.' =>
            '',
        'Can\'t get for ArticleID %s!' => '',
        'Article filter settings were saved.' => 'Podešavanja filtera članka su sačuvana.',
        'Event type filter settings were saved.' => 'Podešavanja filtera tipa događaja su sačuvana.',
        'Need ArticleID!' => '',
        'Invalid ArticleID!' => '',
        'Fields with no group' => 'Polja bez grupe',
        'Reply All' => 'Odgovori na sve',
        'Forward' => 'Prosledi',
        'Forward article via mail' => 'Prosledi članak putem mejla',
        'Bounce Article to a different mail address' => 'Preusmeravanje članka na drugu imejl adresu',
        'Bounce' => 'Preusmeri',
        'Split this article' => 'Podeli ovaj članak',
        'Split' => 'Podeli',
        'Print this article' => 'Odštampaj ovaj članak',
        'View the source for this Article' => '',
        'Plain Format' => 'Neformatiran format',
        'Mark' => 'Označeno',
        'Unmark' => 'Neoznačeno',
        'Reply to note' => 'Odgovori na napomenu',

        # Perl Module: Kernel/Modules/CustomerTicketAttachment.pm
        'FileID and ArticleID are needed!' => '',
        'No TicketID for ArticleID (%s)!' => '',
        'No such attachment (%s)!' => '',

        # Perl Module: Kernel/Modules/CustomerTicketMessage.pm
        'Check SysConfig setting for %s::QueueDefault.' => '',
        'Check SysConfig setting for %s::TicketTypeDefault.' => '',

        # Perl Module: Kernel/Modules/CustomerTicketOverview.pm
        'Need CustomerID!' => '',
        'My Tickets' => 'Moji tiketi',
        'Company Tickets' => 'Tiketi firmi',
        'Untitled!' => '',

        # Perl Module: Kernel/Modules/CustomerTicketSearch.pm
        'Created within the last' => 'Kreirano u poslednjih',
        'Created more than ... ago' => 'Kreirano pre više od ...',
        'Please remove the following words because they cannot be used for the search:' =>
            'Molimo da uklonite sledeće reči  jer se ne mogu koristiti za pretragu:',

        # Perl Module: Kernel/Modules/CustomerTicketZoom.pm
        'Can\'t reopen ticket, not possible in this queue!' => '',
        'Create a new ticket!' => 'Napravi novi tiket!',

        # Perl Module: Kernel/Modules/Installer.pm
        'Directory "%s" doesn\'t exist!' => '',
        'Configure "Home" in Kernel/Config.pm first!' => '',
        'File "%s/Kernel/Config.pm" not found!' => '',
        'Directory "%s" not found!' => '',
        'Install OTRS' => 'Instaliraj „OTRS”',
        'Intro' => 'Uvod',
        'Kernel/Config.pm isn\'t writable!' => '',
        'If you want to use the installer, set the Kernel/Config.pm writable for the webserver user!' =>
            '',
        'Database Selection' => 'Selekcija baze podataka',
        'Unknown Check!' => '',
        'The check "%s" doesn\'t exist!' => '',
        'Enter the password for the database user.' => 'Unesi lozinku za korisnika baze podataka.',
        'Database %s' => '',
        'Enter the password for the administrative database user.' => 'Unesi lozinku za korisnika administrativne baze podataka.',
        'Unknown database type "%s".' => '',
        'Please go back' => '',
        'Create Database' => 'Kreiraj bazu podataka',
        'Install OTRS - Error' => '',
        'File "%s/%s.xml" not found!' => '',
        'Contact your Admin!' => 'Kontaktirajte vašeg administratora!',
        'System Settings' => 'Sistemska podešavanja',
        'Configure Mail' => 'Podesi imejl',
        'Mail Configuration' => 'Podešavanje imejla',
        'Can\'t write Config file!' => '',
        'Unknown Subaction %s!' => '',
        'Can\'t connect to database, Perl module DBD::%s not installed!' =>
            '',
        'Can\'t connect to database, read comment!' => '',
        'Database already contains data - it should be empty!' => 'Baza podataka već sadrži podatke - trebalo bi da bude prazna.',
        'Error: Please make sure your database accepts packages over %s MB in size (it currently only accepts packages up to %s MB). Please adapt the max_allowed_packet setting of your database in order to avoid errors.' =>
            'Greška: Molimo da proverite da vaša baza podataka prihvata pakete po veličini veće od %s MB  (trenutno prihvata pakete veličine do %s MB). Molimo da prilagodite parametar „max_allowed_packet setting” u vašoj bazi podataka kako bi izbegli greške.',
        'Error: Please set the value for innodb_log_file_size on your database to at least %s MB (current: %s MB, recommended: %s MB). For more information, please have a look at %s.' =>
            'Greška: Molimo da podesete vrednost za „innodb_log_file_size” u vašoj bazi podataka na najmanje %s MB (trenutno: %s MB, preporučeno: %s MB). Za više informacija, molimo pogledajte na %s.',

        # Perl Module: Kernel/Modules/PublicRepository.pm
        'Need config Package::RepositoryAccessRegExp' => '',
        'Authentication failed from %s!' => '',

        # Perl Module: Kernel/Output/HTML/ArticleCheck/PGP.pm
        'Crypted' => 'Šifrovano',
        'Sent message encrypted to recipient!' => '',
        'Signed' => 'Potpisano',
        '"PGP SIGNED MESSAGE" header found, but invalid!' => '',

        # Perl Module: Kernel/Output/HTML/ArticleCheck/SMIME.pm
        '"S/MIME SIGNED MESSAGE" header found, but invalid!' => '',
        'Ticket decrypted before' => '',
        'Impossible to decrypt: private key for email was not found!' => '',
        'Successful decryption' => '',

        # Perl Module: Kernel/Output/HTML/ArticleCompose/Crypt.pm
        'Crypt' => 'Šifra',

        # Perl Module: Kernel/Output/HTML/ArticleCompose/Sign.pm
        'Sign' => 'Potpis',

        # Perl Module: Kernel/Output/HTML/Dashboard/CustomerUserList.pm
        'Shown customer users' => 'Prikazani klijenti korisnici',

        # Perl Module: Kernel/Output/HTML/Dashboard/EventsTicketCalendar.pm
        'The start time of a ticket has been set after the end time!' => 'Vreme početka tiketa je podešeno posle vremena završetka!',

        # Perl Module: Kernel/Output/HTML/Dashboard/TicketGeneric.pm
        'Shown Tickets' => 'Prikazani tiketi',
        'Shown Columns' => 'Prikazane kolone',
        'sorted ascending' => 'sortirano rastuće',
        'sorted descending' => 'sortirano opadajuće',
        'filter not active' => 'filter nije aktivan',
        'filter active' => 'filter je aktivan',
        'This ticket has no title or subject' => 'Ovaj tiket nema naslov ili predmet',

        # Perl Module: Kernel/Output/HTML/Dashboard/TicketStatsGeneric.pm
        '7 Day Stats' => 'Sedmodnevna statistika',

        # Perl Module: Kernel/Output/HTML/Dashboard/UserOnline.pm
        'Shown' => 'Prikazan',
        'This user is currently offline' => 'Ovaj korisnik je sada neaktivan',
        'This user is currently active' => 'Ovaj korisnik je sada aktivan',
        'This user is currently away' => 'Ovaj korisnik je sada odsutan',
        'This user is currently unavailable' => 'Ovaj korisnik je sada nedostupan',

        # Perl Module: Kernel/Output/HTML/Layout.pm
        'Standard' => 'Standardan',
        'h' => 'č',
        'm' => 'm',
        'hour' => 'sat',
        'minute' => 'minut',
        'd' => 'd',
        'day' => 'dan',
        'We are sorry, you do not have permissions anymore to access this ticket in its current state. You can take one of the following actions:' =>
            '',
        'This is a' => 'Ovo je',
        'email' => 'imejl',
        'click here' => 'kliknite ovde',
        'to open it in a new window.' => 'za otvaranje u novom prozoru.',
        'Hours' => 'Sati',
        'Minutes' => 'Minuti',
        'Check to activate this date' => 'Proverite za aktiviranje ovog datuma',
        'No Permission!' => 'Nemate dozvolu!',
        'No Permission' => '',
        'Show Tree Selection' => 'Prikaži drvo selekcije',

        # Perl Module: Kernel/Output/HTML/Layout/LinkObject.pm
        'Linked as' => 'Povezano kao',
        'Search Result' => '',
        'Linked' => 'Povezano',
        'Bulk' => 'Masovno',

        # Perl Module: Kernel/Output/HTML/Layout/Ticket.pm
        'Lite' => 'Jednostavan',
        'Unread article(s) available' => 'Raspoliživi nepročitani članci',

        # Perl Module: Kernel/Output/HTML/Notification/AgentCloudServicesDisabled.pm
        'Enable cloud services to unleash all OTRS features!' => '',

        # Perl Module: Kernel/Output/HTML/Notification/AgentOTRSBusiness.pm
        '%s Upgrade to %s now! %s' => '%s ažurirajte na %s sada! %s',
        'The license for your %s is about to expire. Please make contact with %s to renew your contract!' =>
            'Licenca za vaš %s ističe uskoro. Molimo da kontaktirate %s radi obnove ugovora!',
        'An update for your %s is available, but there is a conflict with your framework version! Please update your framework first!' =>
            'Ažuriranje za vašu %s je dostupno, ali postoji neusaglašenost sa verzijom vašeg sistema! Molimo da prvo ažurirate strukturu vašeg sisitema!',

        # Perl Module: Kernel/Output/HTML/Notification/AgentOnline.pm
        'Online Agent: %s' => 'Operater na vezi: %s',

        # Perl Module: Kernel/Output/HTML/Notification/AgentTicketEscalation.pm
        'There are more escalated tickets!' => 'Ima još eskaliralih tiketa!',

        # Perl Module: Kernel/Output/HTML/Notification/AgentTimeZoneCheck.pm
        'Please select a time zone in your preferences and confirm it by clicking "Update".' =>
            '',

        # Perl Module: Kernel/Output/HTML/Notification/CustomerOnline.pm
        'Online Customer: %s' => 'Klijent na vezi: %s',

        # Perl Module: Kernel/Output/HTML/Notification/CustomerSystemMaintenanceCheck.pm
        'A system maintenance period will start at: ' => 'Period održavanja sistema će otpočeti u:',

        # Perl Module: Kernel/Output/HTML/Notification/DaemonCheck.pm
        'OTRS Daemon is not running.' => '„OTRS” servis ne radi.',

        # Perl Module: Kernel/Output/HTML/Notification/OutofOfficeCheck.pm
        'You have Out of Office enabled, would you like to disable it?' =>
            'Aktivirana je opcija "Van kancelarije", želite li da je isključite?',

        # Perl Module: Kernel/Output/HTML/Notification/UIDCheck.pm
        'Don\'t use the Superuser account to work with OTRS! Create new Agents and work with these accounts instead.' =>
            'Ne koristite superkorisnički nalog za rad sa „OTRS”! Napravite nove naloge za operatere i koristite njih.',

        # Perl Module: Kernel/Output/HTML/Preferences/ColumnFilters.pm
        'Preferences updated successfully!' => 'Podešavanja su uspešno ažurirana!',

        # Perl Module: Kernel/Output/HTML/Preferences/Language.pm
        '(in process)' => '(u toku)',

        # Perl Module: Kernel/Output/HTML/Preferences/NotificationEvent.pm
        'Please make sure you\'ve chosen at least one transport method for mandatory notifications.' =>
            'Molimo vas da proverite da ste izabrali bar jedan metod transporta za obavezna obaveštenja.',

        # Perl Module: Kernel/Output/HTML/Preferences/OutOfOffice.pm
        'Please specify an end date that is after the start date.' => 'Molimo da odredite datum završetka koji je posle datuma početka.',

        # Perl Module: Kernel/Output/HTML/Preferences/Password.pm
        'Current password' => 'Sadašnja lozinka',
        'New password' => 'Nova lozinka',
        'Verify password' => 'Potvrdi lozinku',
        'The current password is not correct. Please try again!' => 'Uneta lozinka je netačna. Molimo pokušajte ponovo!',
        'Please supply your new password!' => 'Molimo da obezbedite novu lozinku!',
        'Can\'t update password, your new passwords do not match. Please try again!' =>
            'Lozinka ne može biti ažurirana, novi unosi su različiti. Molimo pokušajte ponovo!',
        'This password is forbidden by the current system configuration. Please contact the administrator if you have additional questions.' =>
            '',
        'Can\'t update password, it must be at least %s characters long!' =>
            'Lozinka ne može biti ažurirana. Minimalna dužina lozinke je %s znakova.',
        'Can\'t update password, it must contain at least 2 lowercase and 2 uppercase letter characters!' =>
            '',
        'Can\'t update password, it must contain at least 1 digit!' => 'Lozinka ne može biti ažurirana. Mora da sadrži najnmanje jednu brojku.',
        'Can\'t update password, it must contain at least 2 letter characters!' =>
            '',

        # Perl Module: Kernel/Output/HTML/Preferences/TimeZone.pm
        'Time zone updated successfully!' => '',

        # Perl Module: Kernel/Output/HTML/Statistics/View.pm
        'invalid' => 'nevažeći',
        'valid' => 'važeći',
        'No (not supported)' => '',
        'No past complete or the current+upcoming complete relative time value selected.' =>
            'Nije odabrana vremenska vrednost sa kompletnom prošlošću ili kompletnim trenutnim i budućim relativnim periodom.',
        'The selected time period is larger than the allowed time period.' =>
            'Izabrani vremenski period je duži od dozvoljenog.',
        'No time scale value available for the current selected time scale value on the X axis.' =>
            'Nema dostupnog vremenskog opsega za aktuelnu izabranu vrednost opsega na X osi.',
        'The selected date is not valid.' => 'Izabrani datum nije važeći.',
        'The selected end time is before the start time.' => 'Izabrano vreme završetka je pre vremena početka.',
        'There is something wrong with your time selection.' => 'Nešto nije u redu sa vašim izborom vremena.',
        'Please select only one element or allow modification at stat generation time.' =>
            'Molimo da izaberete samo jedan element ili dozvolite izmene u vreme generisanja starta!',
        'Please select at least one value of this field or allow modification at stat generation time.' =>
            'Molimo da izaberete barem jednu vrednost ovog polja ili dozvolite izmenu u vreme generisanja statistike.',
        'Please select one element for the X-axis.' => 'Molimo da izaberete jedan element za X-osu.',
        'You can only use one time element for the Y axis.' => 'Možete koristiti samo jedan vremenski element za Y osu.',
        'You can only use one or two elements for the Y axis.' => 'Možete da koristite samo jedan ili dva elementa za Y osu.',
        'Please select at least one value of this field.' => 'Molimo da izaberete bar jednu vrednost za ovo polje.',
        'Please provide a value or allow modification at stat generation time.' =>
            'Molimo da obezbedite vrednost ili dozvolite izmene u vreme generisanja starta.',
        'Please select a time scale.' => 'Molimo da odaberete vremenski opseg.',
        'Your reporting time interval is too small, please use a larger time scale.' =>
            'Vaš interval izveštavanja je prekratak, molimo upotrebite veći raspon vremena.',
        'second(s)' => 'sekunde(e)',
        'quarter(s)' => 'tromesečje(a)',
        'half-year(s)' => 'polugodište(a)',
        'Please remove the following words because they cannot be used for the ticket restrictions: %s.' =>
            'Molimo da uklonite sledeće reči jer se ne mogu koristiti zbog ograničenja tiketa: %s.',

        # Perl Module: Kernel/Output/HTML/TicketMenu/Lock.pm
        'Unlock to give it back to the queue' => 'Otključajte za vraćanje u red',
        'Lock it to work on it' => 'Zaključajte za rad na tiketu',

        # Perl Module: Kernel/Output/HTML/TicketMenu/TicketWatcher.pm
        'Unwatch' => 'Prekini nadzor',
        'Remove from list of watched tickets' => 'Ukloni sa liste praćenih tiketa',
        'Watch' => 'Posmatraj',
        'Add to list of watched tickets' => 'Dodaj na listu praćenih tiketa',

        # Perl Module: Kernel/Output/HTML/TicketOverviewMenu/Sort.pm
        'Order by' => 'Sortiraj po',

        # Perl Module: Kernel/Output/HTML/TicketZoom/TicketInformation.pm
        'Ticket Information' => 'Informacije o tiketu',

        # Perl Module: Kernel/Output/HTML/ToolBar/TicketLocked.pm
        'Locked Tickets New' => 'Novi zaključani tiketi',
        'Locked Tickets Reminder Reached' => 'Dostignut podsetnik zaključanih tiketa',
        'Locked Tickets Total' => 'Ukupno zaključnih tiketa',

        # Perl Module: Kernel/Output/HTML/ToolBar/TicketResponsible.pm
        'Responsible Tickets New' => 'Novi odgovorni tiketi',
        'Responsible Tickets Reminder Reached' => 'Dostignut podsetnik odgovornih tiketa',
        'Responsible Tickets Total' => 'Ukupno odgovornih tiketa',

        # Perl Module: Kernel/Output/HTML/ToolBar/TicketWatcher.pm
        'Watched Tickets New' => 'Novi praćeni tiketi',
        'Watched Tickets Reminder Reached' => 'Dostignut podsetnik praćenih tiketa',
        'Watched Tickets Total' => 'Ukupno praćenih tiketa',

        # Perl Module: Kernel/System/Auth.pm
        'It is currently not possible to login due to a scheduled system maintenance.' =>
            'Prijava trenutno nije moguća zbog planiranog održavanja sistema.',

        # Perl Module: Kernel/System/AuthSession/DB.pm
        'Session invalid. Please log in again.' => 'Sesija je nevažeća. Molimo prijavite se ponovo.',
        'Session has timed out. Please log in again.' => 'Vreme sesije je isteklo. Molimo prijavite se ponovo.',
        'Session limit reached! Please try again later.' => 'Sesija je istekla! Molimo pokušajte kasnije!',
        'Session per user limit reached!' => '',

        # Perl Module: Kernel/System/Console/Command/Dev/Tools/Config2Docbook.pm
        'Configuration Options Reference' => 'Referentni spisak konfiguracionih opcija',
        'This setting can not be changed.' => 'Ovo podešavanje se ne može menjati.',
        'This setting is not active by default.' => 'Ovo podešavanje nije podrazumevano aktivno.',
        'This setting can not be deactivated.' => 'Ovo podešavanje se ne može deaktivirati.',

        # Perl Module: Kernel/System/DynamicField/Driver/BaseDateTime.pm
        'in more than ...' => 'u više od ...',
        'before/after' => 'pre/posle',
        'between' => 'između',

        # Perl Module: Kernel/System/DynamicField/Driver/TextArea.pm
        'This field is required or' => 'Ovo polje je obavezno ili',
        'The field content is too long!' => 'Sadržaj polja je predugačak!',
        'Maximum size is %s characters.' => 'Maksimalna veličina je %s karaktera.',

        # Perl Module: Kernel/System/Package.pm
        'not installed' => 'nije instalirano',
        'installed' => 'instalirano',
        'Unable to parse repository index document.' => 'Nije moguće raščlaniti spremište indeksa dokumenta.',
        'No packages for your framework version found in this repository, it only contains packages for other framework versions.' =>
            'Nema paketa za verziju vašeg sistema, u spremištu su samo paketi za druge verzije.',
        '<br>If you continue to install this package, the following issues may occur!<br><br>&nbsp;-Security problems<br>&nbsp;-Stability problems<br>&nbsp;-Performance problems<br><br>Please note that issues that are caused by working with this package are not covered by OTRS service contracts!<br><br>' =>
            '<br>Ako nastavite da instalirate ovaj paket, mogu se javiti sledeći problemi!<br><br>&nbsp;-Bezbednosni problemi<br>&nbsp;-Problemi stabilnosti<br>&nbsp;-Problemi u performansama<br><br>Napominjemo da problemi nastali usled rada sa ovim paketom nisu pokriveni OTRS servisnim ugovorom!<br><br>',

        # Perl Module: Kernel/System/Registration.pm
        'Can\'t contact registration server. Please try again later.' => 'Ne možete da kontaktirate server za registraciju. Molimo pokušajte ponovo kasnije.',
        'No content received from registration server. Please try again later.' =>
            'Sadržaj nije primljen od servera za registraciju. Molimo pokušajte ponovo kasnije.',
        'Can\'t get Token from sever' => '',
        'Username and password do not match. Please try again.' => 'Korisničko ime i lozinka se ne poklapaju. Molimo pokušajte ponovo.',
        'Problems processing server result. Please try again later.' => 'Problemi u obradi rezultata servera. Molimo pokušajte ponovo kasnije.',

        # Perl Module: Kernel/System/Stats.pm
        'week' => 'nedelja',
        'quarter' => 'tromesečje',
        'half-year' => 'polugodište',

        # Perl Module: Kernel/System/Stats/Dynamic/Ticket.pm
        'State Type' => 'Tip statusa',
        'Created Priority' => 'Napravljeni prioriteti',
        'Created State' => 'Kreirani status',
        'CustomerUserLogin' => 'Prijava klijenta korisnika',
        'Create Time' => 'Vreme kreiranja',
        'Until Time' => '',
        'Close Time' => 'Vreme zatvaranja',
        'Escalation' => 'Eskalacija',
        'Escalation - First Response Time' => 'Eskalacija - vreme prvog odziva',
        'Escalation - Update Time' => 'Eskalacija - vreme ažuriranja',
        'Escalation - Solution Time' => 'Eskalacija - vreme rešavanja',
        'Agent/Owner' => 'Operater/Vlasnik',
        'Created by Agent/Owner' => 'Kreirao Operater/Vlasnik',

        # Perl Module: Kernel/System/Stats/Dynamic/TicketAccountedTime.pm
        'Evaluation by' => 'Procenio',
        'Ticket/Article Accounted Time' => 'Obračunato vreme',
        'Ticket Create Time' => 'Vreme otvaranja tiketa',
        'Ticket Close Time' => 'Vreme zatvaranja tiketa',
        'Accounted time by Agent' => 'Obračunato vreme po operateru',
        'Total Time' => '',
        'Ticket Average' => '',
        'Ticket Min Time' => '',
        'Ticket Max Time' => '',
        'Number of Tickets' => '',
        'Article Average' => '',
        'Article Min Time' => '',
        'Article Max Time' => '',
        'Number of Articles' => '',

        # Perl Module: Kernel/System/Stats/Dynamic/TicketList.pm
        'unlimited' => '',
        'ascending' => '',
        'descending' => '',
        'Attributes to be printed' => 'Atributi za štampu',
        'Sort sequence' => 'Redosled sortiranja',
        'State Historic' => 'Istorijat statusa',
        'State Type Historic' => 'Istorijat tipa statusa',
        'Until times' => '',
        'Historic Time Range' => 'Vremenski opseg istorijata',

        # Perl Module: Kernel/System/Stats/Dynamic/TicketSolutionResponseTime.pm
        'Solution Average' => '',
        'Solution Min Time' => '',
        'Solution Max Time' => '',
        'Solution Average (affected by escalation configuration)' => '',
        'Solution Min Time (affected by escalation configuration)' => '',
        'Solution Max Time (affected by escalation configuration)' => '',
        'Solution Working Time Average (affected by escalation configuration)' =>
            '',
        'Solution Min Working Time (affected by escalation configuration)' =>
            '',
        'Solution Max Working Time (affected by escalation configuration)' =>
            '',
        'Response Average (affected by escalation configuration)' => '',
        'Response Min Time (affected by escalation configuration)' => '',
        'Response Max Time (affected by escalation configuration)' => '',
        'Response Working Time Average (affected by escalation configuration)' =>
            '',
        'Response Min Working Time (affected by escalation configuration)' =>
            '',
        'Response Max Working Time (affected by escalation configuration)' =>
            '',
        'Number of Tickets (affected by escalation configuration)' => '',

        # Perl Module: Kernel/System/Stats/Static/StateAction.pm
        'Days' => 'Dani',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/OutdatedTables.pm
        'Outdated Tables' => '',
        'Outdated tables were found in the database. These can be removed if empty.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/TablePresence.pm
        'Table Presence' => 'Prisustvo tabele',
        'Internal Error: Could not open file.' => 'Interna greška: Nije moguće otvoriti datoteku.',
        'Table Check' => 'Provera tabele',
        'Internal Error: Could not read file.' => 'Interna greška: Nije moguće pročitati datoteku.',
        'Tables found which are not present in the database.' => 'Pronađene tabele koje nisu prisutne u bazi podataka.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mssql/Size.pm
        'Database Size' => 'Veličina baze podataka',
        'Could not determine database size.' => 'Nije moguće utvrditi veličinu baze podataka.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mssql/Version.pm
        'Database Version' => 'Verzija baze podataka',
        'Could not determine database version.' => 'Nije moguće utvrditi verziju baze podataka',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/Charset.pm
        'Client Connection Charset' => 'Karakterset za povezivanje klijenta',
        'Setting character_set_client needs to be utf8.' => 'Podešavanje character_set_client mora biti utf8.',
        'Server Database Charset' => 'Karakterset serverske baze podataka',
        'Setting character_set_database needs to be UNICODE or UTF8.' => 'Podešavanje character_set_database mora biti UNICODE ili UTF8.',
        'Table Charset' => 'Tabela karakterseta',
        'There were tables found which do not have utf8 as charset.' => 'Pronađene su tabele koje nemaju utf8 kao karakterset.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/InnoDBLogFileSize.pm
        'InnoDB Log File Size' => 'Veličina InnoDB datoteke dnevnika',
        'The setting innodb_log_file_size must be at least 256 MB.' => 'Podešavanje „innodb_log_file_size” mora biti barem 256 MB.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/MaxAllowedPacket.pm
        'Maximum Query Size' => 'Maksimalna veličina upita',
        'The setting \'max_allowed_packet\' must be higher than 20 MB.' =>
            'Podešavanje \'max_allowed_packet\' mora biti veće od 20 MB.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/Performance.pm
        'Query Cache Size' => 'Veličina keš upita',
        'The setting \'query_cache_size\' should be used (higher than 10 MB but not more than 512 MB).' =>
            'Podešavanje \'query_cache_size\' mora biti korišćeno (veće od 10 MB, ali ne više od 512 MB)',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/StorageEngine.pm
        'Default Storage Engine' => 'Podrazumevani mehanizam za skladištenje',
        'Table Storage Engine' => 'Mehanizam za skladištenje tabele',
        'Tables with a different storage engine than the default engine were found.' =>
            'Pronađene su tabele sa različitim mehanizmom za skladištenje nego što je predefinisani mehanizam.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/mysql/Version.pm
        'MySQL 5.x or higher is required.' => 'Neophodan je MySQL 5.x ili više.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/oracle/NLS.pm
        'NLS_LANG Setting' => 'NLS_LANG podešavanje',
        'NLS_LANG must be set to al32utf8 (e.g. GERMAN_GERMANY.AL32UTF8).' =>
            'NLS_LANG mora biti podešen na al32utf8 (npr. GERMAN_GERMANY.AL32UTF8).',
        'NLS_DATE_FORMAT Setting' => 'NLS_DATE_FORMAT podešavanje',
        'NLS_DATE_FORMAT must be set to \'YYYY-MM-DD HH24:MI:SS\'.' => 'NLS_DATE_FORMAT mora biti podešen na \'YYYY-MM-DD HH24:MI:SS\'.',
        'NLS_DATE_FORMAT Setting SQL Check' => 'SQL provera NLS_DATE_FORMAT podešavanja',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/postgresql/Charset.pm
        'Setting client_encoding needs to be UNICODE or UTF8.' => 'Podešavanje client_encoding mora biti UNICODE ili UTF8.',
        'Setting server_encoding needs to be UNICODE or UTF8.' => 'Podešavanje server_encoding mora biti UNICODE ili UTF8.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/postgresql/DateStyle.pm
        'Date Format' => 'Format datuma',
        'Setting DateStyle needs to be ISO.' => 'Podešavanje DateStyle mora biti ISO',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Database/postgresql/Version.pm
        'PostgreSQL 8.x or higher is required.' => 'Preporučeno je PostgreSQL 8.x ili više.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/DiskPartitionOTRS.pm
        'OTRS Disk Partition' => 'OTRS particija na disku',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/DiskSpace.pm
        'Disk Usage' => 'Korišćenje diska',
        'The partition where OTRS is located is almost full.' => 'Particija na kojoj je smešten OTRS je skoro puna.',
        'The partition where OTRS is located has no disk space problems.' =>
            'Particija na kojoj je smešten OTRS nema probleme sa prostorom.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/DiskSpacePartitions.pm
        'Operating System/Disk Partitions Usage' => 'Operativni sistem/Korišćenje particije na disku',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/Distribution.pm
        'Distribution' => 'Raspodela',
        'Could not determine distribution.' => 'Nije moguće utvrditi raspodelu.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/KernelVersion.pm
        'Kernel Version' => 'Kernel verzija',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/Load.pm
        'System Load' => 'Opterećenje sistema',
        'The system load should be at maximum the number of CPUs the system has (e.g. a load of 8 or less on a system with 8 CPUs is OK).' =>
            'Opterećenje sistema može biti najviše broj procesora koje sistem poseduje (npr. opterećenje od 8 ili manje na sistemu sa 8 jezgara je u redu).',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/PerlModules.pm
        'Perl Modules' => 'Perl moduli',
        'Not all required Perl modules are correctly installed.' => 'Svi zahtevani Perl moduli nisu korektno instalirani.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OS/Swap.pm
        'Free Swap Space (%)' => 'Slobodni Swap prostor (%)',
        'No swap enabled.' => 'Razmenjivanje nije aktivirano.',
        'Used Swap Space (MB)' => 'Upotrebljen Swap prostor (MB)',
        'There should be more than 60% free swap space.' => 'Mora postojati više od 60 % slobodnog swap prostora',
        'There should be no more than 200 MB swap space used.' => 'Ne treba da bude više od 200 MB upotrebljenog Swap prostora.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/ConfigSettings.pm
        'OTRS/Config Settings' => ' „OTRS”/Konfiguraciona podešavanja',
        'Could not determine value.' => 'Nije moguće utvrditi vrednost.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/DaemonRunning.pm
        'OTRS' => 'OTRS',
        'Daemon' => 'Sistemski servis',
        'Daemon is not running.' => 'Servis ne radi.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/DatabaseRecords.pm
        'OTRS/Database Records' => ' „OTRS”/Zapisi baze podataka',
        'Tickets' => 'Tiketi',
        'Ticket History Entries' => 'Istorija unosa tiketa',
        'Articles' => 'Članci',
        'Attachments (DB, Without HTML)' => 'Prilozi (baza podataka, bez HTML)',
        'Customers With At Least One Ticket' => 'Klijenti sa bar jednim tiketom',
        'Dynamic Field Values' => 'Vrednosti dinamičkog polja',
        'Invalid Dynamic Fields' => 'Nevažeća dinamička polja.',
        'Invalid Dynamic Field Values' => 'Nevažeće vrednosti dinamičkih polja.',
        'GenericInterface Webservices' => 'GenericInterface veb servis',
        'Months Between First And Last Ticket' => 'Meseci između prvog i poslednjeg tiketa',
        'Tickets Per Month (avg)' => 'Tiketi mesečno (prosečno)',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/DefaultSOAPUser.pm
        'Default SOAP Username And Password' => 'Podrazumevano „SOAP” korisničko ime i lozinka',
        'Security risk: you use the default setting for SOAP::User and SOAP::Password. Please change it.' =>
            'Sigurnosni rizik: koristite podrazumevana podešavanja za SOAP::User i SOAP::Password. Molimo promenite ga.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/DefaultUser.pm
        'Default Admin Password' => 'Predefinisana lozinka administratora',
        'Security risk: the agent account root@localhost still has the default password. Please change it or invalidate the account.' =>
            'Sigurnosni rizik: agent nalog root@localhost još uvek ima predefinisanu lozinku. Molimo promenite je ili deaktivirajte nalog.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/ErrorLog.pm
        'Error Log' => 'Greška u prijavi',
        'There are error reports in your system log.' => 'Postoje izveštaji o greškama u vašem pristupnom sistemu.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/FQDN.pm
        'FQDN (domain name)' => ' „FQDN” (naziv domena)',
        'Please configure your FQDN setting.' => 'Molimo da podesite „FQDN” parametar.',
        'Domain Name' => 'Naziv domena',
        'Your FQDN setting is invalid.' => 'Vaša FQDN podešavanja su nevažeća.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/FileSystemWritable.pm
        'File System Writable' => 'Omogućeno pisanje u sistem datoteka.',
        'The file system on your OTRS partition is not writable.' => 'Nije moguće pisanje u sistem datoteka na vašoj OTRS particiji.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/PackageDeployment.pm
        'Package Installation Status' => 'Status instalacije paketa',
        'Some packages have locally modified files.' => 'Neki paketi sadrže lokalno izmenjene datoteke.',
        'Some packages are not correctly installed.' => 'Neki paketi nisu ispravno instalirani.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/PackageList.pm
        'OTRS/Package List' => ' „OTRS”/Lista paketa',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/SystemID.pm
        'Your SystemID setting is invalid, it should only contain digits.' =>
            'Vaša podešavanja sistemtemskog ID-a su nevažeća, treba da sadrže samo cifre.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/Ticket/DefaultType.pm
        'Default Ticket Type' => 'Podrazumevani tip tiketa',
        'The configured default ticket type is invalid or missing. Please change the setting Ticket::Type::Default and select a valid ticket type.' =>
            '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/Ticket/IndexModule.pm
        'Ticket Index Module' => 'Tiket indeks modul',
        'You have more than 60,000 tickets and should use the StaticDB backend. See admin manual (Performance Tuning) for more information.' =>
            'Imate više od 60.000 tiketa i treba da koristite StaticDB. Pogledajte administratorsko uputstvo (Podešavanje performansi) za više informacija.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/Ticket/InvalidUsersWithLockedTickets.pm
        'Invalid Users with Locked Tickets' => '',
        'There are invalid users with locked tickets.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/Ticket/OpenTickets.pm
        'Open Tickets' => 'Otvoreni tiketi',
        'You should not have more than 8,000 open tickets in your system.' =>
            'Ne bi trebalo da imate više od 8.000 otvorenih tiketa u sistemu.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/Ticket/SearchIndexModule.pm
        'Ticket Search Index Module' => 'Modul za indeksnu pretragu tiketa',
        'You have more than 50,000 articles and should use the StaticDB backend. See admin manual (Performance Tuning) for more information.' =>
            'Imate više od 50.000 članaka i treba da koristite StaticDB. Pogledajte administratorsko uputstvo (Podešavanje performansi) za više informacija.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/Ticket/StaticDBOrphanedRecords.pm
        'Orphaned Records In ticket_lock_index Table' => 'Napušteni zapisi u ticket_lock_index tabeli',
        'Table ticket_lock_index contains orphaned records. Please run bin/otrs.Console.pl "Maint::Ticket::QueueIndexCleanup" to clean the StaticDB index.' =>
            'Tabela „ticket_lock_index” sadrži nepovezane zapise. Molimo da pokrenete „bin/otrs.Console.pl” „Maint::Ticket::QueueIndexCleanup” da bi očistili „StaticDB” indeks.',
        'Orphaned Records In ticket_index Table' => 'Napušteni zapisi u ticket_index tabeli',
        'Table ticket_index contains orphaned records. Please run otrs/bin/otrs.CleanTicketIndex.pl to clean the StaticDB index.' =>
            'Tabela ticket_index sadrži napuštene zapise. Molimo pokrenite otrs/bin/otrs.CleanTicketIndex.pl da obrišete StaticDB indeks.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/OTRS/TimeSettings.pm
        'OTRS/Time Settings' => ' „OTRS”/Podešavanje vremena',
        'Server time zone' => 'Vreneska zona servera',
        'OTRS time zone' => '',
        'OTRS time zone is not set.' => '',
        'User default time zone' => '',
        'User default time zone is not set.' => '',
        'OTRS time zone setting for calendar' => '',
        'Calendar time zone is not set.' => '',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Apache/LoadedModules.pm
        'Webserver/Loaded Apache Modules' => 'Veb server/Učitani „Apache” moduli',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Apache/MPMModel.pm
        'Webserver' => 'Veb server',
        'MPM model' => 'MPM model',
        'OTRS requires apache to be run with the \'prefork\' MPM model.' =>
            'OTRS zahteva da Apache bude pokrenut sa \'prefork\' MPM modelom.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Apache/Performance.pm
        'CGI Accelerator Usage' => 'Upotreba CGI Accelerator',
        'You should use FastCGI or mod_perl to increase your performance.' =>
            'Za povećanje performansi treba da koristite FastCGI ili mod_perl.',
        'mod_deflate Usage' => 'Upotreba mod_deflate',
        'Please install mod_deflate to improve GUI speed.' => 'Molimo instalirajte mod_deflate da povećate brzinu GUI.',
        'mod_filter Usage' => 'Korišćenje „mod_filter”',
        'Please install mod_filter if mod_deflate is used.' => 'Molimo da instalirate „mod_filter” ako je „mod_deflate” upotrebljen.',
        'mod_headers Usage' => 'Upotreba mod_headers',
        'Please install mod_headers to improve GUI speed.' => 'Molimo instalirajte mod_headers da povećate brzinu GUI',
        'Apache::Reload Usage' => 'Upotreba Apache::Reload',
        'Apache::Reload or Apache2::Reload should be used as PerlModule and PerlInitHandler to prevent web server restarts when installing and upgrading modules.' =>
            'Apache::Reload ili Apache2::Reload se koriste kao Perl modul i PerlInitHandler radi zaštite od restartovanja veb servera tokom instaliranja ili nadogradnje modula.',
        'Apache2::DBI Usage' => 'Upotreba Apache2::DBI',
        'Apache2::DBI should be used to get a better performance  with pre-established database connections.' =>
            'Apache2::DBI bi trebalo koristiti za bolje performanse sa unapred uspostavljenim vezama sa bazom podataka.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/EnvironmentVariables.pm
        'Webserver/Environment Variables' => 'Veb server/Promenljive okruženja',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/IIS/Performance.pm
        'You should use PerlEx to increase your performance.' => 'Za povećanje performansi treba da koristite PerlEx.',

        # Perl Module: Kernel/System/SupportDataCollector/Plugin/Webserver/Version.pm
        'Webserver Version' => 'Veb server verzija',
        'Could not determine webserver version.' => 'Ne može da prepozna veb server verziju.',

        # Perl Module: Kernel/System/SupportDataCollector/PluginBase.pm
        'Unknown' => 'Nepoznato',
        'OK' => 'U redu',
        'Problem' => 'Problem',

        # Perl Module: Kernel/System/Ticket.pm
        'Reset of unlock time.' => '',

        # Perl Module: Kernel/System/Ticket/Event/NotificationEvent/Transport/Email.pm
        'PGP sign only' => '',
        'PGP encrypt only' => '',
        'PGP sign and encrypt' => '',
        'SMIME sign only' => '',
        'SMIME encrypt only' => '',
        'SMIME sign and encrypt' => '',
        'PGP and SMIME not enabled.' => '',
        'Skip notification delivery' => '',
        'Send unsigned notification' => '',
        'Send unencrypted notification' => '',

        # Perl Module: Kernel/System/Web/InterfaceAgent.pm
        'Login failed! Your user name or password was entered incorrectly.' =>
            'Neuspešna prijava! Netačno je uneto vaše korisničko ime ili lozinka.',
        'Panic, user authenticated but no user data can be found in OTRS DB!! Perhaps the user is invalid.' =>
            '',
        'Can`t remove SessionID.' => '',
        'Logout successful.' => '',
        'Feature not active!' => 'Funkcija nije aktivna!',
        'Sent password reset instructions. Please check your email.' => 'Uputstvo za reset lozinke je poslato. Molimo proverite vaše imejlove.',
        'Invalid Token!' => 'Nevažeći Token!',
        'Sent new password to %s. Please check your email.' => 'Poslata nova lozinka za %s. Molimo proverite vaše imejlove.',
        'Panic! Invalid Session!!!' => 'Pažnja! Nevažeća sesija!!!',
        'No Permission to use this frontend module!' => '',

        # Perl Module: Kernel/System/Web/InterfaceCustomer.pm
        'Authentication succeeded, but no customer record is found in the customer backend. Please contact the administrator.' =>
            '',
        'Reset password unsuccessful. Please contact the administrator.' =>
            '',
        'This e-mail address already exists. Please log in or reset your password.' =>
            'Ova imejl adresa već postoji. Molimo, prijavite se ili resetujte vašu lozinku.',
        'This email address is not allowed to register. Please contact support staff.' =>
            'Registracija ove imejl adrese nije dozvoljeno. Molimo da kontaktirate podršku.',
        'Added via Customer Panel (%s)' => '',
        'Customer user can\'t be added!' => '',
        'Can\'t send account info!' => '',
        'New account created. Sent login information to %s. Please check your email.' =>
            'Kreiran je novi nalog. Podaci za prijavu poslati %s. Molimo proverite vaš imejl.',

        # Perl Module: Kernel/System/Web/InterfaceInstaller.pm
        'SecureMode active!' => '',
        'If you want to re-run the Installer, disable the SecureMode in the SysConfig.' =>
            '',
        'Action "%s" not found!' => '',

        # Database XML Definition: scripts/database/otrs-initial_insert.xml
        'invalid-temporarily' => 'nevažeći-privremeno',
        'Group for default access.' => 'Grupa za podrazumevan pristup.',
        'Group of all administrators.' => 'Grupa svih administratora.',
        'Group for statistics access.' => 'Grupa za pristup statistici.',
        'new' => 'novo',
        'All new state types (default: viewable).' => 'Svi novi tipovi stanja (podrazumevano: vidljivo).',
        'open' => 'otvoreni',
        'All open state types (default: viewable).' => 'Svi otvoreni tipovi stanja (podrazumevano: vidljivo).',
        'closed' => 'zatvoreni',
        'All closed state types (default: not viewable).' => 'Svi zatvoreni tipovi stanja (podrazumevano: vidljivo).',
        'pending reminder' => 'podsetnik čekanja',
        'All \'pending reminder\' state types (default: viewable).' => 'Svi tipovi stanja „podsetnik na čekanju” (podrazumevano: vidljivo).',
        'pending auto' => 'automatsko čekanje',
        'All \'pending auto *\' state types (default: viewable).' => 'Svi tipovi stanja „podsetnik automatski *” (podrazumevano: vidljivo).',
        'removed' => 'uklonjeni',
        'All \'removed\' state types (default: not viewable).' => 'Svi tipovi stanja „uklonjeno” (podrazumevano: vidljivo).',
        'merged' => 'spojeno',
        'State type for merged tickets (default: not viewable).' => 'Tip stanja za spojene tikete (podrazumevano: nije vidljivo).',
        'New ticket created by customer.' => 'Novi tiket koji je kreirao klijent.',
        'closed successful' => 'uspešno zatvaranje',
        'Ticket is closed successful.' => 'Tiket je zatvoren „uspešno”.',
        'closed unsuccessful' => 'neuspešno zatvaranje',
        'Ticket is closed unsuccessful.' => 'Tiket je zatvoren „neuspešno”.',
        'Open tickets.' => 'Otvoreni tiketi.',
        'Customer removed ticket.' => 'Klijent je uklonio tiket.',
        'Ticket is pending for agent reminder.' => 'Tiket je na čekanju za operaterski podsetnik.',
        'pending auto close+' => 'čekanje na automatsko zatvaranje+',
        'Ticket is pending for automatic close.' => 'Tiket je na čekanju za automatsko zatvaranje.',
        'pending auto close-' => 'čekanje na automatsko zatvaranje-',
        'State for merged tickets.' => 'Status za spojene tikete.',
        'system standard salutation (en)' => 'standardni sistemski pozdrav (en)',
        'Standard Salutation.' => 'Standardni Pozdrav',
        'system standard signature (en)' => 'standardni sistemski potpis (en)',
        'Standard Signature.' => 'Standardni potpis.',
        'Standard Address.' => 'Standardna adresa.',
        'possible' => 'moguće',
        'Follow-ups for closed tickets are possible. Ticket will be reopened.' =>
            'Nastavljanje na zatvorene tikete je moguće. Tiketi će biti ponovo otvoreni.',
        'reject' => 'odbaci',
        'Follow-ups for closed tickets are not possible. No new ticket will be created.' =>
            'Nastavljanje na zatvorene tikete nije moguće. Novi tiket neće biti kreiran.',
        'new ticket' => 'novi tiket',
        'Follow-ups for closed tickets are not possible. A new ticket will be created..' =>
            'Nastavljanje na zatvorene tikete nije moguće. Novi tiket će biti kreiran.',
        'Postmaster queue.' => '„Postmaster” red.',
        'All default incoming tickets.' => ' Svi podrazumevani dolazni tiketi.',
        'All junk tickets.' => 'Svi besmisleni tiketi „junk”.',
        'All misc tickets.' => 'Svi drugi tiketi.',
        'auto reply' => 'automatski odgovor',
        'Automatic reply which will be sent out after a new ticket has been created.' =>
            'Automatski odgovor koji će biti poslat posle kreiranja novog tiketa.',
        'auto reject' => 'automatsko odbacivanje',
        'Automatic reject which will be sent out after a follow-up has been rejected (in case queue follow-up option is "reject").' =>
            'Automatska poruka koja će biti poslata nakon odbacivanja nastavka (u slučaju da je opcija nastavka za red postavljena na "odbaci").',
        'auto follow up' => 'automatsko praćenje',
        'Automatic confirmation which is sent out after a follow-up has been received for a ticket (in case queue follow-up option is "possible").' =>
            'Automatska potvrda koja će biti poslata nakon primanja nastavka u tiketu (u slučaju da je opcija nastavka za red postavljena na "moguće").',
        'auto reply/new ticket' => 'automatski odgovor/novi tiket',
        'Automatic response which will be sent out after a follow-up has been rejected and a new ticket has been created (in case queue follow-up option is "new ticket").' =>
            'Automatski odgovor koji će biti poslat nakon odbacivanja nastavka i kreiranja novog tiketa (u slučaju da je opcija nastavka za red postavljena na "novi tiket").',
        'auto remove' => 'automatsko uklanjanje',
        'Auto remove will be sent out after a customer removed the request.' =>
            'Automatsko uklanjanje će biti poslato kad klijent ukloni zahtev.',
        'default reply (after new ticket has been created)' => 'podrazumevani odgovor (posle kreiranja novog tiketa)',
        'default reject (after follow-up and rejected of a closed ticket)' =>
            'podrazumevano odbacivanje (posle nastavljanja i odbacivanja zatvorenog tiketa)',
        'default follow-up (after a ticket follow-up has been added)' => 'podrazumevano nastvljanje (posle dodavanja nastavljanja na tiket)',
        'default reject/new ticket created (after closed follow-up with new ticket creation)' =>
            'podrazumevano odbacivanje/kreiran novi tiket (posle zatvorenog nastavljanja sa kreiranjem novog tiketa)',
        'Unclassified' => 'Nerazvrstano',
        '1 very low' => '1 vrlo nizak',
        '2 low' => '2 nizak',
        '3 normal' => '3 normalan',
        '4 high' => '4 visok',
        '5 very high' => '5 vrlo visok',
        'unlock' => 'otključan',
        'lock' => 'zaključan',
        'tmp_lock' => 'tmp_lock',
        'email-external' => 'elektronska pošta-eksterna',
        'email-internal' => 'elektronska pošta-interna',
        'email-notification-ext' => 'email-notification-ext',
        'email-notification-int' => 'email-notification-int',
        'agent' => 'operater',
        'system' => 'sistem',
        'customer' => 'klijent',
        'Ticket create notification' => 'Obaveštenje o kreiranju tiketa',
        'You will receive a notification each time a new ticket is created in one of your "My Queues" or "My Services".' =>
            '',
        'Ticket follow-up notification (unlocked)' => 'Obaveštenje o nastavljanju tiketa (otključano)',
        'You will receive a notification if a customer sends a follow-up to an unlocked ticket which is in your "My Queues" or "My Services".' =>
            '',
        'Ticket follow-up notification (locked)' => 'Obaveštenje o nastavljanju tiketa (zaključano)',
        'You will receive a notification if a customer sends a follow-up to a locked ticket of which you are the ticket owner or responsible.' =>
            '',
        'Ticket lock timeout notification' => 'Obaveštenje o isticanju zaključavanja tiketa',
        'You will receive a notification as soon as a ticket owned by you is automatically unlocked.' =>
            '',
        'Ticket owner update notification' => 'Obaveštenje o ažuriranju vlasnika tiketa',
        'Ticket responsible update notification' => 'Obaveštenje o ažuriranju odgovornog za tiket',
        'Ticket new note notification' => 'Obaveštenje o novoj napomeni tiketa',
        'Ticket queue update notification' => 'Obaveštenje o ažuriranju reda tiketa',
        'You will receive a notification if a ticket is moved into one of your "My Queues".' =>
            '',
        'Ticket pending reminder notification (locked)' => 'Obaveštenje - podsetnik tiketa na čekanju (zaključano)',
        'Ticket pending reminder notification (unlocked)' => 'Obaveštenje - podsetnik tiketa na čekanju (otključano)',
        'Ticket escalation notification' => 'Obaveštenje o eskalaciji tiketa',
        'Ticket escalation warning notification' => 'Obaveštenje o upozorenju na eskalaciju tiketa',
        'Ticket service update notification' => 'Obaveštenje o ažuriranju usluge tiketa',
        'You will receive a notification if a ticket\'s service is changed to one of your "My Services".' =>
            '',

        # JS File: Core.AJAX
        'Error during AJAX communication. Status: %s, Error: %s' => '',

        # JS File: Core.Agent.Admin.ACL
        'Add all' => 'Dodaj sve',
        'An item with this name is already present.' => 'Već je prisutna tavka pod ovim imenom.',
        'This item still contains sub items. Are you sure you want to remove this item including its sub items?' =>
            'Ova stavka i dalje sadrži podstavke. Da li ste sigurni da želite da uklonite ovu stavku uključujući i njene podstavke?',

        # JS File: Core.Agent.Admin.Attachment
        'Do you really want to delete this attachment?' => '',

        # JS File: Core.Agent.Admin.DynamicField
        'Do you really want to delete this dynamic field? ALL associated data will be LOST!' =>
            'Da li zaista želite da obrišete ovo dinamičko polje? Svi povezani podaci će biti IZGUBLJENI!',
        'Delete field' => 'Obriši polje',
        'Deleting the field and its data. This may take a while...' => '',

        # JS File: Core.Agent.Admin.GenericAgent
        'Remove selection' => 'Ukloni izbor',
        'Delete this Event Trigger' => 'Obriši ovaj okidač događaja',
        'Duplicate event.' => 'Napravi duplikat događaja.',
        'This event is already attached to the job, Please use a different one.' =>
            'Ovaj događaj je priložen poslu. Molimo koristite neki drugi.',

        # JS File: Core.Agent.Admin.GenericInterfaceDebugger
        'An error occurred during communication.' => 'Došlo je do greške prilikom komunikacije.',
        'Show or hide the content.' => 'Pokaži ili sakrij sadržaj.',
        'Clear debug log' => 'Očisti otklanjanje grešaka u logu',

        # JS File: Core.Agent.Admin.GenericInterfaceInvoker
        'Delete this Invoker' => 'Obriši ovog pozivaoca',

        # JS File: Core.Agent.Admin.GenericInterfaceOperation
        'Delete this Operation' => 'Obriši ovu operaciju',

        # JS File: Core.Agent.Admin.GenericInterfaceWebservice
        'Delete webservice' => 'Obriši veb servis',
        'Clone webservice' => 'Kloniraj veb servis',
        'Import webservice' => 'Uvezi veb servis',
        'Delete operation' => 'Obriši operaciju',
        'Delete invoker' => 'Obriši pozivaoca',

        # JS File: Core.Agent.Admin.Group
        'WARNING: When you change the name of the group \'admin\', before making the appropriate changes in the SysConfig, you will be locked out of the administrations panel! If this happens, please rename the group back to admin per SQL statement.' =>
            'UPOZORENJE: Ako promenite ime grupe \'admin\' pre adekvatnog podešavanja u sistemskoj konfiguraciji, izgubićete pristup administrativnom panelu! Ukoliko se to desi, vratite ime grupi u "admin" pomoću SQL komande.',
        'Confirm' => 'Potvrdi',

        # JS File: Core.Agent.Admin.NotificationEvent
        'Do you really want to delete this notification language?' => 'Da li zaista želite da izbrišete ovaj jezik za obaveštenja?',
        'Do you really want to delete this notification?' => 'Da li stvarno želite da obrišete ovo obaveštenje?',

        # JS File: Core.Agent.Admin.PostMasterFilter
        'Do you really want to delete this filter?' => '',

        # JS File: Core.Agent.Admin.ProcessManagement.Canvas
        'Remove Entity from canvas' => 'Ukloni objekat sa površine',
        'No TransitionActions assigned.' => 'Nema dodeljenih tranzicionih aktivnosti.',
        'No dialogs assigned yet. Just pick an activity dialog from the list on the left and drag it here.' =>
            'Još uvek nema dodeljenih dijaloga. Samo izaberite jedan dijalog aktivnosti iz liste sa leve strane i prevucite ga ovde.',
        'This Activity cannot be deleted because it is the Start Activity.' =>
            'Ova aktivnost se ne može brisati, zato što je to početak aktivnosti.',
        'Remove the Transition from this Process' => 'Ukloni tranziciju iz ovog procesa',

        # JS File: Core.Agent.Admin.ProcessManagement
        'As soon as you use this button or link, you will leave this screen and its current state will be saved automatically. Do you want to continue?' =>
            'Ukoliko koristite ovo dugme ili vezu, napustićete ekran i njegov trenutni sadržaj će biti automatski sačuvan. Želite li da nastavite?',
        'Delete Entity' => 'Izbriši objekat',
        'This Activity is already used in the Process. You cannot add it twice!' =>
            'Ova aktivnost je već korišćena u procesu. Ne možete je dodavati dva puta.',
        'Error during AJAX communication' => '',
        'An unconnected transition is already placed on the canvas. Please connect this transition first before placing another transition.' =>
            'Nepovezana tranzicija je već postavljena na površinu. Molimo povežite prvu tranziciju pre nego što postavite drugu tranziciju.',
        'This Transition is already used for this Activity. You cannot use it twice!' =>
            'Ova tranzicija je već korišćena za ovu aktivnost. Ne možete je koristiti dva puta.',
        'This TransitionAction is already used in this Path. You cannot use it twice!' =>
            'Ova tranziciona tktivnost je već korišćena u ovoj putanji. Ne možete je koristiti dva puta.',
        'Hide EntityIDs' => 'Sakrij ID-ove objekta',
        'Edit Field Details' => 'Uredi detalje polja',
        'Customer interface does not support internal article types.' => 'Klijentski interfejs ne podržava interne tipove članka.',
        'Sorry, the only existing condition can\'t be removed.' => '',
        'Sorry, the only existing field can\'t be removed.' => '',
        'Sorry, the only existing parameter can\'t be removed.' => '',

        # JS File: Core.Agent.Admin.SMIME
        'Do you really want to delete this certificate?' => '',

        # JS File: Core.Agent.Admin.SysConfig
        'Show more' => 'Prikaži više',

        # JS File: Core.Agent.Admin.SystemMaintenance
        'Do you really want to delete this scheduled system maintenance?' =>
            'Da li stvarno želite da obrišete ovo planirano oržavanje sistema?',

        # JS File: Core.Agent.CustomerInformationCenterSearch
        'Loading...' => 'Učitavanje...',

        # JS File: Core.Agent.CustomerSearch
        'Duplicated entry' => 'Dvostruki unos',
        'It is going to be deleted from the field, please try again.' => 'Biće obrisano iz polja, molimo pokušajte ponovo.',

        # JS File: Core.Agent.Daemon
        'Information about the OTRS Daemon' => 'Informacije o „OTRS” servisu',

        # JS File: Core.Agent.Dashboard
        'Please check the fields marked as red for valid inputs.' => 'Molimo proverite polja označena crvenim za važeće unose.',
        'All-day' => 'Celodnevno',
        'Jan' => 'Jan',
        'Feb' => 'Feb',
        'Mar' => 'Mar',
        'Apr' => 'Apr',
        'May' => 'Maj',
        'Jun' => 'Jun',
        'Jul' => 'Jul',
        'Aug' => 'Avg',
        'Sep' => 'Sep',
        'Oct' => 'Okt',
        'Nov' => 'Nov',
        'Dec' => 'Dec',
        'January' => 'januar',
        'February' => 'februar',
        'March' => 'mart',
        'April' => 'april',
        'May_long' => 'maj',
        'June' => 'jun',
        'July' => 'jul',
        'August' => 'avgust',
        'September' => 'septembar',
        'October' => 'oktobar',
        'November' => 'novembar',
        'December' => 'decembar',
        'Sunday' => 'nedelja',
        'Monday' => 'ponedeljak',
        'Tuesday' => 'utorak',
        'Wednesday' => 'sreda',
        'Thursday' => 'četvrtak',
        'Friday' => 'petak',
        'Saturday' => 'subota',
        'Su' => 'ne',
        'Mo' => 'po',
        'Tu' => 'ut',
        'We' => 'sr',
        'Th' => 'če',
        'Fr' => 'pe',
        'Sa' => 'su',
        'month' => 'mesec',

        # JS File: Core.Agent.LinkObject.SearchForm
        'Please enter at least one search value or * to find anything.' =>
            'Molimo unesite barem jednu vrednost pretrage ili * da bi ste nešto pronašli.',

        # JS File: Core.Agent.Login
        'Are you using a browser plugin like AdBlock or AdBlockPlus? This can cause several issues and we highly recommend you to add an exception for this domain.' =>
            '',
        'Do not show this warning again.' => '',

        # JS File: Core.Agent.Preferences
        'Sorry, but you can\'t disable all methods for notifications marked as mandatory.' =>
            'Izvinite ali ne možete isključiti sve metode za obaveštenja označena kao obavezna.',
        'Sorry, but you can\'t disable all methods for this notification.' =>
            'Izvinite ali ne možete isključiti sve metode za ovo obaveštenje.',

        # JS File: Core.Agent.Responsive
        'Switch to desktop mode' => 'Pređi na desktop mod',

        # JS File: Core.Agent.Search
        'Please remove the following words from your search as they cannot be searched for:' =>
            'Molimo da uklonite sledeće reči iz vaše pretrage jer se ne mogu tražiti:',

        # JS File: Core.Agent.Statistics
        'Do you really want to delete this statistic?' => 'Da li stvarno želite da obrišete ovu statistiku?',

        # JS File: Core.Agent.TicketAction
        'Please perform a spell check on the the text first.' => 'Molimo da prvo proverite pravopis na tekstu.',
        'Close this dialog' => 'Zatvori ovaj dijalog',
        'Do you really want to continue?' => 'Da li zaista želite da nastavite?',

        # JS File: Core.Agent
        'Slide the navigation bar' => 'Pomerite navigacionu traku',
        'Please turn off Compatibility Mode in Internet Explorer!' => 'Molimo da isključite mod kompatibilnosti u Internet eksploreru!',

        # JS File: Core.App.Responsive
        'Switch to mobile mode' => 'Pređi na mobilni mod',

        # JS File: Core.Customer
        'You have unanswered chat requests' => 'Imate neodgovorene zahteve za ćaskanje',

        # JS File: Core.Debug
        'Namespace %s could not be initialized, because %s could not be found.' =>
            '',

        # JS File: Core.Exception
        'An error occurred! Do you want to see the complete error message?' =>
            '',

        # JS File: Core.Form.Validate
        'One or more errors occurred!' => 'Došlo je do jedne ili više grešaka!',

        # JS File: Core.Installer
        'Mail check successful.' => 'Uspešna provera imejl podešavanja.',
        'Error in the mail settings. Please correct and try again.' => 'Greška u podešavanju imejla. Molimo ispravite i pokušajte ponovo.',

        # JS File: Core.UI.Datepicker
        'Previous' => 'Nazad',
        'Sun' => 'ned',
        'Mon' => 'pon',
        'Tue' => 'uto',
        'Wed' => 'sre',
        'Thu' => 'čet',
        'Fri' => 'pet',
        'Sat' => 'sub',
        'Open date selection' => 'Otvori izbor datuma',
        'Invalid date (need a future date)!' => 'Neispravan datum (poteban budući datum)!',
        'Invalid date (need a past date)!' => 'Neispravan datum (potreban datum u prošlosti)!',
        'Invalid date!' => 'Nevažeći datum!',

        # JS File: Core.UI.Dialog
        'Close' => 'Zatvori',

        # JS File: Core.UI.InputFields
        'Not available' => 'Nije dostupno',
        'and %s more...' => 'i %s više...',
        'Clear all' => 'Očisti sve',
        'Filters' => 'Filteri',
        'Clear search' => 'Očisti pretragu',

        # JS File: Core.UI.Popup
        'If you now leave this page, all open popup windows will be closed, too!' =>
            'Ako napustite ovu stranicu, svi otvoreni prozori će biti zatvoreni!',
        'A popup of this screen is already open. Do you want to close it and load this one instead?' =>
            'Prikaz ovog ekrana je već otvoren. Želite li da ga zatvorite i učitate ovaj umesto njega?',
        'Could not open popup window. Please disable any popup blockers for this application.' =>
            'Nije moguće otvoriti iskačući prozor. Molimo da isključite blokadu iskačućih prozora za ovu aplikaciju.',

        # JS File: Core.UI.TreeSelection
        'There are currently no elements available to select from.' => 'Trenutno nema slobodnih elemenata za odabir.',

        # SysConfig
        '
Dear Customer,

Unfortunately we could not detect a valid ticket number
in your subject, so this email can\'t be processed.

Please create a new ticket via the customer panel.

Thanks for your help!

 Your Helpdesk Team
' => '
Poštovani,

Na žalost ne možemo pronaći važeći broj tiketa
u vašem predmetu, pa ovaj imejl ne može biti obrađen.

Molimo Vas da preko klijentskog panela kreirate novi tiket.

Hvala na vašoj pomoći!

Vaša tehnička podrška
',
        ' (work units)' => '(radne jedinice)',
        ' 2 minutes' => ' 2 minuta',
        ' 5 minutes' => ' 5 minuta',
        ' 7 minutes' => ' 7 minuta',
        '"%s" notification was sent to "%s" by "%s".' => '"%s" obaveštenja poslato za "%s" od "%s".',
        '"Slim" skin which tries to save screen space for power users.' =>
            '',
        '%s' => '%s',
        '%s time unit(s) accounted. Now total %s time unit(s).' => '%s vremenskih jedinica prebrojano. Ukupno %s vremenskih jedinica.',
        '(UserLogin) Firstname Lastname' => '(Prijava korisnika) Ime Prezime',
        '(UserLogin) Lastname Firstname' => '(Prijava korisnika) Prezime Ime',
        '(UserLogin) Lastname, Firstname' => '(Prijava korisnika) Prezime, Ime',
        '*** out of office until %s (%s d left) ***' => '',
        '10 minutes' => '10 minuta',
        '100 (Expert)' => '100 (Ekspert)',
        '15 minutes' => '15 minuta',
        '200 (Advanced)' => '200 (Napredni)',
        '300 (Beginner)' => '300 (Početnik)',
        'A TicketWatcher Module.' => 'Modul nadzora tiketa.',
        'A Website' => 'Vebsajt',
        'A list of dynamic fields that are merged into the main ticket during a merge operation. Only dynamic fields that are empty in the main ticket will be set.' =>
            'Lista dinamičkih polja koja su spoajena u glavni tiket tokom operacije spajanja. Biće podešena samo dinamička polja koja su prazna u glavnom tiketu.',
        'A picture' => 'Slika',
        'ACL module that allows closing parent tickets only if all its children are already closed ("State" shows which states are not available for the parent ticket until all child tickets are closed).' =>
            'ACL modul koji dozvoljava da nadređeni tiketi budu zatvoreni samo ako su već zatvoreni svi podređeni tiketi ("Status" pokazuje koji statusi nisu dostupni za nadređeni tiket dok se ne zatvore svi podređeni tiketi).',
        'Access Control Lists (ACL)' => 'Liste za kontrolu pristupa (ACL)',
        'AccountedTime' => 'Obračunato vreme',
        'Activates a blinking mechanism of the queue that contains the oldest ticket.' =>
            'Aktivira mehanizam treptanja reda koji sarži najstariji tiket.',
        'Activates lost password feature for agents, in the agent interface.' =>
            'Aktivira opciju izgubljene lozinke za operatere, na interfejsu za njih.',
        'Activates lost password feature for customers.' => 'Aktivira svojstvo izgubljene lozinke za klijente.',
        'Activates support for customer groups.' => 'Aktivira podršku za klijentske grupe.',
        'Activates the article filter in the zoom view to specify which articles should be shown.' =>
            'Aktivira filter za članke u proširenom pregledu radi definisanja koji članci treba da budu prikazani.',
        'Activates the available themes on the system. Value 1 means active, 0 means inactive.' =>
            'Aktivira raspoložive teme - šablone u sistemu. Vrednost 1 znači aktivno, 0 znači neaktivno.',
        'Activates the ticket archive system search in the customer interface.' =>
            'Aktivira mogućnost pretraživanja arhive tiketa u klijentskom interfejsu.',
        'Activates the ticket archive system to have a faster system by moving some tickets out of the daily scope. To search for these tickets, the archive flag has to be enabled in the ticket search.' =>
            'Aktivira arhivski sistem radi ubrzanja rada, tako što ćete neke tikete ukloniti van dnevnog praćenja. Da biste pronašli ove tikete, marker arhive mora biti omogućen za pretragu tiketa.',
        'Activates time accounting.' => 'Aktivira merenje vremena.',
        'ActivityID' => 'ID aktivnosti',
        'Add a note to this ticket' => 'Dodaj napomenu ovom tiketu',
        'Add an inbound phone call to this ticket' => 'Dodaj dolazni telefonski poziv ovom tiketu.',
        'Add an outbound phone call to this ticket' => 'Dodaj odlazni telefonski poziv ovom tiketu.',
        'Added email. %s' => 'Dodat imejl. %s',
        'Added link to ticket "%s".' => 'Veza na "%s" postavljena.',
        'Added note (%s)' => 'Dodata napomena (%s)',
        'Added subscription for user "%s".' => 'Pretplata za korisnika "%s" uključena.',
        'Address book of CustomerUser sources.' => '',
        'Adds a suffix with the actual year and month to the OTRS log file. A logfile for every month will be created.' =>
            'Dodaje tekuću godinu i mesec kao sufiks u OTRS log datoteku. Biće kreirana log datoteka za svaki mesec.',
        'Adds customers email addresses to recipients in the ticket compose screen of the agent interface. The customers email address won\'t be added if the article type is email-internal.' =>
            'Dodavanje imejl adresa klijenata, primaocima u tiketu na prikazu ekrana za otvaranje tiketa u interfejsu operatera. Imejl adrese klijenata neće biti dodate, ukoliko je tip artikla imejl-interni.',
        'Adds the one time vacation days for the indicated calendar. Please use single digit pattern for numbers from 1 to 9 (instead of 01 - 09).' =>
            'Jednokratno dodaje neradne dane za izabrani kalendar. Molimo Vas da koristite jednu cifru za brojeve od 1 do 9 (umesto 01 - 09).',
        'Adds the one time vacation days. Please use single digit pattern for numbers from 1 to 9 (instead of 01 - 09).' =>
            'Jednokratno dodaje neradne dane. Molimo Vas da koristite jednu cifru za brojeve od 1 do 9 (umesto 01 - 09).',
        'Adds the permanent vacation days for the indicated calendar. Please use single digit pattern for numbers from 1 to 9 (instead of 01 - 09).' =>
            'Trajno dodaje neradne dane za izabrani kalendar. Molimo Vas da koristite jednu cifru za brojeve od 1 do 9 (umesto 01 - 09).',
        'Adds the permanent vacation days. Please use single digit pattern for numbers from 1 to 9 (instead of 01 - 09).' =>
            'Trajno dodaje neradne dane. Molimo Vas da koristite jednu cifru za brojeve od 1 do 9 (umesto 01 - 09).',
        'Admin Area.' => '',
        'After' => 'Posle',
        'Agent Customer Search' => '',
        'Agent Customer Search.' => '',
        'Agent Name' => '',
        'Agent Name + FromSeparator + System Address Display Name' => '',
        'Agent Preferences.' => 'Operaterska podešavanja.',
        'Agent User Search' => '',
        'Agent User Search.' => '',
        'Agent called customer.' => 'Operater je pozvao klijenta',
        'Agent interface article notification module to check PGP.' => 'Modul interfejsa operatera za obaveštavanja o članku, provera PGP.',
        'Agent interface article notification module to check S/MIME.' =>
            'Modul interfejsa operatera za obaveštavanja o članku, provera S/MIME',
        'Agent interface module to access CIC search via nav bar. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface module to access fulltext search via nav bar. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface module to access search profiles via nav bar. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface module to check incoming emails in the Ticket-Zoom-View if the S/MIME-key is available and true.' =>
            'Modul interfejsa operatera za proveru dolaznih poruka u uvećanom pregledu tiketa ako S/MIME-ključ postoji i dostupan je.',
        'Agent interface notification module to see the number of locked tickets. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface notification module to see the number of tickets an agent is responsible for. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface notification module to see the number of tickets in My Services. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Agent interface notification module to see the number of watched tickets. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'AgentTicketZoom widget that displays a table of objects linked to the ticket.' =>
            '',
        'AgentTicketZoom widget that displays customer information for the ticket in the side bar.' =>
            '',
        'AgentTicketZoom widget that displays ticket data in the side bar.' =>
            '',
        'Agents ↔ Groups' => '',
        'Agents ↔ Roles' => '',
        'All customer users of a CustomerID' => 'Svi klijenti korisnici za CustomerID',
        'All escalated tickets' => 'Svi eskalirani tiketi',
        'All new tickets, these tickets have not been worked on yet' => 'Svi novi tiketi, na njima još nije ništa rađeno',
        'All open tickets, these tickets have already been worked on, but need a response' =>
            'Svi otvoreni tiketi, na ovima je već rađeno, ali na njih treba odgovoriti',
        'All tickets with a reminder set where the reminder date has been reached' =>
            'Svi tiketi sa podešenim podsetnikom, a datum podsetnika je dostignut',
        'Allows adding notes in the close ticket screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            'Dozvoljava dodavanje napomena na ekranu zatvaranja tiketa interfejsa operatera. „Ticket::Frontend::NeedAccountedTime” je može prepisati.',
        'Allows adding notes in the ticket free text screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            'Dozvoljava dodavanje napomena na ekranu slobodnog teksta tiketa interfejsa operatera. „Ticket::Frontend::NeedAccountedTime” je može prepisati.',
        'Allows adding notes in the ticket note screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            'Dozvoljava dodavanje napomena na ekranu napomene tiketa interfejsa operatera. „Ticket::Frontend::NeedAccountedTime” je može prepisati.',
        'Allows adding notes in the ticket owner screen of a zoomed ticket in the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            'Dozvoljava dodavanje napomena na ekranu vlasnika tiketa interfejsa operatera. „Ticket::Frontend::NeedAccountedTime” je može prepisati.',
        'Allows adding notes in the ticket pending screen of a zoomed ticket in the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            'Dozvoljava dodavanje napomena na ekranu tiketa na čekanju interfejsa operatera. „Ticket::Frontend::NeedAccountedTime” je može prepisati.',
        'Allows adding notes in the ticket priority screen of a zoomed ticket in the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            'Dozvoljava dodavanje napomena na ekranu prioriteta detaljnog prikaza tiketa interfejsa operatera. „Ticket::Frontend::NeedAccountedTime” je može prepisati.',
        'Allows adding notes in the ticket responsible screen of the agent interface. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            'Dozvoljava dodavanje napomena na ekranu odgovornog za tiket interfejsa operatera. „Ticket::Frontend::NeedAccountedTime” je može prepisati.',
        'Allows agents to exchange the axis of a stat if they generate one.' =>
            'Dozvoljava operaterima da zamene ose na statistici ako je generišu.',
        'Allows agents to generate individual-related stats.' => 'Dozvoljava operaterima da generišu individualnu statistiku.',
        'Allows choosing between showing the attachments of a ticket in the browser (inline) or just make them downloadable (attachment).' =>
            'Dozvoljava izbor između prikaza priloga u pretraživaču ili samo omogućavanja njegovog preuzimanja.',
        'Allows choosing the next compose state for customer tickets in the customer interface.' =>
            'Dozvoljava izbor sledećeg stanja za klijentske tikete u klijentskom interfejsu.',
        'Allows customers to change the ticket priority in the customer interface.' =>
            'Dozvoljava klijentima da promene prioritet tiketa u klijentskom interfejsu.',
        'Allows customers to set the ticket SLA in the customer interface.' =>
            'Dozvoljava klijentima da podese SLA za tiket u klijentskom interfejsu.',
        'Allows customers to set the ticket priority in the customer interface.' =>
            'Dozvoljava klijentima da podese prioritet tiketa u klijentskom interfejsu.',
        'Allows customers to set the ticket queue in the customer interface. If this is set to \'No\', QueueDefault should be configured.' =>
            'Dozvoljava klijentima da podese red tiketa u korisničkom interfejsu. Ako je podešeno na "Ne", onda treba podesiti QueueDefault.',
        'Allows customers to set the ticket service in the customer interface.' =>
            'Dozvoljava klijentima da podese uslugu za tiket u korisničkom interfejsu.',
        'Allows customers to set the ticket type in the customer interface. If this is set to \'No\', TicketTypeDefault should be configured.' =>
            'Dozvoljava klijentima da podese tip tiketa u interfejsu  korisnika. Ukoliko je ovo podešeno na  \'No\', treba konfigurisati TicketTypeDefault.',
        'Allows default services to be selected also for non existing customers.' =>
            'Dozvoljava da podrazumevane usluge budu izabrane i za nepostojeće klijente.',
        'Allows defining new types for ticket (if ticket type feature is enabled).' =>
            'Dozvoljava definisanje novog tipa tiketa (ako je opcija tipa tiketa aktivirana).',
        'Allows defining services and SLAs for tickets (e. g. email, desktop, network, ...), and escalation attributes for SLAs (if ticket service/SLA feature is enabled).' =>
            'Dozvoljava definisanje usluge i SLA za tikete (npr. imejl, radna površina, mreža, ...), i eskalacione atribute za SLA (ako je aktivirana funkcija usluga/SLA za tiket).',
        'Allows extended search conditions in ticket search of the agent interface. With this feature you can search e. g. with this kind of conditions like "(key1&&key2)" or "(key1||key2)".' =>
            'Dozvoljava proširene uslove pretrage u tiketu na interfejsu operatera. Pomoću ove funkcije možete vršiti pretrage npr. sa vrstom uslova kao što su: "(key1&&key2)" ili "(key1||key2)".',
        'Allows extended search conditions in ticket search of the customer interface. With this feature you can search e. g. with this kind of conditions like "(key1&&key2)" or "(key1||key2)".' =>
            '',
        'Allows extended search conditions in ticket search of the generic agent interface. With this feature you can search e. g. ticket title with this kind of conditions like "(*key1*&&*key2*)" or "(*key1*||*key2*)".' =>
            '',
        'Allows having a medium format ticket overview (CustomerInfo => 1 - shows also the customer information).' =>
            'Dozvoljava posedovanje srednjeg formata pregleda tiketa ( CustomerInfo => 1 - takođe prikazuje informacije o klijentu).',
        'Allows having a small format ticket overview (CustomerInfo => 1 - shows also the customer information).' =>
            'Dozvoljava posedovanje malog formata pregleda tiketa ( CustomerInfo => 1  - takođe prikazuje informacije o klijentu).',
        'Allows invalid agents to generate individual-related stats.' => 'Dozvoljava nevažećim operaterima da generišu individualno povezane statistike.',
        'Allows the administrators to login as other customers, via the customer user administration panel.' =>
            'Dozvoljava administratorima da pristupe kao drugi klijenti, kroz administrativni panel klijenta korisnika.',
        'Allows the administrators to login as other users, via the users administration panel.' =>
            'Dozvoljava administratorima da pristupe kao drugi korisnici, kroz administrativni panel.',
        'Allows to set a new ticket state in the move ticket screen of the agent interface.' =>
            'Dozvoljava podešavanje statusa novog tiketa na prikazanom ekranu pomerenog tiketa u interfejsu operatera.',
        'Always show RichText if available' => '',
        'Answer' => 'Odgovor',
        'Arabic (Saudi Arabia)' => 'Arapski (Saudijska arabija)',
        'Archive state changed: "%s"' => 'Promenjeno stanje arhiviranja: "%s"',
        'ArticleTree' => 'Članak u obliku drveta',
        'Attachments ↔ Templates' => '',
        'Auto Responses ↔ Queues' => '',
        'AutoFollowUp sent to "%s".' => 'Automatski nastavak za "%s".',
        'AutoReject sent to "%s".' => 'Automatski odbijeno "%s".',
        'AutoReply sent to "%s".' => 'Poslat automatski odgovor za "%s".',
        'Automated line break in text messages after x number of chars.' =>
            'Automatski kraj reda u tekstualnim porukama posle h karaktera.',
        'Automatically change the state of a ticket with an invalid owner once it is unlocked. Maps from a state type to a new ticket state.' =>
            '',
        'Automatically lock and set owner to current Agent after opening the move ticket screen of the agent interface.' =>
            'Automatsko zaključavanje i podešavanje vlasnika na aktuelnog operatera posle otvaranja prozora za premeštanje tiketa u interfejsu operatera.',
        'Automatically lock and set owner to current Agent after selecting for an Bulk Action.' =>
            'Automatsko zaključavanje i podešavanje vlasnika na aktuelnog operatera posle izbora masovne akcije.',
        'Automatically sets the owner of a ticket as the responsible for it (if ticket responsible feature is enabled). This will only work by manually actions of the logged in user. It does not work for automated actions e.g. GenericAgent, Postmaster and GenericInterface.' =>
            '',
        'Automatically sets the responsible of a ticket (if it is not set yet) after the first owner update.' =>
            'Automatsko podešavanje odgovornog za tiket (ako nije do sada podešeno) posle prvog ažuriranja.',
        'Balanced white skin by Felix Niklas (slim version).' => 'Izbalansirani beli izgled, Feliks Niklas (tanka verzija).',
        'Balanced white skin by Felix Niklas.' => 'Izbalansirani beli izgled, Feliks Niklas.',
        'Based on global RichText setting' => '',
        'Basic fulltext index settings. Execute "bin/otrs.Console.pl Maint::Ticket::FulltextIndexRebuild" in order to generate a new index.' =>
            'Osnovn podešavanje indeksa celog teksta. Izvrši „bin/otrs.Console.pl Maint::Ticket::FulltextIndexRebuild” kako bi se generisao novi indeks.',
        'Blocks all the incoming emails that do not have a valid ticket number in subject with From: @example.com address.' =>
            'Blokira sve dolazne email-ove koji nemaju ispravan broj tiketa u predmetu sa Od: @example.com adrese.',
        'Bounced to "%s".' => 'Odbijeno "%s".',
        'Builds an article index right after the article\'s creation.' =>
            'Generiše indeks članaka odmah po kreiranju članka.',
        'Bulgarian' => 'Bugarski',
        'Bulk Action' => 'Masovna akcija',
        'CMD example setup. Ignores emails where external CMD returns some output on STDOUT (email will be piped into STDIN of some.bin).' =>
            'Primer podešavanja CMD. Ignoriše imejlove kada eksterni CMD vrati neke izlaze na STDOUT (imejl će biti kanalisan u STDIN od some.bin).',
        'CSV Separator' => '„CSV” separator',
        'Cache time in seconds for agent authentication in the GenericInterface.' =>
            'Vreme keširanja u sekundama za autentifikacije operatera u generičkom interfejsu.',
        'Cache time in seconds for customer authentication in the GenericInterface.' =>
            'Vreme keširanja u sekundama za autentifikaciju klijenta u opštem interfejsu.',
        'Cache time in seconds for the DB ACL backend.' => 'Vreme keširanja u sekundama za pozadinu ACL baze podataka.',
        'Cache time in seconds for the DB process backend.' => 'Vreme keširanja u sekundama za pozadinski proces baze podataka.',
        'Cache time in seconds for the SSL certificate attributes.' => 'Vreme keširanja u sekundama za SSL sertifikovane atribute.',
        'Cache time in seconds for the ticket process navigation bar output module.' =>
            'Vreme keširanja u sekundama za izlazni modul navigacione trake procesa tiketa',
        'Cache time in seconds for the web service config backend.' => 'Vreme keširanja u sekundama za veb servis konfiguracije pozadine.',
        'Catalan' => 'Katalonski',
        'Change password' => 'Promena lozinke',
        'Change queue!' => 'Promena reda!',
        'Change the customer for this ticket' => 'Promeni klijenta za ovaj tiket',
        'Change the free fields for this ticket' => 'Promeni slobodna polja ovog tiketa',
        'Change the owner for this ticket' => 'Promeni vlasnika ovog tiketa',
        'Change the priority for this ticket' => 'Promeni prioritete za ovaj tiket.',
        'Change the responsible for this ticket' => 'Promeni odgovornog za ovaj tiket',
        'Changed priority from "%s" (%s) to "%s" (%s).' => 'Ažuriran prioritet sa "%s" (%s) na "%s" (%s).',
        'Changes the owner of tickets to everyone (useful for ASP). Normally only agent with rw permissions in the queue of the ticket will be shown.' =>
            'Promeni vlasnika tiketa za sve (korisno za ASP). Obično se pokazuje samo agent sa dozvlama za čitanje/pisanje u redu tiketa.',
        'Checkbox' => 'Polje za potvrdu',
        'Checks if an E-Mail is a followup to an existing ticket by searching the subject for a valid ticket number.' =>
            'Proverava da li je imejl nastavljanje na postojeći tiketa pretragom predmeta važećih brojeva tiketa.',
        'Checks the SystemID in ticket number detection for follow-ups (use "No" if SystemID has been changed after using the system).' =>
            'Proveravanje SystemID u detekciji broja tiketa za praćenja (koristiti "Ne" ukoliko je SystemID promenjen nakon korišćenja sistema).',
        'Checks the availability of OTRS Business Solution™ for this system.' =>
            'Proverava dostupnost „OTRS” Poslovnog rešenja za ovaj sistem.',
        'Checks the entitlement status of OTRS Business Solution™.' => 'Proverava staus prava korišćenja „OTRS” Poslovnog rešenja.',
        'Child' => 'Dete',
        'Chinese (Simplified)' => 'Kineski (uprošćeno)',
        'Chinese (Traditional)' => 'Kineski (tradicionalno)',
        'Choose for which kind of ticket changes you want to receive notifications.' =>
            'Izaberi za kakve promene tiketa želiš da primiš obaveštenja.',
        'Christmas Eve' => 'Badnje veče',
        'Close this ticket' => 'Zatvori ovaj tiket',
        'Closed tickets (customer user)' => 'Zatvoreni tiketi (klijent korisnik)',
        'Closed tickets (customer)' => 'Zatvoreni tiketi (klijent)',
        'Cloud Services' => 'Servisi u oblaku',
        'Cloud service admin module registration for the transport layer.' =>
            'Registracija admin modula servisa u oblaku za transportni sloj.',
        'Collect support data for asynchronous plug-in modules.' => 'Prikupi podatke podrške za asinhdone priključne module.',
        'Column ticket filters for Ticket Overviews type "Small".' => 'Filteri kolona tiketa za preglede tiketa tipa "Malo".',
        'Columns that can be filtered in the escalation view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu eskalacija u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Columns that can be filtered in the locked view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu zaključavanja u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Columns that can be filtered in the queue view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu reda u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Columns that can be filtered in the responsible view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu odgovornosti u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Columns that can be filtered in the service view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu servisa u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Columns that can be filtered in the status view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu statusa u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Columns that can be filtered in the ticket search result view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu rezultata pretrage u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Columns that can be filtered in the watch view of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note: Only Ticket attributes, Dynamic Fields (DynamicField_NameX) and Customer attributes (e.g. CustomerUserPhone, CustomerCompanyName, ...) are allowed.' =>
            'Kolone koje mogu biti filtrirane na prikazu nadzora u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Podrazumevano omogućeno. Napomena: Samo atributi tiketa, Dinamička polja („DynamicField_NameX”) i Klijentski atributi (npr TelefonKlijentaKorisnika, NazivFirmeKlijenta, ...) su dozvoljeni.',
        'Comment for new history entries in the customer interface.' => 'Komentar za nove stavke istorije u klijentskom interfejsu.',
        'Comment2' => 'Komentar 2',
        'Communication' => 'Komunikacija',
        'Company Status' => 'Status firme',
        'Company Tickets.' => 'Tiketi firmi.',
        'Company name which will be included in outgoing emails as an X-Header.' =>
            'Naziv firme koji će biti uključen u odlazne imejlove kao X-Zaglavlje.',
        'Compat module for AgentZoom to AgentTicketZoom.' => '',
        'Complex' => 'Složeno',
        'Compose' => 'Napiši',
        'Configure Processes.' => 'Konfiguriši procese.',
        'Configure and manage ACLs.' => 'Konfiguriši i upravljaj ACL listama.',
        'Configure any additional readonly mirror databases that you want to use.' =>
            'Konfiguriše bilo koju dodatnu preslikanu bazu podataka, koju želite da koristite, samo za čitanje.',
        'Configure sending of support data to OTRS Group for improved support.' =>
            'Podešavanje slanja podataka za podršku za „OTRS Group” radi unapređenja podrške.',
        'Configure which screen should be shown after a new ticket has been created.' =>
            'Konfiguriše koji ekran bi trebalo prikazati nakon kreiranja novog tiketa.',
        'Configure your own log text for PGP.' => 'Konfiguriši sopstveni log tekst za PGP.',
        'Configures a default TicketDynamicField setting. "Name" defines the dynamic field which should be used, "Value" is the data that will be set, and "Event" defines the trigger event. Please check the developer manual (http://otrs.github.io/doc/), chapter "Ticket Event Module".' =>
            'Konfiguriše podrazumevana podešavanja dinamičkog polja tiketa. "Ime" definiše dinamičko polje koje će biti korišćeno, "Vrednost" je podatak koji će biti podešen, a "Događaj" definiše okidač događaja. Molimo konsultujte uputstvo za programere (http://otrs.github.io/doc/), poglavlje "Modul događaja tiketa".',
        'Controls how to display the ticket history entries as readable values.' =>
            'Kontroliše način prikaza istorijskih unosa tiketa kao čitljivih vrednosti. ',
        'Controls if CutomerID is editable in the agent interface.' => 'Kontroliše da li je ID klijenta u interfejsu operatera izmenljiv.',
        'Controls if customers have the ability to sort their tickets.' =>
            'Kontroliše da li klijenti imaju mogućnost da sortiraju svoje tikete.',
        'Controls if more than one from entry can be set in the new phone ticket in the agent interface.' =>
            'Kontroliše da li više od jednog ulaza može biti podešeno u novom telefonskom tiketu u interfejsu operatera.',
        'Controls if the admin is allowed to import a saved system configuration in SysConfig.' =>
            'Kontroliše da li je administratoru dozvoljeno da uveze sačuvanu sistemsku konfiguraciju u „SysConfig”.',
        'Controls if the admin is allowed to make changes to the database via AdminSelectBox.' =>
            'Kontroliše da li je administratoru dozvoljeno da napravi izemene u bazi podataka preko Administrativnog okvira za izbor.',
        'Controls if the ticket and article seen flags are removed when a ticket is archived.' =>
            'Kontroliše da li su zastavicom obeleženi tiket i članak uklonjeni kada je tiket arhiviran.',
        'Converts HTML mails into text messages.' => 'Konvertuje HTML poruke u tekstualne poruke.',
        'Create New process ticket.' => '',
        'Create and manage Service Level Agreements (SLAs).' => 'Kreira i upravlja Sporazume o nivou usluga (SLA)',
        'Create and manage agents.' => 'Kreiranje i upravljanje operaterima.',
        'Create and manage attachments.' => 'Kreiranje i upravljanje prilozima.',
        'Create and manage customer users.' => 'Kreiranje i upravljanje klijentima korisnicima.',
        'Create and manage customers.' => 'Kreiranje i upravljanje klijentima.',
        'Create and manage dynamic fields.' => 'Kreiranje i upravljanje dinamičkim poljima.',
        'Create and manage groups.' => 'Kreiranje i upravljanje grupama.',
        'Create and manage queues.' => 'Kreiranje i upravljanje redovima.',
        'Create and manage responses that are automatically sent.' => 'Kreiranje i upravljanje automatskim odgovorima.',
        'Create and manage roles.' => 'Kreiranje i upravljanje ulogama.',
        'Create and manage salutations.' => 'Kreiranje i upravljanje pozdravima.',
        'Create and manage services.' => 'Kreiranje i upravljanje uslugama.',
        'Create and manage signatures.' => 'Kreiranje i upravljanje potpisima.',
        'Create and manage templates.' => 'Kreiranje i upravljanje šablonima.',
        'Create and manage ticket notifications.' => 'Kreiranje i upravljanje obaveštenjima za tikete.',
        'Create and manage ticket priorities.' => 'Kreiranje i upravljanje prioritetima tiketa.',
        'Create and manage ticket states.' => 'Kreiranje i upravljanje statusima tiketa.',
        'Create and manage ticket types.' => 'Kreiranje i upravljanje tipovima tiketa.',
        'Create and manage web services.' => 'Kreiranje i upravljanje veb servisima.',
        'Create new Ticket.' => 'Kreiranje novog tiketa.',
        'Create new email ticket and send this out (outbound).' => '',
        'Create new email ticket.' => 'Kreiranje novog Imejl tiketa.',
        'Create new phone ticket (inbound).' => '',
        'Create new phone ticket.' => 'Kreiranje novog telefonskog tiketa.',
        'Create new process ticket.' => '',
        'Create tickets.' => 'Kreiranje tiketa.',
        'Croatian' => 'Hrvatski',
        'Custom RSS Feed' => 'Prilagođeni RSS izvor',
        'Custom text for the page shown to customers that have no tickets yet (if you need those text translated add them to a custom translation module).' =>
            'Prilagođen tekst za stranicu koja se prikazuje klijentima koji još uvek nemaju tikete (ako vam je taj tekst potreban na drugom jeziku, dodajte ga u prilagođen modul za prevode).',
        'Customer Administration' => 'Administracija klijenata',
        'Customer Companies' => 'Firme klijenti',
        'Customer Information Center Search.' => '',
        'Customer Information Center.' => '',
        'Customer Ticket Print Module.' => '',
        'Customer User Administration' => 'Administracija klijenta korisnika',
        'Customer User ↔ Groups' => '',
        'Customer User ↔ Services' => '',
        'Customer Users' => 'Klijenti korisnici',
        'Customer called us.' => 'Klijent nas je pozvao.',
        'Customer item (icon) which shows the closed tickets of this customer as info block. Setting CustomerUserLogin to 1 searches for tickets based on login name rather than CustomerID.' =>
            'Klijentska stavka (ikona) koja pokazuje zatvorene tikete ovog klijenta kao info blok. Podešavanje Prijave klijenta korisnika “CustomerUserLogin“ na 1 pretragu tiketa zasniva više na prijavi imena nego na ID klijenta.',
        'Customer item (icon) which shows the open tickets of this customer as info block. Setting CustomerUserLogin to 1 searches for tickets based on login name rather than CustomerID.' =>
            'Klijentska stavka (ikona) koja pokazuje otvorene tikete ovog klijenta kao info blok. Podešavanje Prijave klijenta korisnika “CustomerUserLogin“ na 1 pretragu tiketa zasniva više na prijavi imena nego na ID klijenta.',
        'Customer preferences.' => '',
        'Customer request via web.' => 'Klijentski veb zahtev.',
        'Customer ticket overview' => '',
        'Customer ticket search.' => '',
        'Customer ticket zoom' => '',
        'Customer user search' => 'Pretraga klijenata korisnika',
        'CustomerID search' => 'Pretraga ID klijenata',
        'CustomerName' => 'Naziv klijenta',
        'CustomerUser' => 'Klijent korisnik',
        'Customers ↔ Groups' => '',
        'Customizable stop words for fulltext index. These words will be removed from the search index.' =>
            'Podesive zaustavne reči za indeks kompletnog teksta. Ove reči će biti uklonjene iz indeksa pretrage.',
        'Czech' => 'Češki',
        'Danish' => 'Danski',
        'Data used to export the search result in CSV format.' => 'Podaci upotrebljeni za ivoz rezultata pretraživanja u CSV formatu.',
        'Date / Time' => 'Datum / Vreme',
        'Debug' => '',
        'Debugs the translation set. If this is set to "Yes" all strings (text) without translations are written to STDERR. This can be helpful when you are creating a new translation file. Otherwise, this option should remain set to "No".' =>
            'Uklanjanje grešaka kompleta prevoda. Ako je ovo podešeno na "Da" celokupan niz znakova (tekst) će bez prevoda biti upisan u STDERR. Ovo može biti od pomoći prilikom kreiranja nove datoteke prevoda. U suprotnom, ova opcija bi trebala da ostane podešena na "ne".',
        'Default' => 'Podrazumevano',
        'Default (Slim)' => '',
        'Default ACL values for ticket actions.' => 'Podrazumevane ACL vrednosti za akcije tiketa.',
        'Default ProcessManagement entity prefixes for entity IDs that are automatically generated.' =>
            'Podrazumevani prefiksi objekta za upravljanje procesom za IĐeve objekta koji su automatski generisani.',
        'Default data to use on attribute for ticket search screen. Example: "TicketCreateTimePointFormat=year;TicketCreateTimePointStart=Last;TicketCreateTimePoint=2;".' =>
            'Podrazumevani podaci za korišćenje na atributima za prikaz pretrage tiketa. Primer: TicketCreateTimePointFormat=year;TicketCreateTimePointStart=Last;TicketCreateTimePoint=2;".',
        'Default data to use on attribute for ticket search screen. Example: "TicketCreateTimeStartYear=2010;TicketCreateTimeStartMonth=10;TicketCreateTimeStartDay=4;TicketCreateTimeStopYear=2010;TicketCreateTimeStopMonth=11;TicketCreateTimeStopDay=3;".' =>
            'Podrazumevani podaci za korišćenje na atributima za prikaz pretrage tiketa. Primer: "TicketCreateTimeStartYear=2010;TicketCreateTimeStartMonth=10;TicketCreateTimeStartDay=4;TicketCreateTimeStopYear=2010;TicketCreateTimeStopMonth=11;TicketCreateTimeStopDay=3;".',
        'Default display type for recipient (To,Cc) names in AgentTicketZoom and CustomerTicketZoom.' =>
            'Podrazumevani tip prikaza za imena primaoca (To,Cc) na detaljnom prikazu tiketa u interfejsu operatara i klijenta.',
        'Default display type for sender (From) names in AgentTicketZoom and CustomerTicketZoom.' =>
            'Podrazumevani tip prikaza za imena (Od) pošiljaoca na detaljnom prikazu tiketa u interfejsu operatera i klijenta.',
        'Default loop protection module.' => 'Podrazumevani modul zaštite od petlje.',
        'Default queue ID used by the system in the agent interface.' => 'Podrazumevani ID reda koji koristi sistem u interfejsu operatera.',
        'Default skin for the agent interface (slim version).' => 'Podrazumevani izgled okruženja za interfejs operatera (slaba verzija).',
        'Default skin for the agent interface.' => 'Podrazumevani izgled okruženja za interfejs operatera.',
        'Default skin for the customer interface.' => 'Podrazumevani izgled okruženja za interfejs klijenta.',
        'Default spelling dictionary' => 'Podrazumevani pravopisni rečnik',
        'Default ticket ID used by the system in the agent interface.' =>
            'Podrazumevani ID tiketa koji koristi sistem u interfejsu operatera.',
        'Default ticket ID used by the system in the customer interface.' =>
            'Podrazumevani ID tiketa koji koristi sistem u klijentskom interfejsu.',
        'Default value for NameX' => 'Podrazumevana vrednost za ImeH',
        'Define Actions where a settings button is available in the linked objects widget (LinkObject::ViewMode = "complex"). Please note that these Actions must have registered the following JS and CSS files: Core.AllocationList.css, Core.UI.AllocationList.js, Core.UI.Table.Sort.js, Core.Agent.TableFilters.js.' =>
            '',
        'Define a filter for html output to add links behind a defined string. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possiblity is to insert the link to the image.' =>
            'Definiši filter za html izlaz da bi dodali veze iza definisanog niza znakova. Element Slika dozvoljava dva načina ulaza. U jednom naziv slike (npr. faq.png). U tom slučaju biće korišćena OTRS putanja slike. Drugi način je unošenje veze do slike.',
        'Define a mapping between variables of the customer user data (keys) and dynamic fields of a ticket (values). The purpose is to store customer user data in ticket dynamic fields. The dynamic fields must be present in the system and should be enabled for AgentTicketFreeText, so that they can be set/updated manually by the agent. They mustn\'t be enabled for AgentTicketPhone, AgentTicketEmail and AgentTicketCustomer. If they were, they would have precedence over the automatically set values. To use this mapping, you have to also activate the next setting below.' =>
            'Definisanje mapiranja između promenljivih: podataka klijenta korisnika (ključevi) i dinamičkih polja tiketa (vrednosti). Cilj je da se sačuvaju podaci klijenta korisnika u dinamičkom polju tiketa. Dinamička polja moraju biti prisutna u sistemu i treba da budu omogućena za  AgentTicketFreeText, tako da mogu da budu manuelno podešena/ažurirana od strane operatera. Ona ne smeju biti omogućena za AgentTicketPhone, AgentTicketEmail i AgentTicketCustomer. Da su bila, ona bi imala prednost nad automatski postavljenim vrednostima. Za korišćenje ovog mapiranja treba, takođe, da aktivirate sledeća podešavanja.',
        'Define dynamic field name for end time. This field has to be manually added to the system as Ticket: "Date / Time" and must be activated in ticket creation screens and/or in any other ticket action screens.' =>
            'Definiši naziv dinamičkog polja za krajnje vreme. Ovo polje mora biti manuelno dodato sistemu kao tiket: "Datum / Vreme" i moraju biti aktivirani u ekranima za kreiranje tiketa i/ili u bilo kom drugom ekranu sa događajima.',
        'Define dynamic field name for start time. This field has to be manually added to the system as Ticket: "Date / Time" and must be activated in ticket creation screens and/or in any other ticket action screens.' =>
            'Definiši naziv dinamičkog polja za početno vreme. Ovo polje mora biti manuelno dodato sistemu kao tiket: "Datum / Vreme" i moraju biti aktivirani u ekranima za kreiranje tiketa i/ili u bilo kom drugom ekranu sa događajima.',
        'Define the max depth of queues.' => 'Definiši maksimalnu dubinu za redove.',
        'Define the queue comment 2.' => 'Definiše komentar reda 2.',
        'Define the service comment 2.' => 'Definiše servisni komentar 2.',
        'Define the sla comment 2.' => 'Definiše sla komentar 2.',
        'Define the start day of the week for the date picker for the indicated calendar.' =>
            'Definiši prvi dan u nedelji za izbor datuma za navedeni kalendar.',
        'Define the start day of the week for the date picker.' => 'Definiši prvi dan u nedelji za izbor datuma.',
        'Define which columns are shown in the linked tickets widget (LinkObject::ViewMode = "complex"). Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.' =>
            '',
        'Defines a customer item, which generates a LinkedIn icon at the end of a customer info block.' =>
            'Definiši stavku klijenta, koja generiše LinkedIn ikonu na kraju info bloka klijenta.',
        'Defines a customer item, which generates a XING icon at the end of a customer info block.' =>
            'Definišie stavku klijenta, koja generiše XING ikonu na kraju info bloka klijenta.',
        'Defines a customer item, which generates a google icon at the end of a customer info block.' =>
            'Određuje stavku klijenta, koja generiše google ikonu na kraju info bloka klijenta.',
        'Defines a customer item, which generates a google maps icon at the end of a customer info block.' =>
            'Određuje stavku klijenta, koja generiše google maps ikonu na kraju info bloka klijenta.',
        'Defines a default list of words, that are ignored by the spell checker.' =>
            'Definiše podrazumevanu listu reči, koje su ignorisane od strane provere pravopisa.',
        'Defines a filter for html output to add links behind CVE numbers. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possiblity is to insert the link to the image.' =>
            'Definiše filter za html izlaz da bi ste dodali veze iza CVE brojeva. Element Slika dozvoljava dva načina ulaza. U jednom naziv slike (npr. faq.png). I tom slučaju biće korišćena OTRS putanja slike. Drugi način je unošenje veze do slike.',
        'Defines a filter for html output to add links behind MSBulletin numbers. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possiblity is to insert the link to the image.' =>
            'Definiše filter za html izlaz da bi ste dodali veze iza Microsoft znakova za nabrajanje ili brojeva Element Slika dozvoljava dva načina ulaza. U jednom naziv slike (npr. faq.png). I tom slučaju biće korišćena OTRS putanja slike. Drugi način je unošenje veze do slike.',
        'Defines a filter for html output to add links behind a defined string. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possiblity is to insert the link to the image.' =>
            'Definiše filter za html izlaz da bi ste dodali veze iza definisanog niza znakova. Element Slika dozvoljava dva načina ulaza. U jednom naziv slike (npr. faq.png). I tom slučaju biće korišćena OTRS putanja slike. Drugi način je unošenje veze do slike.',
        'Defines a filter for html output to add links behind bugtraq numbers. The element Image allows two input kinds. At once the name of an image (e.g. faq.png). In this case the OTRS image path will be used. The second possiblity is to insert the link to the image.' =>
            'Definiše filter za html izlaz da bi ste dodali veze iza "bugtraq" brojeva. Element Slika dozvoljava dva načina ulaza. U jednom naziv slike (npr. faq.png). I tom slučaju biće korišćena OTRS putanja slike. Drugi način je unošenje veze do slike.',
        'Defines a filter to collect CVE numbers from article texts in AgentTicketZoom. The results will be displayed in a meta box next to the article. Fill in URLPreview if you would like to see a preview when moving your mouse cursor above the link element. This could be the same URL as in URL, but also an alternate one. Please note that some websites deny being displayed within an iframe (e.g. Google) and thus won\'t work with the preview mode.' =>
            '',
        'Defines a filter to process the text in the articles, in order to highlight predefined keywords.' =>
            'Definiše filter za obradu teksta u člancima, da bi se istakle unapred definisane ključne reči.',
        'Defines a regular expression that excludes some addresses from the syntax check (if "CheckEmailAddresses" is set to "Yes"). Please enter a regex in this field for email addresses, that aren\'t syntactically valid, but are necessary for the system (i.e. "root@localhost").' =>
            'Definiše regularni izraz koji isključuje neke adrese iz provere sintakse (ako je "ProveraEmailAdresa" postavljena na "Da"). Molimo vas unesite regularni izraz u ovo polje za email adrese, koji nije sintaksno ispravan, sli je neophodan za sistem (npr. "root@localhost").',
        'Defines a regular expression that filters all email addresses that should not be used in the application.' =>
            'Definiše regularni izraz koji kiltrira sve email adrese koje ne bi smele da se koriste u aplikaciji.',
        'Defines a sleep time in microseconds between tickets while they are been processed by a job.' =>
            'Definiše vreme spavanja u mikrosekundama između tiketa dok se obrađuju od strane posla.',
        'Defines a useful module to load specific user options or to display news.' =>
            'Definiše koristan modul za učitavanje određenih korisničkih opcija ili za prikazivanje novosti.',
        'Defines all the X-headers that should be scanned.' => 'Određuje sva H-zaglavlja koja treba skenirati.',
        'Defines all the languages that are available to the application. Specify only English names of languages here.' =>
            'Određuje sve jezike koji su dostupni aplikaciji. Ovde unesite imena jezika samo na engleskom.',
        'Defines all the languages that are available to the application. Specify only native names of languages here.' =>
            'Određuje sve jezike koji su dostupni aplikaciji. Ovde unesite imena jezika samo na matičnom jeziku.',
        'Defines all the parameters for the RefreshTime object in the customer preferences of the customer interface.' =>
            'Određuje sve parametre za objekat Vreme Osvežavanja u postavkama klijenta u klijentskom interfejsu.',
        'Defines all the parameters for the ShownTickets object in the customer preferences of the customer interface.' =>
            'Određuje sve parametre za objekat Prikazani Tiketi u postavkama klijenta u klijentskom interfejsu.',
        'Defines all the parameters for this item in the customer preferences.' =>
            'Određuje sve parametre za ovu stavku u klijentskim podešavanjima.',
        'Defines all the parameters for this item in the customer preferences. \'PasswordRegExp\' allows to match passwords against a regular expression. Define the minimum number of characters using \'PasswordMinSize\'. Define if at least 2 lowercase and 2 uppercase letter characters are needed by setting the appropriate option to \'1\'. \'PasswordMin2Characters\' defines if the password needs to contain at least 2 letter characters (set to 0 or 1). \'PasswordNeedDigit\' controls the need of at least 1 digit (set to 0 or 1 to control).' =>
            '',
        'Defines all the parameters for this notification transport.' => 'Definiše sve parametre za ovaj transport obaveštenja.',
        'Defines all the possible stats output formats.' => 'Određuje sve moguće izlazne formate statistike.',
        'Defines an alternate URL, where the login link refers to.' => 'Određuje alternativnu URL adresu, na koju ukazuje veza za prijavljivanje.',
        'Defines an alternate URL, where the logout link refers to.' => 'Određuje alternativnu URL adresu, na koju ukazuje veza za odavljivanje.',
        'Defines an alternate login URL for the customer panel..' => 'Određuje alternativnu URL adresu prijavljivanja za klijentski panel.',
        'Defines an alternate logout URL for the customer panel.' => 'Određuje alternativnu URL adresu odjavljivanja za klijentski panel.',
        'Defines an external link to the database of the customer (e.g. \'http://yourhost/customer.php?CID=[% Data.CustomerID %]\' or \'\').' =>
            'Određuje spoljašnju vezu za bazu podataka klijenta (npr „http://yourhost/customer.php?CID=[% Data.CustomerID %]” ili „”).',
        'Defines default headers for outgoing emails.' => '',
        'Defines from which ticket attributes the agent can select the result order.' =>
            'Definiše iz kog atributa tiketa operater može da izabere redosled rezultata.',
        'Defines how the From field from the emails (sent from answers and email tickets) should look like.' =>
            'Definiše kako polje Od u imejl porukama (poslato iz odgovora i imejl tiketa) treba da izgleda.',
        'Defines if a pre-sorting by priority should be done in the queue view.' =>
            'Određuje ako prethodno sortiranje po prioritetu treba da se uradi u prikazu reda.',
        'Defines if a pre-sorting by priority should be done in the service view.' =>
            'Određuje da li prethodno sortiranje po prioritetu treba da se uradi u servisnom prikazu.',
        'Defines if a ticket lock is required in the close ticket screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket u zatvorenom prikazu ekrana tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the email outbound screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Definiše da li je potrebno zaključati tiket na prikazu ekrana za tiket odlaznih imejlova u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket bounce screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana za povraćaj tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket compose screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana za otvaranje tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket forward screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana za prosleđivanje tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket free text screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana slobodnog teksta tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket merge screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana za spajanje tiketa pri uvećanom prikazu tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket note screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana za napomenu tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket owner screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana vlasnika tiketa pri uvećanom prikazu tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket pending screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana tiketa na čekanju pri uvećanom prikazu tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket phone inbound screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana za tiket dolaznih telefonskih poziva u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket phone outbound screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana za tiket odlaznih telefonskih poziva u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket priority screen of a zoomed ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana prioritetnog tiketa pri uvećanom prikazu tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required in the ticket responsible screen of the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje ako je potrebno zaključati tiket na prikazu ekrana odgovornog tiketa u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if a ticket lock is required to change the customer of a ticket in the agent interface (if the ticket isn\'t locked yet, the ticket gets locked and the current agent will be set automatically as its owner).' =>
            'Određuje da li je potrebno zaključati tiket da bi promenili klijenta na tiketu u interfejsu operatera (ako tiket još uvek nije zaključan, tiket će dobiti status zaključan i trenutni operater će biti automatski postavljen kao vlasnik).',
        'Defines if agents should be allowed to login if they have no shared secret stored in their preferences and therefore are not using two-factor authentication.' =>
            'Definiše da li će operaterima biti dozvoljena prijava na sistem ukoliko nemaju podešen deljeni tajni ključ i time ne koriste dvofaktorski modul za identifikaciju.',
        'Defines if composed messages have to be spell checked in the agent interface.' =>
            'Određuje da li porukama napisanim u interfejsu operatera treba uraditi proveru pravopisa.',
        'Defines if customers should be allowed to login if they have no shared secret stored in their preferences and therefore are not using two-factor authentication.' =>
            'Definiše da li će klijentima biti dozvoljena prijava na sistem ukoliko nemaju podešen deljeni tajni ključ i time ne koriste dvofaktorski modul za identifikaciju.',
        'Defines if the enhanced mode should be used (enables use of table, replace, subscript, superscript, paste from word, etc.).' =>
            'Određuje da li treba da se koristi poboljšani režim (omogućava korišćenje tabele, zamene, indeksiranja, eksponiranja, umetanja iz Word-a, itd.).',
        'Defines if the previously valid token should be accepted for authentication. This is slightly less secure but gives users 30 seconds more time to enter their one-time password.' =>
            'Određuje da li za autentifikaciju treba da bude prihvaćen token koji je ranije bio važeći. Ovo je malo manje bezbedno ali korisniku daje 30 sekundi više vremena da unese svoju jednokratnu lozinku.',
        'Defines if the values for filters should be retrieved from all available tickets. If set to "Yes", only values which are actually used in any ticket will be available for filtering. Please note: The list of customers will always be retrieved like this.' =>
            '',
        'Defines if time accounting is mandatory in the agent interface. If activated, a note must be entered for all ticket actions (no matter if the note itself is configured as active or is originally mandatory for the individual ticket action screen).' =>
            'Definiše da li je obračun vremena obavezan u interfejsu operatera. Ako je aktivirano, za sve akcije na tiketima se mora uneti napomena (bez obzira da li je sama napomena konfigurisana kao aktivna ili je u orginalu obavezna na ekranu individualne akcije na tiketu).',
        'Defines if time accounting must be set to all tickets in bulk action.' =>
            'Određuje da li obračun vremena mora biti podešen na svim tiketima u masovnim akcijama.',
        'Defines out of office message template. Two string parameters (%s) available: end date and number of days left.' =>
            '',
        'Defines queues that\'s tickets are used for displaying as calendar events.' =>
            'Definiše redove koje koriste tiketi za prikazivanje u vidu kalendarskih događaja.',
        'Defines the IP regular expression for accessing the local repository. You need to enable this to have access to your local repository and the package::RepositoryList is required on the remote host.' =>
            'Definiše regularni izraz za IP adresu za pristup lokalnom spremištu. Potrebno je da im omogućite pristup vašem lokalnom spremištu i pakovanju: :RepositoryList se zahteva na udaljenom host-u',
        'Defines the URL CSS path.' => 'Definiše URL CSS putanju.',
        'Defines the URL base path of icons, CSS and Java Script.' => 'Definiše URL osnovnu putanju za ikone, CSS i Java Script.',
        'Defines the URL image path of icons for navigation.' => 'Definiše URL putanju do slika za navigacione ikone.',
        'Defines the URL java script path.' => 'Definiše URL putanju java skriptova.',
        'Defines the URL rich text editor path.' => 'Definiše URL Reach Text Editor putanju.',
        'Defines the address of a dedicated DNS server, if necessary, for the "CheckMXRecord" look-ups.' =>
            'Definiše adrese namenskog DNS servera, ukoliko je potrebno, za "CheckMXRecord" pretrage.',
        'Defines the agent preferences key where the shared secret key is stored.' =>
            'Određuje ključ operaterskih podešavanja gde se smešta deljeni tajni ključ.',
        'Defines the body text for notification mails sent to agents, about new password (after using this link the new password will be sent).' =>
            'Definiše telo teksta za obaveštenja o novoj lozinki, poslata operaterima putem imejlova (nova lozinka će biti poslata posle korišćenja ove veze).',
        'Defines the body text for notification mails sent to agents, with token about new requested password (after using this link the new password will be sent).' =>
            'Definiše telo teksta za obaveštenja poslata operaterima putem imejlova, sa tokenom u vezi nove zahtevane lozinke (nova lozinka će biti poslata posle korišćenja ove veze).',
        'Defines the body text for notification mails sent to customers, about new account.' =>
            'Određuje sadržaj teksta za obaveštenja poslata klijentima putem imejlova, o novom nalogu.',
        'Defines the body text for notification mails sent to customers, about new password (after using this link the new password will be sent).' =>
            'Određuje sadržaj teksta za obaveštenja poslata klijentima putem imejlova, o novoj lozinki (nova lozinka će biti poslata posle korišćenja ove veze).',
        'Defines the body text for notification mails sent to customers, with token about new requested password (after using this link the new password will be sent).' =>
            'Određuje sadržaj teksta za obaveštenja poslata klijentima putem imejlova, sa tokenom u vezi nove zahtevane lozinke (nova lozinka će biti poslata posle korišćenja ove veze).',
        'Defines the body text for rejected emails.' => 'Definiše sadržaj teksta za odbačene poruke.',
        'Defines the calendar width in percent. Default is 95%.' => 'Definiše širinu kalendara u procentima. Podrazumevano je 95%.',
        'Defines the cluster node identifier. This is only used in cluster configurations where there is more than one OTRS frontend system. Note: only values from 1 to 99 are allowed.' =>
            'Određuje identifikator čvora klastera. Ovo se koristi samo u klaster konfiguracijama gde postoji više od jednog „OTRS” pristupnog sistema. Napomena: dozvoljene su samo vrednosti os 1 do 99.',
        'Defines the column to store the keys for the preferences table.' =>
            'Definiše kolonu za čuvanje ključeva tabele podešavanja.',
        'Defines the config options for the autocompletion feature.' => 'Definiše konfiguracione opcije za funkciju automatskog dovršavanja.',
        'Defines the config parameters of this item, to be shown in the preferences view.' =>
            'Definiše konfiguracione parametre za ovu stavku, da budu prikazani u prikazu podešavanja.',
        'Defines the config parameters of this item, to be shown in the preferences view. \'PasswordRegExp\' allows to match passwords against a regular expression. Define the minimum number of characters using \'PasswordMinSize\'. Define if at least 2 lowercase and 2 uppercase letter characters are needed by setting the appropriate option to \'1\'. \'PasswordMin2Characters\' defines if the password needs to contain at least 2 letter characters (set to 0 or 1). \'PasswordNeedDigit\' controls the need of at least 1 digit (set to 0 or 1 to control). \'PasswordMaxLoginFailed\' allows to set an agent to invalid-temporarily if max failed logins reached.' =>
            '',
        'Defines the config parameters of this item, to be shown in the preferences view. Take care to maintain the dictionaries installed in the system in the data section.' =>
            'Definiše konfiguracione parametre za ovu stavku, da budu prikazani u prikazu podešavanja. Voditi računa o održavanju rečnika instaliranih u sistemu u sekciji podataka.',
        'Defines the connections for http/ftp, via a proxy.' => 'Definiše konekcije za http/ftp preko posrednika.',
        'Defines the customer preferences key where the shared secret key is stored.' =>
            'Određuje ključ klijentskih podešavanja gde se smešta deljeni tajni ključ.',
        'Defines the date input format used in forms (option or input fields).' =>
            'Definiše fornosa datuma u formulare (opciono ili polja za unos).',
        'Defines the default CSS used in rich text editors.' => 'Definiše podrazumevani CSS upotrebljen u RTF uređivanju.',
        'Defines the default auto response type of the article for this operation.' =>
            'Definiše podrazumevani tip automatskog odgovora članka za ovu operaciju.',
        'Defines the default body of a note in the ticket free text screen of the agent interface.' =>
            'Definiše telo napomene na prikazu ekrana slobodnog teksta tiketa u interfejsu operatera.',
        'Defines the default front-end (HTML) theme to be used by the agents and customers. If you like, you can add your own theme. Please refer the administrator manual located at http://otrs.github.io/doc/.' =>
            'Definiše podrazumevanu korisničku (HTML) temu za operatere i klijente. Ukoliko želite, možete dodati sopstvenu temu. Molimo konsultujte uputstvo za administratore na http://otrs.github.io/doc/.',
        'Defines the default front-end language. All the possible values are determined by the available language files on the system (see the next setting).' =>
            'Definiše podrazumevani jezik glavnog korisničkog dela. Sve moguće vrednosti su određene u raspoloživim jezičkim datotekama u sistemu (pogledajte sledeća podešavanja).',
        'Defines the default history type in the customer interface.' => 'Određuje podrazumevani tip istorije u interfejsu klijenta.',
        'Defines the default maximum number of X-axis attributes for the time scale.' =>
            'Definiše podrazumevani maksimalni broj atributa na H-osi vremenske skale.',
        'Defines the default maximum number of statistics per page on the overview screen.' =>
            'Definiše podrazumevani maksimalni broj rezultata statistike po strani na ekranu pregleda.',
        'Defines the default next state for a ticket after customer follow-up in the customer interface.' =>
            'Definiše podrazumevani sledeći status tiketa nakon klijentovog nastavljanja tiketa u interfejsu klijenta.',
        'Defines the default next state of a ticket after adding a note, in the close ticket screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana zatvorenog tiketa u interfejsu operatera.',
        'Defines the default next state of a ticket after adding a note, in the ticket bulk screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana masovnih tiketa u interfejsu operatera.',
        'Defines the default next state of a ticket after adding a note, in the ticket free text screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana tiketa slobodnog teksta u interfejsu operatera.',
        'Defines the default next state of a ticket after adding a note, in the ticket note screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana napomene tiketa u interfejsu operatera.',
        'Defines the default next state of a ticket after adding a note, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana vlasnika tiketa, pri uvećanom prikazu tiketa, u interfejsu operatera.',
        'Defines the default next state of a ticket after adding a note, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana tiketa na čekanju, pri uvećanom prikazu tiketa, u interfejsu operatera.',
        'Defines the default next state of a ticket after adding a note, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana prioritnog tiketa, pri uvećanom prikazu tiketa, u interfejsu operatera.',
        'Defines the default next state of a ticket after adding a note, in the ticket responsible screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana odgovornog tiketa u interfejsu operatera.',
        'Defines the default next state of a ticket after being bounced, in the ticket bounce screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana za povraćaj tiketa u interfejsu operatera.',
        'Defines the default next state of a ticket after being forwarded, in the ticket forward screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja napomene u prikazu ekrana za prosleđivanje tiketa u interfejsu operatera.',
        'Defines the default next state of a ticket after the message has been sent, in the email outbound screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle slanja poruke, na ekranu odlaznih imejlova u interfejsu operatera.',
        'Defines the default next state of a ticket if it is composed / answered in the ticket compose screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa ukoliko je sastavljeno / odgovoreno u prikazu ekrana za otvaranje tiketa u interfejsu operatera.',
        'Defines the default note body text for phone tickets in the ticket phone inbound screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status telefonskih tiketa u prikazu ekrana tiketa za dolazne telefonske pozive u interfejsu operatera.',
        'Defines the default note body text for phone tickets in the ticket phone outbound screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status telefonskih tiketa u prikazu ekrana tiketa za odlazne telefonske pozive u interfejsu operatera.',
        'Defines the default priority of follow-up customer tickets in the ticket zoom screen in the customer interface.' =>
            'Definiše podrazumevani prioritet tiketa klijenta za nastavljanje na ekranu detaljnog prikaza tiketa u interfejsu  klijenta.',
        'Defines the default priority of new customer tickets in the customer interface.' =>
            'Određuje podrazumevani prioritet za nove klijentske tikete u interfejsu klijenta.',
        'Defines the default priority of new tickets.' => 'Određuje podrazumevani prioritet za nove tikete.',
        'Defines the default queue for new customer tickets in the customer interface.' =>
            'Određuje podrazumevani red za nove klijentske tikete u interfejsu klijenta.',
        'Defines the default selection at the drop down menu for dynamic objects (Form: Common Specification).' =>
            'Definiše podrazumevani izbor iz padajućeg menija za dinamičke objekte (Od: Zajednička specifikacija).',
        'Defines the default selection at the drop down menu for permissions (Form: Common Specification).' =>
            'Definiše podrazumevani izbor iz padajućeg menija za dozvole (Od: Zajednička specifikacija).',
        'Defines the default selection at the drop down menu for stats format (Form: Common Specification). Please insert the format key (see Stats::Format).' =>
            'Definiše podrazumevani izbor iz padajućeg menija za status formata (Od: Zajednička specifikacija). Molimo vas da ubacite ključ formata (vidi statistika :: Format).',
        'Defines the default sender type for phone tickets in the ticket phone inbound screen of the agent interface.' =>
            'Definiše podrazumevani tip pošiljaoca za telefonske tikete na prikazu ekrana za tiket dolaznih telefonskih poziva u interfejsu operatera.',
        'Defines the default sender type for phone tickets in the ticket phone outbound screen of the agent interface.' =>
            'Definiše podrazumevani tip pošiljaoca za telefonske tikete na prikazu ekrana za tiket odlaznih telefonskih poziva u interfejsu operatera.',
        'Defines the default sender type for tickets in the ticket zoom screen of the customer interface.' =>
            'Određuje podrazumevani tip pošiljaoca za tikete na detaljnom prikazu ekrana tiketa u interfejsu klijenta.',
        'Defines the default shown ticket search attribute for ticket search screen (AllTickets/ArchivedTickets/NotArchivedTickets).' =>
            '',
        'Defines the default shown ticket search attribute for ticket search screen.' =>
            'Definiše podrazumevani prikaz pretrage atributa tiketa za prikaz ekrana pretrage tiketa.',
        'Defines the default shown ticket search attribute for ticket search screen. Example: "Key" must have the name of the Dynamic Field in this case \'X\', "Content" must have the value of the Dynamic Field depending on the Dynamic Field type,  Text: \'a text\', Dropdown: \'1\', Date/Time: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' and or \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.' =>
            'Definiše podrazumevani prikaz pretrage atributa tiketa za prikaz ekrana pretrage tiketa. Primer: "Ključ" mora imati naziv dinamičkog polja, u ovom slučaju \'X\', "Sadržaj" mora imati vrednost dinamičkog polja u zavisnosti od tipa dinamičkog polja, Tekst \'a text\', Padajući: \'1\', Datum/Vreme: \'Search_DynamicField_XTimeSlotStartYear=1974; Search_DynamicField_XTimeSlotStartMonth=01; Search_DynamicField_XTimeSlotStartDay=26; Search_DynamicField_XTimeSlotStartHour=00; Search_DynamicField_XTimeSlotStartMinute=00; Search_DynamicField_XTimeSlotStartSecond=00; Search_DynamicField_XTimeSlotStopYear=2013; Search_DynamicField_XTimeSlotStopMonth=01; Search_DynamicField_XTimeSlotStopDay=26; Search_DynamicField_XTimeSlotStopHour=23; Search_DynamicField_XTimeSlotStopMinute=59; Search_DynamicField_XTimeSlotStopSecond=59;\' i ili \'Search_DynamicField_XTimePointFormat=week; Search_DynamicField_XTimePointStart=Before; Search_DynamicField_XTimePointValue=7\';.',
        'Defines the default sort criteria for all queues displayed in the queue view.' =>
            'Određuje podrazumevani kriterijum sortiranja za sve redove prikazane u pregledu reda.',
        'Defines the default sort criteria for all services displayed in the service view.' =>
            'Definiše podrazumevani kriterijum sortiranja za sve servise prikazane u servisnom pregledu.',
        'Defines the default sort order for all queues in the queue view, after priority sort.' =>
            'Određuje podrazumevani redosled sortiranja za sve redove prikazane u prikazu reda, nakon sortiranja po prioritetu.',
        'Defines the default sort order for all services in the service view, after priority sort.' =>
            'Definiše podrazumevani kriterijum sortiranja za sve servise u servisnom pregledu, posle  sortiranja po prioritu.',
        'Defines the default spell checker dictionary.' => 'Određuje podrazumevani rečnik za proveru pravopisa.',
        'Defines the default state of new customer tickets in the customer interface.' =>
            'Određuje podrazumevani status tiketa novog klijenta u interfejsu klijenta.',
        'Defines the default state of new tickets.' => 'Određuje podrazumevani status novih tiketa.',
        'Defines the default subject for phone tickets in the ticket phone inbound screen of the agent interface.' =>
            'Definiše podrazumevani predmet za telefonske tikete na prikazu ekrana za tiket dolaznih telefonskih poziva u interfejsu operatera.',
        'Defines the default subject for phone tickets in the ticket phone outbound screen of the agent interface.' =>
            'Definiše podrazumevani predmet za telefonske tikete na prikazu ekrana za tiket odlaznih telefonskih poziva u interfejsu operatera.',
        'Defines the default subject of a note in the ticket free text screen of the agent interface.' =>
            'Definiše podrazumevani predmet napomene za prikaz ekrana tiketa slobodnog teksta u interfejsu operatera.',
        'Defines the default the number of seconds (from current time) to re-schedule a generic interface failed task.' =>
            'Definiše podrazumevani broj sekundi (od sadašnjeg momenta) do ponovnog rasporeda neuspešnog zadatka u opštem interfejsu.',
        'Defines the default ticket attribute for ticket sorting in a ticket search of the customer interface.' =>
            'Određuje podrazumevani atribut tiketa za sortiranje tiketa u pretrazi tiketa u interfejsu klijenta.',
        'Defines the default ticket attribute for ticket sorting in the escalation view of the agent interface.' =>
            'Definiše podrazumevani atribut tiketa za sortiranje tiketa u eskalacionom pregledu interfejsa operatera.',
        'Defines the default ticket attribute for ticket sorting in the locked ticket view of the agent interface.' =>
            'Definiše podrazumevani atribut tiketa za sortiranje tiketa u pregledu zaključanog tiketa interfejsa operatera.',
        'Defines the default ticket attribute for ticket sorting in the responsible view of the agent interface.' =>
            'Definiše podrazumevani atribut tiketa za sortiranje tiketa u odgovornom pregledu interfejsa operatera.',
        'Defines the default ticket attribute for ticket sorting in the status view of the agent interface.' =>
            'Definiše podrazumevani atribut tiketa za sortiranje tiketa u pregledu statusa interfejsa operatera.',
        'Defines the default ticket attribute for ticket sorting in the watch view of the agent interface.' =>
            'Definiše podrazumevani atribut tiketa za sortiranje tiketa u posmatranom pregledu interfejsa operatera.',
        'Defines the default ticket attribute for ticket sorting of the ticket search result of the agent interface.' =>
            'Definiše podrazumevani atribut tiketa za sortiranje tiketa u rezultatu pretrage tiketa interfejsa operatera.',
        'Defines the default ticket attribute for ticket sorting of the ticket search result of this operation.' =>
            'Definiše podrazumevani atribut tiketa za sortiranje tiketa u rezultatu pretrage tiketa u ovoj operaciji.',
        'Defines the default ticket bounced notification for customer/sender in the ticket bounce screen of the agent interface.' =>
            'Određuje podrazumevanu napomenu povratnog tiketa za  klijenta/pošiljaoca na prikazu ekrana za povraćaj tiketa u interfejsu operatera.',
        'Defines the default ticket next state after adding a phone note in the ticket phone inbound screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja telefonske napomene na prikazu ekrana za tiket dolaznih telefonskih poziva u interfejsu operatera.',
        'Defines the default ticket next state after adding a phone note in the ticket phone outbound screen of the agent interface.' =>
            'Definiše podrazumevani sledeći status tiketa posle dodavanja telefonske napomene na prikazu ekrana za tiket odlaznih telefonskih poziva u interfejsu operatera.',
        'Defines the default ticket order (after priority sort) in the escalation view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            'Definiše podrazumevani redosled tiketa (posle sortiranja po prioritetu) u eskalacionom pregledu u interfejsu opreratera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket order (after priority sort) in the status view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            'Definiše podrazumevani redosled tiketa (posle sortiranja po prioritetu) u pregledu statusa u interfejsu opreratera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket order in the responsible view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            'Definiše podrazumevani redosled tiketa (posle sortiranja po prioritetu) u odgovornom pregledu u interfejsu opreratera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket order in the ticket locked view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            'Definiše podrazumevani redosled tiketa (posle sortiranja po prioritetu) u pregledu zaključanih tiketa u interfejsu opreratera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket order in the ticket search result of the agent interface. Up: oldest on top. Down: latest on top.' =>
            'Definiše podrazumevani redosled tiketa (posle sortiranja po prioritetu) u pregledu pretrage tiketa u interfejsu opreratera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket order in the ticket search result of the this operation. Up: oldest on top. Down: latest on top.' =>
            'Definiše podrazumevani redosled tiketa u pregledu pretrage tiketa u ovoj operaciji. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket order in the watch view of the agent interface. Up: oldest on top. Down: latest on top.' =>
            'Definiše podrazumevani redosled tiketa u posmatranom pregledu interfejsa operatera. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket order of a search result in the customer interface. Up: oldest on top. Down: latest on top.' =>
            'Određuje podrazumevani redosled tiketa u pregledu pretrage rezultata u interfejsu klijenta. Gore: Najstariji na vrhu. Dole: Najnovije na vrhu.',
        'Defines the default ticket priority in the close ticket screen of the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana zatvorenog tiketa u interfejsu operatera.',
        'Defines the default ticket priority in the ticket bulk screen of the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana masovnih tiketa u interfejsu operatera.',
        'Defines the default ticket priority in the ticket free text screen of the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana tiketa slobodnog teksta u interfejsu operatera.',
        'Defines the default ticket priority in the ticket note screen of the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana napomene tiketa u interfejsu operatera.',
        'Defines the default ticket priority in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana vlasnika tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the default ticket priority in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana vlasnika tiketa na čekanju pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the default ticket priority in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana prioritetnog tiketa pri uvećanom prikazu tiketa u interfejsu operatera',
        'Defines the default ticket priority in the ticket responsible screen of the agent interface.' =>
            'Određuje podrazumevani prioritet tiketa na prikazu ekrana odgovornog tiketa interfejsa operatera.',
        'Defines the default ticket type for new customer tickets in the customer interface.' =>
            'Određuje podrazumevani tip tiketa za tikete novog klijenta u interfejsu klijenta.',
        'Defines the default ticket type.' => 'Određuje podrazumevani tip tiketa.',
        'Defines the default type for article in the customer interface.' =>
            'Određuje podrazumevani tip članka u interfejsu klijenta.',
        'Defines the default type of forwarded message in the ticket forward screen of the agent interface.' =>
            'Određuje podrazumevani tip prosleđene poruke na prikaz ekrana prosleđenih tiketa interfejsa operatera.',
        'Defines the default type of the article for this operation.' => 'Određuje podrazumevani tip članka za ovu operaciju.',
        'Defines the default type of the message in the email outbound screen of the agent interface.' =>
            'Određuje podrazumevani tip poruke na ekranu odlaznih imejlova interfejsa operatera.',
        'Defines the default type of the note in the close ticket screen of the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana zatvorenog tiketa interfejsa operatera.',
        'Defines the default type of the note in the ticket bulk screen of the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana masovnih tiketa interfejsa operatera.',
        'Defines the default type of the note in the ticket free text screen of the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana tiketa slobodnog teksta interfejsa operatera.',
        'Defines the default type of the note in the ticket note screen of the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana napomene tiketa interfejsa operatera.',
        'Defines the default type of the note in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana vlasnika tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the default type of the note in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana tiketa na čekanju pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the default type of the note in the ticket phone inbound screen of the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana za tiket dolaznih telefonskih poziva interfejsa operatera.',
        'Defines the default type of the note in the ticket phone outbound screen of the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana za tiket odlaznih telefonskih poziva interfejsa operatera.',
        'Defines the default type of the note in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana prioritetnog tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the default type of the note in the ticket responsible screen of the agent interface.' =>
            'Određuje podrazumevani tip napomene na prikazu ekrana odgovornog tiketa interfejsa operatera.',
        'Defines the default type of the note in the ticket zoom screen of the customer interface.' =>
            'Određuje podrazumevani tip napomene na ekranu detaljnog prikaza tiketa interfejsa klijenta.',
        'Defines the default used Frontend-Module if no Action parameter given in the url on the agent interface.' =>
            'Definiše podrazumevani upotrebljeni modul korisničkog dela, ako akcioni parametar nije dat u url na inerfejsu operatera.',
        'Defines the default used Frontend-Module if no Action parameter given in the url on the customer interface.' =>
            'Određuje podrazumevani upotrebljeni modul korisničkog dela, ako akcioni parametar nije dat u url na inerfejsu klijenta.**',
        'Defines the default value for the action parameter for the public frontend. The action parameter is used in the scripts of the system.' =>
            'Definiše podrezumevanu vrednost za akcioni parametar za javni korisnički deo. Akcioni parametar je korišćen u skriptama sistema.',
        'Defines the default viewable sender types of a ticket (default: customer).' =>
            'Određuje podrazumevani tip vidljivog pošiljaoca tiketa (podrazmevano: klijent).',
        'Defines the dynamic fields that are used for displaying on calendar events.' =>
            'Definiše dinamička polja koja se koriste za prikazivanje na kalendaru događaja.',
        'Defines the fall-back path to open fetchmail binary. Note: The name of the binary needs to be \'fetchmail\', if it is different please use a symbolic link.' =>
            'Definiše rezervnu putanju za fetchmail program. Napomena: naziv programa mora biti \'fetchmail\', ukoliko je drugačiji molimo koristite simboličku vezu.',
        'Defines the filter that processes the text in the articles, in order to highlight URLs.' =>
            'Definiše filter koji obrađuje tekst u člancima, da bi se istakle URL adrese.',
        'Defines the format of responses in the ticket compose screen of the agent interface ([% Data.OrigFrom | html %] is From 1:1, [% Data.OrigFromName | html %] is only realname of From).' =>
            'Definiše format odgovora u prikazu ekrana za kreiranje tiketa interfejsa operatera ([% Data.OrigFrom | html %]  je Od u originalnom obliku, [% Data.OrigFromName | html %] je samo pravo ime iz Od).',
        'Defines the fully qualified domain name of the system. This setting is used as a variable, OTRS_CONFIG_FQDN which is found in all forms of messaging used by the application, to build links to the tickets within your system.' =>
            'Definiše potpuno kvalifikovano ime domena sistema. Ovo podešavanje se koristi kao promenljiva OTRS_CONFIG_FQDN, koja se nalazi u svim formama poruka i koristi od strane aplikacije, za građenje veza do tiketa unutar vašeg sistema.',
        'Defines the groups every customer user will be in (if CustomerGroupSupport is enabled and you don\'t want to manage every user for these groups).' =>
            'Određuje grupe u kojima će se nalaziti svaki klijent korisnik (ako je „CustomerGroupSupport” aktivirana i ne želite da upravljate svakim korisnikom iz ovih grupa).',
        'Defines the height for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).' =>
            'Određuje visinu za komponentu Rich Text Editor za ovaj prikaz ekrana. Unesi broj (pikseli) ili procentualnu vrednost (relativnu).',
        'Defines the height for the rich text editor component. Enter number (pixels) or percent value (relative).' =>
            'Određuje visinu za komponentu Rich Text Editor. Unesi broj (pikseli) ili procentualnu vrednost (relativnu).',
        'Defines the history comment for the close ticket screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti zatvorenog tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the email ticket screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti imejl tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the phone ticket screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti telefonskog tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket free text screen action, which gets used for ticket history.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti tiketa slebodnog teksta, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket note screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti napomene tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket owner screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti vlasnika tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket pending screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti tiketa na čekanju, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket phone inbound screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti dolaznh telefonskih poziva tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket phone outbound screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti odlaznh telefonskih poziva tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket priority screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti prioritetnih tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket responsible screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za prikaz ekrana aktivnosti odgovornih tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history comment for the ticket zoom action, which gets used for ticket history in the customer interface.' =>
            'Određuje komentar istorije za prikaz ekrana aktivnosti tiketa detaljnog prikaza, koji se koristi za istoriju tiketa u interfejsu klijenta.',
        'Defines the history comment for this operation, which gets used for ticket history in the agent interface.' =>
            'Definiše komentar istorije za ovu operaciju, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the close ticket screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti zatvorenog tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the email ticket screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti imejl tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the phone ticket screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti telefonskog tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket free text screen action, which gets used for ticket history.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti tiketa slobodnog teksta, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket note screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti napomene tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket owner screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti vlasnika tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket pending screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti tiketa na čekanju, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket phone inbound screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti tiketa dolaznih telefonskih poziva, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket phone outbound screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti tiketa odlaznih telefonskih poziva, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket priority screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti prioritetnog tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket responsible screen action, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za prikaz ekrana aktivnosti odgovornog tiketa, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the history type for the ticket zoom action, which gets used for ticket history in the customer interface.' =>
            'Određuje tip istorije za prikaz ekrana aktivnosti detaljnog prikaza tiketa, koji se koristi za istoriju tiketa u interfejsu klijenta.',
        'Defines the history type for this operation, which gets used for ticket history in the agent interface.' =>
            'Definiše tip istorije za ovu operaciju, koji se koristi za istoriju tiketa u interfejsu operatera.',
        'Defines the hours and week days of the indicated calendar, to count the working time.' =>
            'Određuje sate i dane u nedelji u naznačenom kalendaru, radi računanja radnog vremena.',
        'Defines the hours and week days to count the working time.' => 'Određuje sate i dane u nedelji u naznačenom kalendaru, radi računanja radnog vremena.',
        'Defines the key to be checked with Kernel::Modules::AgentInfo module. If this user preferences key is true, the message is accepted by the system.' =>
            'Definiše ključ koji treba proveriti sa "Kernel::Modules::AgentInfo" modulom. Ako je ovaj korisnički parametar ključa tačan, poruka će biti prihvaćena od strane sistema.',
        'Defines the key to check with CustomerAccept. If this user preferences key is true, then the message is accepted by the system.' =>
            'Određuje ključ koji treba proveriti sa "CustomerAccept" (Prihvatanje korisnika). Ako je ovaj korisnički parametar ključa tačan, poruka će biti prihvaćena od strane sistema.',
        'Defines the link type \'Normal\'. If the source name and the target name contain the same value, the resulting link is a non-directional one; otherwise, the result is a directional link.' =>
            'Definiše tip veze \'Normal\'. Ako naziv izvora i naziv cilja sadrže iste vrednosti, dobijena veza se smatra neusmerenom; u suprotnom se kao rezultat dobija usmerena veza. ',
        'Defines the link type \'ParentChild\'. If the source name and the target name contain the same value, the resulting link is a non-directional one; otherwise, the result is a directional link.' =>
            'Definiše tip veze nadređeni-podređeni. Ako naziv izvora i naziv cilja sadrže iste vrednosti, dobijena veza se smatra neusmerenom; u suprotnom se kao rezultat dobija usmerena veza. ',
        'Defines the link type groups. The link types of the same group cancel one another. Example: If ticket A is linked per a \'Normal\' link with ticket B, then these tickets could not be additionally linked with link of a \'ParentChild\' relationship.' =>
            'Definiše tip veze grupa. Tipovi veze iste grupe poništavaju jedni druge. Primer: Ako je tiket A vezan preko \'Normal\' veze sa tiketom B, onda ovi tiketi ne mogu biti dodatno vezani vezom nadređeni-podređeni.',
        'Defines the list of online repositories. Another installations can be used as repository, for example: Key="http://example.com/otrs/public.pl?Action=PublicRepository;File=" and Content="Some Name".' =>
            'Definiše listu online spremišta. Još instalacija može da se koristi kao spremište, na primer: Ključ="http://example.com/otrs/public.pl?Action=PublicRepository;File=" i Sadržaj="Some Name".',
        'Defines the list of possible next actions on an error screen, a full path is required, then is possible to add external links if needed.' =>
            '',
        'Defines the list of types for templates.' => 'Definiše listu tipova šablona.',
        'Defines the location to get online repository list for additional packages. The first available result will be used.' =>
            'Definiše lokaciju za dobijanje spiska online spremišta za dodatne pakete. Prvi raspoloživi rezultat će biti korišćen.',
        'Defines the log module for the system. "File" writes all messages in a given logfile, "SysLog" uses the syslog daemon of the system, e.g. syslogd.' =>
            'Definiše log modul za sistem. "File" piše sve poruke u datoj log datoteci, "SysLog" koristi sistemski log "daemon" sistema, npr. syslogd.',
        'Defines the maximal size (in bytes) for file uploads via the browser. Warning: Setting this option to a value which is too low could cause many masks in your OTRS instance to stop working (probably any mask which takes input from the user).' =>
            'Definiše maksimalnu veličinu (u bajtovima) za slanje datoteke preko pretraživača. Upozorenje: Podešavanje ove opcije na suviše malu vrednost može uzrokovati mnoge maske u vašem OTRS-u da prestane da radi (verovatno svaka maska koja ima ulaz od korisnika).',
        'Defines the maximal valid time (in seconds) for a session id.' =>
            'Definiše maksimalno vreme važenja (u sekundama) za ID sesije.',
        'Defines the maximum number of affected tickets per job.' => 'Definiše maksimalni broj obuhvaćenih tiketa po poslu.',
        'Defines the maximum number of pages per PDF file.' => 'Definiše maksimalni broj strana po PDF datoteci.',
        'Defines the maximum number of quoted lines to be added to responses.' =>
            'Definiše maksimalni broj citiranih linija za dodavanje u odgovore.',
        'Defines the maximum number of tasks to be executed as the same time.' =>
            'Definiše maksimalni broj zadataka koji će se izvršavati u isto vreme.',
        'Defines the maximum size (in MB) of the log file.' => 'Definiše maksimalnu veličinu log datoteke (u megabajtima).',
        'Defines the maximum size in KiloByte of GenericInterface responses that get logged to the gi_debugger_entry_content table.' =>
            'Definiše maksimalnu veličinu u kilobajtima za odgovore Generičkog interfejsa koji se beleže u gi_debugger_entry_content tabelu.',
        'Defines the module that shows a generic notification in the agent interface. Either "Text" - if configured - or the contents of "File" will be displayed.' =>
            'Definiše modul koji prikazuje generičku napomenu u interfejsu operatera. Biće prikazan ili "Text" (ako je konfigursan) ili sadržaj "File".',
        'Defines the module that shows all the currently loged in customers in the agent interface.' =>
            'Određuje modul koji prikazuje sve trenutno prijavljene klijente u interfejsu operatera.',
        'Defines the module that shows all the currently logged in agents in the agent interface.' =>
            'Definiše modul koji prikazuje sve trenutno prijavljene operatere u interfejsu operatera.',
        'Defines the module that shows the currently loged in agents in the customer interface.' =>
            'Određuje modul koji prikazuje sve trenutno prijavljene operatere u interfejsu klijenta.',
        'Defines the module that shows the currently loged in customers in the customer interface.' =>
            'Određuje modul koji prikazuje sve trenutno prijavljene klijente u interfejsu klijenta.',
        'Defines the module to authenticate customers.' => 'Određuje modul za autentifikaciju klijenata.',
        'Defines the module to display a notification if cloud services are disabled.' =>
            '',
        'Defines the module to display a notification in different interfaces on different occasions for OTRS Business Solution™.' =>
            'Određuje modul za prikaz obaveštenja u raznim interfejsima u različitim prilikama za „OTRS poslovno rešenje”.',
        'Defines the module to display a notification in the agent interface if the OTRS Daemon is not running.' =>
            'Određuje modul za prikaz obaveštenja u interfejsu operatera ako „OTRS” sistemski proces ne radi.',
        'Defines the module to display a notification in the agent interface, if the agent has not yet selected a time zone.' =>
            '',
        'Defines the module to display a notification in the agent interface, if the agent is logged in while having out-of-office active.' =>
            'Definiše modul za prikazivanje obaveštenja u interfejsu operatera ako je operater prijavljen na sistem dok je opcija "van kancelarije" aktivna.',
        'Defines the module to display a notification in the agent interface, if the agent is logged in while having system maintenance active.' =>
            'Određuje modul za prikaz obaveštenja u interfejsu operatera, ako je operater prijavljen na sistem dok je aktivno održavanje sisitema.',
        'Defines the module to display a notification in the agent interface, if the system is used by the admin user (normally you shouldn\'t work as admin).' =>
            'Definiše modul za prikazivanje obaveštenja u interfejsu operatera ako se sistem koristi od strane admin korisnika (normalno ne treba da rade kao administrator).',
        'Defines the module to display a notification in the customer interface, if the customer is logged in while having system maintenance active.' =>
            '',
        'Defines the module to display a notification in the customer interface, if the customer user has not yet selected a time zone.' =>
            '',
        'Defines the module to generate code for periodic page reloads.' =>
            'Definiše modul za generisanje koda za periodično učitavanje stranica.',
        'Defines the module to send emails. "Sendmail" directly uses the sendmail binary of your operating system. Any of the "SMTP" mechanisms use a specified (external) mailserver. "DoNotSendEmail" doesn\'t send emails and it is useful for test systems.' =>
            'Definiše module za slanje imejlova. "Sendmail" (pošalji mail) direktno koristi pošalji mejl binarni kod vašeg operativnog sistema. Svaki od SMTP mehanizama koristi specifični (eksterni) mejl server. "DoNotSendEmail" ne šalje imejlove i to je korisno pri testiranju sistema.',
        'Defines the module used to store the session data. With "DB" the frontend server can be splitted from the db server. "FS" is faster.' =>
            'Definiše modul koji se koristi za skladištenje podataka sesije. Sa "DB" pristupni server može biti odvojen od servera baze podataka. "FS" je brže.',
        'Defines the name of the application, shown in the web interface, tabs and title bar of the web browser.' =>
            'Definiše naziv aplikacije, koji se prikazuje u veb interfejsu, karticama i naslovnoj traci veb pretraživača.',
        'Defines the name of the column to store the data in the preferences table.' =>
            'Definiše naziv kolone za skladištenje podataka u tabeli parametara.',
        'Defines the name of the column to store the user identifier in the preferences table.' =>
            'Definiše naziv kolone za skladištenje identifikacije korisnika u tabeli parametara.',
        'Defines the name of the indicated calendar.' => 'Definiše naziv naznačenog kalendara.',
        'Defines the name of the key for customer sessions.' => 'Određuje naziv ključa za klijentske sesije.',
        'Defines the name of the session key. E.g. Session, SessionID or OTRS.' =>
            'Definiše naziv ključa sesije. Npr. Sesija, Sesija ID ili OTRS.',
        'Defines the name of the table where the user preferences are stored.' =>
            '',
        'Defines the next possible states after composing / answering a ticket in the ticket compose screen of the agent interface.' =>
            'Definiše sledeće moguće statuse nakon otvaranja / odgovaranja tiketa u prikazu ekrana za otvaranje tiketa interfejsa operatera.',
        'Defines the next possible states after forwarding a ticket in the ticket forward screen of the agent interface.' =>
            'Definiše sledeće moguće statuse nakon prosleđivanja tiketa u prikazu ekrana za prosleđivanje tiketa interfejsa operatera.',
        'Defines the next possible states after sending a message in the email outbound screen of the agent interface.' =>
            'Definiše sledeće moguće statuse nakon slanja poruke u prikazu ekrana odlaznih imejlova interfejsa operatera.',
        'Defines the next possible states for customer tickets in the customer interface.' =>
            'Određuje sledeće moguće statuse za tikete klijenata u interfejsu klijenta.',
        'Defines the next state of a ticket after adding a note, in the close ticket screen of the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana zatvorenog tiketa interfejsa operatera.',
        'Defines the next state of a ticket after adding a note, in the ticket bulk screen of the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana masovnih tiketa interfejsa operatera.',
        'Defines the next state of a ticket after adding a note, in the ticket free text screen of the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana tiketa slobodnog teksta interfejsa operatera.',
        'Defines the next state of a ticket after adding a note, in the ticket note screen of the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana napomene tiketa interfejsa operatera.',
        'Defines the next state of a ticket after adding a note, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana vlasnika tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the next state of a ticket after adding a note, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana tiketa na čekanju pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the next state of a ticket after adding a note, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana prioritetnog tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Defines the next state of a ticket after adding a note, in the ticket responsible screen of the agent interface.' =>
            'Definiše sledeći status tiketa nakon dodavanja napomene u prikazu ekrana odgovornog tiketa u interfejsu operatera.',
        'Defines the next state of a ticket after being bounced, in the ticket bounce screen of the agent interface.' =>
            'Definiše sledeći status tiketa nakon vraćanja, u prikazu ekrana za povraćaj tiketa interfejsa operatera.',
        'Defines the next state of a ticket after being moved to another queue, in the move ticket screen of the agent interface.' =>
            'Definiše sledeći status tiketa nakon što je pomeren u drugi red u prikazu ekrana pomerenog tiketa interfejsa operatera.',
        'Defines the number of character per line used in case an HTML article preview replacement on TemplateGenerator for EventNotifications.' =>
            'Određuje broj znakova po liniji koji se koriste u slučaju zamene za pregled „HTML” članka u generatoru šablona za obaveštenja o događajima.',
        'Defines the number of days to keep the daemon log files.' => 'Određuje koliko dana će se čuvati datoteke istorijata rada sistemskog servisa',
        'Defines the number of header fields in frontend modules for add and update postmaster filters. It can be up to 99 fields.' =>
            'Odeređuje broj naslovnih polja u pristupnim modulima za dodavanje i ažuriranje glavnih imejl filtera. Može ih biti do 99.',
        'Defines the parameters for the customer preferences table.' => 'Određuje parametre za tabelu podešavanja klijenata.',
        'Defines the parameters for the dashboard backend. "Cmd" is used to specify command with parameters. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTL" indicates the cache expiration period in minutes for the plugin.' =>
            'Definiše parametre pozadinskog prikaza komandne table. "Cmd" se koristi za komandne parametre. "Grupa" se koristi da ograniči pristup plugin-u (npr. Grupa: admin;group1;group2;). "Podrazumevano" ukazuje na to da je plugin podrazumevano aktiviran ili da je potrebno da ga korisnik manuelno aktivira. "CacheTTL" ukazuje na istek perioda u minutima tokom kog se plugin čuva u kešu.',
        'Defines the parameters for the dashboard backend. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTL" indicates the cache expiration period in minutes for the plugin.' =>
            'Definiše parametre za pozadinski prikaz kontrolne table. "Grupa" se koristi da ograniči pristup plugin-u (npr. Grupa: admin;group1;group2;). "Podrazumevano" ukazuje na to da je plugin podrazumevano aktiviran ili da je potrebno da ga korisnik manuelno aktivira. "CacheTTL" ukazje na istek perioda u minutama tokom kog se plugin čuva u kešu.',
        'Defines the parameters for the dashboard backend. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" defines the cache expiration period in minutes for the plugin.' =>
            'Definiše parametre za pozadinski prikaz kontrolne table. "Grupa" se koristi da ograniči pristup plugin-u (npr. Grupa: admin;group1;group2;). "Podrazumevano" ukazuje na to da je plugin podrazumevano aktiviran ili da je potrebno da ga korisnik manuelno aktivira. "CacheTTL" ukazje na istek perioda u minutama tokom kog se plugin čuva u kešu.',
        'Defines the parameters for the dashboard backend. "Limit" defines the number of entries displayed by default. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTL" indicates the cache expiration period in minutes for the plugin.' =>
            'Definiše parametre za pozadinski prikaz kontrolne table. "Limit" definiše broj unosa podrezumevano prikazanih. "Grupa" se koristi da ograniči pristup plugin-u (npr. Grupa: admin;group1;group2;)."Podrazumevano" ukazuje na to da je plugin podrazumevano aktiviran ili da je potrebno da ga korisnik manuelno aktivira. "CacheTTL" ukazje na istek perioda u minutama tokom kog se plugin čuva u kešu.',
        'Defines the parameters for the dashboard backend. "Limit" defines the number of entries displayed by default. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" defines the cache expiration period in minutes for the plugin.' =>
            'Definiše parametre za pozadinski prikaz kontrolne table. "Limit" definiše broj unosa podrezumevano prikazanih. "Grupa" se koristi da ograniči pristup plugin-u (npr. Grupa: admin;group1;group2;)."Podrazumevano" ukazuje na to da je plugin podrazumevano aktiviran ili da je potrebno da ga korisnik manuelno aktivira. "CacheTTL" ukazje na istek perioda u minutama tokom kog se plugin čuva u kešu.',
        'Defines the password to access the SOAP handle (bin/cgi-bin/rpc.pl).' =>
            'Definiše lozinku za pristup SOAP rukovanju (bin/cgi-bin/rpc.pl).',
        'Defines the path and TTF-File to handle bold italic monospaced font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje podebljanim kurzivnim neproporcionalnim fontom ("bold italic monospaced font") u PDF dokumentima.',
        'Defines the path and TTF-File to handle bold italic proportional font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje podebljanim kurzivnim proporcionalnim fontom ("bold italic proportional font") u PDF dokumentima.',
        'Defines the path and TTF-File to handle bold monospaced font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje podebljanim neproporcionalnim fontom ("bold monospaced font") u PDF dokumentima.',
        'Defines the path and TTF-File to handle bold proportional font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje podebljanim proporcionalnim fontom ("bold proportional font") u PDF dokumentima.',
        'Defines the path and TTF-File to handle italic monospaced font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje kurzivnim neproporcionalnim fontom ("italic monospaced font") u PDF dokumentima.',
        'Defines the path and TTF-File to handle italic proportional font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje kurzivnim proporcionalnim fontom ("italic proportional font") u PDF dokumentima.',
        'Defines the path and TTF-File to handle monospaced font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje neproporcionalnim fontom ("monospaced font") u PDF dokumentima.',
        'Defines the path and TTF-File to handle proportional font in PDF documents.' =>
            'Definiše putanju i TTF-Direktorijum za rukovanje proporcionalnim fontom ("proportional font") u PDF dokumentima.',
        'Defines the path of the shown info file, that is located under Kernel/Output/HTML/Templates/Standard/CustomerAccept.tt.' =>
            'Definiše putanju prikazanog info fajla koji je lociran pod Kernel/Output/HTML/Templates/Standard/CustomerAccept.tt.',
        'Defines the path to PGP binary.' => 'Određuje putanju do PGP binary.',
        'Defines the path to open ssl binary. It may need a HOME env ($ENV{HOME} = \'/var/lib/wwwrun\';).' =>
            'Određuje putanju do open ssl binary. Može biti potrebno HOME Env ($ENV{HOME} = \'/var/lib/wwwrun\';).',
        'Defines the postmaster default queue.' => 'Definiše podrazumevani red postmastera.',
        'Defines the priority in which the information is logged and presented.' =>
            'Definiše prioritet po kom se informacije beleže i prikazuju.',
        'Defines the recipient target of the phone ticket and the sender of the email ticket ("Queue" shows all queues, "System address" displays all system addresses) in the agent interface.' =>
            'Određuje ciljnog primaoca telefonskog tiketa i pošiljaoca imejl tiketa ("Red" prikazuje sve redove, "Sistemska adresa" prikazuje sve sistemske adrese) u interfejsu operatera.',
        'Defines the recipient target of the tickets ("Queue" shows all queues, "SystemAddress" shows only the queues which are assigned to system addresses) in the customer interface.' =>
            '',
        'Defines the required permission to show a ticket in the escalation view of the agent interface.' =>
            'Definiše zahtevanu dozvolu za prikaz tiketa u eskalacionom pregledu interfejsa operatera.',
        'Defines the search limit for the stats.' => 'Definiše granicu pretrage za statistike.',
        'Defines the sender for rejected emails.' => 'Definiše pošiljaoca odbijenih imejl poruka.',
        'Defines the separator between the agents real name and the given queue email address.' =>
            'Određuje separator između pravog imena operatera i email adrese dodeljene redu.',
        'Defines the standard permissions available for customers within the application. If more permissions are needed, you can enter them here. Permissions must be hard coded to be effective. Please ensure, when adding any of the afore mentioned permissions, that the "rw" permission remains the last entry.' =>
            'Određuje standardne dozvole raspoložive za korisnike u aplikaciji. Ukoliko je potrebno više dozvola, možete ih uneti ovde. Da bi bile efektivne, dozvole moraju biti nepromenljive. Molimo proverite kada dodajete bilo koju od gore navedenih dozvola, da "rw" dozvola podseća na poslednji unos.',
        'Defines the standard size of PDF pages.' => 'Definiše standardnu veličinu PDF stranica.',
        'Defines the state of a ticket if it gets a follow-up and the ticket was already closed.' =>
            'Definiše stanje tiketa ukoliko dobije nastavak, a tiket je već zatvoen.',
        'Defines the state of a ticket if it gets a follow-up.' => 'Definiše stanje tiketa ukoliko dobije nastavak',
        'Defines the state type of the reminder for pending tickets.' => 'Definiše dip statusa podsetnika za tikete na čekanju.',
        'Defines the subject for notification mails sent to agents, about new password.' =>
            'Definiše predmet za imejl poruke obaveštenja poslata operaterima, o novoj lozinki.',
        'Defines the subject for notification mails sent to agents, with token about new requested password.' =>
            'Definiše predmet za imejl poruke obaveštenja poslata operaterima, sa tokenom o novoj zahtevanoj lozinki.',
        'Defines the subject for notification mails sent to customers, about new account.' =>
            'Određuje predmet za imejl poruke obaveštenja poslata klijentima, o novom nalogu.',
        'Defines the subject for notification mails sent to customers, about new password.' =>
            'Određuje predmet za imejl poruke obaveštenja poslata klijentima, o novoj lozinki.',
        'Defines the subject for notification mails sent to customers, with token about new requested password.' =>
            'Određuje predmet za imejl poruke obaveštenja poslata klijentima, sa tokenom o novoj zahtevanoj lozinki.',
        'Defines the subject for rejected emails.' => 'Definiše predmet za odbačene poruke.',
        'Defines the system administrator\'s email address. It will be displayed in the error screens of the application.' =>
            'Definiše imejl adresu sistem administratora. Ona će biti prikazana na ekranima sa greškom u aplikaciji.',
        'Defines the system identifier. Every ticket number and http session string contains this ID. This ensures that only tickets which belong to your system will be processed as follow-ups (useful when communicating between two instances of OTRS).' =>
            'Definiše identifikator sistema. Svaki broj tiketa i niz znakova http sesije sadrši ovaj ID. Ovo osigurava da će samo tiketi koji pripadaju sistemu biti obrađeni kao operacije praćenja (korisno kada se odvija komunikacija između dve instance OTRS-a.',
        'Defines the target attribute in the link to external customer database. E.g. \'AsPopup PopupType_TicketAction\'.' =>
            'Određuje ciljni atribut u vezi sa eksternom bazom podataka klijenta. Npr. \'AsPopup PopupType_TicketAction\'.',
        'Defines the target attribute in the link to external customer database. E.g. \'target="cdb"\'.' =>
            'Određuje ciljni atribut u vezi sa eksternom bazom podataka klijenta. Npr. \'target="cdb"\'.',
        'Defines the ticket fields that are going to be displayed calendar events. The "Key" defines the field or ticket attribute and the "Content" defines the display name.' =>
            'Definiše polja tiketa koja će biti prikazana u kalendaru događaja. "Ključ" definiše polje ili atribut tiketa, a "Sadržaj" definiše prikazano ime.',
        'Defines the time zone of the indicated calendar, which can be assigned later to a specific queue.' =>
            'Definiše vremensku zonu naznačenog kalendara, koja kasnije može biti dodeljena određenom redu.',
        'Defines the two-factor module to authenticate agents.' => 'Određuje dvofaktorski modul za identifikaciju operatera.',
        'Defines the two-factor module to authenticate customers.' => 'Određuje dvofaktorski modul za identifikaciju klijenata.',
        'Defines the type of protocol, used by the web server, to serve the application. If https protocol will be used instead of plain http, it must be specified here. Since this has no affect on the web server\'s settings or behavior, it will not change the method of access to the application and, if it is wrong, it will not prevent you from logging into the application. This setting is only used as a variable, OTRS_CONFIG_HttpType which is found in all forms of messaging used by the application, to build links to the tickets within your system.' =>
            'Definiše tip protokola korišćenog od strane veb servera, za potrebe aplikacije. Ako se koristi https protokol umesto plain http, mora biti ovde naznačeno. Pošto ovo nema uticaja na podešavanja ili ponašanje veb servera, neće promeniti način pristupa aplikaciji i, ako je to pogrešno, neće vas sprečiti da se prijavite u aplikaciju. Ovo podešavanje se koristi samo kao promenljiva, OTRS_CONFIG_HttpType koja se nalazi u svim oblicima poruka korišćenih od strane aplikacije, da izgrade veze sa tiketima u vašem sistemu.',
        'Defines the used character for plaintext email quotes in the ticket compose screen of the agent interface. If this is empty or inactive, original emails will not be quoted but appended to the response.' =>
            'Definiše korišćene karaktere za plaintext imejl navode u prikazu ekrana otvorenog tiketa interfejsa operatera. Ukoliko je ovo prazno ili neaktivno, originalni imejlovi neće biti navedeni, nego dodati odgovoru.',
        'Defines the user identifier for the customer panel.' => 'Određuje identifikator klijenta za klijentski panel.',
        'Defines the username to access the SOAP handle (bin/cgi-bin/rpc.pl).' =>
            'Definiše korisničko ime za pristup SOAP rukovanju (bin/cgi-bin/rpc.pl).',
        'Defines the valid state types for a ticket.' => 'Definiše važeće tipove statusa za tiket.',
        'Defines the valid states for unlocked tickets. To unlock tickets the script "bin/otrs.Console.pl Maint::Ticket::UnlockTimeout" can be used.' =>
            'Određuje važeće statuse za otključane tikete. Za otključavanje tiketa može se koristiti skript „bin/otrs.Console.pl Maint::Ticket::UnlockTimeout”.',
        'Defines the viewable locks of a ticket. Default: unlock, tmp_lock.' =>
            'Definiše vidljivo zaključavanje tiketa. Podrazumevano: otključano, tmp_lock.',
        'Defines the width for the rich text editor component for this screen. Enter number (pixels) or percent value (relative).' =>
            'Određuje širinu za komponentu rich text editor za ovaj prikaz ekrana. Unesi broj (pikseli) ili procentualnu vrednost (relativnu).',
        'Defines the width for the rich text editor component. Enter number (pixels) or percent value (relative).' =>
            'Određuje širinu za komponentu rich text editor. Unesi broj (pikseli) ili procentualnu vrednost (relativnu).',
        'Defines which article sender types should be shown in the preview of a ticket.' =>
            'Definiše koji tipovi pošiljaoca artikla treba da budu pokazani u prikazu tiketa.',
        'Defines which items are available for \'Action\' in third level of the ACL structure.' =>
            'Definiše koje su stavke slobodne za \'Action\' u trećem nivou ACL strukture.',
        'Defines which items are available in first level of the ACL structure.' =>
            'Definiše koje su stavke slobodne u prvom nivou ACL strukture.',
        'Defines which items are available in second level of the ACL structure.' =>
            'Definiše koje su stavke slobodne u drugom nivou ACL strukture',
        'Defines which states should be set automatically (Content), after the pending time of state (Key) has been reached.' =>
            'Definiše koji statusi treba da budu automatski podešeni (Sadržaj), nakon dostizanja vremena čekanja statusa (Ključ).',
        'Defines wich article type should be expanded when entering the overview. If nothing defined, latest article will be expanded.' =>
            'Definiše koji tip članka treba da bude proširen prilikom ulaska u pregled. Ako ništa nije definisano, poslednji članak će biti proširen.',
        'Defines, which tickets of which ticket state types should not be listed in linked ticket lists.' =>
            'Definiše, koji tiketi od kojih tipova statusa tiketa ne treba da budu prikazani u listi povezanih tiketa.',
        'Delete expired cache from core modules.' => 'Brisanje isteklog keša iz modula jezgra.',
        'Delete expired loader cache weekly (Sunday mornings).' => 'Briše istekli keš učitavanja sedmično (nedeljom ujutro).',
        'Delete expired sessions.' => 'Briše istekle sesije',
        'Delete expired upload cache hourly.' => '',
        'Delete this ticket' => 'Obrišite ovaj tiket',
        'Deleted link to ticket "%s".' => 'Veza na "%s" obrisana.',
        'Deletes a session if the session id is used with an invalid remote IP address.' =>
            'Briše sesiju ukoliko je ID sesije korišćen preko nevažeće udaljene IP adrese.',
        'Deletes requested sessions if they have timed out.' => 'Briše zahtevanu sesiju ako je isteklo vreme.',
        'Delivers extended debugging information in the frontend in case any AJAX errors occur, if enabled.' =>
            '',
        'Deploy and manage OTRS Business Solution™.' => 'Primeni i upravljaj „OTRS poslovno rešenje™”.',
        'Determines if the list of possible queues to move to ticket into should be displayed in a dropdown list or in a new window in the agent interface. If "New Window" is set you can add a move note to the ticket.' =>
            'Određuje da li lista mogućih redova za premeštanje u tiket treba da bude prikazana u padajućoj listi ili u novom prozoru u interfejsu operatera. Ako je podešen "Novi prozor" možete dodavati napomene o premeštanju u tiket.',
        'Determines if the statistics module may generate ticket lists.' =>
            'Određuje da li statistički modul može generisati liste tiketa.',
        'Determines the next possible ticket states, after the creation of a new email ticket in the agent interface.' =>
            'Određuje sledeći mogući status tiketa, nakon kreiranja novog imejl tiketa u interfejsu operatera.',
        'Determines the next possible ticket states, after the creation of a new phone ticket in the agent interface.' =>
            'Određuje sledeći mogući status tiketa, nakon kreiranja novog telefonskog tiketa u interfejsu operatera.',
        'Determines the next possible ticket states, for process tickets in the agent interface.' =>
            'Određuje sledeći mogući status tiketa, za tikete procesa u interfejsu operatera.',
        'Determines the next screen after new customer ticket in the customer interface.' =>
            'Određuje sledeći prikaz ekrana, nakon tiketa novog klijenta u interfejsu klijenta.',
        'Determines the next screen after the follow-up screen of a zoomed ticket in the customer interface.' =>
            'Određuje sledeći ekrana, nakon narednog ekrana detaljnog prikaza tiketa u interfejsu klijenta.',
        'Determines the next screen after the ticket is moved. LastScreenOverview will return the last overview screen (e.g. search results, queueview, dashboard). TicketZoom will return to the TicketZoom.' =>
            'Određuje sledeći prikaz ekrana, nakon premeštanja tiketa. LastScreenOverview će vratiti poslednji pregled ekrana (npr. rezultati pretrage, pregled redova, kontrolna tabla). TicketZoom će vratiti na uvećanje tiketa.',
        'Determines the possible states for pending tickets that changed state after reaching time limit.' =>
            'Određuje mogući status za tikete na čekanju koji menjaju status nakon dostizanja vremenskog limita.',
        'Determines the strings that will be shown as recipient (To:) of the phone ticket and as sender (From:) of the email ticket in the agent interface. For Queue as NewQueueSelectionType "<Queue>" shows the names of the queues and for SystemAddress "<Realname> <<Email>>" shows the name and email of the recipient.' =>
            'Određuje frazu koje će biti prikazana kao primalac (Za:) telefonskog tiketa i kao pošiljalac (Od:) imejl tiketa u interfejsu operatera. Za Red kao „NewQueueSelectionType” „<Queue>” prikazuje nazive redova, a za Sistemsku adresu „<Realname> <<Email>>” prikazuje ime i imejl primaoca.',
        'Determines the strings that will be shown as recipient (To:) of the ticket in the customer interface. For Queue as CustomerPanelSelectionType, "<Queue>" shows the names of the queues, and for SystemAddress, "<Realname> <<Email>>" shows the name and email of the recipient.' =>
            'Određuje frazu koja će biti prikazana kao primalac (Za:) tiket u interfejsu klijenta. Za Red kao „CustomerPanelSelectionType” „<Queue>” prikazuje imena redova i za Sistemsku adresu „<Realname> <<Email>>” prikazuje ime i imejl primaoca.',
        'Determines the way the linked objects are displayed in each zoom mask.' =>
            'Određuje način na koji se povezani objekti prikazuju u svakoj uvećanoj maski.',
        'Determines which options will be valid of the recipient (phone ticket) and the sender (email ticket) in the agent interface.' =>
            'Određuje koje opcije će biti važeće za primaoca (telefonski tiket) i pošiljaoca (imejl tiket) u interfejsu operatera.',
        'Determines which queues will be valid for ticket\'s recepients in the customer interface.' =>
            'Određuje koji će redovi biti važeći za tikete primaoca u interfejsu klijenta.',
        'Disable HTTP header "X-Frame-Options: SAMEORIGIN" to allow OTRS to be included as an IFrame in other websites. Disabling this HTTP header can be a security issue! Only disable it, if you know what you are doing!' =>
            '',
        'Disables sending reminder notifications to the responsible agent of a ticket (Ticket::Responsible needs to be activated).' =>
            'Onemogućuje slanje obaveštenja podsetnika odgovornom operateru tiketa (Ticket::Responsible mora biti aktiviran).',
        'Disables the communication between this system and OTRS Group servers that provides cloud services. If active, some functionality will be lost such as system registration, support data sending, upgrading to and use of OTRS Business Solution™, OTRS Verify™, OTRS News and product News dashboard widgets, among others.' =>
            '',
        'Disables the web installer (http://yourhost.example.com/otrs/installer.pl), to prevent the system from being hijacked. If set to "No", the system can be reinstalled and the current basic configuration will be used to pre-populate the questions within the installer script. If not active, it also disables the GenericAgent, PackageManager and SQL Box.' =>
            'Onemogućuje veb instalacionom programu (http://yourhost.example.com/otrs/installer.pl) da zaštiti sistem od nedozvoljenog preuzimanja. Ako podesite na "Ne", sistem može biti ponovo instaliran i trenutna osnovna konfiguracija će biti korišćena da unapred popuni pitanja unutar instalacione skripte. Ukoliko nije aktivno, takođe se onemogućuju GenericAgent, PackageManager i SQL Box.',
        'Display a warning and prevent search when using stop words within fulltext search.' =>
            'Prikaži upozorenje i onemogući pretragu ako su upotrebljene zaustavne reči u pretrazi kompletnog teksta.',
        'Display settings to override defaults for Process Tickets.' => 'Prikaži podešavanja da bi ste zamenili podrazumevana za tikete procesa.',
        'Displays the accounted time for an article in the ticket zoom view.' =>
            'Prikazuje obračunato vreme za jedan članak u prikazu uvećanog tiketa.',
        'Down' => 'Dole',
        'Dropdown' => 'Padajući',
        'Dutch stop words for fulltext index. These words will be removed from the search index.' =>
            'Holandske zaustavne reči za indeks pretrage kompletnog teksta. Ove reči će biti uklonjene iz indeksa pretrage.',
        'Dynamic Fields Checkbox Backend GUI' => 'Pozadinski prikaz dinamičkog polja za potvrdu',
        'Dynamic Fields Date Time Backend GUI' => 'Pozadinski prikaz dinamičkog polja za datum i vreme',
        'Dynamic Fields Drop-down Backend GUI' => 'Pozadinski prikaz padajućeg dinamičkog polja',
        'Dynamic Fields GUI' => 'Dinamička polja GUI',
        'Dynamic Fields Multiselect Backend GUI' => 'Pozadinski prikaz dinamičkog polja sa višestrukim izborom',
        'Dynamic Fields Overview Limit' => 'Ograničen pregled dinamičkih polja',
        'Dynamic Fields Text Backend GUI' => 'Pozadinski prikaz tekstualnog dinamičkog polja',
        'Dynamic Fields used to export the search result in CSV format.' =>
            'Dinamička polja korišćena za izvoz rezultata pretrage u CSV format.',
        'Dynamic fields groups for process widget. The key is the name of the group, the value contains the fields to be shown. Example: \'Key => My Group\', \'Content: Name_X, NameY\'.' =>
            'Grupe dinamičkih polja za obradu aplikativnog dodatka (widget). Ključ je naziv grupe, vrednost sadrži polje koje će biti prikazano. Primer: \'Key => My Group\', \'Content: Name_X, NameY\'.',
        'Dynamic fields limit per page for Dynamic Fields Overview' => 'Ograničenje dinamičkih polja po strani za prikaz dinamičkih polja.',
        'Dynamic fields options shown in the ticket message screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required. NOTE. If you want to display these fields also in the ticket zoom of the customer interface, you have to enable them in CustomerTicketZoom###DynamicField.' =>
            'Opcije dinamičkih polja prikazane na ekranu poruke tiketa interfejsa klijenta. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno. NAPOMENA: Ako želite da prikažete ova polja takođe i pri uvećanom prikazu ekrana tiketa interfejsa klijenta, treba da ih omogućite u CustomerTicketZoom###DynamicField.',
        'Dynamic fields options shown in the ticket reply section in the ticket zoom screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Opcije dinamičkih polja prikazane u odeljku odgovora tiketa pri uvećanom prikazu ekrana tiketa interfejsa klijenta. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno.',
        'Dynamic fields shown in the email outbound screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu odlaznih imejlova interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno.',
        'Dynamic fields shown in the process widget in ticket zoom screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana u procesu aplikativnog dodatka (widget-a) pri uvećanom prikazu ekrana tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the sidebar of the ticket zoom screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana u izvojenom delu uvećanog prikaza ekrana tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the ticket close screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu zatvorenog tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket compose screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu otvorenog tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano',
        'Dynamic fields shown in the ticket email screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu imejl tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano',
        'Dynamic fields shown in the ticket forward screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu prosleđenog tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano',
        'Dynamic fields shown in the ticket free text screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu tiketa slobodnog teksta interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano',
        'Dynamic fields shown in the ticket medium format overview screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana na ekranu pregleda srednjeg formata tiketa slobodnog teksta interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the ticket move screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu premeštenog tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket note screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu napomene tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket overview screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu pregleda tiketa interfejsa klijenta. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i neophodno.',
        'Dynamic fields shown in the ticket owner screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu vlasnika tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket pending screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu tiketa na čekanju interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket phone inbound screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu tiketa dolaznih telefonskih poziva interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket phone outbound screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu tiketa odlaznih telefonskih poziva interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket phone screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu telefonskih tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket preview format overview screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja pokazana na ekranu prikaza pregleda formata tiketa u interfejsu operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the ticket print screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana na ekranu štampe tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the ticket print screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana na ekranu štampe tiketa interfejsa klijenta. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the ticket priority screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu prioritetnog tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket responsible screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and required.' =>
            'Dinamička polja prikazana na ekranu odgovornog za tiket interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket search overview results screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana na ekranu pregleda rezultata pretrage tiketa interfejsa klijenta. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the ticket search screen of the agent interface. Possible settings: 0 = Disabled, 1 = Enabled, 2 = Enabled and shown by default.' =>
            'Dinamička polja prikazana na ekranu pretrage tiketa interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i prikazano u startu.',
        'Dynamic fields shown in the ticket search screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana na ekranu pretrage tiketa interfejsa klijenta. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'Dynamic fields shown in the ticket small format overview screen of the agent interface. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.' =>
            'Dinamička polja prikazana na ekranu pregleda malog formata tiketa slobodnog teksta interfejsa operatera. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno, 2 = Omogućeno i zahtevano.',
        'Dynamic fields shown in the ticket zoom screen of the customer interface. Possible settings: 0 = Disabled, 1 = Enabled.' =>
            'Dinamička polja prikazana na ekranu uvećanog tiketa interfejsa klijenta. Moguća podešavanja: 0 = Onemogućeno, 1 = Omogućeno.',
        'DynamicField' => '',
        'DynamicField backend registration.' => 'Pozadinska registarcija  dinamičkih polja.',
        'DynamicField object registration.' => 'Registarcija objekta dinamičkih polja.',
        'E-Mail Outbound' => 'Odlazni imejl',
        'Edit Customer Companies.' => '',
        'Edit Customer Users.' => '',
        'Edit customer company' => 'Izmeni firmu klijenta',
        'Email Addresses' => 'Imejl adrese',
        'Email Outbound' => '',
        'Email sent to "%s".' => 'Poslat odgovor "%s".',
        'Email sent to customer.' => 'Imejl poslat klijentu.',
        'Enable keep-alive connection header for SOAP responses.' => 'Omogući zaglavlje za održanje aktivne konekcije za „SOAP” odgovore.',
        'Enabled filters.' => 'Omogućeni filteri.',
        'Enables PGP support. When PGP support is enabled for signing and encrypting mail, it is HIGHLY recommended that the web server runs as the OTRS user. Otherwise, there will be problems with the privileges when accessing .gnupg folder.' =>
            'Obezbeđuje PGP podršku. Kada je PGP podrška omogućena za potpisivanje i enkriprovanje mejla, strogo se preporučuje da veb server radi kao OTRS korisnik. U suprotnom, biće problema sa privilegijama prilikom pristupa .gnupg folderu.',
        'Enables S/MIME support.' => 'Omogućava S/MIME podršku.',
        'Enables customers to create their own accounts.' => 'Omogućava klijentima da kreiraju sopstvene naloge.',
        'Enables file upload in the package manager frontend.' => 'Omogućava slanje datoteka u upravljaču paketima pristupnog sistema.',
        'Enables or disables the caching for templates. WARNING: Do NOT disable template caching for production environments for it will cause a massive performance drop! This setting should only be disabled for debugging reasons!' =>
            'Aktivira ili deaktivira keširanje za šablone. UPOZORENJE: NEMOJTE isključivati keširanje šablona na sistemima u radu jer će to dovesti do ogromnog pada performansi. Ovo podešavanje treba koristiti samo u cilju nalaženja i otklanjanja grešaka!',
        'Enables or disables the debug mode over frontend interface.' => 'Uključuje ili isključuje mod traženja grešaka preko pristupnog interfejsa.',
        'Enables or disables the ticket watcher feature, to keep track of tickets without being the owner nor the responsible.' =>
            'Aktivira ili isključuje mogućnost nadzora tiketa, radi praćenja tiketa bez vlasnika ili odgovorne osobe.',
        'Enables performance log (to log the page response time). It will affect the system performance. Frontend::Module###AdminPerformanceLog must be enabled.' =>
            'Omogućuje logovanje performansi (vreme izvršavanja strane). Utiče na performanse sistema. Opcija Frontend::Module###AdminPerformanceLog mora biti omogućena.',
        'Enables spell checker support.' => 'Omogućava podršku za proveru pravopisa.',
        'Enables the minimal ticket counter size (if "Date" was selected as TicketNumberGenerator).' =>
            'Aktivira minimalnu veličinu brojača tiketa (ako je izabran „datum” kao generator broja tiketa).',
        'Enables ticket bulk action feature for the agent frontend to work on more than one ticket at a time.' =>
            'Aktivira funkciju masovne akcije na tiketima za operaterski pristupni sistem na više tiketa istovremeno.',
        'Enables ticket bulk action feature only for the listed groups.' =>
            'Aktivira funkciju masovne akcije na tiketima samo za izlistane grupe.',
        'Enables ticket responsible feature, to keep track of a specific ticket.' =>
            'Aktivira funkciju odgovornog za tiket radi evidentiranja specifičnog tiketa',
        'Enables ticket watcher feature only for the listed groups.' => 'Aktivira funkciju nadzora tiketa samo za izlistane grupe.',
        'English (Canada)' => 'Engleski (Kanada)',
        'English (United Kingdom)' => 'Engleski (Ujedinjeno Kraljevstvo)',
        'English (United States)' => 'Engleski (Sjedinjene Države)',
        'English stop words for fulltext index. These words will be removed from the search index.' =>
            'Engleske zaustavne reči za indeks pretrage kompletnog teksta. Ove reči će biti uklonjene iz indeksa pretrage.',
        'Enroll process for this ticket' => 'Upiši proces za ovaj tiket',
        'Enter your shared secret to enable two factor authentication.' =>
            'Unesite svoj deljeni tajni ključ za dvofaktorski modul za identifikaciju.',
        'Escalated Tickets' => 'Eskalirani tiketi',
        'Escalation response time finished' => 'Isteklo vreme odgovora na eskalaciju',
        'Escalation response time forewarned' => 'Prethodno upozorenje za vreme odgovora na eskalaciju',
        'Escalation response time in effect' => 'Aktuelno vreme odgovora na eskalaciju',
        'Escalation solution time finished' => 'Isteklo vreme rešavanja eskalacije',
        'Escalation solution time forewarned' => 'Prethodno upozorenje za vreme rešavanja eskalacije',
        'Escalation solution time in effect' => 'Aktuelnoo vreme rešavanja eskalacije',
        'Escalation update time finished' => 'Isteklo vreme ažuriranja eskalacije',
        'Escalation update time forewarned' => 'Prethodno upozorenje za vreme ažuriranja eskalacije',
        'Escalation update time in effect' => 'Aktuelno vreme ažuriranja eskalacije',
        'Escalation view' => 'Pregled eskalacija',
        'EscalationTime' => 'Vreme eskalacije',
        'Estonian' => 'Estonski',
        'Event module registration. For more performance you can define a trigger event (e. g. Event => TicketCreate).' =>
            'Registracija modula događaja. Za bolji učinak možete definisati događaj okidač (npr Događaj => KreiranjeTiketa).',
        'Event module registration. For more performance you can define a trigger event (e. g. Event => TicketCreate). This is only possible if all Ticket dynamic fields need the same event.' =>
            'Registracija modula događaja. Za bolji učinak možete definisati događaj okidač (npr Događaj => KreiranjeTiketa). Ovo je moguće samo ako svim dinamičkim poljima tiketa treba isti događaj.',
        'Event module that performs an update statement on TicketIndex to rename the queue name there if needed and if StaticDB is actually used.' =>
            'Modul događaja koji izvršava ažuriranje na indeksu tiketa radi promene naziva reda ako je potrebno i ako je stvarno upotrebljena statička baza podataka.',
        'Event module that updates customer company object name for dynamic fields.' =>
            '',
        'Event module that updates customer user object name for dynamic fields.' =>
            '',
        'Event module that updates customer user search profiles if login changes.' =>
            'Modul događaja koji ažurira profile pretrage klijent korisnika ako se promeni prijava.',
        'Event module that updates customer user service membership if login changes.' =>
            'Modul događaja koji ažurira servisno članstvo klijenta korisnika ako se promeni prijava.',
        'Event module that updates customer users after an update of the Customer.' =>
            'Modul događaja koji ažurira klijenta korisnika posle ažuriranja klijenta.',
        'Event module that updates tickets after an update of the Customer User.' =>
            'Modul događaja koji ažurira tikete posle ažuriranja klijenta korisnika.',
        'Event module that updates tickets after an update of the Customer.' =>
            'Modul događaja koji ažurira tikete posle ažuriranja korisnika.',
        'Events Ticket Calendar' => 'Kalendar događaja tiketa',
        'Execute SQL statements.' => 'Izvrši SQL naredbe.',
        'Executes a custom command or module. Note: if module is used, function is required.' =>
            'Izvršava prilagođenu komandu ili modul. Napomena: ako je upotrebljen modul, funkcija je neophodna.',
        'Executes follow-up checks on In-Reply-To or References headers for mails that don\'t have a ticket number in the subject.' =>
            'Izvršava provere za nastavak tiketa na In-Reply-To ili References zaglavljima imejla koji nemaju broj tiketa u predmetu.',
        'Executes follow-up checks on attachment contents for mails that don\'t have a ticket number in the subject.' =>
            'Izvršava proveru nastavljanja u sadržaju priloga za imejlove koji nemaju broj tiketa u predmetu.',
        'Executes follow-up checks on email body for mails that don\'t have a ticket number in the subject.' =>
            'Izvršava proveru nastavljanja u sadržaju imejla za poruke koje nemaju broj tiketa u predmetu.',
        'Executes follow-up checks on the raw source email for mails that don\'t have a ticket number in the subject.' =>
            'Izvršava proveru nastavljanja u sirovom izvoru imejla za imejlove koji nemaju broj tiketa u predmetu.',
        'Exports the whole article tree in search result (it can affect the system performance).' =>
            'Izvozi celo stablo članaka u rezultat pretrage (može ozbiljno da utiče na performanse sistema).',
        'Fetch emails via fetchmail (using SSL).' => 'Preuzima imejlove preko fetchmail programa (putem SSL).',
        'Fetch emails via fetchmail.' => 'Preuzima imejlove preko fetchmail programa.',
        'Fetch incoming emails from configured mail accounts.' => 'Preuzimanje ',
        'Fetches packages via proxy. Overwrites "WebUserAgent::Proxy".' =>
            'Preuzima pakete preko proxy servera. Preinačuje opciju "WebUserAgent::Proxy".',
        'File that is displayed in the Kernel::Modules::AgentInfo module, if located under Kernel/Output/HTML/Templates/Standard/AgentInfo.tt.' =>
            'Datoteka za prikaz u modulu Kernel::Modules::AgentInfo, ukoliko je snimljena pod Kernel/Output/HTML/Templates/Standard/AgentInfo.tt.',
        'Filter for debugging ACLs. Note: More ticket attributes can be added in the format <OTRS_TICKET_Attribute> e.g. <OTRS_TICKET_Priority>.' =>
            'Filter za otklanjanje grešaka u „ACL” listama. Napomena: atributi tiketa mogu biti dodati u formatu <OTRS_TICKET_Attribute> npr. <OTRS_TICKET_Priority>.',
        'Filter for debugging Transitions. Note: More filters can be added in the format <OTRS_TICKET_Attribute> e.g. <OTRS_TICKET_Priority>.' =>
            'Filter za otklanjanje grešaka kod tranzicija. Napomena: filteri mogu biti dodati u formatu <OTRS_TICKET_Attribute> npr. <OTRS_TICKET_Priority>.',
        'Filter incoming emails.' => 'Filtriranje dolaznih poruka.',
        'Finnish' => 'Finski',
        'First Christmas Day' => 'Prvi dan Božića',
        'First Queue' => 'Prvi red',
        'FirstLock' => 'FirstLock',
        'FirstResponse' => 'FirstResponse',
        'FirstResponseDiffInMin' => 'FirstResponseDiffInMin',
        'FirstResponseInMin' => 'FirstResponseInMin',
        'Firstname Lastname' => 'Ime Prezime',
        'Firstname Lastname (UserLogin)' => 'Ime Prezime (Prijava korisnika)',
        'FollowUp for [%s]. %s' => 'Nastavak za [%s]. %s',
        'For these state types the ticket numbers are striked through in the link table.' =>
            '',
        'Forces encoding of outgoing emails (7bit|8bit|quoted-printable|base64).' =>
            'Nameće šifriranje odlaznih imejlova (7bit|8bit|quoted-printable|base64).',
        'Forces to choose a different ticket state (from current) after lock action. Define the current state as key, and the next state after lock action as content.' =>
            'Nameće izbor različitog statusa tiketa (od aktuelnog) posle akcije zaključavanja. Definiše aktuelni status kao ključ, a sledeći status posle zaključavanja kao sadržaj.',
        'Forces to unlock tickets after being moved to another queue.' =>
            'Prinudno otključava tikete posle premeštanja u drugi red.',
        'Forwarded to "%s".' => 'Prosleđeno "%s".',
        'Free Fields' => 'Slobodna polja',
        'French' => 'Francuski',
        'French (Canada)' => 'Francuski (Kanada)',
        'French stop words for fulltext index. These words will be removed from the search index.' =>
            'Francuske zaustavne reči za indeks pretrage kompletnog teksta. Ove reči će biti uklonjene iz indeksa pretrage.',
        'Frontend' => '',
        'Frontend module registration (disable AgentTicketService link if Ticket Serivice feature is not used).' =>
            'Registracija modula pristupa (onemogućite vezu „AgentTicketService” ako se ne koristi Tiket servis).',
        'Frontend module registration (disable company link if no company feature is used).' =>
            'Registracija modula pristupa (onemogućite vezu „preduzeće” ako se ne koristi svojstvo preduzeće).',
        'Frontend module registration (disable ticket processes screen if no process available) for Customer.' =>
            'Registracija modula pristupa (onemogućite ekran procesa tiketa ako proces nije raspoloživ) za Klijenta.',
        'Frontend module registration (disable ticket processes screen if no process available).' =>
            'Registracija modula pristupa (onemogućite ekran procesa tiketa ako proces nije raspoloživ).',
        'Frontend module registration for the agent interface.' => 'Registracija modula pristupa za interfejs operatera.',
        'Frontend module registration for the customer interface.' => 'Registracija modula pristupa za interfejs klijenta.',
        'Frontend theme' => 'Izgled pristupnog sistema',
        'Full value' => 'Cela vrednost',
        'Fulltext index regex filters to remove parts of the text.' => 'Tekst indeks RegEx filteri za uklanjanje delova teksta.',
        'Fulltext search' => 'Tekst za pretragu',
        'Galician' => 'Galicijski',
        'General ticket data shown in the ticket overviews (fall-back). Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default. Note that TicketNumber can not be disabled, because it is necessary.' =>
            'Opšti podaci tiketa prikazani u pregledu tiketa (rezerva). Moguća podešavanja: 0 = Onemogućeno, 1 = Dostupno, 2 = Omogućeno (podrazumevano). Napominjemo da TicketNumber ne može biti onemogućen, jer je neophodan.',
        'Generate dashboard statistics.' => 'Generiši statistike kontrolne table.',
        'Generic Info module.' => '',
        'GenericAgent' => 'Opšti operater',
        'GenericInterface Debugger GUI' => 'Opšti interfejs - GKI otklanjanja grešaka.',
        'GenericInterface Invoker GUI' => 'Opšti interfejs - GKI pozivaoca.',
        'GenericInterface Operation GUI' => 'Opšti interfejs - operativni GKI.',
        'GenericInterface TransportHTTPREST GUI' => 'Opšti interfejs - GKI REST HTTP transporta.',
        'GenericInterface TransportHTTPSOAP GUI' => 'Opšti interfejs - GKI SOAP HTTP transporta.',
        'GenericInterface Web Service GUI' => 'Opšti interfejs - GKI veb servisa.',
        'GenericInterface Webservice History GUI' => 'Opšti interfejs - GKI istorijata veb servisa.',
        'GenericInterface Webservice Mapping GUI' => 'Opšti interfejs - GKI mapiranje veb servisa.',
        'GenericInterface module registration for the invoker layer.' => 'Registracija modula opšteg interfejsa za sloj pozivaoca.',
        'GenericInterface module registration for the mapping layer.' => 'Registracija modula opšteg interfejsa za sloj mapiranja.',
        'GenericInterface module registration for the operation layer.' =>
            'Registracija modula opšteg interfejsa za operativni sloj.',
        'GenericInterface module registration for the transport layer.' =>
            'Registracija modula opšteg interfejsa za transportni sloj.',
        'German' => 'Nemački',
        'German stop words for fulltext index. These words will be removed from the search index.' =>
            'Nemačke zaustavne reči za indeks pretragu kompletnog teksta. Ove reči će biti uklonjene iz indeksa pretrage.',
        'Gives end users the possibility to override the separator character for CSV files, defined in the translation files.' =>
            'Omogućava krajnjim korisnicima da zamene separator za CSV datoteke, definisan u datotekama prevoda.',
        'Global Search Module.' => '',
        'Go back' => 'Idi nazad',
        'Go to dashboard!' => 'Idi na komandnu tablu!',
        'Google Authenticator' => 'Gugl autentifikacija',
        'Graph: Bar Chart' => '',
        'Graph: Line Chart' => '',
        'Graph: Stacked Area Chart' => '',
        'Greek' => 'Grčki',
        'HTML Reference' => '',
        'HTML Reference.' => '',
        'Hebrew' => 'Hebrejski',
        'Helps to extend your articles full-text search (From, To, Cc, Subject and Body search). Runtime will do full-text searches on live data (it works fine for up to 50.000 tickets). StaticDB will strip all articles and will build an index after article creation, increasing fulltext searches about 50%. To create an initial index use "bin/otrs.Console.pl Maint::Ticket::FulltextIndexRebuild".' =>
            'Omogućuje proširenu tekstualnu pretragu vaših članaka (pretraga po poljima Od, Za, Cc, Predmet i Sadržaj). RuntimeDB će vršiti pretragu postojećih podataka (daje dobre performanse za do 50.000 tiketa). StaticDB će ignorisati sve članke i napraviće indeks pretrage po kreiranju članka, ubrzavajući tekstualnu pretragu za oko 50%. Za kreiranje početnog indeksa koristite "bin/otrs.Console.pl Maint::Ticket::FulltextIndexRebuild".',
        'Hindi' => 'Hindi',
        'Hungarian' => 'Mađarski',
        'If "DB" was selected for Customer::AuthModule, a database driver (normally autodetection is used) can be specified.' =>
            'Ukoliko je izabrano "DB" za Customer::AuthModule, moguće je podesiti drajver baze podataka (obično se koristi automatsko prepoznavanje).',
        'If "DB" was selected for Customer::AuthModule, a password to connect to the customer table can be specified.' =>
            'Ukoliko je izabrano "DB" za Customer::AuthModule, moguće je podesiti lozinku za tabelu korisnika.',
        'If "DB" was selected for Customer::AuthModule, a username to connect to the customer table can be specified.' =>
            'Ukoliko je izabrano "DB" za Customer::AuthModule, moguće je podesiti korisničko ime za tabelu korisnika.',
        'If "DB" was selected for Customer::AuthModule, the DSN for the connection to the customer table must be specified.' =>
            'Ukoliko je izabrano "DB" za Customer::AuthModule, neophodno je podesiti DSN za konekciju ka tabeli korisnika.',
        'If "DB" was selected for Customer::AuthModule, the column name for the CustomerPassword in the customer table must be specified.' =>
            'Ukoliko je izabrano "DB" za Customer::AuthModule, neophodno je podesiti naziv kolone za CustomerPassword u tabeli korisnika.',
        'If "DB" was selected for Customer::AuthModule, the encryption type of passwords must be specified.' =>
            '',
        'If "DB" was selected for Customer::AuthModule, the name of the column for the CustomerKey in the customer table must be specified.' =>
            'Ukoliko je izabrano "DB" za Customer::AuthModule, neophodno je podesiti naziv kolone za CustomerKey u tabeli korisnika.',
        'If "DB" was selected for Customer::AuthModule, the name of the table where your customer data should be stored must be specified.' =>
            'Ukoliko je izabrano "DB" za Customer::AuthModule, neophodno je podesiti naziv tabele gde se čuvaju korisnički podaci.',
        'If "DB" was selected for SessionModule, a table in database where session data will be stored must be specified.' =>
            'Ukoliko je izabrano "DB" za SessionModule, neophodno je podesiti naziv tabele gde će se čuvati podaci sesija.',
        'If "FS" was selected for SessionModule, a directory where the session data will be stored must be specified.' =>
            'Ukoliko je izabrano "FS" za SessionModule, neophodno je podesiti naziv direktorijuma gde će se čuvati podaci sesija.',
        'If "HTTPBasicAuth" was selected for Customer::AuthModule, you can specify (by using a RegExp) to strip parts of REMOTE_USER (e. g. for to remove trailing domains). RegExp-Note, $1 will be the new Login.' =>
            '',
        'If "HTTPBasicAuth" was selected for Customer::AuthModule, you can specify to strip leading parts of user names (e. g. for domains like example_domain\user to user).' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and if you want to add a suffix to every customer login name, specifiy it here, e. g. you just want to write the username user but in your LDAP directory exists user@domain.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and special paramaters are needed for the Net::LDAP perl module, you can specify them here. See "perldoc Net::LDAP" for more information about the parameters.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and your users have only anonymous access to the LDAP tree, but you want to search through the data, you can do this with a user who has access to the LDAP directory. Specify the password for this special user here.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule and your users have only anonymous access to the LDAP tree, but you want to search through the data, you can do this with a user who has access to the LDAP directory. Specify the username for this special user here.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, the BaseDN must be specified.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, the LDAP host can be specified.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, the user identifier must be specified.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, user attributes can be specified. For LDAP posixGroups use UID, for non LDAP posixGroups use full user DN.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, you can specify access attributes here.' =>
            '',
        'If "LDAP" was selected for Customer::AuthModule, you can specify if the applications will stop if e. g. a connection to a server can\'t be established due to network problems.' =>
            '',
        'If "LDAP" was selected for Customer::Authmodule, you can check if the user is allowed to authenticate because he is in a posixGroup, e.g. user needs to be in a group xyz to use OTRS. Specify the group, who may access the system.' =>
            '',
        'If "LDAP" was selected, you can add a filter to each LDAP query, e.g. (mail=*), (objectclass=user) or (!objectclass=computer).' =>
            '',
        'If "Radius" was selected for Customer::AuthModule, the password to authenticate to the radius host must be specified.' =>
            '',
        'If "Radius" was selected for Customer::AuthModule, the radius host must be specified.' =>
            '',
        'If "Radius" was selected for Customer::AuthModule, you can specify if the applications will stop if e. g. a connection to a server can\'t be established due to network problems.' =>
            '',
        'If "Sendmail" was selected as SendmailModule, the location of the sendmail binary and the needed options must be specified.' =>
            '',
        'If "SysLog" was selected for LogModule, a special log facility can be specified.' =>
            '',
        'If "SysLog" was selected for LogModule, the charset that should be used for logging can be specified.' =>
            '',
        'If "file" was selected for LogModule, a logfile must be specified. If the file doesn\'t exist, it will be created by the system.' =>
            '',
        'If a note is added by an agent, sets the state of a ticket in the close ticket screen of the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa u prikazu ekrana zatvaranja tiketa interfejsa operatera.',
        'If a note is added by an agent, sets the state of a ticket in the ticket bulk screen of the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa na ekranu masovne akcije tiketa interfejsa operatera.',
        'If a note is added by an agent, sets the state of a ticket in the ticket free text screen of the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa na ekranu slobodnog teksta tiketa interfejsa operatera.',
        'If a note is added by an agent, sets the state of a ticket in the ticket note screen of the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa na ekranu napomene tiketa interfejsa operatera.',
        'If a note is added by an agent, sets the state of a ticket in the ticket responsible screen of the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa na ekranu odgovornog za tiket interfejsa operatera.',
        'If a note is added by an agent, sets the state of the ticket in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa na ekranu vlasnika tiketa u detaljnom prikazu tiketa interfejsa operatera.',
        'If a note is added by an agent, sets the state of the ticket in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa na ekranu tiketa na čekanju u detaljnom prikazu tiketa interfejsa operatera.',
        'If a note is added by an agent, sets the state of the ticket in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Ako je operater dodao napomenu, podešava status tiketa na ekranu prioriteta tiketa u detaljnom prikazu tiketa interfejsa operatera.',
        'If active, none of the regular expressions may match the user\'s email address to allow registration.' =>
            'Ako je aktivno, ni jedan regularni izraz se ne može poklopiti sa korisnikovom imejl adresom da bi dozvolio registraciju.',
        'If active, one of the regular expressions has to match the user\'s email address to allow registration.' =>
            'Ako je aktivno, jedan regularni izraz se mora poklopiti sa korisnikovom imejl adresom da bi dozvolio registraciju.',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, and authentication to the mail server is needed, a password must be specified.' =>
            '',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, and authentication to the mail server is needed, an username must be specified.' =>
            '',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, the mailhost that sends out the mails must be specified.' =>
            '',
        'If any of the "SMTP" mechanisms was selected as SendmailModule, the port where your mailserver is listening for incoming connections must be specified.' =>
            '',
        'If enabled debugging information for ACLs is logged.' => 'Ako je aktivirano, ispravljanje grešaka za ACL se beleži.',
        'If enabled debugging information for transitions is logged.' => 'Ako je aktivirano, ispravljanje grešaka za tranzicije se beleži.',
        'If enabled the daemon will redirect the standard error stream to a log file.' =>
            'Ako je aktivirano servis će preusmeriti standardni tok greške u datoteku dnevnika.',
        'If enabled the daemon will redirect the standard output stream to a log file.' =>
            'Ako je aktivirano servis će preusmeriti standardni izlazni tok u datoteku dnevnika.',
        'If enabled, OTRS will deliver all CSS files in minified form.' =>
            '',
        'If enabled, OTRS will deliver all JavaScript files in minified form.' =>
            'Ako je aktivirano, „OTRS” će isporučiti sve javaskript datoteke u smanjenoj formi.',
        'If enabled, TicketPhone and TicketEmail will be open in new windows.' =>
            'Ako je aktivirano, telefonski i imejl tiketi će biti otvoreni u novom prozoru.',
        'If enabled, the OTRS version tag will be removed from the Webinterface, the HTTP headers and the X-Headers of outgoing mails.' =>
            '',
        'If enabled, the customer can search for tickets in all services (regardless what services are assigned to the customer).' =>
            'Ako je aktivirano, klijent može pretraživati tikete u svim servisima (bez obzira na to koji servisi su dodeljeni klijentu).',
        'If enabled, the different overviews (Dashboard, LockedView, QueueView) will automatically refresh after the specified time.' =>
            'Ako je aktivirinao, različiti pregledi (Kontrolna tabla, Zaključavanje, Redovi) će se automatski osvežiti posle zadatog vremena.',
        'If enabled, the first level of the main menu opens on mouse hover (instead of click only).' =>
            'Ako je aktivirano, prvi nivo glavnog menija se otvara na prelaz miša (umesto samo na klik).',
        'If enabled, users that haven\'t selected a time zone yet will be notified to do so. Note: Notification will not be shown if (1) user has not yet selected a time zone and (2) OTRSTimeZone and UserDefaultTimeZone do match and (3) are not set to UTC.' =>
            '',
        'If set, this address is used as envelope sender header in outgoing notifications. If no address is specified, the envelope sender header is empty.' =>
            'Ako je podešeno ova adresa se koristi kao okvir zaglavlja pošiljaoca u odlaznim obaveštenjima. Ako adresa nije uneta, okvir zaglavlja pošiljaoca je prazan.',
        'If set, this address is used as envelope sender in outgoing messages (not notifications - see below). If no address is specified, the envelope sender is equal to queue e-mail address.' =>
            'Ako je podešeno ova adresa se koristi kao okvir zaglavlja pošiljaoca u odlaznim porukama (ne za obaveštenja - vidi niže). Ako adresa nije uneta, okvir zaglavlja pošiljaoca je jednak imejl adresi reda.',
        'If this option is enabled, then the decrypted data will be stored in the database if they are displayed in AgentTicketZoom.' =>
            'Ako je ova opcija aktivirana, onda će dešifrovani podaci biti smešteni u bazu podataka ako su prikazani na detaljnom prikazu tiketa u interfejsu operatera.',
        'If this option is set to \'Yes\', tickets created via the web interface, via Customers or Agents, will receive an autoresponse if configured. If this option is set to \'No\', no autoresponses will be sent.' =>
            'Ako je ova opcija podešena kao „Da”, tiketi kreirani preko veb interfejsa od strane klijenata ili operatera, će ako je podešen dobiti automatski odgovor. Ako je ova opcija podešena kao „Ne”, automatski odgovori neće biti slani.',
        'If this regex matches, no message will be send by the autoresponder.' =>
            'Ako se ovaj izraz poklapa, automatski odgovarač neće poslati nijednu poruku.',
        'If this setting is active, local modifications will not be highlighted as errors in the package manager and support data collector.' =>
            '',
        'Ignore article with system sender type for new article feature (e. g. auto responses or email notifications).' =>
            'Ignoriši članak sa sistemskim tipom pošiljaoca za svojstvo novog članka (npr automatski odgovori ili imejl obaveštenja).',
        'Include tickets of subqueues per default when selecting a queue.' =>
            'Kod izbora reda, podrazumevano uključi i tikete podredova.',
        'Include unknown customers in ticket filter.' => 'Uključite nepoznate klijente u filter tiketa.',
        'Includes article create times in the ticket search of the agent interface.' =>
            'Uključuje vremena kreiranja tiketa u pretragu na operaterskom interfejsu.',
        'Incoming Phone Call.' => 'Ulazni telefonski poziv.',
        'IndexAccelerator: to choose your backend TicketViewAccelerator module. "RuntimeDB" generates each queue view on the fly from ticket table (no performance problems up to approx. 60.000 tickets in total and 6.000 open tickets in the system). "StaticDB" is the most powerful module, it uses an extra ticket-index table that works like a view (recommended if more than 80.000 and 6.000 open tickets are stored in the system). Use the command "bin/otrs.Console.pl Maint::Ticket::QueueIndexRebuild" for initial index creation.' =>
            '',
        'Indonesian' => '',
        'Input' => 'Unos',
        'Install ispell or aspell on the system, if you want to use a spell checker. Please specify the path to the aspell or ispell binary on your operating system.' =>
            'Ako želite da koristite proveru pravopisa instalirajte „ispell” ili „aspell” na sistem. molimo da navedete putanju do „ispell” ili „aspell” datoteke na vašem operativnom sisitemu.',
        'Interface language' => 'Jezik interfejsa',
        'International Workers\' Day' => 'Međunarodni praznik rada',
        'It is possible to configure different skins, for example to distinguish between diferent agents, to be used on a per-domain basis within the application. Using a regular expression (regex), you can configure a Key/Content pair to match a domain. The value in "Key" should match the domain, and the value in "Content" should be a valid skin on your system. Please see the example entries for the proper form of the regex.' =>
            '',
        'It is possible to configure different skins, for example to distinguish between diferent customers, to be used on a per-domain basis within the application. Using a regular expression (regex), you can configure a Key/Content pair to match a domain. The value in "Key" should match the domain, and the value in "Content" should be a valid skin on your system. Please see the example entries for the proper form of the regex.' =>
            '',
        'It is possible to configure different themes, for example to distinguish between agents and customers, to be used on a per-domain basis within the application. Using a regular expression (regex), you can configure a Key/Content pair to match a domain. The value in "Key" should match the domain, and the value in "Content" should be a valid theme on your system. Please see the example entries for the proper form of the regex.' =>
            '',
        'Italian' => 'Italijanski',
        'Italian stop words for fulltext index. These words will be removed from the search index.' =>
            'Italijanske zaustavne reči za indeks pretrage kompletnog teksta. Ove reči će biti uklonjene iz indeksa pretrage.',
        'Ivory' => '',
        'Ivory (Slim)' => '',
        'Japanese' => 'Japanski',
        'JavaScript function for the search frontend.' => '',
        'Large' => 'Veliko',
        'Last customer subject' => '',
        'Lastname Firstname' => 'Prezime, Ime',
        'Lastname Firstname (UserLogin)' => 'Prezime, Ime (Prijava korisnika)',
        'Lastname, Firstname' => 'Prezime, Ime',
        'Lastname, Firstname (UserLogin)' => 'Prezime, Ime (Prijava korisnika)',
        'Latvian' => 'Letonski',
        'Left' => 'Levo',
        'Link Object' => 'Poveži objekat',
        'Link Object.' => 'Poveži objekat.',
        'Link agents to groups.' => 'Poveži operatere sa gupama.',
        'Link agents to roles.' => 'Poveži operatere sa ulogama.',
        'Link attachments to templates.' => 'Poveži priloge sa šablonima',
        'Link customer user to groups.' => 'Poveži klijente korisnike sa grupama',
        'Link customer user to services.' => 'Poveži klijente korisnike sa uslugama.',
        'Link queues to auto responses.' => 'Poveži redove sa automatskim odgovorima.',
        'Link roles to groups.' => 'Poveži uloge sa grupama.',
        'Link templates to queues.' => 'Poveži šablone sa redovima',
        'Link this ticket to other objects' => 'Uveži ovaj tiket sa drugim objektom',
        'Links 2 tickets with a "Normal" type link.' => 'Poveži 2 tiketa tipom veze "Normal".',
        'Links 2 tickets with a "ParentChild" type link.' => 'Poveži 2 tiketa tipom veze "ParentChild".',
        'List of CSS files to always be loaded for the agent interface.' =>
            'Lista CSS direktorijuma uvek učitanih za interfejs operatera.',
        'List of CSS files to always be loaded for the customer interface.' =>
            'Lista CSS datoteka koje se uvek učitavaju za interfejs klijenta.',
        'List of JS files to always be loaded for the agent interface.' =>
            'Lista JS direktorijuma uvek učitanih za interfejs operatera.',
        'List of JS files to always be loaded for the customer interface.' =>
            'Lista JS datoteka koje se uvek učitavaju za interfejs klijenta.',
        'List of all CustomerCompany events to be displayed in the GUI.' =>
            'Lista svih događaja za Firmu klijenta koja će biti prikazana u GKI.',
        'List of all CustomerUser events to be displayed in the GUI.' => 'Lista svih događaja za klijenta korisnika koja će biti prikazana u GKI.',
        'List of all DynamicField events to be displayed in the GUI.' => 'Lista svih događaja na dinamičkim poljima koja će biti prikazana u GKI',
        'List of all Package events to be displayed in the GUI.' => 'Lista svih događaja na paketima koja će biti prikazana u GKI',
        'List of all article events to be displayed in the GUI.' => 'Lista svih događaja na člancima koja će biti prikazana u GKI',
        'List of all queue events to be displayed in the GUI.' => 'Lista svih događaja u redu koji će biti prikazani u GKI.',
        'List of all ticket events to be displayed in the GUI.' => 'Lista svih događaja na tiketima koja će biti prikazana u GKI',
        'List of default Standard Templates which are assigned automatically to new Queues upon creation.' =>
            'Lista podrazumevanih standardnih šablona koji se automatski dodeljiju novom Redu nakon kreiranja.',
        'List of responsive CSS files to always be loaded for the agent interface.' =>
            'Lista prilagodljivih CSS datoteka uvek učitanih za interfejs operatera.',
        'List of responsive CSS files to always be loaded for the customer interface.' =>
            'Lista prilagodljivih CSS datoteka uvek učitanih za interfejs klijenta.',
        'List view' => 'Pregled liste',
        'Lithuanian' => 'Litvanski',
        'Lock / unlock this ticket' => 'Zaključaj / otključaj ovaj tiket',
        'Locked Tickets' => 'Zaključani tiketi',
        'Locked Tickets.' => 'Zaključani tiketi.',
        'Locked ticket.' => 'Zaključan tiket.',
        'Log file for the ticket counter.' => 'Datoteka dnevnika za brojač tiketa.',
        'Logout of customer panel.' => '',
        'Look into a ticket!' => 'Pogledaj sadržaj tiketa!',
        'Loop-Protection! No auto-response sent to "%s".' => 'Zaštita od petlje! Automatski odgovor nije poslat na "%s".',
        'Mail Accounts' => 'Imejl nalozi',
        'Main menu registration.' => 'Registracija glavnog menija.',
        'Makes the application check the MX record of email addresses before sending an email or submitting a telephone or email ticket.' =>
            '',
        'Makes the application check the syntax of email addresses.' => 'Primorava aplikaciju da proverava sintaksu imejl aderesa.',
        'Makes the session management use html cookies. If html cookies are disabled or if the client browser disabled html cookies, then the system will work as usual and append the session id to the links.' =>
            '',
        'Malay' => 'Malajski',
        'Manage OTRS Group cloud services.' => 'Upravljaj uslugama u oblaku OTRS Grupe.',
        'Manage PGP keys for email encryption.' => 'Upravljaj PGP ključevima za imejl enkripciju.',
        'Manage POP3 or IMAP accounts to fetch email from.' => 'Upravljanje POP3 ili IMAP nalozima za preuzimanje email-a od.',
        'Manage S/MIME certificates for email encryption.' => 'Upravljaj S/MIME sertifikatima za imej enkripciju.',
        'Manage existing sessions.' => 'Upravljanje postojećim sesijama.',
        'Manage support data.' => 'Upravljanje podacima podrške.',
        'Manage system registration.' => 'Upravljanje sistem registracijom.',
        'Manage tasks triggered by event or time based execution.' => 'Upravlja zadacima pokrenutim od događaja ili na osnovu vremenskog izvršavanja.',
        'Mark as Spam!' => 'Označi kao Spam!',
        'Mark this ticket as junk!' => 'Označi ovaj tiket kao besmislen „junk”!',
        'Max size (in characters) of the customer information table (phone and email) in the compose screen.' =>
            'Maksimalna dužina (u znacima) klijentske info tabele (telefon i imejl) na ekranu pisanja imejla.',
        'Max size (in rows) of the informed agents box in the agent interface.' =>
            'Maksimalna veličina (u redovima) okvira informisanih operatera u operaterskom interfejsu.',
        'Max size (in rows) of the involved agents box in the agent interface.' =>
            'Maksimalna veličina (u redovima) okvira uključenih operatera u operaterskom interfejsu.',
        'Max size of the subjects in an email reply and in some overview screens.' =>
            '',
        'Maximal auto email responses to own email-address a day (Loop-Protection).' =>
            'Mksimum automatskih imejl odgovora dnevno na sopstvenu adresu (Zaštita od petlje)',
        'Maximal size in KBytes for mails that can be fetched via POP3/POP3S/IMAP/IMAPS (KBytes).' =>
            'Maksimalna veličina u kilobajtima za imejlove koji mogu biti preuzeti preko „POP3/POP3S/IMAP/IMAPS (KBytes)”.',
        'Maximum Number of a calendar shown in a dropdown.' => '',
        'Maximum length (in characters) of the dynamic field in the article of the ticket zoom view.' =>
            'Maksimalna dužina (u znacima) dinamičkog polja u članku na detaljnom pregledu tiketa.',
        'Maximum length (in characters) of the dynamic field in the sidebar of the ticket zoom view.' =>
            'Maksimalna dužina (u znacima) dinamičkog polja u bočnoj traci na detaljnom pregledu tiketa.',
        'Maximum number of tickets to be displayed in the result of a search in the agent interface.' =>
            'Maksimalni broj tiketa koji će biti prikazani u rezultatu pretrage u interfejsu operatera.',
        'Maximum number of tickets to be displayed in the result of a search in the customer interface.' =>
            'Maksimalni broj tiketa koji će biti prikazani u rezultatu pretrage u interfejsu klijenta.',
        'Maximum number of tickets to be displayed in the result of this operation.' =>
            'Maksimalni broj tiketa koji će biti prikazani u rezultatu ove operacije.',
        'Maximum size (in characters) of the customer information table in the ticket zoom view.' =>
            'Maksimalna dužina (u znacima) klijentske info tabele na detaljnom pregledu tiketa.',
        'Medium' => 'Srednje',
        'Merge this ticket and all articles into a another ticket' => 'Spoji ovaj tiket i sve članke u drugi tiket',
        'Merged Ticket <OTRS_TICKET> to <OTRS_MERGE_TO_TICKET>.' => 'Tiket <OTRS_TICKET> spojen u <OTRS_MERGE_TO_TICKET>.',
        'Miscellaneous' => 'Razno',
        'Module for To-selection in new ticket screen in the customer interface.' =>
            'Modul za izbor primaoca (Za:) u prikazu novog tiketa u interfejsu klijenta.',
        'Module to check if arrived emails should be marked as email-internal (because of original forwarded internal email). ArticleType and SenderType define the values for the arrived email/article.' =>
            'Modul za proveru da li pristigli imejlovi treba da budu iznačeni kao interni (na osnovu orginalnog imejla prosleđivanja). Tip članka i tip pošiljaoca definišu vrednosti za primljeni imejl/članak.',
        'Module to check the group permissions for customer access to tickets.' =>
            'Modul za proveru grupnih dozvola za klijentski pristup tiketima.',
        'Module to check the group permissions for the access to tickets.' =>
            'Modul za proveru grupnih dozvola za pristup tiketima.',
        'Module to compose signed messages (PGP or S/MIME).' => 'Modul za izradu potpisane poruke („PGP” ili „S/MIME”).',
        'Module to encrypt composed messages (PGP or S/MIME).' => '',
        'Module to filter and manipulate incoming messages. Block/ignore all spam email with From: noreply@ address.' =>
            'Modul za filtriranje i rukovanje dolaznim porukama. Blokiranje/ignorisanje svih nepoželjnih imejlova Od: „noreply@” adrese',
        'Module to filter and manipulate incoming messages. Get a 4 digit number to ticket free text, use regex in Match e. g. From => \'(.+?)@.+?\', and use () as [***] in Set =>.' =>
            'Modul za filtriranje i rukovanje dolaznim porukama. Uzmite broj sa 4 cifre za slobodni tekst tiketa, upotrebite regularni izraz za poklapanje, npr Od: => \'(.+?)@.+?\', i upotrebite () kao [***] u Postavi =>.',
        'Module to generate accounted time ticket statistics.' => 'Modul za generisanje statistike obračunatog vremena tiketa.',
        'Module to generate html OpenSearch profile for short ticket search in the agent interface.' =>
            'Modul za generisanje „HTML OpenSearch” profila za kratku pretragu tiketa u profilu operatera.',
        'Module to generate html OpenSearch profile for short ticket search in the customer interface.' =>
            'Modul za generisanje „HTML OpenSearch” profila za kratku pretragu tiketa u profilu klijenta.',
        'Module to generate ticket solution and response time statistics.' =>
            'Modul za generisanje statistike rešavanja tiketa i vremena odgovora.',
        'Module to generate ticket statistics.' => 'Modul za generisanje statistike tiketa.',
        'Module to grant access if the CustomerID of the ticket matches the CustomerID of the customer.' =>
            'Modul za dodelu pristupa ako se ID klijenta tiketa poklapa sa ID klijenta.',
        'Module to grant access if the CustomerUserID of the ticket matches the CustomerUserID of the customer.' =>
            'Modul za dodelu pristupa ako se ID klijenta korisika tiketa poklapa sa ID korinika klijenta za klijenta. ',
        'Module to grant access to any agent that has been involved in a ticket in the past (based on ticket history entries).' =>
            'Modul za dodelu pristupa bilo kom operateru angažovanom na tiketu u prošlosti (bazirano na stavkama istorijata tiketa).',
        'Module to grant access to the agent responsible of a ticket.' =>
            'Modul za dodelu pristupa tiketu za odgovornog operatera.',
        'Module to grant access to the creator of a ticket.' => 'Modul za dodelu pristupa tiketu za kreatora tiketa.',
        'Module to grant access to the owner of a ticket.' => 'Modul za dodelu pristupa tiketu za vlasnika.',
        'Module to grant access to the watcher agents of a ticket.' => 'Modul za dodelu pristupa tiketu za nadzornog operatera.',
        'Module to show notifications and escalations (ShownMax: max. shown escalations, EscalationInMinutes: Show ticket which will escalation in, CacheTime: Cache of calculated escalations in seconds).' =>
            '',
        'Module to use database filter storage.' => 'Modul za smeštaj filtera u bazu podataka.',
        'Multiselect' => 'Višestruki izbor',
        'My Queues' => 'Moji redovi',
        'My Services' => 'Moje usluge',
        'My Tickets.' => 'Moji tiketi.',
        'Name of custom queue. The custom queue is a queue selection of your preferred queues and can be selected in the preferences settings.' =>
            'Naziv namenskog reda. Namenski red je izbor redova po vašoj želji i može se izabrati u podešavanjima.',
        'Name of custom service. The custom service is a service selection of your preferred services and can be selected in the preferences settings.' =>
            'Naziv namenskog servisa. Namenski servis je izbor servisa po vašoj želji i može se izabrati u podešavanjima.',
        'NameX' => 'ImeH',
        'Nederlands' => 'Holandski',
        'New Ticket' => 'Novi tiket',
        'New Ticket [%s] created (Q=%s;P=%s;S=%s).' => 'Novi tiket [%s] otvoren (Q=%s;P=%s;S=%s).',
        'New Tickets' => 'Novi tiketi',
        'New Window' => 'Novi prozor',
        'New Year\'s Day' => 'Nova godina',
        'New Year\'s Eve' => 'Doček nove godine',
        'New owner is "%s" (ID=%s).' => 'Novi vlasnik je "%s" (ID=%s).',
        'New process ticket' => 'Novi tiket procesa',
        'New responsible is "%s" (ID=%s).' => 'Novi odgovorni je "%s" (ID=%s).',
        'News about OTRS releases!' => 'Vesti o „OTRS” izdanjima!',
        'Next possible ticket states after adding a phone note in the ticket phone inbound screen of the agent interface.' =>
            'Sledeći mogući status tiketa nakon dodavanja telefonske napomene u prikazu ekrana dolaznih poziva interfejsa operatera.',
        'Next possible ticket states after adding a phone note in the ticket phone outbound screen of the agent interface.' =>
            'Sledeći mogući status tiketa nakon dodavanja telefonske napomene u prikazu ekrana odlaznih poziva interfejsa operatera.',
        'None' => 'Ni jedan',
        'Norwegian' => 'Norveški',
        'Notification Settings' => 'Podešavanja obaveštenja',
        'Notification sent to "%s".' => 'Poslato obaveštenja korisniku"%s".',
        'Number of displayed tickets' => 'Broj prikazanih tiketa',
        'Number of lines (per ticket) that are shown by the search utility in the agent interface.' =>
            'Broj linija (po tiketu) prikazanih prema uslužnoj pretrazi u interfejsu operatera.',
        'Number of tickets to be displayed in each page of a search result in the agent interface.' =>
            'Broj tiketa koji će biti prikazani na svakoj strani rezultata pretrage u interfejsu operatera.',
        'Number of tickets to be displayed in each page of a search result in the customer interface.' =>
            'Broj tiketa koji će biti prikazani na svakoj strani rezultata pretrage u interfejsu klijenta.',
        'OTRS News' => '„OTRS” novosti',
        'OTRS can use one or more readonly mirror databases for expensive operations like fulltext search or statistics generation. Here you can specify the DSN for the first mirror database.' =>
            '',
        'Old: "%s" New: "%s"' => 'Staro: "%s" Novo: "%s"',
        'Online' => 'Na mreži',
        'Open Tickets / Need to be answered' => 'Otvoreni tiketi / Potrebno odgovoriti',
        'Open tickets (customer user)' => 'Otvoreni tiketi (klijent korisnik)',
        'Open tickets (customer)' => 'Otvoreni tiketi (klijent)',
        'Option' => '',
        'Optional queue limitation for the CreatorCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Optional queue limitation for the InvolvedCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Optional queue limitation for the OwnerCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Optional queue limitation for the ResponsibleCheck permission module. If set, permission is only granted for tickets in the specified queues.' =>
            '',
        'Other Settings' => 'Druga podešavanja',
        'Out Of Office' => 'Van kancelarije',
        'Out Of Office Time' => 'Vreme van kancelarije',
        'Overloads (redefines) existing functions in Kernel::System::Ticket. Used to easily add customizations.' =>
            'Preopterećuje (redefinisano) postojeće fuckcije u Kernel::System::Ticket. Koristi se za lako dodavanje prilagođavanja.',
        'Overview Escalated Tickets.' => 'Pregled eskaliranih tiketa.',
        'Overview Refresh Time' => 'Pregled vremena osvežavanja',
        'Overview of all escalated tickets.' => 'Pregled svih eskaliranih tiketa.',
        'Overview of all open Tickets.' => 'Pregled svih otvorenih tiketa.',
        'Overview of all open tickets.' => 'Pregled svih otvorenih tiketa.',
        'Overview of customer tickets.' => 'Pregled klijentskih tiketa.',
        'PGP Key' => 'PGP ključ',
        'PGP Key Management' => 'Upravljanje PGP ključem',
        'PGP Key Upload' => 'Slanje PGP ključa',
        'PGP Keys' => 'PGP ključevi',
        'Package event module file a scheduler task for update registration.' =>
            'Datoteka paketa modula događaja za zadatak planera za ažuriranje registracije.',
        'Parameters for the CreateNextMask object in the preference view of the agent interface.' =>
            '',
        'Parameters for the CustomQueue object in the preference view of the agent interface.' =>
            '',
        'Parameters for the CustomService object in the preference view of the agent interface.' =>
            '',
        'Parameters for the RefreshTime object in the preference view of the agent interface.' =>
            '',
        'Parameters for the column filters of the small ticket overview.' =>
            '',
        'Parameters for the dashboard backend of the customer company information of the agent interface . "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the customer id status widget of the agent interface . "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the customer user list overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the new tickets overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.' =>
            '',
        'Parameters for the dashboard backend of the open tickets overview of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.' =>
            '',
        'Parameters for the dashboard backend of the queue overview widget of the agent interface. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "QueuePermissionGroup" is not mandatory, queues are only listed if they belong to this permission group if you enable it. "States" is a list of states, the key is the sort order of the state in the widget. "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the running process tickets overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the ticket escalation overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.' =>
            '',
        'Parameters for the dashboard backend of the ticket events calendar of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the ticket pending reminder overview of the agent interface . "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin. Note: Only Ticket attributes and Dynamic Fields (DynamicField_NameX) are allowed for DefaultColumns. Possible settings: 0 = Disabled, 1 = Available, 2 = Enabled by default.' =>
            '',
        'Parameters for the dashboard backend of the ticket stats of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the dashboard backend of the upcoming events widget of the agent interface. "Limit" is the number of entries shown by default. "Group" is used to restrict the access to the plugin (e. g. Group: admin;group1;group2;). "Default" determines if the plugin is enabled by default or if the user needs to enable it manually. "CacheTTLLocal" is the cache time in minutes for the plugin.' =>
            '',
        'Parameters for the pages (in which the dynamic fields are shown) of the dynamic fields overview.' =>
            'Parametri stranica (na kojima su dinamička polja vidljiva) pregleda dinamičkih polja.',
        'Parameters for the pages (in which the tickets are shown) of the medium ticket overview.' =>
            'Parametri stranica (na kojima su tiketi vidljivi) srednjeg pregleda tiketa.',
        'Parameters for the pages (in which the tickets are shown) of the small ticket overview.' =>
            'Parametri stranica (na kojima su tiketi vidljivi) smanjenog pregleda tiketa.',
        'Parameters for the pages (in which the tickets are shown) of the ticket preview overview.' =>
            'Parametri stranica (na kojima su tiketi vidljivi) prikaza  pregleda tiketa.',
        'Parameters of the example SLA attribute Comment2.' => 'Parametri za primer atributa „SLA” komentara 2.',
        'Parameters of the example queue attribute Comment2.' => 'Parametri za primer atributa red komentara 2.',
        'Parameters of the example service attribute Comment2.' => 'Parametri za primer atributa servis komentara 2.',
        'Parent' => 'Nadređeni',
        'ParentChild' => '',
        'Path for the log file (it only applies if "FS" was selected for LoopProtectionModule and it is mandatory).' =>
            'Putanja do datoteke dnevnika (važi jedino ako je za „LoopProtectionModule” izabrano „FS” i postavljeno kao obavezno).',
        'People' => 'Osobe',
        'Performs the configured action for each event (as an Invoker) for each configured Webservice.' =>
            'Izvršava podešenu akciju za svaki događaj (kao pozivaoc) za svaki podešeni veb servis.',
        'Permitted width for compose email windows.' => 'Dozvoljena širina prozora za pisanje poruke.',
        'Permitted width for compose note windows.' => 'Dozvoljena širina prozora za pisanje napomene.',
        'Persian' => 'Persijski',
        'Phone Call Inbound' => 'Dolazni telefonski poziv',
        'Phone Call Outbound' => 'Odlazni telefonski poziv',
        'Phone Call.' => 'Telefonski poziv.',
        'Phone call' => 'Telefonski poziv',
        'Phone-Ticket' => 'Telefonski tiket',
        'Picture Upload' => 'Otpremanje slike',
        'Picture upload module.' => 'Modul za otpremanje slike.',
        'Picture-Upload' => 'Otpremanje slike',
        'Polish' => 'Poljski',
        'Portuguese' => 'Portugalski',
        'Portuguese (Brasil)' => 'Portugalski (Brazil)',
        'PostMaster Filters' => 'PostMaster filteri',
        'PostMaster Mail Accounts' => 'PostMaster mejl nalozi',
        'Print this ticket' => 'Odštampaj ovaj tiket',
        'Priorities' => 'Prioriteti',
        'Process Management Activity Dialog GUI' => 'GKI dijaloga aktivnosti upravljanja procesom',
        'Process Management Activity GUI' => 'GKI aktivnosti upravljanja procesom',
        'Process Management Path GUI' => 'GKI putanje upravljanja procesom',
        'Process Management Transition Action GUI' => 'GKI tranzicione akcije upravljanja procesom',
        'Process Management Transition GUI' => 'GKI tranzicije upravljanja procesom',
        'Process Ticket.' => '',
        'Process pending tickets.' => '',
        'Process ticket' => '',
        'ProcessID' => 'ID procesa',
        'Product News' => 'Novosti o proizvodu',
        'Protection against CSRF (Cross Site Request Forgery) exploits (for more info see http://en.wikipedia.org/wiki/Cross-site_request_forgery).' =>
            '',
        'Provides a matrix overview of the tickets per state per queue' =>
            '',
        'Queue view' => 'Pregled reda',
        'Rebuild the ticket index for AgentTicketQueue.' => 'Ponovo izradi indeks tiketa za operaterski red tiketa.',
        'Recognize if a ticket is a follow-up to an existing ticket using an external ticket number.' =>
            'Prepoznaj da li je tiket nastavak postojećeg tiketa korišćenjem eksternog broja tiketa.',
        'Refresh interval' => 'Interval osvežavanja',
        'Reminder Tickets' => 'Tiketi podsetnika',
        'Removed subscription for user "%s".' => 'Pretplata za korisnika "%s" isključena.',
        'Removes the ticket watcher information when a ticket is archived.' =>
            'Uklanja informacije posmatrača tiketa kada se tiket arhivira.',
        'Replaces the original sender with current customer\'s email address on compose answer in the ticket compose screen of the agent interface.' =>
            'Zamenjuje originalnog pošiljaoca sa imejl adresom aktuelnog klijenta pri kreiranju odgovora u prozoru za pisanje odgovora interfejsa operatera.',
        'Reports' => 'Izveštaji',
        'Reports (OTRS Business Solution™)' => 'Izveštaji („OTRS” Poslovno Rešenje™)',
        'Reprocess mails from spool directory that could not be imported in the first place.' =>
            'Ponovo obradi imejlove iz direktorijuma reda čekanja koji prvi put nisu mogli biti uvezeni.',
        'Required permissions to change the customer of a ticket in the agent interface.' =>
            'Potrebne dozvole za promenu klijenta na tiketu u interfejsu operatera.',
        'Required permissions to use the close ticket screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana za zatvaranje tiketa u interfejsu operatera.',
        'Required permissions to use the email outbound screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana odlaznih imejlova u interfejsu operatera.',
        'Required permissions to use the ticket bounce screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana za odbijanje tiketa u interfejsu operatera.',
        'Required permissions to use the ticket compose screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prozora za otvaranje tiketa u interfejsu operatera.',
        'Required permissions to use the ticket forward screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana za prosleđivanje tiketa u interfejsu operatera.',
        'Required permissions to use the ticket free text screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana tiketa slobodnog teksta u interfejsu operatera.',
        'Required permissions to use the ticket merge screen of a zoomed ticket in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana za spajanje tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Required permissions to use the ticket note screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana za napomene tiketa u interfejsu operatera.',
        'Required permissions to use the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana vlasnika tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Required permissions to use the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana tiketa na čekanju pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Required permissions to use the ticket phone inbound screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana tiketa dolaznih poziva u interfejsu operatera.',
        'Required permissions to use the ticket phone outbound screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana tiketa odlaznih poziva u interfejsu operatera.',
        'Required permissions to use the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana prioritetnog tiketa pri uvećanom prikazu tiketa u interfejsu operatera.',
        'Required permissions to use the ticket responsible screen in the agent interface.' =>
            'Potrebne dozvole za upotrebu prikaza ekrana odgovornog za tiket u interfejsu operatera.',
        'Resets and unlocks the owner of a ticket if it was moved to another queue.' =>
            'Resetuje i otključava vlasnika tiketa ako je premešten u drugi red.',
        'Responsible Tickets' => '',
        'Responsible Tickets.' => '',
        'Restores a ticket from the archive (only if the event is a state change, from closed to any open available state).' =>
            'Vraća tiket iz arhive (samo ako je događaj promena statusa od zatvorenog na bilo koji dostupan otvoreni status).',
        'Retains all services in listings even if they are children of invalid elements.' =>
            'Zadrži sve servise u listi čak iako su deca nevažećih elemenata.',
        'Right' => 'Desno',
        'Roles ↔ Groups' => '',
        'Run file based generic agent jobs (Note: module name need needs to be specified in -configuration-module param e.g. "Kernel::System::GenericAgent").' =>
            '',
        'Running Process Tickets' => '',
        'Runs an initial wildcard search of the existing customer company when accessing the AdminCustomerCompany module.' =>
            '',
        'Runs an initial wildcard search of the existing customer users when accessing the AdminCustomerUser module.' =>
            '',
        'Runs the system in "Demo" mode. If set to "Yes", agents can change preferences, such as selection of language and theme via the agent web interface. These changes are only valid for the current session. It will not be possible for agents to change their passwords.' =>
            '',
        'Russian' => 'Ruski',
        'S/MIME Certificate Upload' => 'Slanje S/MIME sertifikata',
        'S/MIME Certificates' => 'S/MIME sertifikati',
        'SMS' => 'SMS',
        'SMS (Short Message Service)' => '',
        'Salutations' => 'Pozdravi',
        'Sample command output' => 'Primer komandnog izlaza',
        'Saves the attachments of articles. "DB" stores all data in the database (not recommended for storing big attachments). "FS" stores the data on the filesystem; this is faster but the webserver should run under the OTRS user. You can switch between the modules even on a system that is already in production without any loss of data. Note: Searching for attachment names is not supported when "FS" is used.' =>
            '',
        'Schedule a maintenance period.' => 'Planiranje perioda održavanja.',
        'Screen' => 'Ekran',
        'Screen after new ticket' => 'Prikaz ekrana posle otvaranja novog tiketa',
        'Search Customer' => 'Traži klijenta',
        'Search Ticket.' => 'Traži tiket.',
        'Search Tickets.' => 'Pretraži tikete.',
        'Search User' => 'Traži korisnika',
        'Search backend default router.' => '',
        'Search backend router.' => '',
        'Search.' => 'Pretraga.',
        'Second Christmas Day' => 'Drugi dan Božića',
        'Second Queue' => 'Drugi Red',
        'Select the separator character used in CSV files (stats and searches). If you don\'t select a separator here, the default separator for your language will be used.' =>
            'Izaberite separator koji će se koristi u CSV datotekama (statistika i pretrage). Ako ovde ne izaberete separator, koristiće se podrazumevani separator za vaš jezik',
        'Select your frontend Theme.' => '',
        'Selects the cache backend to use.' => 'Izbor keša koji će koristiti sistem u pozadini.',
        'Selects the module to handle uploads via the web interface. "DB" stores all uploads in the database, "FS" uses the file system.' =>
            'Bira modul za rukovanje prenešenim datotekama preko veb interfejsa. "DB" skladišti sve prenešene datoteke u bazu podataka, "FS" koristi sistem datoteka.',
        'Selects the ticket number generator module. "AutoIncrement" increments the ticket number, the SystemID and the counter are used with SystemID.counter format (e.g. 1010138, 1010139). With "Date" the ticket numbers will be generated by the current date, the SystemID and the counter. The format looks like Year.Month.Day.SystemID.counter (e.g. 200206231010138, 200206231010139). With "DateChecksum"  the counter will be appended as checksum to the string of date and SystemID. The checksum will be rotated on a daily basis. The format looks like Year.Month.Day.SystemID.Counter.CheckSum (e.g. 2002070110101520, 2002070110101535). "Random" generates randomized ticket numbers in the format "SystemID.Random" (e.g. 100057866352, 103745394596).' =>
            'Bira modul za generisanje broja tiketa. "AutoIncrement" uvećava broj tiketa, ID sistema i brojač se koriste u SistemID.brojač formatu (npr. 1010138, 1010139). Sa "Date" brojevi tiketa će biti generisani preko trenutnog datuma, ID-a sistema i brojača. Format će izgledati kao Godina.Mesec.Dan.SistemID.brojač (npr. 2002070110101520, 2002070110101535). Sa "DateChecksum" brojač će biti dodat kao kontrolni zbir nizu sačinjenom od datuma i ID-a sistema. Kontrolni zbir će se smenjivati na dnevnom nivou. Format izgleda ovako: Godina.Mesec.Dan.SistemID.Brojač.KontrolniZbir (npr. 2002070110101520, 2002070110101535). "Slučajno" generiše brojeve tiketa po slobodnom izboru u formatu "SistemID.Slučajno" (npr. 1010138, 1010139).',
        'Send new outgoing mail from this ticket' => 'Pošalji novi odlazni imejl iz ovog tiketa',
        'Send notifications to users.' => 'Pošalji obaveštenja korisnicima.',
        'Sender type for new tickets from the customer inteface.' => 'Tip pošiljaoca za nove tikete iz interfejsa klijenta.',
        'Sends agent follow-up notification only to the owner, if a ticket is unlocked (the default is to send the notification to all agents).' =>
            'Šalje obaveštenje o nastavku samo operateru vlasniku, ako je tiket otključan (podrazumevano je da šalje svim operaterima).',
        'Sends all outgoing email via bcc to the specified address. Please use this only for backup reasons.' =>
            'Šalje sve odlazne imejlove kao nevidljive kopije („bcc”) na određenu adresu. Molimo da ovo koristite samo za rezervne kopije.',
        'Sends customer notifications just to the mapped customer. Normally, if no customer is mapped, the latest customer sender gets the notification.' =>
            'Šalje klijentska obaveštenja samo mapiranim klijenima. Normalno, ako klijent nije mapiran, poslednji klijent pošiljaoc dobija obaveštenje.',
        'Sends registration information to OTRS group.' => 'Šalje registracione informacije za „OTRS group”.',
        'Sends reminder notifications of unlocked ticket after reaching the reminder date (only sent to ticket owner).' =>
            'Šalje obaveštenje za potsećanje o otključanom tiketu kad se dostigne datum podsetnika (šalje samo vlasniku tiketa).',
        'Sends the notifications which are configured in the admin interface under "Notfication (Event)".' =>
            'Šalje obaveštenja koja su u administrativnom interfejsu konfigurisana pod „Obaveštenje (događaj)”.',
        'Serbian Cyrillic' => 'Srpski ćirilica',
        'Serbian Latin' => 'Srpski latinica',
        'Service Level Agreements' => 'Sporazumi o nivou usluga',
        'Service view' => 'Pregled usluge',
        'ServiceView' => '',
        'Set minimum loglevel. If you select \'error\', just errors are logged. With \'debug\' you get all logging messages.' =>
            '',
        'Set sender email addresses for this system.' => 'Podesi sistemsku adresu pošiljaoca.',
        'Set the default height (in pixels) of inline HTML articles in AgentTicketZoom.' =>
            'Podesi podrazumevanu visinu (u pikselima) inline HTML članaka u AgentTicketZoom.',
        'Set the limit of tickets that will be executed on a single genericagent job execution.' =>
            'Postavlja ograničenje koliko će tiketa biti izvršeno u jednom izvršavanju posla opšteg operatera.',
        'Set the maximum height (in pixels) of inline HTML articles in AgentTicketZoom.' =>
            'Podesi maksimalnu visinu (u pikselima) inline HTML članaka u AgentTicketZoom.',
        'Set this ticket to pending' => 'Postavi ovaj tiket u status čekanja',
        'Set this to yes if you trust in all your public and private pgp keys, even if they are not certified with a trusted signature.' =>
            'Postavi ovo na da ako verujete u sve vaše javne i privatne pgp ključeve, čak i ako nisu potvrđeni pouzdanim potpisom.',
        'Sets if SLA must be selected by the agent.' => 'Podešava ako SLA mora biti izabran od strane operatera.',
        'Sets if SLA must be selected by the customer.' => 'Podešava ako „SLA” mora biti izabran od strane klijenta.',
        'Sets if note must be filled in by the agent. Can be overwritten by Ticket::Frontend::NeedAccountedTime.' =>
            '',
        'Sets if service must be selected by the agent.' => 'Podešava da li usluga mora biti izabrana od strane operatera.',
        'Sets if service must be selected by the customer.' => 'Podešava da li usluga mora biti izabrana od strane klijenta.',
        'Sets if ticket owner must be selected by the agent.' => 'Podešava ako vlasnik tiketa mora biti izabran od strane operatera.',
        'Sets if ticket responsible must be selected by the agent.' => '',
        'Sets the PendingTime of a ticket to 0 if the state is changed to a non-pending state.' =>
            '',
        'Sets the age in minutes (first level) for highlighting queues that contain untouched tickets.' =>
            'Postavi vreme u minutama (prvi nivo) za naglašavanje redova koji sadrže netaknute tikete.',
        'Sets the age in minutes (second level) for highlighting queues that contain untouched tickets.' =>
            'Postavi vreme u minutama (drugi nivo) za naglašavanje redova koji sadrže netaknute tikete.',
        'Sets the configuration level of the administrator. Depending on the config level, some sysconfig options will be not shown. The config levels are in in ascending order: Expert, Advanced, Beginner. The higher the config level is (e.g. Beginner is the highest), the less likely is it that the user can accidentally configure the system in a way that it is not usable any more.' =>
            'Postavi konfiguracioni nivo za administratora. U zavisnosti od konfiguracionog nivoa, neke sistemske opcije neće biti prikazane. Konfiguracioni nivoi poređani rastuće: Ekspert, Napredni, Početni. Što je viši nivo (npr Početni je najviši), manja je verovatnoća da korisnik može da konfiguriše sistem tako da više nije upotrebljiv.',
        'Sets the count of articles visible in preview mode of ticket overviews.' =>
            'Podešava brojanje članaka vidnjivih u modu prikaza pregleda tiketa.',
        'Sets the default article type for new email tickets in the agent interface.' =>
            'Određuje podrazumevani tip članka za nove imejl tikete na interfejsu operatera.',
        'Sets the default article type for new phone tickets in the agent interface.' =>
            'Određuje podrazumevani tip članka za nove telefonske tikete na interfejsu operatera.',
        'Sets the default body text for notes added in the close ticket screen of the agent interface.' =>
            'Postavlja podrazumevani sadržaj za napomene dodate na ekranu zatvaranja tiketa u interfejsu operatera.',
        'Sets the default body text for notes added in the ticket move screen of the agent interface.' =>
            'Postavlja podrazumevani sadržaj za napomene dodate na ekranu pomeranja tiketa u interfejsu operatera.',
        'Sets the default body text for notes added in the ticket note screen of the agent interface.' =>
            'Postavlja podrazumevani sadržaj za napomene dodate na ekranu napomene tiketa u interfejsu operatera.',
        'Sets the default body text for notes added in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Postavlja podrazumevani sadržaj za napomene dodate na ekranu vlasnika tiketa u interfejsu operatera.',
        'Sets the default body text for notes added in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Postavlja podrazumevani sadržaj za napomene dodate na ekranu tiketa na čekanju na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the default body text for notes added in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Postavlja podrazumevani sadržaj za napomene dodate na ekranu prioriteta tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the default body text for notes added in the ticket responsible screen of the agent interface.' =>
            'Postavlja podrazumevani sadržaj za napomene dodate na ekranu odgovornog za tiket u interfejsu operatera.',
        'Sets the default error message for the login screen on Agent and Customer interface, it\'s shown when a running system maintenance period is active.' =>
            'Postavlja podrazumevanu poruku greške za prijavni ekran u interfejsu operatera i klijenta, prikazuje se tokom aktivnog perioda održavanja.',
        'Sets the default link type of splitted tickets in the agent interface.' =>
            'Postavlja podrazumevani tip veze za podeljene tikete u interfejsu operatera.',
        'Sets the default message for the login screen on Agent and Customer interface, it\'s shown when a running system maintenance period is active.' =>
            'Postavlja podrazumevanu poruku za prijavni ekran u interfejsu operatera i klijenta, prikazuje se tokom aktivnog perioda održavanja.',
        'Sets the default message for the notification is shown on a running system maintenance period.' =>
            'Određuje podrazumevanu poruku za obaveštenje koje se vidi tokom perioda održavanja.',
        'Sets the default next state for new phone tickets in the agent interface.' =>
            'Određuje podrazumevani sledeći status za nove telefonske tikete u interfejsu operatera.',
        'Sets the default next ticket state, after the creation of an email ticket in the agent interface.' =>
            'Određuje podrazumevani sledeći status tiketa, nakon kreiranja imejl tiketa u interfejsu operatera.',
        'Sets the default note text for new telephone tickets. E.g \'New ticket via call\' in the agent interface.' =>
            'Postavlja podrazumevani tekst napomene za nove telefonske tikete. Npr „Novi tiket iz poziva” u interfejsu operatera.',
        'Sets the default priority for new email tickets in the agent interface.' =>
            'Određuje podrazumevani prioritet novog imejl tiketa a u interfejsu operatera.',
        'Sets the default priority for new phone tickets in the agent interface.' =>
            'Određuje podrazumevani prioritet novog telefonskog tiketa a u interfejsu operatera.',
        'Sets the default sender type for new email tickets in the agent interface.' =>
            'Postavlja podrazumevani tip pošiljaoca za nove imejl tikete u interfejsu operatera.',
        'Sets the default sender type for new phone ticket in the agent interface.' =>
            'Postavlja podrazumevani tip pošiljaoca za nove telefonske tikete u interfejsu operatera.',
        'Sets the default subject for new email tickets (e.g. \'email Outbound\') in the agent interface.' =>
            'Određuje podrazumevani predmet za nove imejl tikete (npr „odlazni imejl”) u interfejsu operatera.',
        'Sets the default subject for new phone tickets (e.g. \'Phone call\') in the agent interface.' =>
            'Određuje podrazumevani predmet za nove telefonske tikete (npr „telefonski poziv”) u interfejsu operatera.',
        'Sets the default subject for notes added in the close ticket screen of the agent interface.' =>
            'Određuje podrazumevani predmet za napomene dodate na prikazu ekrana zatvorenog tiketa u interfejsu operatera.',
        'Sets the default subject for notes added in the ticket move screen of the agent interface.' =>
            'Određuje podrazumevani predmet za napomene dodate na prikazu ekrana pomeranja tiketa u interfejsu operatera.',
        'Sets the default subject for notes added in the ticket note screen of the agent interface.' =>
            'Određuje podrazumevani predmet za napomene dodate na prikazu ekrana napomena tiketa u interfejsu operatera.',
        'Sets the default subject for notes added in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani predmet za napomene dodate na detaljnom prikazu ekrana vlasnika tiketa u interfejsu operatera.',
        'Sets the default subject for notes added in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani predmet za napomene dodate na detaljnom prikazu ekrana tiketa na čekanju u interfejsu operatera.',
        'Sets the default subject for notes added in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Određuje podrazumevani predmet za napomene dodate na detaljnom prikazu ekrana prioriteta tiketa u interfejsu operatera.',
        'Sets the default subject for notes added in the ticket responsible screen of the agent interface.' =>
            'Određuje podrazumevani predmet za napomene dodate na prikazu ekrana odgovornog za tiket u interfejsu operatera.',
        'Sets the default text for new email tickets in the agent interface.' =>
            'Određuje podrazumevani tekst novog imejl tiketa a u interfejsu operatera.',
        'Sets the display order of the different items in the preferences view.' =>
            'Određuje redosled prikaza raznih stavki u prikazu podešavanja.',
        'Sets the inactivity time (in seconds) to pass before a session is killed and a user is loged out.' =>
            'Određuje vreme bez aktivnosti (u sekundama) pre nego što sesija bude ugašena, a korisnik odjavljen.',
        'Sets the maximum number of active agents within the timespan defined in SessionActiveTime.' =>
            'Postavlja maksimalni broj aktivnih operatera u vremenskom rasponu definisanom u „SessionActiveTime”.',
        'Sets the maximum number of active customers within the timespan defined in SessionActiveTime.' =>
            'Postavlja maksimalni broj aktivnih klijenta u vremenskom rasponu definisanom u „SessionActiveTime”.',
        'Sets the maximum number of active sessions per agent within the timespan defined in SessionActiveTime.' =>
            'Postavlja maksimalni broj aktivnih sesija po operateru u vremenskom rasponu definisanom u „SessionActiveTime”.',
        'Sets the maximum number of active sessions per customers within the timespan defined in SessionActiveTime.' =>
            'Postavlja maksimalni broj aktivnih sesija po korisniku u vremenskom rasponu definisanom u „SessionActiveTime”.',
        'Sets the minimal ticket counter size if "AutoIncrement" was selected as TicketNumberGenerator. Default is 5, this means the counter starts from 10000.' =>
            '',
        'Sets the minutes a notification is shown for notice about upcoming system maintenance period.' =>
            'Određuje broj minuta trajanja prikaza obaveštenja o predsojećem periodu održavanja.',
        'Sets the number of lines that are displayed in text messages (e.g. ticket lines in the QueueZoom).' =>
            'Podešava broj linija prikazanih u tekstualnim porukama (npr broj linija u detaljnom pregledu reda).',
        'Sets the options for PGP binary.' => 'Određuje opcije za PGP binary.',
        'Sets the order of the different items in the customer preferences view.' =>
            'Određuje redosled prikaza raznih stavki u prikazu klijentskih podešavanja.',
        'Sets the password for private PGP key.' => 'Podesi lozinku za privatni PGP ključ.',
        'Sets the prefered time units (e.g. work units, hours, minutes).' =>
            'Podesi prioritetne vremenske jedinice (npr jedinice posla, sate, minute)',
        'Sets the preferred digest to be used for PGP binary.' => '',
        'Sets the prefix to the scripts folder on the server, as configured on the web server. This setting is used as a variable, OTRS_CONFIG_ScriptAlias which is found in all forms of messaging used by the application, to build links to the tickets within the system.' =>
            '',
        'Sets the queue in the ticket close screen of a zoomed ticket in the agent interface.' =>
            'Postavlja red na prozoru zatvaranja tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the queue in the ticket free text screen of a zoomed ticket in the agent interface.' =>
            'Postavlja red na prozoru slobodnog teksta tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the queue in the ticket note screen of a zoomed ticket in the agent interface.' =>
            'Postavlja red na prozoru napomene tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the queue in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Postavlja red na prozoru vlasnika tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the queue in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Postavlja red na prozoru tiketa na čekanju na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the queue in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Postavlja red na prozoru prioriteta tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the queue in the ticket responsible screen of a zoomed ticket in the agent interface.' =>
            'Postavlja red na prozoru odgovornog za tiket na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the close ticket screen of the agent interface.' =>
            'Postavlja odgovornog operatera za tiket na prozoru zatvaranja tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the ticket bulk screen of the agent interface.' =>
            'Postavlja odgovornog operatera za tiket na prozoru masovnih akcija tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the ticket free text screen of the agent interface.' =>
            'Postavlja odgovornog operatera za tiket na prozoru slobodnog teksta tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the ticket note screen of the agent interface.' =>
            'Postavlja odgovornog operatera za tiket na prozoru napomene tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Postavlja odgovornog operatera za tiket u prozoru vlasnika tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Postavlja odgovornog operatera za tiket u prozoru tiketa na čekanju na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Postavlja odgovornog operatera za tiket u prozoru prioriteta tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Sets the responsible agent of the ticket in the ticket responsible screen of the agent interface.' =>
            'Postavlja odgovornog operatera za tiket u prozoru odgovornog za tiket u interfejsu operatera.',
        'Sets the service in the close ticket screen of the agent interface (Ticket::Service needs to be activated).' =>
            'Podešava servis na ekranu zatvaranja tiketa u interfejsu operatera (neophodno je aktivirati Ticket::Service).',
        'Sets the service in the ticket free text screen of the agent interface (Ticket::Service needs to be activated).' =>
            'Podešava servis na ekranu slobodnog teksta tiketa u interfejsu operatera (neophodno je aktivirati Ticket::Service).',
        'Sets the service in the ticket note screen of the agent interface (Ticket::Service needs to be activated).' =>
            'Podešava servis na ekranu napomene tiketa u interfejsu operatera (neophodno je aktivirati Ticket::Service).',
        'Sets the service in the ticket owner screen of a zoomed ticket in the agent interface (Ticket::Service needs to be activated).' =>
            'Podešava servis na ekranu vlasnika tiketa na detaljnom pregledu tiketa u interfejsu operatera (neophodno je aktivirati Ticket::Service).',
        'Sets the service in the ticket pending screen of a zoomed ticket in the agent interface (Ticket::Service needs to be activated).' =>
            'Podešava servis na ekranu tiketa na čekanju na detaljnom pregledu tiketa u interfejsu operatera (neophodno je aktivirati Ticket::Service).',
        'Sets the service in the ticket priority screen of a zoomed ticket in the agent interface (Ticket::Service needs to be activated).' =>
            'Podešava servis na ekranu prioriteta tiketa na detaljnom pregledu tiketa u interfejsu operatera (neophodno je aktivirati Ticket::Service).',
        'Sets the service in the ticket responsible screen of the agent interface (Ticket::Service needs to be activated).' =>
            'Podešava servis na ekranu odgovornog za tiket u interfejsu operatera (neophodno je aktivirati Ticket::Service).',
        'Sets the stats hook.' => '',
        'Sets the ticket owner in the close ticket screen of the agent interface.' =>
            'Postavlja vlasnika tiketa u prozoru zatvaranja tiketa u interfejsu operatera.',
        'Sets the ticket owner in the ticket bulk screen of the agent interface.' =>
            'Postavlja vlasnika tiketa u prozoru masovnih akcija tiketa u interfejsu operatera.',
        'Sets the ticket owner in the ticket free text screen of the agent interface.' =>
            'Postavlja vlasnika tiketa u prozoru slobodnog teksta tiketa u interfejsu operatera.',
        'Sets the ticket owner in the ticket note screen of the agent interface.' =>
            'Postavlja vlasnika tiketa u prozoru napomene tiketa u interfejsu operatera.',
        'Sets the ticket owner in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Određuje vlasnika tiketa na ekranu vlasništva tiketa u detaljnom prikazu tiketa interfejsa operatera.',
        'Sets the ticket owner in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Određuje vlasnika tiketa na ekranu tiketa na čekanju u detaljnom prikazu tiketa interfejsa operatera.',
        'Sets the ticket owner in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Određuje vlasnika tiketa na ekranu prioriteta tiketa u detaljnom prikazu tiketa interfejsa operatera.',
        'Sets the ticket owner in the ticket responsible screen of the agent interface.' =>
            'Određuje vlasnika tiketa na ekranu odgovornosti za tiket u interfejsu operatera.',
        'Sets the ticket type in the close ticket screen of the agent interface (Ticket::Type needs to be activated).' =>
            'Određuje tip tiketa na ekranu zatvaranja tiket u interfejsu operatera (Tiket::Tip treba da bude aktivirano).',
        'Sets the ticket type in the ticket bulk screen of the agent interface.' =>
            'Određuje tip tiketa na ekranu masovne akcije tiketa u interfejsu operatera.',
        'Sets the ticket type in the ticket free text screen of the agent interface (Ticket::Type needs to be activated).' =>
            'Određuje tip tiketa na ekranu slobodnog teksta tiketa u interfejsu operatera (Tiket::Tip treba da bude aktivirano).',
        'Sets the ticket type in the ticket note screen of the agent interface (Ticket::Type needs to be activated).' =>
            'Određuje tip tiketa na ekranu napomene tiketa u interfejsu operatera (Tiket::Tip treba da bude aktivirano).',
        'Sets the ticket type in the ticket owner screen of a zoomed ticket in the agent interface (Ticket::Type needs to be activated).' =>
            'Određuje tip tiketa na ekranu vlasništva tiketa detaljnog prikaza tiketa u interfejsu operatera (Tiket::Tip treba da bude aktivirano).',
        'Sets the ticket type in the ticket pending screen of a zoomed ticket in the agent interface (Ticket::Type needs to be activated).' =>
            'Određuje tip tiketa na ekranu tiketa na čekanju detaljnog prikaza tiketa u interfejsu operatera (Tiket::Tip treba da bude aktivirano).',
        'Sets the ticket type in the ticket priority screen of a zoomed ticket in the agent interface (Ticket::Type needs to be activated).' =>
            'Određuje tip tiketa na ekranu prioriteta tiketa detaljnog prikaza tiketa u interfejsu operatera (Tiket::Tip treba da bude aktivirano).',
        'Sets the ticket type in the ticket responsible screen of the agent interface (Ticket::Type needs to be activated).' =>
            'Određuje tip tiketa na ekranu odgovornosti za tiket u interfejsu operatera (Tiket::Tip treba da bude aktivirano).',
        'Sets the time (in seconds) a user is marked as active.' => 'Određuje vreme (u sekundama) za označavanje korisnika kao aktivnog.',
        'Sets the time zone being used internally by OTRS to e. g. store dates and times in the database. WARNING: This setting must not be changed once set and tickets or any other data containing date/time have been created.' =>
            '',
        'Sets the time zone that will be assigned to newly created users and will be used for users that haven\'t yet set a time zone. This is the time zone being used as default to convert date and time between the OTRS time zone and the user\'s time zone.' =>
            '',
        'Sets the timeout (in seconds) for http/ftp downloads.' => 'Postavlja vremensko odlaganje (u sekundama) za „http/ftp” preuzimanja.',
        'Sets the timeout (in seconds) for package downloads. Overwrites "WebUserAgent::Timeout".' =>
            '',
        'Shared Secret' => '',
        'Should the cache data be held in memory?' => '',
        'Should the cache data be stored in the selected cache backend?' =>
            'Da li keširani podaci treba da se čuvaju u odabranom kešu sistema u pozadini?',
        'Show a responsible selection in phone and email tickets in the agent interface.' =>
            'Prikaži izbor odgovornog u telefonskim i imejl tiketima u operaterskom interfejsu.',
        'Show article as rich text even if rich text writing is disabled.' =>
            'Prikaži članak kao obogaćeni tekst čak i kad je pisanje obogaćenog teksta deaktivirano.',
        'Show queues even when only locked tickets are in.' => 'Prikaži redove čak i kad sadrže samo zaključane tikete.',
        'Show the current owner in the customer interface.' => 'Prikazuje aktuelnog vlasnika u klijentskom interfejsu.',
        'Show the current queue in the customer interface.' => 'Prikazuje aktuelni red u klijentskom interfejsu.',
        'Show the history for this ticket' => 'Prikaži istorijat za ovaj tiket',
        'Show the ticket history' => 'Prikaži istoriju tiketa',
        'Shows a count of icons in the ticket zoom, if the article has attachments.' =>
            'Prikazuje broj ikona u detaljnom prikazu tiketa ako članak  ima priloge.',
        'Shows a link in the menu for subscribing / unsubscribing from a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu that allows linking a ticket with another object in the ticket zoom view of the agent interface.  Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu that allows merging tickets in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to access the history of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to add a free text field in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to add a note in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to add a note to a ticket in every ticket overview of the agent interface.' =>
            'U meniju prikazuje vezu za dodavanje napomene na tiket u svaki pregled tiketa u interfejsu operatera.',
        'Shows a link in the menu to close a ticket in every ticket overview of the agent interface.' =>
            'U meniju prikazuje vezu za zatvaranje tiketa u svaki pregled tiketa u interfejsu operatera.',
        'Shows a link in the menu to close a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to delete a ticket in every ticket overview of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Shows a link in the menu to delete a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to enroll a ticket into a process in the ticket zoom view of the agent interface.' =>
            '',
        'Shows a link in the menu to go back in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to lock / unlock a ticket in the ticket overviews of the agent interface.' =>
            'U meniju prikazuje vezu za zaključavanje / otključavanje tiketa u preglede tiketa u interfejsu operatera.',
        'Shows a link in the menu to lock/unlock tickets in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to move a ticket in every ticket overview of the agent interface.' =>
            'U meniju prikazuje vezu za pomeranje tiketa u svaki pregled tiketa u interfejsu operatera.',
        'Shows a link in the menu to print a ticket or an article in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to see the customer who requested the ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to see the history of a ticket in every ticket overview of the agent interface.' =>
            'U meniju prikazuje vezu za gledanje istorijata tiketa u svaki pregled tiketa u interfejsu operatera.',
        'Shows a link in the menu to see the owner of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to see the priority of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to see the responsible agent of a ticket in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to send an outbound email in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to set a ticket as junk in every ticket overview of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Shows a link in the menu to set a ticket as pending in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a link in the menu to set the priority of a ticket in every ticket overview of the agent interface.' =>
            'U meniju prikazuje vezu za podešavanje prioriteta tiketa u svaki pregled tiketa u interfejsu operatera.',
        'Shows a link in the menu to zoom a ticket in the ticket overviews of the agent interface.' =>
            'U meniju prikazuje vezu za detaljni prikaz tiketa u preglede tiketa u interfejsu operatera.',
        'Shows a link to access article attachments via a html online viewer in the zoom view of the article in the agent interface.' =>
            'U meniju prikazuje vezu za pristup prilozima članka preko „html” pregleda u detaljnom pregledu članka u interfejsu operatera.',
        'Shows a link to download article attachments in the zoom view of the article in the agent interface.' =>
            'U meniju prikazuje vezu za preuzimanje priloga članka u detaljnom pregledu članka u interfejsu operatera',
        'Shows a link to see a zoomed email ticket in plain text.' => 'Prikazuje vezu za prikaz detaljnog pregleda tiketa kao običan tekst.',
        'Shows a link to set a ticket as junk in the ticket zoom view of the agent interface. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2". To cluster menu items use for Key "ClusterName" and for the Content any name you want to see in the UI. Use "ClusterPriority" to configure the order of a certain cluster within the toolbar.' =>
            '',
        'Shows a list of all the involved agents on this ticket, in the close ticket screen of the agent interface.' =>
            'Prikazuje listu svih uključenih operatera za ovaj tiket, na ekranu zatvaranja tiketa u operaterskom interfejsu.',
        'Shows a list of all the involved agents on this ticket, in the ticket free text screen of the agent interface.' =>
            'Prikazuje listu svih uključenih operatera za ovaj tiket, na ekranu slobodnog teksta tiketa u operaterskom interfejsu.',
        'Shows a list of all the involved agents on this ticket, in the ticket note screen of the agent interface.' =>
            'Prikazuje listu svih uključenih operatera za ovaj tiket, na ekranu napomene tiketa u operaterskom interfejsu.',
        'Shows a list of all the involved agents on this ticket, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje listu svih uključenih operatera za ovaj tiket, na ekranu vlasnika tiketa na detaljnom prikazu tiketa u operaterskom interfejsu.',
        'Shows a list of all the involved agents on this ticket, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje listu svih uključenih operatera za ovaj tiket, na ekranu tiketa na čekanju na detaljnom prikazu tiketa u operaterskom interfejsu.',
        'Shows a list of all the involved agents on this ticket, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje listu svih uključenih operatera za ovaj tiket, na ekranu prioriteta tiketa na detaljnom prikazu tiketa u operaterskom interfejsu.',
        'Shows a list of all the involved agents on this ticket, in the ticket responsible screen of the agent interface.' =>
            'Prikazuje listu svih uključenih operatera za ovaj tiket, na ekranu odgovornog za tiket u operaterskom interfejsu.',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the close ticket screen of the agent interface.' =>
            'Prikazuje listu svih mogućih operatera (svi operateri sa dozvolom za napomenu za red/tiket) radi utvrđivanja ko treba da bude informisan o ovoj napomeni, na ekranu zatvaranja tiketa u interfejsu operatera.',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket free text screen of the agent interface.' =>
            'Prikazuje listu svih mogućih operatera (svi operateri sa dozvolom za napomenu za red/tiket) radi utvrđivanja ko treba da bude informisan o ovoj napomeni, na ekranu slobodnog teksta tiketa u interfejsu operatera.',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket note screen of the agent interface.' =>
            'Prikazuje listu svih mogućih operatera (svi operateri sa dozvolom za napomenu za red/tiket) radi utvrđivanja ko treba da bude informisan o ovoj napomeni, na ekranu napomene tiketa u interfejsu operatera.',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje listu svih mogućih operatera (svi operateri sa dozvolom za napomenu za red/tiket) radi utvrđivanja ko treba da bude informisan o ovoj napomeni, na ekranu vlasništva tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje listu svih mogućih operatera (svi operateri sa dozvolom za napomenu za red/tiket) radi utvrđivanja ko treba da bude informisan o ovoj napomeni, na ekranu tiketa na čekanju na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje listu svih mogućih operatera (svi operateri sa dozvolom za napomenu za red/tiket) radi utvrđivanja ko treba da bude informisan o ovoj napomeni, na ekranu prioriteta tiketa na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows a list of all the possible agents (all agents with note permissions on the queue/ticket) to determine who should be informed about this note, in the ticket responsible screen of the agent interface.' =>
            'Prikazuje listu svih mogućih operatera (svi operateri sa dozvolom za napomenu za red/tiket) radi utvrđivanja ko treba da bude informisan o ovoj napomeni, na ekranu odgovornosti za tiket u interfejsu operatera.',
        'Shows a preview of the ticket overview (CustomerInfo => 1 - shows also Customer-Info, CustomerInfoMaxSize max. size in characters of Customer-Info).' =>
            'Prikazuje pregleda tiketa (Info klijenta => 1 - pokazuje i podatke o klijentu, Maksimalna veličina prikaza podataka o klijentu u karakterima).',
        'Shows a select of ticket attributes to order the queue view ticket list. The possible selections can be configured via \'TicketOverviewMenuSort###SortAttributes\'.' =>
            '',
        'Shows all both ro and rw queues in the queue view.' => 'Prikazuje sve, i „ro” i „rw” redove na pregledu redova.',
        'Shows all both ro and rw tickets in the service view.' => 'Prikazuje sve, i ro i rw tikete na pregledu usluga.',
        'Shows all open tickets (even if they are locked) in the escalation view of the agent interface.' =>
            'Prikazuje sve otvorene tikete (čak iako su zaključani) na eskalacionom pregledu u interfejsu operatera.',
        'Shows all open tickets (even if they are locked) in the status view of the agent interface.' =>
            'Prikazuje sve otvorene tikete (čak iako su zaključani) na statusnom pregledu u interfejsu operatera.',
        'Shows all the articles of the ticket (expanded) in the zoom view.' =>
            'Prikazuje sve članke tiketa (detaljno) na detaljnom pregledu.',
        'Shows all the customer identifiers in a multi-select field (not useful if you have a lot of customer identifiers).' =>
            'Prikazuje sve klijentske identifikatore u polju višestrukog izbora (nije korisno ako imate mnogo klijentskih identifikatora).',
        'Shows an owner selection in phone and email tickets in the agent interface.' =>
            'Prikazuje izbor vlasnika za telefonske i imejl tikete u interfejsu operatera.',
        'Shows colors for different article types in the article table.' =>
            'Prikazuje boje za razne tipove članaka u tabeli članaka.',
        'Shows customer history tickets in AgentTicketPhone, AgentTicketEmail and AgentTicketCustomer.' =>
            '',
        'Shows either the last customer article\'s subject or the ticket title in the small format overview.' =>
            'Prikazuje predmet zadnjeg klijentovog članka ili naslov tiketa u prekledu malog formata.',
        'Shows existing parent/child queue lists in the system in the form of a tree or a list.' =>
            'Prikazuje postojeće liste redova nadređeni-podređeni u sistemu u formi stabla ili liste.',
        'Shows information on how to start OTRS Daemon' => 'Prikazuje informacije kako pokrenuti „OTRS” servis',
        'Shows the activated ticket attributes in the customer interface (0 = Disabled and 1 = Enabled).' =>
            'Prikazuje atribute aktiviranih tiketa u interfejsu klijenta (0 = Onemogućeno, 1 = Omogućeno).',
        'Shows the articles sorted normally or in reverse, under ticket zoom in the agent interface.' =>
            'Prikazuje članke sortirano normalno ili obrnuto, na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the customer user information (phone and email) in the compose screen.' =>
            'Prikazuje podatke o klijentu korisniku (broj telefona i imejl) na ekranu pisanja poruke.',
        'Shows the customer user\'s info in the ticket zoom view.' => 'Prikazuje informacije o klijentu na detaljnom pregledu tiketa.',
        'Shows the message of the day (MOTD) in the agent dashboard. "Group" is used to restrict access to the plugin (e. g. Group: admin;group1;group2;). "Default" indicates if the plugin is enabled by default or if the user needs to enable it manually.' =>
            '',
        'Shows the message of the day on login screen of the agent interface.' =>
            'Prikazuje dnevnu poruku na ekranu za prijavu u interfejsu operatera.',
        'Shows the ticket history (reverse ordered) in the agent interface.' =>
            'Prikazuje istorijat tiketa (obrnut redosled) u interfejsu operatera.',
        'Shows the ticket priority options in the close ticket screen of the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu zatvorenog tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the move ticket screen of the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu pomeranja tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the ticket bulk screen of the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu masovnih tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the ticket free text screen of the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu slobodnog teksta tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the ticket note screen of the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu napomene tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu vlasnika na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu prikaza  čekanja na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu prioriteta na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the ticket priority options in the ticket responsible screen of the agent interface.' =>
            'Prikazuje opcije prioriteta tiketa na ekranu o odgovornosti na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the title fields in the close ticket screen of the agent interface.' =>
            'Prikazuje naslovna polja na ekranu zatvorenog tiketa u interfejsu operatera.',
        'Shows the title fields in the ticket free text screen of the agent interface.' =>
            'Prikazuje naslovna polja na ekranu slobodnog teksta tiketa u interfejsu operatera.',
        'Shows the title fields in the ticket note screen of the agent interface.' =>
            'Prikazuje naslovna polja na ekranu napomene tiketa u interfejsu operatera.',
        'Shows the title fields in the ticket owner screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje naslovna polja na ekranu vlasnika na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the title fields in the ticket pending screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje naslovna polja na ekranu prikaza čekanja na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the title fields in the ticket priority screen of a zoomed ticket in the agent interface.' =>
            'Prikazuje naslovna polja na ekranu prioriteta na detaljnom prikazu tiketa u interfejsu operatera.',
        'Shows the title fields in the ticket responsible screen of the agent interface.' =>
            'Prikazuje naslovna polja na prikazu ekrana odgovornosti  za tiket u interfejsu operatera.',
        'Shows time in long format (days, hours, minutes), if set to "Yes"; or in short format (days, hours), if set to "No".' =>
            '',
        'Shows time use complete description (days, hours, minutes), if set to "Yes"; or just first letter (d, h, m), if set to "No".' =>
            '',
        'Signatures' => 'Potpisi',
        'Simple' => 'Jednostavno',
        'Skin' => 'Izgled',
        'Slovak' => 'Slovački',
        'Slovenian' => 'Slovenački',
        'Small' => 'Malo',
        'Software Package Manager.' => 'Upravljanje programskim paketima.',
        'SolutionDiffInMin' => '',
        'SolutionInMin' => '',
        'Some description!' => 'Neki opis!',
        'Some picture description!' => 'Neki opis slike!',
        'Sorts the tickets (ascendingly or descendingly) when a single queue is selected in the queue view and after the tickets are sorted by priority. Values: 0 = ascending (oldest on top, default), 1 = descending (youngest on top). Use the QueueID for the key and 0 or 1 for value.' =>
            'Sortiranje tiketa (uzlazno ili silazno) kada se izabere jedan red iz pregleda redova posle sortiranja tiketa po prioritetu. Vrednosti: 0 = uzlazno (najstarije na vrhu, podrazumevano), 1 = silazno (najnovije na vrhu). Koristi ID reda za ključ i 0 ili 1 za vrednost.',
        'Sorts the tickets (ascendingly or descendingly) when a single queue is selected in the service view and after the tickets are sorted by priority. Values: 0 = ascending (oldest on top, default), 1 = descending (youngest on top). Use the ServiceID for the key and 0 or 1 for value.' =>
            'Sortiranje tiketa (uzlazno ili silazno) kada se izabere jedan red iz pregleda usluge posle sortiranja tiketa po prioritetu. Vrednosti: 0 = uzlazno (najstarije na vrhu, podrazumevano), 1 = silazno (najnovije na vrhu). Koristi ID usluge za ključ i 0 ili 1 za vrednost.',
        'Spam' => '',
        'Spam Assassin example setup. Ignores emails that are marked with SpamAssassin.' =>
            'Primer podešavanja za Spam Assassin. Ignoriše imejlove koje je označio Spam Assassin.',
        'Spam Assassin example setup. Moves marked mails to spam queue.' =>
            'Primer podešavanja za Spam Assassin. Premešta označene imejlove u red za nepoželjne.',
        'Spanish' => 'Španski',
        'Spanish (Colombia)' => 'Španski (Kolumbija)',
        'Spanish (Mexico)' => 'Španski (Meksiko)',
        'Spanish stop words for fulltext index. These words will be removed from the search index.' =>
            'Španske zaustavne reči za indeks pretragu kompletnog teksta. Ove reči će biti uklonjene iz indeksa pretrage.',
        'Specifies if an agent should receive email notification of his own actions.' =>
            'Definiše da li operater treba da dobije imejl obaveštenje za svoje akcije.',
        'Specifies the available note types for this ticket mask. If the option is deselected, ArticleTypeDefault is used and the option is removed from the mask.' =>
            'Navodi dostupne tipove napomena za ovu masku tiketa. Ako opcija nije izabrana, koristi se podrazumevani tip članka i opcija je uklonjena iz maske.',
        'Specifies the default article type for the ticket compose screen in the agent interface if the article type cannot be automatically detected.' =>
            'Navodi podrazumevani tip članka za ekran sastavljanja tiketa u interfejsu operatera ako se ne može automatski odrediti tip članka.',
        'Specifies the different article types that will be used in the system.' =>
            'Određuje različite tipove artikala koji će se koristiti u sistemu.',
        'Specifies the different note types that will be used in the system.' =>
            'Određuje različite tipove napomena koji će se koristiti u sistemu.',
        'Specifies the directory to store the data in, if "FS" was selected for TicketStorageModule.' =>
            'Određuje direktorijum za skladištenje podataka ako je "FS" izabran za TicketStorageModule.',
        'Specifies the directory where SSL certificates are stored.' => 'Određuje direktorijum gde se SSL sertifikati skladište.',
        'Specifies the directory where private SSL certificates are stored.' =>
            'Određuje direktorijum gde se privatni SSL sertifikati skladište.',
        'Specifies the email address that should be used by the application when sending notifications. The email address is used to build the complete display name for the notification master (i.e. "OTRS Notifications" otrs@your.example.com). You can use the OTRS_CONFIG_FQDN variable as set in your configuation, or choose another email address.' =>
            '',
        'Specifies the email addresses to get notification messages from scheduler tasks.' =>
            'Odredi imejl adresu koja će dobijati poruke obaveštenja od zadataka planera.',
        'Specifies the group where the user needs rw permissions so that he can access the "SwitchToCustomer" feature.' =>
            'Određuje grupu gde su klijentima potrebne „rw” dozvole kako bi mogli pristupiti svojstvu „SwitchToCustomer”.',
        'Specifies the name that should be used by the application when sending notifications. The sender name is used to build the complete display name for the notification master (i.e. "OTRS Notifications" otrs@your.example.com).' =>
            '',
        'Specifies the order in which the firstname and the lastname of agents will be displayed.' =>
            'Određuje redosled kojim će biti prikazano ime i prezime operatera.',
        'Specifies the path of the file for the logo in the page header (gif|jpg|png, 700 x 100 pixel).' =>
            'Određuje putanju datoteke logoa u zaglavlju strane (gif|jpg|png, 700 x 100 pixel).',
        'Specifies the path of the file for the performance log.' => 'Određuje putanju datoteke za performansu log-a.',
        'Specifies the path to the converter that allows the view of Microsoft Excel files, in the web interface.' =>
            'Određuje putanju konvertora koji dozvoljava pregled Microsoft Excel datoteka u veb interfejsu.',
        'Specifies the path to the converter that allows the view of Microsoft Word files, in the web interface.' =>
            'Određuje putanju konvertora koji dozvoljava pregled Microsoft Word datoteka u veb interfejsu.',
        'Specifies the path to the converter that allows the view of PDF documents, in the web interface.' =>
            'Određuje putanju konvertora koji dozvoljava pregled PDF dokumenata u veb interfe',
        'Specifies the path to the converter that allows the view of XML files, in the web interface.' =>
            'Određuje putanju konvertora koji dozvoljava pregled XML datoteka u veb interfe',
        'Specifies the text that should appear in the log file to denote a CGI script entry.' =>
            'Određuje tekst koji treba da se pojavi u log datoteci da označi ulazak CGI skripte.',
        'Specifies user id of the postmaster data base.' => 'Određuje ID korisnika postmaster baze podataka.',
        'Specifies whether all storage backends should be checked when looking for attachments. This is only required for installations where some attachments are in the file system, and others in the database.' =>
            '',
        'Specify how many sub directory levels to use when creating cache files. This should prevent too many cache files being in one directory.' =>
            'Navođenje koliko nivoa poddirektorijuma da koristi prilikom kreiranja keš fajlova. To bi trebalo da spreči previše keš fajlova u jednom direktorijumu.',
        'Specify the channel to be used to fetch OTRS Business Solution™ updates. Warning: Development releases might not be complete, your system might experience unrecoverable errors and on extreme cases could become unresponsive!' =>
            '',
        'Specify the password to authenticate for the first mirror database.' =>
            'Navedi lozinku za autorizaciju na prvu preslikanu bazu podataka.',
        'Specify the username to authenticate for the first mirror database.' =>
            'Navedi korisničko ime za autorizaciju na prvu preslikanu bazu podataka.',
        'Spell checker.' => '',
        'Spelling Dictionary' => 'Pravopisni rečnik',
        'Standard available permissions for agents within the application. If more permissions are needed, they can be entered here. Permissions must be defined to be effective. Some other good permissions have also been provided built-in: note, close, pending, customer, freetext, move, compose, responsible, forward, and bounce. Make sure that "rw" is always the last registered permission.' =>
            'Standardne raspoložive dozvole za operatere unutar aplikacije. Ukoliko je potrebno više dozvola oni mogu uneti ovde. Dozvole moraju biti definisane da budu efektivne. Neke druge dozvole su takođe obezbeđene ugrađivanjem u: napomenu, zatvori, na čekanju, klijent, slobodan tekst, pomeri, otvori, odgovoran, prosledi i povrati. Obezbedi da „rw” uvek bude poslednja registrovana dozvola.',
        'Start number for statistics counting. Every new stat increments this number.' =>
            'Početni broj za brojanje statistika. Svaka nova statistika povećava ovaj broj.',
        'Starts a wildcard search of the active object after the link object mask is started.' =>
            'Počinje džoker pretragu aktivnog objekta nakon pokretanja veze maske objekta.',
        'Stat#' => 'Statistika#',
        'States' => 'Stanja',
        'Status view' => 'Pregled statusa',
        'Stores cookies after the browser has been closed.' => 'Čuva kolačiće nakon zatvaranja pretraživača.',
        'Strips empty lines on the ticket preview in the queue view.' => 'Uklanja prazne linije u prikazu tiketa na pregledu reda.',
        'Strips empty lines on the ticket preview in the service view.' =>
            'Uklanja prazne linije u prikazu tiketa na pregledu usluga.',
        'Swahili' => '',
        'Swedish' => 'Švedski',
        'System Address Display Name' => '',
        'System Maintenance' => 'Održavanje sistema',
        'System Request (%s).' => 'Sistemski zahtev (%s).',
        'Target' => 'Cilj',
        'Templates ↔ Queues' => '',
        'Textarea' => 'Oblast teksta',
        'Thai' => '',
        'The agent skin\'s InternalName which should be used in the agent interface. Please check the available skins in Frontend::Agent::Skins.' =>
            '',
        'The customer skin\'s InternalName which should be used in the customer interface. Please check the available skins in Frontend::Customer::Skins.' =>
            '',
        'The daemon registration for the scheduler cron task manager.' =>
            '',
        'The daemon registration for the scheduler future task manager.' =>
            '',
        'The daemon registration for the scheduler generic agent task manager.' =>
            '',
        'The daemon registration for the scheduler task worker.' => '',
        'The divider between TicketHook and ticket number. E.g \': \'.' =>
            'Delilac između priključka i broja tiketa, npr „: ”.',
        'The duration in minutes after emitting an event, in which the new escalation notify and start events are suppressed.' =>
            'Vreme u minutima posle emitovanja događaja, u kom su novo obaveštenje o eskalaciji i startu događaja prikriveni.',
        'The format of the subject. \'Left\' means \'[TicketHook#:12345] Some Subject\', \'Right\' means \'Some Subject [TicketHook#:12345]\', \'None\' means \'Some Subject\' and no ticket number. In the latter case you should verify that the setting PostMaster::CheckFollowUpModule###0200-References is activated to recognize followups based on email headers.' =>
            '',
        'The headline shown in the customer interface.' => 'Naslov prikazan u klijentskom interfejsu.',
        'The identifier for a ticket, e.g. Ticket#, Call#, MyTicket#. The default is Ticket#.' =>
            'Identifikator tiketa, npr Tiket#, Poziv#, MojTiket#. Podrazumevano je Tiket#.',
        'The logo shown in the header of the agent interface for the skin "default". See "AgentLogo" for further description.' =>
            '',
        'The logo shown in the header of the agent interface for the skin "ivory". See "AgentLogo" for further description.' =>
            '',
        'The logo shown in the header of the agent interface for the skin "ivory-slim". See "AgentLogo" for further description.' =>
            '',
        'The logo shown in the header of the agent interface for the skin "slim". See "AgentLogo" for further description.' =>
            '',
        'The logo shown in the header of the agent interface. The URL to the image can be a relative URL to the skin image directory, or a full URL to a remote web server.' =>
            'Logo prikazan u zaglavlju operaterskog interfejsa. URL do slike može biti relativan u odnosu na direktorijum sa slikama ili apsolutan do udaljenog servera.',
        'The logo shown in the header of the customer interface. The URL to the image can be a relative URL to the skin image directory, or a full URL to a remote web server.' =>
            'Logo prikazan u zaglavlju klijentskog interfejsa. URL do slike može biti relativan u odnosu na direktorijum sa slikama ili apsolutan do udaljenog servera.',
        'The logo shown on top of the login box of the agent interface. The URL to the image must be relative URL to the skin image directory.' =>
            'Logo prikazan na vrhu ekrana za prijavu u operaterski interfejs. URL do slike mora biti relativan u odnosu na direktorijum sa slikama.',
        'The maximal number of articles expanded on a single page in AgentTicketZoom.' =>
            '',
        'The maximal number of articles shown on a single page in AgentTicketZoom.' =>
            'Maksimalni broj članaka za prikaz na jednoj strani na detaljnom prikazu tiketa u interfejsu operatera.',
        'The maximum number of mails fetched at once before reconnecting to the server.' =>
            'Maksimalni broj imejlova preuzetih odjednom pre ponovne konekcije na server.',
        'The text at the beginning of the subject in an email reply, e.g. RE, AW, or AS.' =>
            'Tekst na početku predmeta u odgovoru na imejl, npr „RE”, „AW”, ili „OD”.',
        'The text at the beginning of the subject when an email is forwarded, e.g. FW, Fwd, or WG.' =>
            'Tekst na početku predmeta kada se imejl prosleđuje, npr „FW”, „Fwd”, ili „Pro”.',
        'Theme' => 'Tema',
        'This event module stores attributes from CustomerUser as DynamicFields tickets. Please see the setting above for how to configure the mapping.' =>
            '',
        'This is the default orange - black skin for the customer interface.' =>
            '',
        'This is the default orange - black skin.' => '',
        'This module and its PreRun() function will be executed, if defined, for every request. This module is useful to check some user options or to display news about new applications.' =>
            '',
        'This module is part of the admin area of OTRS.' => '',
        'This option defines the dynamic field in which a Process Management activity entity id is stored.' =>
            'Ova opcija određuje dinamičko polje u koje se smešta ID entiteta aktivnosti upravljanja procesima.',
        'This option defines the dynamic field in which a Process Management process entity id is stored.' =>
            'Ova opcija određuje dinamičko polje u koje se smešta ID entiteta aktivnosti upravljanja procesima.',
        'This option defines the process tickets default lock.' => 'Ova opcija određuje podrazumevano zaključavanje tiketa u obradi.',
        'This option defines the process tickets default priority.' => 'Ova opcija određuje podrazumevani prioritet tiketa u obradi.',
        'This option defines the process tickets default queue.' => 'Ova opcija određuje podrazumevani red tiketa u obradi.',
        'This option defines the process tickets default state.' => 'Ova opcija određuje podrazumevani status tiketa u obradi.',
        'This option will deny the access to customer company tickets, which are not created by the customer user.' =>
            'Ova opcija će odbiti pristup tiketima klijentove firme, ako ih  nije  kreirao klijent korisnik .',
        'This setting allows you to override the built-in country list with your own list of countries. This is particularly handy if you just want to use a small select group of countries.' =>
            'Ova opcija vam dozvoljava da ugrađenu listu država zamenite svojom. Ovo je posbno korisno ako u selekciji želite da koristite samo mali broj država.',
        'This setting is deprecated. Set OTRSTimeZone instead.' => '',
        'This will allow the system to send text messages via SMS.' => 'Ovo će dozvoliti sistemu da šalje tekstualne poruke preko SMS.',
        'Ticket Close.' => '',
        'Ticket Compose Bounce Email.' => '',
        'Ticket Compose email Answer.' => '',
        'Ticket Customer.' => '',
        'Ticket Forward Email.' => '',
        'Ticket FreeText.' => '',
        'Ticket History.' => '',
        'Ticket Lock.' => '',
        'Ticket Merge.' => '',
        'Ticket Move.' => '',
        'Ticket Note.' => '',
        'Ticket Notifications' => 'Obaveštenja o tiketu',
        'Ticket Outbound Email.' => '',
        'Ticket Overview "Medium" Limit' => 'Ograničenje pregleda tiketa - "srednje"',
        'Ticket Overview "Preview" Limit' => 'Ograničenje pregleda tiketa - "Prikaz"',
        'Ticket Overview "Small" Limit' => 'Ograničenje pregleda tiketa - "malo"',
        'Ticket Owner.' => '',
        'Ticket Pending.' => '',
        'Ticket Print.' => '',
        'Ticket Priority.' => '',
        'Ticket Queue Overview' => 'Pregled reda tiketa',
        'Ticket Responsible.' => '',
        'Ticket Watcher' => '',
        'Ticket Zoom.' => '',
        'Ticket bulk module.' => '',
        'Ticket event module that triggers the escalation stop events.' =>
            'Modul događaja tiketa koji okida događaje zaustavljanja eskalacije.',
        'Ticket limit per page for Ticket Overview "Medium"' => 'Ograničenje tiketa po strani za pregled - "srednje"',
        'Ticket limit per page for Ticket Overview "Preview"' => 'Ograničenje tiketa po strani za pregled- "Prikaz"',
        'Ticket limit per page for Ticket Overview "Small"' => 'Ograničenje tiketa po strani za pregled - "malo"',
        'Ticket moved into Queue "%s" (%s) from Queue "%s" (%s).' => 'Tiket premešten u red "%s" (%s) iz reda "%s" (%s).',
        'Ticket notifications' => 'Obaveštenja o tiketu',
        'Ticket overview' => 'Pregled tiketa',
        'Ticket plain view of an email.' => '',
        'Ticket title' => '',
        'Ticket zoom view.' => 'Detaljni pregled tiketa.',
        'TicketNumber' => 'Broj tiketa',
        'Tickets.' => 'Tiketi.',
        'Time in seconds that gets added to the actual time if setting a pending-state (default: 86400 = 1 day).' =>
            'Vreme u sekundama koje se dodaje na trenutno vreme ako se postavlja status „na čekanju” (podrazumevano: 86400 = 1 dan).',
        'Title updated: Old: "%s", New: "%s"' => 'Ažuriran naslov: Stari: „%s”, Nov: „%s”',
        'To accept login information, such as an EULA or license.' => '',
        'To download attachments.' => '',
        'Toggles display of OTRS FeatureAddons list in PackageManager.' =>
            '',
        'Toolbar Item for a shortcut. Additional access control to show or not show this link can be done by using Key "Group" and Content like "rw:group1;move_into:group2".' =>
            '',
        'Transport selection for ticket notifications.' => 'Izbor transporta za obaveštenja o tiketima.',
        'Tree view' => 'Prikaz u obliku stabla',
        'Triggers ticket escalation events and notification events for escalation.' =>
            'Aktivira eskalacione događaje tiketa i događaje obaveštenja za eskalacije.',
        'Turkish' => 'Turski',
        'Turns off SSL certificate validation, for example if you use a transparent HTTPS proxy. Use at your own risk!' =>
            '',
        'Turns on drag and drop for the main navigation.' => 'Aktivira prevuci i otpusti u glavnoj navigaciji.',
        'Turns on the remote ip address check. It should be set to "No" if the application is used, for example, via a proxy farm or a dialup connection, because the remote ip address is mostly different for the requests.' =>
            'Uključivanje provere udaljene IP adrese. Treba biti podešeno na "Ne" ako se aplikacija koristi, na primer preko proxy farme ili dialup konekcije, zato što je udaljena IP adresa uglavnom drugačija za zahteve.',
        'Ukrainian' => 'Ukrajinski',
        'Unlock tickets that are past their unlock timeout.' => 'Otključaj tikete kojima je isteklo vreme odlaganja za otključavanje.',
        'Unlock tickets whenever a note is added and the owner is out of office.' =>
            'Otključavanje tiketa kad god se doda napomena i vlasnik je van kancelarije.',
        'Unlocked ticket.' => 'Otključano',
        'Up' => 'Gore',
        'Upcoming Events' => 'Predstojeći događaji',
        'Update Ticket "Seen" flag if every article got seen or a new Article got created.' =>
            'Ažuriraj oznaku viđenih tiketa ako su svi pregledani ili je kreiran novi članak.',
        'Updated SLA to %s (ID=%s).' => 'Ažuriran SLA "%s" (ID=%s).',
        'Updated Service to %s (ID=%s).' => 'Ažurirana usluga "%s" (ID=%s).',
        'Updated Type to %s (ID=%s).' => 'Ažuriran tip "%s" (ID=%s).',
        'Updated: %s' => 'Ažurirano: %s',
        'Updated: %s=%s;%s=%s;%s=%s;' => 'Ažurirano: %s=%s;%s=%s;%s=%s;',
        'Updates the ticket escalation index after a ticket attribute got updated.' =>
            'Ažuriraj indeks eskalacije tiketa posle ažuriranja atributa tiketa.',
        'Updates the ticket index accelerator.' => 'Ažuriraj akcelerator indeksa tiketa.',
        'Use new type of select and autocomplete fields in agent interface, where applicable (InputFields).' =>
            'Koristite novi tip polja za izbor i automatsko dovršavanje u interfejsu operatera gde je to moguće (polja za unos).',
        'Use new type of select and autocomplete fields in customer interface, where applicable (InputFields).' =>
            'Koristite novi tip polja za izbor i automatsko dovršavanje u interfejsu klijenta gde je to moguće (polja za unos).',
        'User Profile' => 'Korisnički profil',
        'UserFirstname' => 'Ime korisnika',
        'UserLastname' => 'Prezime korisnika',
        'Uses richtext for viewing and editing ticket notification.' => '',
        'Uses richtext for viewing and editing: articles, salutations, signatures, standard templates, auto responses and notifications.' =>
            'Koristi richtekt format za pregled i uređivanje: članaka, pozdrava, potpisa, standardnih šablona, automatskih odgovora i obaveštenja.',
        'Vietnam' => 'Vijetnamski',
        'View performance benchmark results.' => 'Pregled rezultata provere performansi.',
        'Watch this ticket' => 'Nadgledaj ovaj tiket',
        'Watched Tickets' => 'Posmatrani tiket',
        'Watched Tickets.' => 'Nadgledani tiketi.',
        'We are performing scheduled maintenance.' => 'Izvršavamo planirano održavanje.',
        'We are performing scheduled maintenance. Login is temporarily not available.' =>
            'Izvršavamo planirano održavanje. Prijava privremeno nije moguća.',
        'We are performing scheduled maintenance. We should be back online shortly.' =>
            'Izvršavamo planirano održavanje. uskoro ćemo biti ponovo aktivni.',
        'Web View' => '',
        'When tickets are merged, a note will be added automatically to the ticket which is no longer active. Here you can define the body of this note (this text cannot be changed by the agent).' =>
            'Kada su tiketi spojeni, napomena će biti automatski dodata tiketu koji nije više aktivan. Ovde možete definisati telo ove napomene (ovaj tekst se ne može promeniti od strane operatera).',
        'When tickets are merged, a note will be added automatically to the ticket which is no longer active. Here you can define the subject of this note (this subject cannot be changed by the agent).' =>
            'Kada su tiketi spojeni, napomena će biti automatski dodata tiketu koji nije više aktivan. Ovde možete definisati predmet ove napomene (ovaj predmet se ne može promeniti od strane operatera).',
        'When tickets are merged, the customer can be informed per email by setting the check box "Inform Sender". In this text area, you can define a pre-formatted text which can later be modified by the agents.' =>
            'Kada su tiketi spojeni, klijent može biti informisan imejlom postavljanjem polja za potvrdu „Obavesti pošiljaoca”. U prostoru za tekst, možete definisati unapred formatirani tekst koji kasnije biti modifikovan od strane operatera.',
        'Whether or not to collect meta information from articles using filters configured in Ticket::Frontend::ZoomCollectMetaFilters.' =>
            '',
        'Yes, but hide archived tickets' => 'Da, ali skloni arhivirane tikete',
        'Your email with ticket number "<OTRS_TICKET>" is bounced to "<OTRS_BOUNCE_TO>". Contact this address for further information.' =>
            '',
        'Your email with ticket number "<OTRS_TICKET>" is merged to "<OTRS_MERGE_TO_TICKET>".' =>
            'Vaš imejl sa brojem tiketa "<OTRS_TICKET>"je pripojen tiketu "<OTRS_MERGE_TO_TICKET>"!',
        'Your queue selection of your favorite queues. You also get notified about those queues via email if enabled.' =>
            'Izabrani omiljeni redovi. Ako je aktivirano, dobiđete i obaveštenje o ovim redovima.',
        'Your service selection of your favorite services. You also get notified about those services via email if enabled.' =>
            'Vaš izbor omiljenih usluga. Ako je aktivirano, dobićete i obaveštenja o ovim servisima putem imejla.',
        'attachment' => '',
        'debug' => '',
        'error' => 'greška',
        'info' => 'info',
        'inline' => '',
        'normal' => 'normalan',
        'notice' => 'napomena',
        'off' => 'isključeno',
        'reverse' => 'obrnuto',

    };

    $Self->{JavaScriptStrings} = [
        'A popup of this screen is already open. Do you want to close it and load this one instead?',
        'Add all',
        'All-day',
        'An error occurred during communication.',
        'An error occurred! Do you want to see the complete error message?',
        'An item with this name is already present.',
        'An unconnected transition is already placed on the canvas. Please connect this transition first before placing another transition.',
        'Apply',
        'Apr',
        'April',
        'Are you using a browser plugin like AdBlock or AdBlockPlus? This can cause several issues and we highly recommend you to add an exception for this domain.',
        'As soon as you use this button or link, you will leave this screen and its current state will be saved automatically. Do you want to continue?',
        'Attachments',
        'Aug',
        'August',
        'Cancel',
        'Clear',
        'Clear all',
        'Clear debug log',
        'Clear search',
        'Clone webservice',
        'Close',
        'Close this dialog',
        'Confirm',
        'Could not open popup window. Please disable any popup blockers for this application.',
        'Customer interface does not support internal article types.',
        'Data Protection',
        'Dec',
        'December',
        'Delete',
        'Delete Entity',
        'Delete field',
        'Delete invoker',
        'Delete operation',
        'Delete this Event Trigger',
        'Delete this Invoker',
        'Delete this Operation',
        'Delete webservice',
        'Deleting the field and its data. This may take a while...',
        'Do not show this warning again.',
        'Do you really want to continue?',
        'Do you really want to delete this attachment?',
        'Do you really want to delete this certificate?',
        'Do you really want to delete this dynamic field? ALL associated data will be LOST!',
        'Do you really want to delete this filter?',
        'Do you really want to delete this notification language?',
        'Do you really want to delete this notification?',
        'Do you really want to delete this scheduled system maintenance?',
        'Do you really want to delete this statistic?',
        'Duplicate event.',
        'Duplicated entry',
        'Edit Field Details',
        'Edit this transition',
        'Error',
        'Error during AJAX communication',
        'Error during AJAX communication. Status: %s, Error: %s',
        'Error in the mail settings. Please correct and try again.',
        'Feb',
        'February',
        'Filters',
        'Fr',
        'Fri',
        'Friday',
        'Hide EntityIDs',
        'If you now leave this page, all open popup windows will be closed, too!',
        'Import webservice',
        'Information about the OTRS Daemon',
        'Invalid date (need a future date)!',
        'Invalid date (need a past date)!',
        'Invalid date!',
        'It is going to be deleted from the field, please try again.',
        'Jan',
        'January',
        'Jul',
        'July',
        'Jun',
        'June',
        'Loading...',
        'Mail check successful.',
        'Mar',
        'March',
        'May',
        'May_long',
        'Mo',
        'Mon',
        'Monday',
        'Namespace %s could not be initialized, because %s could not be found.',
        'Next',
        'No TransitionActions assigned.',
        'No data found.',
        'No dialogs assigned yet. Just pick an activity dialog from the list on the left and drag it here.',
        'No matches found.',
        'Not available',
        'Nov',
        'November',
        'OTRS runs with a huge lists of browsers, please upgrade to one of these.',
        'Oct',
        'October',
        'One or more errors occurred!',
        'Open date selection',
        'Please check the fields marked as red for valid inputs.',
        'Please enter at least one search value or * to find anything.',
        'Please perform a spell check on the the text first.',
        'Please remove the following words from your search as they cannot be searched for:',
        'Please see the documentation or ask your admin for further information.',
        'Please turn off Compatibility Mode in Internet Explorer!',
        'Previous',
        'Remove Entity from canvas',
        'Remove selection',
        'Remove the Transition from this Process',
        'Restore web service configuration',
        'Sa',
        'Sat',
        'Saturday',
        'Save',
        'Search',
        'Select all',
        'Sep',
        'September',
        'Setting a template will overwrite any text or attachment.',
        'Settings',
        'Show EntityIDs',
        'Show more',
        'Show or hide the content.',
        'Slide the navigation bar',
        'Sorry, but you can\'t disable all methods for notifications marked as mandatory.',
        'Sorry, but you can\'t disable all methods for this notification.',
        'Sorry, the only existing condition can\'t be removed.',
        'Sorry, the only existing field can\'t be removed.',
        'Sorry, the only existing parameter can\'t be removed.',
        'Su',
        'Sun',
        'Sunday',
        'Switch to desktop mode',
        'Switch to mobile mode',
        'System Registration',
        'Th',
        'The browser you are using is too old.',
        'There are currently no elements available to select from.',
        'This Activity cannot be deleted because it is the Start Activity.',
        'This Activity is already used in the Process. You cannot add it twice!',
        'This Transition is already used for this Activity. You cannot use it twice!',
        'This TransitionAction is already used in this Path. You cannot use it twice!',
        'This address already exists on the address list.',
        'This event is already attached to the job, Please use a different one.',
        'This item still contains sub items. Are you sure you want to remove this item including its sub items?',
        'Thu',
        'Thursday',
        'Today',
        'Tu',
        'Tue',
        'Tuesday',
        'WARNING: When you change the name of the group \'admin\', before making the appropriate changes in the SysConfig, you will be locked out of the administrations panel! If this happens, please rename the group back to admin per SQL statement.',
        'We',
        'Wed',
        'Wednesday',
        'You have unanswered chat requests',
        'and %s more...',
        'day',
        'month',
        'week',
    ];

    # $$STOP$$
    return;
}

1;

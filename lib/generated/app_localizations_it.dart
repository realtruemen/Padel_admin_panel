// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Pannello di Amministrazione Padel';

  @override
  String get dashboard => 'Cruscotto';

  @override
  String get bookings => 'Prenotazioni';

  @override
  String get courts => 'Campi';

  @override
  String get users => 'Utenti';

  @override
  String get settings => 'Impostazioni';

  @override
  String get reports => 'Report';

  @override
  String get totalBookings => 'Prenotazioni Totali';

  @override
  String get activeCourts => 'Campi Attivi';

  @override
  String get totalUsers => 'Utenti Totali';

  @override
  String get revenue => 'Entrate';

  @override
  String get todaysBookings => 'Prenotazioni di Oggi';

  @override
  String get courtName => 'Nome Campo';

  @override
  String get status => 'Stato';

  @override
  String get time => 'Ora';

  @override
  String get customer => 'Cliente';

  @override
  String get actions => 'Azioni';

  @override
  String get view => 'Visualizza';

  @override
  String get edit => 'Modifica';

  @override
  String get delete => 'Elimina';

  @override
  String get add => 'Aggiungi';

  @override
  String get addCourt => 'Aggiungi Campo';

  @override
  String get addUser => 'Aggiungi Utente';

  @override
  String get name => 'Nome';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Telefono';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get confirmed => 'Confermato';

  @override
  String get pending => 'In Attesa';

  @override
  String get cancelled => 'Annullato';

  @override
  String get active => 'Attivo';

  @override
  String get inactive => 'Inattivo';

  @override
  String get language => 'Lingua';

  @override
  String get logout => 'Esci';

  @override
  String get search => 'Cerca';

  @override
  String get filter => 'Filtra';

  @override
  String get refresh => 'Aggiorna';

  @override
  String get noData => 'Nessun dato disponibile';

  @override
  String get loading => 'Caricamento...';

  @override
  String get error => 'Errore';

  @override
  String get success => 'Successo';

  @override
  String get warning => 'Avviso';

  @override
  String get bookingDetails => 'Dettagli Prenotazione';

  @override
  String get courtDetails => 'Dettagli Campo';

  @override
  String get userDetails => 'Dettagli Utente';

  @override
  String get date => 'Data';

  @override
  String get price => 'Prezzo';

  @override
  String get duration => 'Durata';

  @override
  String get description => 'Descrizione';

  @override
  String get location => 'Posizione';

  @override
  String get capacity => 'Capacità';

  @override
  String get amenities => 'Servizi';

  @override
  String get calendar => 'Calendario';

  @override
  String get viewBookings => 'Visualizza Prenotazioni';

  @override
  String get selectDate => 'Seleziona Data';

  @override
  String get noBookingsForDate => 'Nessuna prenotazione per questa data';

  @override
  String bookingsForDate(String date) {
    return 'Prenotazioni per $date';
  }

  @override
  String get today => 'Oggi';

  @override
  String get previousMonth => 'Mese Precedente';

  @override
  String get nextMonth => 'Mese Successivo';
}

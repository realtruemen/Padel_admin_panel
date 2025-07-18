// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Panneau d\'Administration Padel';

  @override
  String get dashboard => 'Tableau de Bord';

  @override
  String get bookings => 'Réservations';

  @override
  String get courts => 'Courts';

  @override
  String get users => 'Utilisateurs';

  @override
  String get settings => 'Paramètres';

  @override
  String get reports => 'Rapports';

  @override
  String get totalBookings => 'Total des Réservations';

  @override
  String get activeCourts => 'Courts Actifs';

  @override
  String get totalUsers => 'Total des Utilisateurs';

  @override
  String get revenue => 'Revenus';

  @override
  String get todaysBookings => 'Réservations d\'Aujourd\'hui';

  @override
  String get courtName => 'Nom du Court';

  @override
  String get status => 'Statut';

  @override
  String get time => 'Heure';

  @override
  String get customer => 'Client';

  @override
  String get actions => 'Actions';

  @override
  String get view => 'Voir';

  @override
  String get edit => 'Modifier';

  @override
  String get delete => 'Supprimer';

  @override
  String get add => 'Ajouter';

  @override
  String get addCourt => 'Ajouter Court';

  @override
  String get addUser => 'Ajouter Utilisateur';

  @override
  String get name => 'Nom';

  @override
  String get email => 'E-mail';

  @override
  String get phone => 'Téléphone';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get confirmed => 'Confirmé';

  @override
  String get pending => 'En Attente';

  @override
  String get cancelled => 'Annulé';

  @override
  String get active => 'Actif';

  @override
  String get inactive => 'Inactif';

  @override
  String get language => 'Langue';

  @override
  String get logout => 'Déconnexion';

  @override
  String get search => 'Rechercher';

  @override
  String get filter => 'Filtrer';

  @override
  String get refresh => 'Actualiser';

  @override
  String get noData => 'Aucune donnée disponible';

  @override
  String get loading => 'Chargement...';

  @override
  String get error => 'Erreur';

  @override
  String get success => 'Succès';

  @override
  String get warning => 'Avertissement';

  @override
  String get bookingDetails => 'Détails de Réservation';

  @override
  String get courtDetails => 'Détails du Court';

  @override
  String get userDetails => 'Détails de l\'Utilisateur';

  @override
  String get date => 'Date';

  @override
  String get price => 'Prix';

  @override
  String get duration => 'Durée';

  @override
  String get description => 'Description';

  @override
  String get location => 'Emplacement';

  @override
  String get capacity => 'Capacité';

  @override
  String get amenities => 'Équipements';

  @override
  String get calendar => 'Calendrier';

  @override
  String get viewBookings => 'Voir les Réservations';

  @override
  String get selectDate => 'Sélectionner une Date';

  @override
  String get noBookingsForDate => 'Aucune réservation pour cette date';

  @override
  String bookingsForDate(String date) {
    return 'Réservations pour $date';
  }

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get previousMonth => 'Mois Précédent';

  @override
  String get nextMonth => 'Mois Suivant';
}

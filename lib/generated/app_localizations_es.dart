// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Panel de Administración Padel';

  @override
  String get dashboard => 'Tablero';

  @override
  String get bookings => 'Reservas';

  @override
  String get courts => 'Pistas';

  @override
  String get users => 'Usuarios';

  @override
  String get settings => 'Configuración';

  @override
  String get reports => 'Informes';

  @override
  String get totalBookings => 'Total de Reservas';

  @override
  String get activeCourts => 'Pistas Activas';

  @override
  String get totalUsers => 'Total de Usuarios';

  @override
  String get revenue => 'Ingresos';

  @override
  String get todaysBookings => 'Reservas de Hoy';

  @override
  String get courtName => 'Nombre de Pista';

  @override
  String get status => 'Estado';

  @override
  String get time => 'Hora';

  @override
  String get customer => 'Cliente';

  @override
  String get actions => 'Acciones';

  @override
  String get view => 'Ver';

  @override
  String get edit => 'Editar';

  @override
  String get delete => 'Eliminar';

  @override
  String get add => 'Agregar';

  @override
  String get addCourt => 'Agregar Pista';

  @override
  String get addUser => 'Agregar Usuario';

  @override
  String get name => 'Nombre';

  @override
  String get email => 'Correo';

  @override
  String get phone => 'Teléfono';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get pending => 'Pendiente';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get active => 'Activo';

  @override
  String get inactive => 'Inactivo';

  @override
  String get language => 'Idioma';

  @override
  String get logout => 'Cerrar Sesión';

  @override
  String get search => 'Buscar';

  @override
  String get filter => 'Filtrar';

  @override
  String get refresh => 'Actualizar';

  @override
  String get noData => 'No hay datos disponibles';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Éxito';

  @override
  String get warning => 'Advertencia';

  @override
  String get bookingDetails => 'Detalles de Reserva';

  @override
  String get courtDetails => 'Detalles de Pista';

  @override
  String get userDetails => 'Detalles de Usuario';

  @override
  String get date => 'Fecha';

  @override
  String get price => 'Precio';

  @override
  String get duration => 'Duración';

  @override
  String get description => 'Descripción';

  @override
  String get location => 'Ubicación';

  @override
  String get capacity => 'Capacidad';

  @override
  String get amenities => 'Servicios';

  @override
  String get calendar => 'Calendario';

  @override
  String get viewBookings => 'Ver Reservas';

  @override
  String get selectDate => 'Seleccionar Fecha';

  @override
  String get noBookingsForDate => 'No hay reservas para esta fecha';

  @override
  String bookingsForDate(String date) {
    return 'Reservas para $date';
  }

  @override
  String get today => 'Hoy';

  @override
  String get previousMonth => 'Mes Anterior';

  @override
  String get nextMonth => 'Mes Siguiente';
}

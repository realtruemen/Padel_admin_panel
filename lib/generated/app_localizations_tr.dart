// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Padel Yönetim Paneli';

  @override
  String get dashboard => 'Kontrol Paneli';

  @override
  String get bookings => 'Rezervasyonlar';

  @override
  String get courts => 'Kortlar';

  @override
  String get users => 'Kullanıcılar';

  @override
  String get settings => 'Ayarlar';

  @override
  String get reports => 'Raporlar';

  @override
  String get totalBookings => 'Toplam Rezervasyon';

  @override
  String get activeCourts => 'Aktif Kortlar';

  @override
  String get totalUsers => 'Toplam Kullanıcı';

  @override
  String get revenue => 'Gelir';

  @override
  String get todaysBookings => 'Bugünkü Rezervasyonlar';

  @override
  String get courtName => 'Kort Adı';

  @override
  String get status => 'Durum';

  @override
  String get time => 'Saat';

  @override
  String get customer => 'Müşteri';

  @override
  String get actions => 'İşlemler';

  @override
  String get view => 'Görüntüle';

  @override
  String get edit => 'Düzenle';

  @override
  String get delete => 'Sil';

  @override
  String get add => 'Ekle';

  @override
  String get addCourt => 'Kort Ekle';

  @override
  String get addUser => 'Kullanıcı Ekle';

  @override
  String get name => 'İsim';

  @override
  String get email => 'E-posta';

  @override
  String get phone => 'Telefon';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get confirmed => 'Onaylandı';

  @override
  String get pending => 'Beklemede';

  @override
  String get cancelled => 'İptal Edildi';

  @override
  String get active => 'Aktif';

  @override
  String get inactive => 'Pasif';

  @override
  String get language => 'Dil';

  @override
  String get logout => 'Çıkış';

  @override
  String get search => 'Ara';

  @override
  String get filter => 'Filtrele';

  @override
  String get refresh => 'Yenile';

  @override
  String get noData => 'Veri bulunamadı';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get error => 'Hata';

  @override
  String get success => 'Başarılı';

  @override
  String get warning => 'Uyarı';

  @override
  String get bookingDetails => 'Rezervasyon Detayları';

  @override
  String get courtDetails => 'Kort Detayları';

  @override
  String get userDetails => 'Kullanıcı Detayları';

  @override
  String get date => 'Tarih';

  @override
  String get price => 'Fiyat';

  @override
  String get duration => 'Süre';

  @override
  String get description => 'Açıklama';

  @override
  String get location => 'Konum';

  @override
  String get capacity => 'Kapasite';

  @override
  String get amenities => 'Olanaklar';

  @override
  String get calendar => 'Takvim';

  @override
  String get viewBookings => 'Rezervasyonları Görüntüle';

  @override
  String get selectDate => 'Tarih Seç';

  @override
  String get noBookingsForDate => 'Bu tarih için rezervasyon yok';

  @override
  String bookingsForDate(String date) {
    return '$date Rezervasyonları';
  }

  @override
  String get today => 'Bugün';

  @override
  String get previousMonth => 'Önceki Ay';

  @override
  String get nextMonth => 'Sonraki Ay';
}

# Padel Booking Admin Panel

A comprehensive Flutter admin panel application for managing padel court bookings with multi-language support.

## Features

- 📊 **Dashboard** - Overview of bookings, revenue, and statistics
- 📅 **Bookings Management** - View, create, edit, and manage bookings
- 🏸 **Courts Management** - Manage padel courts and their availability
- 👥 **Users Management** - Handle customer and staff accounts
- 📈 **Reports** - Financial and booking analytics
- ⚙️ **Settings** - Application configuration and preferences
- 🗓️ **Calendar** - Google Calendar-style booking visualization

## Multi-Language Support

The application supports 6 languages:
- 🇺🇸 English
- 🇹🇷 Turkish
- 🇪🇸 Spanish
- 🇫🇷 French
- 🇮🇹 Italian
- 🇩🇪 German

## Multi-Currency Support

Support for 8 different currencies with automatic formatting:
- USD ($), EUR (€), GBP (£), TRY (₺), CAD (C$), AUD (A$), CHF (₣), JPY (¥)

## Calendar Features

- **Google Calendar-style** booking display
- **Color-coded status** indicators:
  - 🟢 Green: Confirmed bookings
  - 🟠 Orange: Pending bookings
  - 🔴 Red: Cancelled bookings
  - 🔵 Blue: Mixed status or multiple bookings
- **Past date styling** with reduced opacity
- **Smart color logic**:
  - Single booking: Shows booking status color
  - Multiple bookings (same status): Shows status color
  - Multiple bookings (mixed status): Shows blue
- **Side-by-side layout** with detailed booking information

## Getting Started

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart SDK

### Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd admin_panel
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the application:
```bash
flutter run -d chrome
```

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── providers/               # State management
│   ├── auth_provider.dart
│   ├── language_provider.dart
│   └── currency_provider.dart
├── screens/                 # UI screens
│   ├── dashboard_screen.dart
│   ├── bookings_screen.dart
│   ├── courts_screen.dart
│   ├── users_screen.dart
│   ├── reports_screen.dart
│   ├── settings_screen.dart
│   └── calendar_screen.dart
├── generated/               # Localization files
│   └── app_localizations.dart
└── l10n/                   # Translation files
    ├── app_en.arb
    ├── app_tr.arb
    ├── app_es.arb
    ├── app_fr.arb
    ├── app_it.arb
    └── app_de.arb
```

## Dependencies

- **flutter**: SDK
- **provider**: State management
- **shared_preferences**: Local storage
- **table_calendar**: Calendar widget
- **fl_chart**: Charts and analytics
- **data_table_2**: Enhanced data tables
- **flutter_localizations**: Internationalization support

## Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

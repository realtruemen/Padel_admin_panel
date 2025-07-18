import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';
import 'screens/main_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/language_provider.dart';
import 'providers/currency_provider.dart';
import 'providers/theme_provider.dart';
import 'generated/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final authProvider = AuthProvider();
  final languageProvider = LanguageProvider();
  final currencyProvider = CurrencyProvider();
  final themeProvider = ThemeProvider();
  
  await authProvider.initAuth();
  await languageProvider.initLanguage();
  await currencyProvider.initializeCurrency(languageProvider.currentLocale.languageCode);
  await themeProvider.initializeTheme();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authProvider),
        ChangeNotifierProvider.value(value: languageProvider),
        ChangeNotifierProvider.value(value: currencyProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<AuthProvider, LanguageProvider, ThemeProvider>(
      builder: (context, authProvider, languageProvider, themeProvider, child) {
        return MaterialApp(
          title: 'Padel Admin Panel',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          darkTheme: themeProvider.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          locale: languageProvider.currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('tr', ''),
            Locale('es', ''),
            Locale('fr', ''),
            Locale('it', ''),
            Locale('de', ''),
          ],
          home: authProvider.isAuthenticated ? const MainScreen() : const LoginScreen(),
        );
      },
    );
  }
}

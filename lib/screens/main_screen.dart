import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/language_provider.dart';
import '../generated/app_localizations.dart';
import 'dashboard_screen.dart';
import 'bookings_screen.dart';
import 'courts_screen.dart';
import 'users_screen.dart';
import 'settings_screen.dart';
import 'reports_screen.dart';
import 'calendar_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  
  List<Widget> get _screens => [
    const DashboardScreen(),
    const BookingsScreen(),
    const CourtsScreen(),
    const UsersScreen(),
    const CalendarScreen(),
    const ReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final localizations = AppLocalizations.of(context)!;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          PopupMenuButton<String>(
            icon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  languageProvider.getCurrentLanguageFlag(),
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
            onSelected: (String languageCode) {
              languageProvider.changeLanguage(languageCode);
            },
            itemBuilder: (BuildContext context) {
              return languageProvider.supportedLanguages.map((language) {
                return PopupMenuItem<String>(
                  value: language['code'],
                  child: Row(
                    children: [
                      Text(language['flag']),
                      const SizedBox(width: 8),
                      Text(language['name']),
                    ],
                  ),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(localizations.logout),
                  content: const Text('Are you sure you want to logout?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(localizations.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        authProvider.logout();
                      },
                      child: Text(localizations.logout),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF21CBF3)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.sports_tennis,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.appTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Welcome, ${authProvider.currentUser}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              title: localizations.dashboard,
              index: 0,
            ),
            _buildDrawerItem(
              icon: Icons.book_online,
              title: localizations.bookings,
              index: 1,
            ),
            _buildDrawerItem(
              icon: Icons.sports_tennis,
              title: localizations.courts,
              index: 2,
            ),
            _buildDrawerItem(
              icon: Icons.people,
              title: localizations.users,
              index: 3,
            ),
            _buildDrawerItem(
              icon: Icons.calendar_month,
              title: localizations.calendar,
              index: 4,
            ),
            _buildDrawerItem(
              icon: Icons.analytics,
              title: localizations.reports,
              index: 5,
            ),
            _buildDrawerItem(
              icon: Icons.settings,
              title: localizations.settings,
              index: 6,
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFF2196F3) : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? const Color(0xFF2196F3) : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFF2196F3).withOpacity(0.1),
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }
}

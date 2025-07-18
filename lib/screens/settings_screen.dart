import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/currency_provider.dart';
import '../generated/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.settings,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        _buildLanguageSettings(context, localizations, languageProvider),
                        const SizedBox(height: 16),
                        _buildCurrencySettings(context, localizations, currencyProvider),
                        const SizedBox(height: 16),
                        _buildGeneralSettings(context, localizations),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        _buildNotificationSettings(context, localizations),
                        const SizedBox(height: 16),
                        _buildSystemSettings(context, localizations),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSettings(BuildContext context, AppLocalizations localizations, LanguageProvider languageProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.language, color: Color(0xFF2196F3)),
                const SizedBox(width: 8),
                Text(
                  localizations.language,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Choose your preferred language',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            ...languageProvider.supportedLanguages.map((language) {
              final isSelected = languageProvider.currentLocale.languageCode == language['code'];
              
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? const Color(0xFF2196F3) : Colors.grey.withOpacity(0.3),
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected ? const Color(0xFF2196F3).withOpacity(0.1) : null,
                ),
                child: ListTile(
                  leading: Text(
                    language['flag'],
                    style: const TextStyle(fontSize: 24),
                  ),
                  title: Text(
                    language['name'],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? const Color(0xFF2196F3) : null,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Color(0xFF2196F3))
                      : null,
                  onTap: () {
                    languageProvider.changeLanguage(language['code']);
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSettings(BuildContext context, AppLocalizations localizations) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings, color: Color(0xFF2196F3)),
                const SizedBox(width: 8),
                Text(
                  'General Settings',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              context,
              'Time Zone',
              'UTC +3 (Turkey Time)',
              Icons.access_time,
              () {},
            ),
            _buildSettingItem(
              context,
              'Currency',
              'EUR (€)',
              Icons.attach_money,
              () {},
            ),
            _buildSettingItem(
              context,
              'Date Format',
              'DD/MM/YYYY',
              Icons.calendar_today,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSettings(BuildContext context, AppLocalizations localizations) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.notifications, color: Color(0xFF2196F3)),
                const SizedBox(width: 8),
                Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSwitchSetting(
              context,
              'Email Notifications',
              'Receive booking updates via email',
              true,
              (value) {},
            ),
            _buildSwitchSetting(
              context,
              'SMS Notifications',
              'Receive urgent notifications via SMS',
              false,
              (value) {},
            ),
            _buildSwitchSetting(
              context,
              'Desktop Notifications',
              'Show notifications on desktop',
              true,
              (value) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemSettings(BuildContext context, AppLocalizations localizations) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.computer, color: Color(0xFF2196F3)),
                const SizedBox(width: 8),
                Text(
                  'System',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingItem(
              context,
              'Backup & Restore',
              'Manage data backup',
              Icons.backup,
              () {},
            ),
            _buildSettingItem(
              context,
              'Export Data',
              'Export reports and data',
              Icons.download,
              () {},
            ),
            _buildSettingItem(
              context,
              'Security',
              'Security and privacy settings',
              Icons.security,
              () {},
            ),
            _buildSettingItem(
              context,
              'About',
              'Version 1.0.0',
              Icons.info,
              () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('About'),
                    content: const Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Padel Admin Panel'),
                        Text('Version 1.0.0'),
                        SizedBox(height: 8),
                        Text('A comprehensive admin panel for managing padel court bookings, users, and reports.'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[600]),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchSetting(
    BuildContext context,
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF2196F3),
    );
  }

  Widget _buildCurrencySettings(
    BuildContext context,
    AppLocalizations localizations,
    CurrencyProvider currencyProvider,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.attach_money, color: Colors.grey[600]),
                const SizedBox(width: 12),
                Text(
                  'Currency',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Select your preferred currency',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: currencyProvider.currentCurrency,
              decoration: const InputDecoration(
                labelText: 'Currency',
                border: OutlineInputBorder(),
              ),
              items: currencyProvider.currencies.entries.map((entry) {
                return DropdownMenuItem<String>(
                  value: entry.key,
                  child: Row(
                    children: [
                      Text(
                        entry.value,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      Text(entry.key),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  currencyProvider.setCurrency(newValue);
                }
              },
            ),
            const SizedBox(height: 12),
            Text(
              'Current: ${currencyProvider.formatPrice(25.00)} (Sample price)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

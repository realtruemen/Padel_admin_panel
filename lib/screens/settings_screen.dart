import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/currency_provider.dart';
import '../providers/theme_provider.dart';
import '../generated/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildLanguageSettings(context, localizations, languageProvider),
                          const SizedBox(height: 16),
                          _buildThemeSettings(context, localizations, themeProvider),
                          const SizedBox(height: 16),
                          _buildCurrencySettings(context, localizations, currencyProvider),
                          const SizedBox(height: 16),
                          _buildGeneralSettings(context, localizations),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildNotificationSettings(context, localizations),
                          const SizedBox(height: 16),
                          _buildSystemSettings(context, localizations),
                        ],
                      ),
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
            const SizedBox(height: 16),
            if (currencyProvider.currentCurrency != currencyProvider.baseCurrency) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Exchange Rate Info',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '1 ${currencyProvider.baseCurrency} = ${currencyProvider.getConversionRate(currencyProvider.baseCurrency, currencyProvider.currentCurrency).toStringAsFixed(4)} ${currencyProvider.currentCurrency}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'All prices are automatically converted from EUR base currency.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Exchange rate controls
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currencyProvider.lastUpdated != null) ...[
                        Text(
                          'Last Updated: ${_formatDateTime(currencyProvider.lastUpdated!)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ] else ...[
                        Text(
                          'Exchange rates not updated yet',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: currencyProvider.isLoading ? null : () {
                    currencyProvider.fetchExchangeRates();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Updating exchange rates...'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: currencyProvider.isLoading 
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(Icons.refresh, size: 18),
                  label: Text('Update Rates'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
  
  Widget _buildThemeSettings(
    BuildContext context,
    AppLocalizations localizations,
    ThemeProvider themeProvider,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  color: themeProvider.isDarkMode ? Colors.amber : Colors.orange,
                ),
                const SizedBox(width: 12),
                Text(
                  'Theme',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Choose your preferred theme mode',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<bool>(
                    title: Row(
                      children: [
                        Icon(Icons.light_mode, size: 20, color: Colors.orange),
                        const SizedBox(width: 8),
                        const Text('Light Mode'),
                      ],
                    ),
                    value: false,
                    groupValue: themeProvider.isDarkMode,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setTheme(value);
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<bool>(
                    title: Row(
                      children: [
                        Icon(Icons.dark_mode, size: 20, color: Colors.amber),
                        const SizedBox(width: 8),
                        const Text('Dark Mode'),
                      ],
                    ),
                    value: true,
                    groupValue: themeProvider.isDarkMode,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setTheme(value);
                      }
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeProvider.isDarkMode 
                    ? Colors.amber[50] 
                    : Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: themeProvider.isDarkMode 
                      ? Colors.amber[200]! 
                      : Colors.orange[200]!,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 20,
                    color: themeProvider.isDarkMode 
                        ? Colors.amber[700] 
                        : Colors.orange[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Current: ${themeProvider.themeName} Mode',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: themeProvider.isDarkMode 
                            ? Colors.amber[700] 
                            : Colors.orange[700],
                        fontWeight: FontWeight.w500,
                      ),
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
}

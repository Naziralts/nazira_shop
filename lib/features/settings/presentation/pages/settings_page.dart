import 'package:flutter/material.dart';
import '../../data/settings_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsService settingsService = SettingsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Column(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: settingsService.isDarkMode(),
            onChanged: (_) {
              settingsService.toggleTheme();
              setState(() {});
            },
          ),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(settingsService.getLanguage()),
            onTap: () {
              String newLang = settingsService.getLanguage() == 'en' ? 'tr' : 'en';
              settingsService.setLanguage(newLang);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

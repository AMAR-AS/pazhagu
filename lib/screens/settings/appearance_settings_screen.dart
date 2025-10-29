
// lib/screens/settings/appearance_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/settings_provider.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appearance'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ListTile(
                title: const Text('Theme Style'),
                trailing: DropdownButton<ThemeStyle>(
                  value: settingsProvider.themeStyle,
                  onChanged: (ThemeStyle? newValue) {
                    if (newValue != null) {
                      settingsProvider.setThemeStyle(newValue);
                    }
                  },
                  items: ThemeStyle.values
                      .map<DropdownMenuItem<ThemeStyle>>((ThemeStyle value) {
                    return DropdownMenuItem<ThemeStyle>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

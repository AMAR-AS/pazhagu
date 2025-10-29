
// lib/screens/settings/privacy_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/settings_provider.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              SwitchListTile(
                title: const Text('Isolated Modes'),
                subtitle: const Text('Keep data separate between modes'),
                value: settingsProvider.isIsolatedMode,
                onChanged: (value) {
                  settingsProvider.toggleIsolatedMode(value);
                },
              ),
              const Divider(),
              SwitchListTile(
                title: const Text('Two-Factor Authentication'),
                subtitle: const Text('Require a second factor to log in'),
                value: settingsProvider.isTwoFactorEnabled,
                onChanged: (value) {
                  settingsProvider.toggleTwoFactor(value);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Location Sharing'),
                trailing: DropdownButton<LocationSharingOption>(
                  value: settingsProvider.locationSharingOption,
                  onChanged: (LocationSharingOption? newValue) {
                    if (newValue != null) {
                      settingsProvider.setLocationSharingOption(newValue);
                    }
                  },
                  items: LocationSharingOption.values
                      .map<DropdownMenuItem<LocationSharingOption>>((LocationSharingOption value) {
                    return DropdownMenuItem<LocationSharingOption>(
                      value: value,
                      child: Text(value.toString().split('.').last.replaceAll('_', ' ')),
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

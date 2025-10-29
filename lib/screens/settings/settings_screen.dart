
// lib/screens/settings/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/settings/appearance_settings_screen.dart';
import 'package:pazhagu/screens/settings/navigation_settings_screen.dart';
import 'package:pazhagu/screens/settings/privacy_settings_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildSettingsTile(
            context,
            icon: Icons.palette,
            title: 'Appearance',
            screen: const AppearanceSettingsScreen(),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.navigation,
            title: 'Navigation',
            screen: const NavigationSettingsScreen(),
          ),
          _buildSettingsTile(
            context,
            icon: Icons.security,
            title: 'Privacy',
            screen: const PrivacySettingsScreen(),
          ),
          // You can add more settings categories here
        ],
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, {required IconData icon, required String title, required Widget screen}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
    );
  }
}

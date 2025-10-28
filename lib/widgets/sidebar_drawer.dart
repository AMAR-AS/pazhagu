
// lib/widgets/sidebar_drawer.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/screens/about/about_screen.dart';
import 'package:pazhagu/screens/ai_hub/ai_hub_screen.dart';
import 'package:pazhagu/screens/contacts/contacts_screen.dart';
import 'package:pazhagu/screens/security/codeword_file_access_screen.dart';
import 'package:pazhagu/screens/settings/settings_screen.dart';
import 'package:pazhagu/screens/storage/backup_options_screen.dart';
import 'package:pazhagu/screens/storage/cloud_storage_screen.dart';
import 'package:pazhagu/screens/storage/local_encrypted_storage_screen.dart';
import 'package:pazhagu/widgets/styled_container.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Tools & Storage',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                _buildDrawerItem(
                  context,
                  Icons.cloud,
                  'Cloud Storage',
                  'Sync across devices',
                  const CloudStorageScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.lock,
                  'Local Encrypted Storage',
                  'Secure on device',
                  const LocalEncryptedStorageScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.backup,
                  'Backup Options',
                  'Auto & manual backups',
                  const BackupOptionsScreen(),
                ),
                const Divider(height: 32),
                _buildDrawerItem(
                  context,
                  Icons.contacts,
                  'Contacts',
                  'Manage your connections',
                  const ContactsScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.smart_toy,
                  'AI Hub',
                  'Smart suggestions',
                  const AiHubScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.link,
                  'Codeword File Access',
                  'Share securely',
                  const CodewordFileAccessScreen(),
                ),
                const Divider(height: 32),
                _buildDrawerItem(
                  context,
                  Icons.settings,
                  'Settings',
                  'App preferences',
                  const SettingsScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.info,
                  'About',
                  'Version & credits',
                  const AboutScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget screen,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: StyledContainer(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        child: ListTile(
          leading: Icon(icon),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}

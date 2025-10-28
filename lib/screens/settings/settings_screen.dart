
// lib/screens/settings/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('General', style: Theme.of(context).textTheme.titleLarge),
                ListTile(
                  title: const Text('Appearance'),
                  subtitle: DropdownButton<ThemeStyle>(
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
                const Divider(),
                Text('Data', style: Theme.of(context).textTheme.titleLarge),
                SwitchListTile(
                  title: const Text('Isolated Modes'),
                  subtitle: const Text('Keep data separate between modes'),
                  value: settingsProvider.isIsolatedMode,
                  onChanged: (value) {
                    settingsProvider.toggleIsolatedMode(value);
                  },
                ),
                const Divider(),
                Text('Navigation', style: Theme.of(context).textTheme.titleLarge),
                ...settingsProvider.navItemOrder.map((item) {
                  return SwitchListTile(
                    title: Text('Show ${item.toString().split('.').last} Tab'),
                    value: settingsProvider.navItemVisibility[item]!,
                    onChanged: (value) {
                      settingsProvider.toggleNavItemVisibility(item, value);
                    },
                  );
                }).toList(),
                const Divider(),
                Text('Arrange Navigation', style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  height: 300, // Adjust height as needed
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      settingsProvider.reorderNavItems(oldIndex, newIndex);
                    },
                    children: settingsProvider.navItemOrder.map((item) {
                      return ListTile(
                        key: Key(item.toString()),
                        title: Text(item.toString().split('.').last),
                        leading: const Icon(Icons.drag_handle),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(),
                Text('Privacy', style: Theme.of(context).textTheme.titleLarge),
                SwitchListTile(
                  title: const Text('Two-Factor Authentication'),
                  subtitle: const Text('Require a second factor to log in'),
                  value: settingsProvider.isTwoFactorEnabled,
                  onChanged: (value) {
                    settingsProvider.toggleTwoFactor(value);
                  },
                ),
                ListTile(
                  title: const Text('Location Sharing'),
                  subtitle: DropdownButton<LocationSharingOption>(
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
      ),
    );
  }
}

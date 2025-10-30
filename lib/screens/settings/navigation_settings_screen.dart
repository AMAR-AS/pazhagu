
// lib/screens/settings/navigation_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class NavigationSettingsScreen extends StatelessWidget {
  const NavigationSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<SettingsProvider>(
          builder: (context, settingsProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Navigation Bar Style', style: Theme.of(context).textTheme.titleLarge),
                DropdownButton<NavBarStyle>(
                  value: settingsProvider.navBarStyle,
                  onChanged: (NavBarStyle? newValue) {
                    if (newValue != null) {
                      settingsProvider.setNavBarStyle(newValue);
                    }
                  },
                  items: NavBarStyle.values
                      .map<DropdownMenuItem<NavBarStyle>>((NavBarStyle value) {
                    return DropdownMenuItem<NavBarStyle>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                ),
                const Divider(),
                Text('Navigation Items', style: Theme.of(context).textTheme.titleLarge),
                ...NavItem.values.map((item) {
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
              ],
            );
          },
        ),
      ),
    );
  }
}

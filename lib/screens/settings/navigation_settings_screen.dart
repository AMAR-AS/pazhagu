
// lib/screens/settings/navigation_settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/settings_provider.dart';

class NavigationSettingsScreen extends StatelessWidget {
  const NavigationSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, _) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Show/Hide Tabs', style: Theme.of(context).textTheme.titleLarge),
                ),
                ...settingsProvider.navItemOrder.map((item) {
                  return SwitchListTile(
                    title: Text(item.toString().split('.').last),
                    value: settingsProvider.navItemVisibility[item]!,
                    onChanged: (value) {
                      settingsProvider.toggleNavItemVisibility(item, value);
                    },
                  );
                }).toList(),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Arrange Navigation', style: Theme.of(context).textTheme.titleLarge),
                ),
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
            ),
          );
        },
      ),
    );
  }
}

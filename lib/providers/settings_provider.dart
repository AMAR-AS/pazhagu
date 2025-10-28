
// lib/providers/settings_provider.dart

import 'package:flutter/material.dart';

enum LocationSharingOption { all, show_except, hide_except, contacts, none }
enum ThemeStyle { glassmorphism, liquid, neumorphism }
enum NavItem { home, stories, media, room, calendar, profile, map, updates }

class SettingsProvider extends ChangeNotifier {
  bool _isIsolatedMode = true; // Default to isolated
  bool _isTwoFactorEnabled = false; // Default to disabled
  LocationSharingOption _locationSharingOption = LocationSharingOption.contacts; // Default to contacts
  ThemeStyle _themeStyle = ThemeStyle.glassmorphism; // Default to glassmorphism

  Map<NavItem, bool> _navItemVisibility = {
    NavItem.home: true,
    NavItem.stories: true,
    NavItem.media: true,
    NavItem.room: true,
    NavItem.calendar: true,
    NavItem.profile: true,
    NavItem.map: true,
    NavItem.updates: false, // Disabled by default
  };

  List<NavItem> _navItemOrder = [
    NavItem.home,
    NavItem.stories,
    NavItem.media,
    NavItem.room,
    NavItem.calendar,
    NavItem.profile,
    NavItem.map,
    NavItem.updates,
  ];

  bool get isIsolatedMode => _isIsolatedMode;
  bool get isTwoFactorEnabled => _isTwoFactorEnabled;
  LocationSharingOption get locationSharingOption => _locationSharingOption;
  ThemeStyle get themeStyle => _themeStyle;
  Map<NavItem, bool> get navItemVisibility => _navItemVisibility;
  List<NavItem> get navItemOrder => _navItemOrder;

  void toggleIsolatedMode(bool value) {
    _isIsolatedMode = value;
    notifyListeners();
  }

  void toggleTwoFactor(bool value) {
    _isTwoFactorEnabled = value;
    notifyListeners();
  }

  void setLocationSharingOption(LocationSharingOption option) {
    _locationSharingOption = option;
    notifyListeners();
  }

  void setThemeStyle(ThemeStyle style) {
    _themeStyle = style;
    notifyListeners();
  }

  void toggleNavItemVisibility(NavItem item, bool isVisible) {
    _navItemVisibility[item] = isVisible;
    notifyListeners();
  }

  void reorderNavItems(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final NavItem item = _navItemOrder.removeAt(oldIndex);
    _navItemOrder.insert(newIndex, item);
    notifyListeners();
  }
}

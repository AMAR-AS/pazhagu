
// lib/providers/settings_provider.dart

import 'package:flutter/material.dart';

enum LocationSharingOption { all, show_except, hide_except, contacts, none }
enum ThemeStyle { glassmorphism, liquid, neumorphism }
enum NavItem { home, moments, media, room, calendar, profile, map, updates }
enum NavBarStyle { rectangular, circular }
enum QuickAccessButtonType { notifications, map, calendar }

class SettingsProvider extends ChangeNotifier {
  bool _isIsolatedMode = true; // Default to isolated
  bool _isTwoFactorEnabled = false; // Default to disabled
  LocationSharingOption _locationSharingOption = LocationSharingOption.contacts; // Default to contacts
  ThemeStyle _themeStyle = ThemeStyle.glassmorphism; // Default to glassmorphism
  NavBarStyle _navBarStyle = NavBarStyle.rectangular; // Default to rectangular
  QuickAccessButtonType _quickAccessButtonType = QuickAccessButtonType.notifications; // Default

  Map<NavItem, bool> _navItemVisibility = {
    NavItem.home: true,
    NavItem.moments: true,
    NavItem.media: true,
    NavItem.room: true,
    NavItem.calendar: false,
    NavItem.profile: true,
    NavItem.map: false,
    NavItem.updates: false,
  };

  List<NavItem> _navItemOrder = [
    NavItem.home,
    NavItem.moments,
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
  NavBarStyle get navBarStyle => _navBarStyle;
  QuickAccessButtonType get quickAccessButtonType => _quickAccessButtonType;
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

  void setNavBarStyle(NavBarStyle style) {
    _navBarStyle = style;
    notifyListeners();
  }

  void cycleQuickAccessButton() {
    final nextIndex = (_quickAccessButtonType.index + 1) % QuickAccessButtonType.values.length;
    _quickAccessButtonType = QuickAccessButtonType.values[nextIndex];
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


// lib/providers/mode_provider.dart

import 'package:flutter/material.dart';

class AppMode {
  final String name;
  final IconData? icon;
  final String? emoji;

  AppMode({required this.name, this.icon, this.emoji})
      : assert(icon != null || emoji != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppMode &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class ModeProvider extends ChangeNotifier {
  final List<AppMode> _defaultModes = [
    AppMode(name: 'Private', icon: Icons.lock),
    AppMode(name: 'Personal', icon: Icons.person),
    AppMode(name: 'Work', icon: Icons.work),
  ];

  final List<AppMode> _customModes = [];
  late AppMode _currentMode;

  ModeProvider() {
    _currentMode = _defaultModes[1]; // Default to Personal
  }

  List<AppMode> get allModes => [..._defaultModes, ..._customModes];

  AppMode get currentMode => _currentMode;

  void switchMode(AppMode mode) {
    if (_currentMode != mode) {
      _currentMode = mode;
      notifyListeners();
    }
  }

  void addMode({required String name, required String emoji}) {
    final newMode = AppMode(name: name, emoji: emoji);
    _customModes.add(newMode);
    notifyListeners();
  }
}

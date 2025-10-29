// ===== PAZHAGU: Main Application Entry Point =====
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';
import 'package:pazhagu/screens/auth/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:pazhagu/providers/mode_provider.dart';
import 'package:pazhagu/providers/theme_provider.dart';
import 'package:pazhagu/providers/auth_provider.dart';
import 'package:pazhagu/screens/home_screen.dart';
import 'package:pazhagu/services/local_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PazhaGUApp());
}

class PazhaGUApp extends StatelessWidget {
  const PazhaGUApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ModeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProxyProvider2<ModeProvider, SettingsProvider, LocalStorageService>(
          create: (context) => LocalStorageService(
            context.read<ModeProvider>(),
            context.read<SettingsProvider>(),
          ),
          update: (context, modeProvider, settingsProvider, localStorageService) =>
              localStorageService!,
        ),
      ],
      child: Consumer2<ThemeProvider, AuthProvider>(
        builder: (context, themeProvider, authProvider, _) {
          return MaterialApp(
            title: 'PAZHAGU',
            theme: _buildLightTheme(),
            darkTheme: _buildDarkTheme(),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: authProvider.isAuthenticated ? const HomeScreen() : const WelcomeScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'Oxanium',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4A90E2),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Oxanium',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF4A90E2),
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: const Color(0xFF0F1419),
    );
  }
}





// ===== PUBSPEC.YAML CONFIGURATION =====
/*
name: pazhagu
description: Next-Generation Unified Communication Platform with End-to-End Encryption
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

  # State Management
  provider: ^6.0.0

  # Storage & Database
  sqflite: ^2.3.0
  flutter_secure_storage: ^9.0.0
  shared_preferences: ^2.2.2
  path_provider: ^2.1.0

  # Networking
  http: ^1.1.0
  web_socket_channel: ^2.4.0

  # Encryption & Security
  cryptography: ^2.7.0

  # Media & Files
  image_picker: ^1.0.4
  camera: ^0.10.5
  video_player: ^2.7.2
  file_picker: ^6.0.0

  # Location
  geolocator: ^9.0.2

  # Utilities
  intl: ^0.19.0
  uuid: ^4.0.0

  # Firebase (optional)
  firebase_core: ^2.24.0
  firebase_messaging: ^14.6.0
  firebase_analytics: ^10.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_linter: ^2.0.0

flutter:
  uses-material-design: true

  assets: 
    - assets/images/
    - assets/icons/

  fonts:
    - family: Oxanium
      fonts:
        - asset: assets/fonts/Oxanium-Regular.ttf
        - asset: assets/fonts/Oxanium-Bold.ttf
          weight: 700
        - asset: assets/fonts/Oxanium-ExtraBold.ttf
          weight: 800
        - asset: assets/fonts/Oxanium-Light.ttf
          weight: 300
*/

// ===== BUILD COMMANDS =====
/*
# Clean & Get Dependencies'
flutter clean
flutter pub get

# Build APK for Google Play
flutter build appbundle --release

# Build iOS for App Store
flutter build ios --release

# Build Web
flutter build web --release

# Build Windows EXE
flutter build windows --release

# Build macOS
flutter build macos --release

# Run in development
flutter run --release
*/
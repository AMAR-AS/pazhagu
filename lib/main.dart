// ===== PAZHAGU: Main Application Entry Point =====
// lib/main.dart

import 'package:flutter/material.dart';
import 'package:pazhagu/providers/settings_provider.dart';
import 'package:pazhagu/screens/auth/welcome_screen.dart';
import 'package:pazhagu/services/search_service.dart';
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
        ChangeNotifierProvider(create: (_) => SearchService()),
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

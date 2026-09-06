import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/theme/app_colors.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';

/// Root widget of Hormon Tracker.
/// Launch flow: [LoginScreen] first (guest-first) -> [HomeScreen].
/// Language lives ONLY in [SettingsScreen].
class HormanTrackerApp extends StatefulWidget {
  const HormanTrackerApp({super.key});

  @override
  State<HormanTrackerApp> createState() => _HormanTrackerAppState();
}

class _HormanTrackerAppState extends State<HormanTrackerApp> {
  Locale _currentLocale = const Locale('en');
  bool _enteredAsGuest = false;

  void _switchLanguage(Locale newLocale) {
    setState(() => _currentLocale = newLocale);
  }

  void _showBackendPending(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(strings.login_backend_pending)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(colorSchemeSeed: AppColors.brandPurple, useMaterial3: true),
      darkTheme: ThemeData(
        colorSchemeSeed: AppColors.brandPurple,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          if (!_enteredAsGuest) {
            return LoginScreen(
              onContinueAsGuest: () => setState(() => _enteredAsGuest = true),
              onProviderLogin: (_) => _showBackendPending(context),
            );
          }
          return HomeScreen(
            currentLocale: _currentLocale,
            onSwitchLanguage: _switchLanguage,
          );
        },
      ),
    );
  }
}

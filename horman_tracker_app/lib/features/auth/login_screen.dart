import 'package:flutter/material.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';

/// First screen of the app (guest-first).
/// [onContinueAsGuest] enters the app locally.
/// [onProviderLogin] is called for Apple/Google/Email — wired to Supabase in
/// the next step; until keys arrive it shows an honest pending message.
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
    required this.onContinueAsGuest,
    required this.onProviderLogin,
  });

  final VoidCallback onContinueAsGuest;
  final void Function(String providerId) onProviderLogin;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: Image.asset(
                    'assets/images/app_icon_source.png',
                    height: 110,
                    width: 110,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  strings.app_title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  strings.login_subtitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: onContinueAsGuest,
                  icon: const Icon(Icons.person_outline),
                  label: Text(strings.action_continue_as_guest),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () => onProviderLogin('apple'),
                  icon: const Icon(Icons.apple),
                  label: Text(strings.login_apple),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => onProviderLogin('google'),
                  icon: const Icon(Icons.g_mobiledata),
                  label: Text(strings.login_google),
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () => onProviderLogin('email_link'),
                  icon: const Icon(Icons.email_outlined),
                  label: Text(strings.login_email),
                ),
                const SizedBox(height: 24),
                Text(
                  strings.disclaimer_estimate_only,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

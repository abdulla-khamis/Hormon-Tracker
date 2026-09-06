import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/theme/app_assets.dart';
import 'package:horman_tracker_app/core/theme/app_spacing.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';

/// First screen of the app (guest-first).
/// [onContinueAsGuest] enters the app locally.
/// [onProviderLogin] is called for Apple/Google/Email — wired to Supabase
/// last; until keys arrive it shows an honest pending message.
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
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                  child: Image.asset(
                    AppAssets.appIcon,
                    height: AppSpacing.loginLogoSize,
                    width: AppSpacing.loginLogoSize,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  strings.app_title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  strings.login_subtitle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xxl),
                FilledButton.icon(
                  onPressed: onContinueAsGuest,
                  icon: const Icon(Icons.person_outline),
                  label: Text(strings.action_continue_as_guest),
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: () => onProviderLogin('apple'),
                  icon: const Icon(Icons.apple),
                  label: Text(strings.login_apple),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () => onProviderLogin('google'),
                  icon: const Icon(Icons.g_mobiledata),
                  label: Text(strings.login_google),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton.icon(
                  onPressed: () => onProviderLogin('email_link'),
                  icon: const Icon(Icons.email_outlined),
                  label: Text(strings.login_email),
                ),
                const SizedBox(height: AppSpacing.xl),
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

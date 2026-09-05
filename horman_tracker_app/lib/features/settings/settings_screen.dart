import 'package:flutter/material.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';

/// Settings screen. Owns the app language switch (no dedicated language
/// screen anywhere else) plus guest-mode info and version.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.currentLocale,
    required this.onSwitchLanguage,
  });

  final Locale currentLocale;
  final void Function(Locale newLocale) onSwitchLanguage;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings_title)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 4),
            child: Text(
              strings.settings_language,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          RadioGroup<String>(
            groupValue: currentLocale.languageCode,
            onChanged: (value) {
              if (value == null) return;
              onSwitchLanguage(Locale(value));
            },
            child: const Column(
              children: [
                LanguageRadioRow(value: 'en', label: 'English'),
                LanguageRadioRow(value: 'ar', label: 'العربية'),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(strings.settings_guest_mode),
          ),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('1.0.0 (M0)'),
          ),
        ],
      ),
    );
  }
}

/// One language row: a [Radio] bound to the ancestor [RadioGroup] plus label.
class LanguageRadioRow extends StatelessWidget {
  const LanguageRadioRow({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(value: value),
      onTap: () => RadioGroup.maybeOf<String>(context)?.onChanged.call(value),
    );
  }
}

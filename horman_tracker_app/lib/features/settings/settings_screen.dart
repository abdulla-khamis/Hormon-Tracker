import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/theme/app_constants.dart';
import 'package:horman_tracker_app/core/theme/app_spacing.dart';
import 'package:horman_tracker_app/features/info/methods_screen.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';

/// Settings screen. Owns the app language switch and the profile sex
/// (used only for a tiny documented baseline nudge) — no dedicated
/// screens for either anywhere else.
///
/// Stateful on purpose: pushed routes keep the props they were built
/// with, so selection state lives here and updates instantly on tap
/// (a Stateless version saved correctly but looked dead — real user bug).
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.currentLocale,
    required this.onSwitchLanguage,
    required this.currentSex,
    required this.onSexChanged,
  });

  final Locale currentLocale;
  final void Function(Locale newLocale) onSwitchLanguage;

  /// 'male', 'female' or 'unset'.
  final String currentSex;
  final void Function(String sex) onSexChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String _localeCode;
  late String _sex;

  @override
  void initState() {
    super.initState();
    _localeCode = widget.currentLocale.languageCode;
    _sex = widget.currentSex;
  }

  @override
  void didUpdateWidget(SettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _localeCode = widget.currentLocale.languageCode;
    _sex = widget.currentSex;
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(strings.settings_title)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.xs,
            ),
            child: Text(
              strings.settings_language,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          RadioGroup<String>(
            groupValue: _localeCode,
            onChanged: (value) {
              if (value == null) return;
              setState(() => _localeCode = value);
              widget.onSwitchLanguage(Locale(value));
            },
            child: Column(
              children: [
                for (var i = 0;
                    i < AppConstants.languageCodes.length;
                    i++)
                  ChoiceRadioRow(
                    value: AppConstants.languageCodes[i],
                    label: AppConstants.languageNativeNames[i],
                    selected: _localeCode == AppConstants.languageCodes[i],
                  ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.lg,
              AppSpacing.sm,
              AppSpacing.lg,
              AppSpacing.xs,
            ),
            child: Text(
              strings.settings_sex,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          RadioGroup<String>(
            groupValue: _sex,
            onChanged: (value) {
              if (value == null) return;
              setState(() => _sex = value);
              widget.onSexChanged(value);
            },
            child: Column(
              children: [
                ChoiceRadioRow(
                  value: 'male',
                  label: strings.sex_male,
                  selected: _sex == 'male',
                ),
                ChoiceRadioRow(
                  value: 'female',
                  label: strings.sex_female,
                  selected: _sex == 'female',
                ),
                ChoiceRadioRow(
                  value: 'unset',
                  label: strings.sex_unset,
                  selected: _sex == 'unset',
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.science_outlined),
            title: Text(strings.methods_title),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MethodsScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(strings.settings_guest_mode),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(strings.settings_version_value),
          ),
        ],
      ),
    );
  }
}

/// One choice row: a [Radio] bound to the ancestor [RadioGroup] plus label
/// plus an explicit check on the selected row (instant visible feedback).
/// Shared by the language and sex sections.
class ChoiceRadioRow extends StatelessWidget {
  const ChoiceRadioRow({
    super.key,
    required this.value,
    required this.label,
    required this.selected,
  });

  final String value;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      leading: Radio<String>(value: value),
      trailing: selected ? const Icon(Icons.check) : null,
      onTap: () => RadioGroup.maybeOf<String>(context)?.onChanged.call(value),
    );
  }
}

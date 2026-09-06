import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/config/config_models.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';
import 'package:horman_tracker_app/core/l10n/config_labels.dart';
import 'package:horman_tracker_app/core/theme/app_spacing.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';
import 'package:horman_tracker_app/widgets/config_icon_mapper.dart';

/// 3-step daily check-in: feelings -> habits -> foods.
/// Returns a [DailyLogInput] via Navigator.pop, or null on cancel.
class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key, required this.config});

  final AppConfigBundle config;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  int _step = 0;
  final Set<String> _feelings = {};
  final Set<String> _activities = {};
  final Set<String> _foods = {};

  void _toggle(Set<String> set, String id) {
    setState(() {
      if (!set.remove(id)) set.add(id);
    });
  }

  void _next() {
    if (_step < 2) {
      setState(() => _step++);
    } else {
      Navigator.of(context).pop(
        DailyLogInput(
          feelings: _feelings.toList(),
          activities: _activities.toList(),
          foods: _foods.toList(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final titles = [
      strings.checkin_step_feel,
      strings.checkin_step_do,
      strings.checkin_step_eat,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.checkin_title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(value: (_step + 1) / 3),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: AppSpacing.pagePadding,
            child: Text(
              titles[_step],
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  if (_step == 0)
                    for (final id in widget.config.feelings)
                      FilterChip(
                        label: Text(feelingLabel(strings, id)),
                        selected: _feelings.contains(id),
                        onSelected: (_) => _toggle(_feelings, id),
                      ),
                  if (_step == 1)
                    for (final a in widget.config.activities)
                      FilterChip(
                        avatar:
                            Icon(configIcon(a.icon), size: AppSpacing.iconSm),
                        label: Text(configLabel(strings, a.i18nKey)),
                        selected: _activities.contains(a.id),
                        onSelected: (_) => _toggle(_activities, a.id),
                      ),
                  if (_step == 2)
                    for (final f in widget.config.foods)
                      FilterChip(
                        label: Text(configLabel(strings, f.i18nKey)),
                        selected: _foods.contains(f.id),
                        onSelected: (_) => _toggle(_foods, f.id),
                      ),
                ],
              ),
            ),
          ),
          Padding(
            padding: AppSpacing.pagePadding,
            child: Row(
              children: [
                if (_step > 0)
                  TextButton(
                    onPressed: () => setState(() => _step--),
                    child: Text(strings.action_back),
                  ),
                const Spacer(),
                FilledButton(
                  onPressed: _next,
                  child: Text(
                    _step < 2 ? strings.action_next : strings.action_done,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/config/config_models.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';
import 'package:horman_tracker_app/core/l10n/config_labels.dart';
import 'package:horman_tracker_app/core/theme/app_spacing.dart';
import 'package:horman_tracker_app/data/local/guest_store.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';
import 'package:horman_tracker_app/widgets/config_icon_mapper.dart';
import 'package:horman_tracker_app/widgets/hormone_balance_chart.dart';
import 'package:horman_tracker_app/widgets/tip_card.dart';

/// One feel-state: typical pattern chart (same unified component) plus
/// top helping tips. All values are educational demos from config.
class StateDetailScreen extends StatefulWidget {
  const StateDetailScreen({
    super.key,
    required this.bundle,
    required this.patternId,
  });

  final AppConfigBundle bundle;
  final String patternId;

  @override
  State<StateDetailScreen> createState() => _StateDetailScreenState();
}

class _StateDetailScreenState extends State<StateDetailScreen> {
  final Map<String, bool?> _feedback = {};

  @override
  void initState() {
    super.initState();
    for (final tip in widget.bundle.tips) {
      _feedback[tip.id] = GuestStore.instance.tipFeedback(tip.id);
    }
  }

  BarStatus _statusFor(double value) {
    final t = widget.bundle.thresholds;
    if (value < t.lowMax) return BarStatus.low;
    if (value > t.balancedMax) return BarStatus.high;
    return BarStatus.balanced;
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final typical = widget.bundle.patternTypical[widget.patternId] ?? {};
    final helpIds = widget.bundle.patternHelpTips[widget.patternId] ?? [];
    final helpTips = [
      for (final id in helpIds)
        if (widget.bundle.tipById.containsKey(id)) widget.bundle.tipById[id]!,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(configLabel(strings, 'pattern_${widget.patternId}')),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.pagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.library_demo_note,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            HormoneBalanceChart(
              bars: [
                for (final id in widget.bundle.validDisplayOrder)
                  ChartBarData(
                    hormoneId: id,
                    label: configLabel(
                      strings,
                      widget.bundle.hormoneById(id).i18nKey,
                    ),
                    icon: configIcon(widget.bundle.hormoneById(id).icon),
                    score: typical[id] ?? widget.bundle.thresholds.baseline,
                    status: _statusFor(
                      typical[id] ?? widget.bundle.thresholds.baseline,
                    ),
                    invert: widget.bundle.hormoneById(id).invert,
                  ),
              ],
              statusLabels: {
                BarStatus.low: strings.balance_low,
                BarStatus.balanced: strings.balance_balanced,
                BarStatus.high: strings.balance_high,
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              strings.library_top_actions,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            for (final tip in helpTips)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: TipCard(
                  tip: tip,
                  feedback: _feedback[tip.id],
                  onFeedback: (helpful) async {
                    await GuestStore.instance.saveTipFeedback(tip.id, helpful);
                    if (mounted) {
                      setState(() => _feedback[tip.id] = helpful);
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/config/config_models.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';
import 'package:horman_tracker_app/core/l10n/config_labels.dart';
import 'package:horman_tracker_app/data/local/guest_store.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';
import 'package:horman_tracker_app/widgets/support_card.dart';
import 'package:horman_tracker_app/widgets/tip_card.dart';

/// Detail for one hormone: what it does, your estimate, and rebalance tips
/// grouped Do / Eat / Avoid / Gentle habits. Opened by tapping a chart bar.
class HormoneDetailScreen extends StatefulWidget {
  const HormoneDetailScreen({
    super.key,
    required this.bundle,
    required this.hormoneId,
    required this.score,
  });

  final AppConfigBundle bundle;
  final String hormoneId;
  final HormoneScore score;

  @override
  State<HormoneDetailScreen> createState() => _HormoneDetailScreenState();
}

class _HormoneDetailScreenState extends State<HormoneDetailScreen> {
  final Map<String, bool?> _feedback = {};

  @override
  void initState() {
    super.initState();
    for (final tip in widget.bundle.tips) {
      _feedback[tip.id] = GuestStore.instance.tipFeedback(tip.id);
    }
  }

  String _sectionTitle(AppLocalizations s, String type) => switch (type) {
        'eat' => s.tip_section_eat,
        'avoid' => s.tip_section_avoid,
        'islamic' => s.tip_section_islamic,
        _ => s.tip_section_do,
      };

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final hormone = widget.bundle.hormoneById(widget.hormoneId);
    final tips = widget.bundle.tips
        .where((t) => t.hormoneIds.contains(widget.hormoneId))
        .toList();
    const sectionOrder = ['do', 'eat', 'avoid', 'islamic'];

    return Scaffold(
      appBar: AppBar(title: Text(configLabel(strings, hormone.i18nKey))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(isArabic ? hormone.descriptionAr : hormone.descriptionEn),
            const SizedBox(height: 16),
            for (final type in sectionOrder)
              if (tips.any((t) => t.type == type)) ...[
                Text(
                  _sectionTitle(strings, type),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 8),
                for (final tip in tips.where((t) => t.type == type))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: TipCard(
                      tip: tip,
                      feedback: _feedback[tip.id],
                      onFeedback: (helpful) async {
                        await GuestStore.instance
                            .saveTipFeedback(tip.id, helpful);
                        if (mounted) {
                          setState(() => _feedback[tip.id] = helpful);
                        }
                      },
                    ),
                  ),
                const SizedBox(height: 8),
              ],
            SupportCard(hotlines: widget.bundle.flags.redFlagHotlines),
            const SizedBox(height: 16),
            Text(
              strings.disclaimer_estimate_only,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/config/config_models.dart';
import 'package:horman_tracker_app/core/theme/app_spacing.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';

/// One rebalance tip with evidence badge and helpful/not-helpful feedback.
/// Tip copy comes from versioned JSON (reviewed content), not from code.
class TipCard extends StatelessWidget {
  const TipCard({
    super.key,
    required this.tip,
    required this.feedback,
    required this.onFeedback,
  });

  final TipDef tip;
  final bool? feedback;
  final void Function(bool helpful) onFeedback;

  String _evidenceLabel(AppLocalizations s) => switch (tip.evidence) {
        'strong' => s.evidence_strong,
        'moderate' => s.evidence_moderate,
        _ => s.evidence_preliminary,
      };

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Card(
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(isArabic ? tip.textAr : tip.textEn),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Chip(
                  label: Text(
                    _evidenceLabel(strings),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.thumb_up_outlined,
                    semanticLabel: 'helpful',
                    color: feedback == true
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  onPressed: () => onFeedback(true),
                ),
                IconButton(
                  icon: Icon(
                    Icons.thumb_down_outlined,
                    semanticLabel: 'not helpful',
                    color: feedback == false
                        ? Theme.of(context).colorScheme.error
                        : null,
                  ),
                  onPressed: () => onFeedback(false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

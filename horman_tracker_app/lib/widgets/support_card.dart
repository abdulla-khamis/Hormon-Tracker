import 'package:flutter/material.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';

/// Always-visible safety card. Uses helpline numbers from app_config.json —
/// never hardcoded, never invented.
class SupportCard extends StatelessWidget {
  const SupportCard({super.key, required this.hotlines});

  final Map<String, String> hotlines;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.sos_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    strings.support_title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(strings.support_body),
            if (hotlines.isNotEmpty) ...[
              const SizedBox(height: 8),
              for (final entry in hotlines.entries)
                Text('${entry.key}: ${entry.value}'),
            ],
          ],
        ),
      ),
    );
  }
}

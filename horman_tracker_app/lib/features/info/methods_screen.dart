import 'package:flutter/material.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';

/// Methods & Limits: honest one-pager on what estimates are (and are not).
/// Required by the medical-safety gate (file 02.6). Linked from Settings.
class MethodsScreen extends StatelessWidget {
  const MethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final points = [
      strings.methods_p1,
      strings.methods_p2,
      strings.methods_p3,
      strings.methods_p4,
    ];

    return Scaffold(
      appBar: AppBar(title: Text(strings.methods_title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final p in points) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('•  '),
                Expanded(child: Text(p)),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

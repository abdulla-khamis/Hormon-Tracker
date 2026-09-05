import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/config/config_models.dart';
import 'package:horman_tracker_app/core/l10n/config_labels.dart';
import 'package:horman_tracker_app/features/library/state_detail_screen.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';
import 'package:horman_tracker_app/widgets/support_card.dart';

/// Feel-state library: "if you feel X, hormones typically look like Y".
/// Every pattern is labeled an educational example — never a diagnosis.
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key, required this.bundle});

  final AppConfigBundle bundle;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final patterns = bundle.patternTypical.keys.toList();

    return Scaffold(
      appBar: AppBar(title: Text(strings.library_title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final id in patterns)
            Card(
              child: ListTile(
                leading: const Icon(Icons.mood_outlined),
                title: Text(configLabel(strings, 'pattern_$id')),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        StateDetailScreen(bundle: bundle, patternId: id),
                  ),
                ),
              ),
            ),
          const SizedBox(height: 8),
          SupportCard(hotlines: bundle.flags.redFlagHotlines),
        ],
      ),
    );
  }
}

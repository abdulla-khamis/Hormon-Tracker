import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/config/app_config_loader.dart';
import 'package:horman_tracker_app/core/config/config_models.dart';
import 'package:horman_tracker_app/core/engine/engine_from_config.dart';
import 'package:horman_tracker_app/core/engine/estimation_engine.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';
import 'package:horman_tracker_app/core/l10n/config_labels.dart';
import 'package:horman_tracker_app/data/local/guest_store.dart';
import 'package:horman_tracker_app/features/checkin/check_in_screen.dart';
import 'package:horman_tracker_app/features/hormone_detail/hormone_detail_screen.dart';
import 'package:horman_tracker_app/features/library/library_screen.dart';
import 'package:horman_tracker_app/features/settings/settings_screen.dart';
import 'package:horman_tracker_app/l10n/app_localizations.dart';
import 'package:horman_tracker_app/widgets/config_icon_mapper.dart';
import 'package:horman_tracker_app/widgets/hormone_balance_chart.dart';

/// Home: today's estimated hormones as the unified chart.
/// Loads config from JSON, computes via [EstimationEngine],
/// persists the day log in [GuestStore]. Language lives ONLY in Settings.
/// Navigation uses this screen's own context (below the Navigator).
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.currentLocale,
    required this.onSwitchLanguage,
  });

  final Locale currentLocale;
  final void Function(Locale newLocale) onSwitchLanguage;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppConfigBundle? _bundle;
  EstimationEngine? _engine;
  DailyLogInput _todayLog = const DailyLogInput();
  DailyEstimate? _estimate;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final bundle = await AppConfigLoader.load();
    final saved = GuestStore.instance.loadTodayLog();
    final engine = engineFromBundle(bundle);
    if (!mounted) return;
    setState(() {
      _bundle = bundle;
      _engine = engine;
      if (saved != null) _todayLog = saved;
      _estimate = engine.compute(_todayLog);
    });
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          currentLocale: widget.currentLocale,
          onSwitchLanguage: widget.onSwitchLanguage,
        ),
      ),
    );
  }

  Future<void> _openCheckIn() async {
    if (_bundle == null) return;
    final result = await Navigator.of(context).push<DailyLogInput>(
      MaterialPageRoute(builder: (_) => CheckInScreen(config: _bundle!)),
    );
    if (result == null || !mounted) return;
    await GuestStore.instance.saveTodayLog(result);
    setState(() {
      _todayLog = result;
      _estimate = _engine!.compute(result);
    });
  }

  String _confidenceLabel(AppLocalizations s, Confidence c) => switch (c) {
        Confidence.low => s.confidence_low,
        Confidence.medium => s.confidence_medium,
        Confidence.high => s.confidence_high,
      };

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.app_title),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: strings.settings_title,
            icon: const Icon(Icons.settings_outlined),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: _bundle == null || _estimate == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          strings.home_today_title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Chip(
                        label: Text(
                          _confidenceLabel(strings, _estimate!.confidence),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  HormoneBalanceChart(
                    bars: [
                      for (final id in _bundle!.displayOrder)
                        ChartBarData(
                          hormoneId: id,
                          label: configLabel(
                            strings,
                            _bundle!.hormones
                                .firstWhere((h) => h.id == id)
                                .i18nKey,
                          ),
                          icon: configIcon(_bundle!.hormones
                              .firstWhere((h) => h.id == id)
                              .icon),
                          score: _estimate!.scores[id]!.score,
                          status: _estimate!.scores[id]!.status,
                          invert: _bundle!.hormones
                              .firstWhere((h) => h.id == id)
                              .invert,
                        ),
                    ],
                    statusLabels: {
                      BarStatus.low: strings.balance_low,
                      BarStatus.balanced: strings.balance_balanced,
                      BarStatus.high: strings.balance_high,
                    },
                    onTapBar: (hormoneId) =>
                        _openHormoneDetail(hormoneId),
                  ),
                  const SizedBox(height: 12),
                  if (_todayLog.selectionCount == 0)
                    Text(
                      strings.home_empty_hint,
                      textAlign: TextAlign.center,
                    )
                  else ...[
                    Text(
                      strings.home_why_title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      children: [
                        for (final id in _whyContributorIds())
                          Chip(label: Text(_contributorLabel(strings, id))),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: _openCheckIn,
                    icon: const Icon(Icons.add),
                    label: Text(strings.home_log_day),
                  ),
                  const SizedBox(height: 8),
                  FilledButton.tonalIcon(
                    onPressed: _openLibrary,
                    icon: const Icon(Icons.mood_outlined),
                    label: Text(strings.library_title),
                  ),
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

  void _openHormoneDetail(String hormoneId) {
    if (_bundle == null || _estimate == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => HormoneDetailScreen(
          bundle: _bundle!,
          hormoneId: hormoneId,
          score: _estimate!.scores[hormoneId]!,
        ),
      ),
    );
  }

  void _openLibrary() {
    if (_bundle == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => LibraryScreen(bundle: _bundle!)),
    );
  }

  /// Union of top contributors behind out-of-balance hormones.
  List<String> _whyContributorIds() {
    final ids = <String>{};
    for (final score in _estimate!.scores.values) {
      if (score.status != BarStatus.balanced) {
        ids.addAll(score.topContributors);
      }
    }
    return ids.take(6).toList();
  }

  String _contributorLabel(AppLocalizations strings, String id) {
    final activities = _bundle!.activityById;
    if (activities.containsKey(id)) {
      return configLabel(strings, activities[id]!.i18nKey);
    }
    final foods = _bundle!.foodById;
    if (foods.containsKey(id)) return configLabel(strings, foods[id]!.i18nKey);
    return id;
  }
}

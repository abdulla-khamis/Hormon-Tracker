import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/config/app_config_loader.dart';
import 'package:horman_tracker_app/core/config/config_models.dart';
import 'package:horman_tracker_app/core/engine/engine_from_config.dart';
import 'package:horman_tracker_app/core/engine/estimation_engine.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';
import 'package:horman_tracker_app/core/l10n/config_labels.dart';
import 'package:horman_tracker_app/core/theme/app_spacing.dart';
import 'package:horman_tracker_app/data/health/health_service.dart';
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
  HealthSummary? _health;
  String? _healthNote;
  String _sex = 'unset';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final bundle = await AppConfigLoader.load();
    final saved = GuestStore.instance.loadTodayLog();
    final engine = engineFromBundle(bundle);
    final sex = GuestStore.instance.loadSex();
    if (!mounted) return;
    setState(() {
      _bundle = bundle;
      _engine = engine;
      _sex = sex;
      if (saved != null) _todayLog = saved;
      _estimate = engine.compute(_todayLog, health: _health, sex: _sex);
    });
  }

  void _recompute() {
    if (_engine == null) return;
    setState(() {
      _estimate = _engine!.compute(_todayLog, health: _health, sex: _sex);
    });
  }

  Future<void> _syncHealth() async {
    final strings = AppLocalizations.of(context)!;
    final allow = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.health_why_title),
        content: Text(strings.health_why_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(strings.health_skip),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(strings.health_allow),
          ),
        ],
      ),
    );
    if (allow != true || !mounted) return;
    final result = await const HealthService().requestAndFetchLastDay();
    if (!mounted) return;
    switch (result.status) {
      case HealthSyncStatus.granted:
        _health = result.summary;
        final hours = result.summary?.sleepHours;
        _healthNote = hours == null
            ? strings.health_synced
            : '${strings.health_synced} • ${hours.toStringAsFixed(1)}h';
        _recompute();
      case HealthSyncStatus.denied:
        _showSnack(strings.health_denied);
      case HealthSyncStatus.unavailable:
        _showSnack(strings.health_unavailable);
    }
    setState(() {});
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          currentLocale: widget.currentLocale,
          onSwitchLanguage: widget.onSwitchLanguage,
          currentSex: _sex,
          onSexChanged: (sex) async {
            await GuestStore.instance.saveSex(sex);
            if (!mounted) return;
            setState(() => _sex = sex);
            _recompute();
          },
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
      _estimate = _engine!.compute(result, health: _health, sex: _sex);
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
            tooltip: strings.health_sync,
            icon: const Icon(Icons.sync_outlined),
            onPressed: _syncHealth,
          ),
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
              padding: AppSpacing.pagePadding,
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
                  if (_healthNote != null) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      _healthNote!,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  HormoneBalanceChart(
                    bars: [
                      for (final id in _bundle!.validDisplayOrder)
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
                  const SizedBox(height: AppSpacing.md),
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
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        for (final id in _whyContributorIds())
                          Chip(label: Text(_contributorLabel(strings, id))),
                      ],
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  FilledButton.icon(
                    onPressed: _openCheckIn,
                    icon: const Icon(Icons.add),
                    label: Text(strings.home_log_day),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  FilledButton.tonalIcon(
                    onPressed: _openLibrary,
                    icon: const Icon(Icons.mood_outlined),
                    label: Text(strings.library_title),
                  ),
                  const SizedBox(height: AppSpacing.lg),
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

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'config_models.dart';

/// Loads all versioned JSON config from assets/config/v1.
/// Single entry point so no screen ever parses JSON itself.
/// Result is cached for the process lifetime: config is immutable per
/// launch, so reloading per screen is pure waste — and repeated
/// binary-messenger loads across widget tests are flaky.
class AppConfigLoader {
  const AppConfigLoader._();

  static const _base = 'assets/config/v1';

  /// Cached VALUE (not Future): a Future completed in one FakeAsync zone
  /// never delivers callbacks registered in another zone, which hangs
  /// every widget test after the first. Returning the value from an async
  /// function mints a fresh, same-zone Future every call.
  static AppConfigBundle? _cache;

  static Future<AppConfigBundle> load() async {
    final hit = _cache;
    if (hit != null) return hit;
    final bundle = await _loadUncached();
    _cache = bundle;
    return bundle;
  }

  @visibleForTesting
  static void clearCache() => _cache = null;

  static Future<Map<String, dynamic>> _read(String file) async {
    final raw = await rootBundle.loadString('$_base/$file');
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  static Map<String, double> _doubleMap(dynamic json) {
    if (json is! Map) return const {};
    return {
      for (final e in json.entries)
        e.key.toString(): (e.value as num).toDouble()
    };
  }

  static Future<AppConfigBundle> _loadUncached() async {
    final hormonesJson = await _read('hormones.json');
    final activitiesJson = await _read('activities.json');
    final foodsJson = await _read('foods.json');
    final feelingsJson = await _read('feel_states.json');
    final thresholdsJson = await _read('thresholds.json');
    final tipsJson = await _read('tips.json');
    final appConfigJson = await _read('app_config.json');

    final typicalRaw = feelingsJson['typicalPatterns'];
    final helpRaw = feelingsJson['helpTips'];

    return AppConfigBundle(
      hormones: [
        for (final h in hormonesJson['hormones'] as List)
          HormoneDef.fromJson(h as Map<String, dynamic>)
      ],
      displayOrder: [
        for (final id in hormonesJson['displayOrder'] as List) id.toString()
      ],
      activities: [
        for (final a in activitiesJson['activities'] as List)
          ActivityDef.fromJson(a as Map<String, dynamic>)
      ],
      foods: [
        for (final f in foodsJson['foods'] as List)
          FoodDef.fromJson(f as Map<String, dynamic>)
      ],
      feelings: [
        for (final f in feelingsJson['feelings'] as List) f.toString()
      ],
      thresholds: AppThresholds.fromJson(thresholdsJson),
      tips: [
        for (final t in tipsJson['tips'] as List)
          TipDef.fromJson(t as Map<String, dynamic>)
      ],
      patternTypical: {
        if (typicalRaw is Map)
          for (final e in typicalRaw.entries)
            e.key.toString(): _doubleMap(e.value),
      },
      patternHelpTips: {
        if (helpRaw is Map)
          for (final e in helpRaw.entries)
            e.key.toString(): [
              for (final t in (e.value as List)) t.toString()
            ],
      },
      flags: AppFlags.fromJson(appConfigJson),
    );
  }
}

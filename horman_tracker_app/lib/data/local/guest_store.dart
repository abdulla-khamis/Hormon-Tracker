import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/engine/hormone_estimate.dart';
import '../../core/theme/app_constants.dart';

/// Guest-local storage. Hive boxes hold plain maps (no codegen adapters).
/// If Hive can't init (e.g. widget tests), silently falls back to memory
/// so the UI and tests never crash.
class GuestStore {
  GuestStore._();
  static final GuestStore instance = GuestStore._();

  static const _boxName = AppConstants.guestBoxName;
  Box? _box;
  final Map<String, Map<String, dynamic>> _memory = {};

  @visibleForTesting
  void useMemoryOnly() => _box = null;

  Future<void> init() async {
    try {
      await Hive.initFlutter();
      _box = await Hive.openBox(_boxName);
    } catch (_) {
      _box = null;
    }
  }

  String todayKey() {
    final now = DateTime.now();
    return '${AppConstants.todayLogKeyPrefix}${now.year}-${now.month}-${now.day}';
  }

  Future<void> saveTodayLog(DailyLogInput log) async {
    final json = log.toJson();
    if (_box != null) {
      await _box!.put(todayKey(), json);
    } else {
      _memory[todayKey()] = json;
    }
  }

  DailyLogInput? loadTodayLog() {
    final raw = _box?.get(todayKey()) ?? _memory[todayKey()];
    if (raw is Map) {
      return DailyLogInput.fromJson(Map<String, dynamic>.from(raw));
    }
    return null;
  }

  static const _tipFeedbackKey = AppConstants.tipFeedbackKey;
  static const _profileKey = AppConstants.profileKey;

  /// Profile sex: 'male', 'female' or 'unset'. Stored locally only.
  Future<void> saveSex(String sex) async {
    final profile = Map<String, dynamic>.from(
      (_box?.get(_profileKey) ?? _memory[_profileKey]) ?? {},
    );
    profile['sex'] = sex;
    if (_box != null) {
      await _box!.put(_profileKey, profile);
    } else {
      _memory[_profileKey] = profile;
    }
  }

  String loadSex() {
    final profile = _box?.get(_profileKey) ?? _memory[_profileKey];
    if (profile is Map) return '${profile['sex'] ?? 'unset'}';
    return 'unset';
  }

  /// null = no feedback yet, true = helpful, false = not helpful.
  Future<void> saveTipFeedback(String tipId, bool helpful) async {
    final all = Map<String, dynamic>.from(
      (_box?.get(_tipFeedbackKey) ?? _memory[_tipFeedbackKey]) ?? {},
    );
    all[tipId] = helpful;
    if (_box != null) {
      await _box!.put(_tipFeedbackKey, all);
    } else {
      _memory[_tipFeedbackKey] = all;
    }
  }

  bool? tipFeedback(String tipId) {
    final all = _box?.get(_tipFeedbackKey) ?? _memory[_tipFeedbackKey];
    if (all is Map) return all[tipId] as bool?;
    return null;
  }
}

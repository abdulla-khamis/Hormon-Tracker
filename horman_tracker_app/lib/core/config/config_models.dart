/// Config models. Every list in the app (hormones, habits, foods, tips)
/// comes from versioned JSON in assets/config/v1 — never from code.
class HormoneDef {
  const HormoneDef({
    required this.id,
    required this.i18nKey,
    required this.icon,
    required this.invert,
    required this.descriptionEn,
    required this.descriptionAr,
  });

  final String id;
  final String i18nKey;
  final String icon;
  final bool invert;
  final String descriptionEn;
  final String descriptionAr;

  factory HormoneDef.fromJson(Map<String, dynamic> json) => HormoneDef(
        id: json['id'] as String,
        i18nKey: json['i18nKey'] as String,
        icon: json['icon'] as String,
        invert: json['invert'] as bool? ?? false,
        descriptionEn: json['description_en'] as String? ?? '',
        descriptionAr: json['description_ar'] as String? ?? '',
      );
}

class ActivityDef {
  const ActivityDef({
    required this.id,
    required this.i18nKey,
    required this.icon,
    required this.deltas,
    required this.delayedDeltas,
    required this.evidence,
  });

  final String id;
  final String i18nKey;
  final String icon;
  final Map<String, double> deltas;
  final Map<String, double> delayedDeltas;
  final String evidence;

  static Map<String, double> _numberMap(dynamic json) {
    if (json is! Map) return const {};
    return {
      for (final e in json.entries)
        e.key.toString(): (e.value as num).toDouble()
    };
  }

  factory ActivityDef.fromJson(Map<String, dynamic> json) => ActivityDef(
        id: json['id'] as String,
        i18nKey: json['i18nKey'] as String,
        icon: json['icon'] as String,
        deltas: _numberMap(json['deltas']),
        delayedDeltas: _numberMap(json['delayed3h']),
        evidence: json['evidence'] as String? ?? 'moderate',
      );
}

class FoodDef {
  const FoodDef({
    required this.id,
    required this.i18nKey,
    required this.deltas,
    required this.delayedDeltas,
  });

  final String id;
  final String i18nKey;
  final Map<String, double> deltas;
  final Map<String, double> delayedDeltas;

  factory FoodDef.fromJson(Map<String, dynamic> json) => FoodDef(
        id: json['id'] as String,
        i18nKey: json['i18nKey'] as String,
        deltas: ActivityDef._numberMap(json['deltas']),
        delayedDeltas: ActivityDef._numberMap(json['delayed3h']),
      );
}

class AppThresholds {
  const AppThresholds({
    required this.baseline,
    required this.lowMax,
    required this.balancedMax,
  });

  final double baseline;
  final double lowMax;
  final double balancedMax;

  factory AppThresholds.fromJson(Map<String, dynamic> json) => AppThresholds(
        baseline: (json['baseline'] as num?)?.toDouble() ?? 50,
        lowMax: (json['lowMax'] as num?)?.toDouble() ?? 40,
        balancedMax: (json['balancedMax'] as num?)?.toDouble() ?? 70,
      );
}

/// Everything the UI needs, loaded once at startup.
class AppConfigBundle {
  const AppConfigBundle({
    required this.hormones,
    required this.displayOrder,
    required this.activities,
    required this.foods,
    required this.feelings,
    required this.thresholds,
    required this.tips,
    required this.patternTypical,
    required this.patternHelpTips,
    required this.flags,
  });

  final List<HormoneDef> hormones;
  final List<String> displayOrder;
  final List<ActivityDef> activities;
  final List<FoodDef> foods;
  final List<String> feelings;
  final AppThresholds thresholds;
  final List<TipDef> tips;
  final Map<String, Map<String, double>> patternTypical;
  final Map<String, List<String>> patternHelpTips;
  final AppFlags flags;

  Map<String, ActivityDef> get activityById =>
      {for (final a in activities) a.id: a};
  Map<String, FoodDef> get foodById => {for (final f in foods) f.id: f};
  Map<String, TipDef> get tipById => {for (final t in tips) t.id: t};
  HormoneDef hormoneById(String id) =>
      hormones.firstWhere((h) => h.id == id);
}

/// One rebalance tip from tips.json. Text lives in JSON (reviewed copy),
/// NOT in arb — tips are content, shipped versioned with config.
class TipDef {
  const TipDef({
    required this.id,
    required this.hormoneIds,
    required this.type,
    required this.textEn,
    required this.textAr,
    required this.evidence,
    required this.supportive,
  });

  final String id;
  final List<String> hormoneIds;
  final String type; // do | eat | avoid | islamic
  final String textEn;
  final String textAr;
  final String evidence; // strong | moderate | preliminary
  final bool supportive;

  factory TipDef.fromJson(Map<String, dynamic> json) => TipDef(
        id: json['id'] as String,
        hormoneIds: [
          for (final h in (json['hormones'] as List? ?? [])) h.toString()
        ],
        type: json['type'] as String? ?? 'do',
        textEn: json['text_en'] as String? ?? '',
        textAr: json['text_ar'] as String? ?? '',
        evidence: json['evidence'] as String? ?? 'moderate',
        supportive: json['supportive'] as bool? ?? false,
      );
}

/// Non-medical app flags + helplines from app_config.json.
class AppFlags {
  const AppFlags({
    required this.quitLines,
    required this.redFlagHotlines,
  });

  final Map<String, String> quitLines;
  final Map<String, String> redFlagHotlines;

  static Map<String, String> _stringMap(dynamic json) {
    if (json is! Map) return const {};
    return {for (final e in json.entries) e.key.toString(): '${e.value}'};
  }

  factory AppFlags.fromJson(Map<String, dynamic> json) => AppFlags(
        quitLines: _stringMap(json['quitLines']),
        redFlagHotlines: _stringMap(json['redFlagHotlines']),
      );
}

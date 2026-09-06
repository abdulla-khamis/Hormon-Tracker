import 'hormone_estimate.dart';

/// Pure estimation engine (deterministic, no randomness).
///
/// score = clamp(0, 100, baseline
///   + SUM immediate deltas
///   + 0.5 * SUM delayed-3h deltas   // spike-now-crash-later honesty
///   + health proxies when the matching habit was NOT logged manually)
///
/// Confidence stays at medium max until 7-day history exists (V1).
class EstimationEngine {
  const EstimationEngine({
    required this.hormoneIds,
    required this.activityDeltas,
    required this.foodDeltas,
    required this.baseline,
    required this.lowMax,
    required this.balancedMax,
  });

  final List<String> hormoneIds;
  final Map<String, Map<String, double>> activityDeltas;
  final Map<String, Map<String, double>> foodDeltas;
  final double baseline;
  final double lowMax;
  final double balancedMax;

  static const delayedWeight = 0.5;

  /// [sex] is 'male', 'female' or null (prefer not to say).
  /// It applies a tiny documented baseline nudge (±2) to the sex hormones
  /// only — educational, capped, and clearly labeled. Cycle-aware tuning
  /// arrives in V1 with explicit opt-in.
  DailyEstimate compute(
    DailyLogInput log, {
    HealthSummary? health,
    String? sex,
  }) {
    final totals = {for (final id in hormoneIds) id: baseline};
    final impacts = {for (final id in hormoneIds) id: <String, double>{}};

    if (sex == 'male') {
      if (totals.containsKey('testosterone')) {
        totals['testosterone'] = totals['testosterone']! + 2;
      }
      if (totals.containsKey('estrogen')) {
        totals['estrogen'] = totals['estrogen']! - 2;
      }
    } else if (sex == 'female') {
      if (totals.containsKey('estrogen')) {
        totals['estrogen'] = totals['estrogen']! + 2;
      }
      if (totals.containsKey('testosterone')) {
        totals['testosterone'] = totals['testosterone']! - 2;
      }
    }

    void apply(String contributor, Map<String, double>? deltas,
        {double weight = 1}) {
      if (deltas == null) return;
      for (final entry in deltas.entries) {
        if (!totals.containsKey(entry.key)) continue;
        totals[entry.key] = totals[entry.key]! + entry.value * weight;
        impacts[entry.key]!.update(
          contributor,
          (v) => v + entry.value.abs() * weight,
          ifAbsent: () => entry.value.abs() * weight,
        );
      }
    }

    for (final id in log.activities) {
      apply(id, activityDeltas['$id#now']);
      apply(id, activityDeltas['$id#later'], weight: delayedWeight);
    }
    for (final id in log.foods) {
      apply(id, foodDeltas['$id#now']);
      apply(id, foodDeltas['$id#later'], weight: delayedWeight);
    }
    if (health != null) {
      if ((health.sleepHours ?? 99) < 6 &&
          !log.activities.contains('sleep_short') &&
          !log.activities.contains('sleep_good')) {
        apply('sleep_short', activityDeltas['sleep_short#now']);
      }
      if ((health.workoutMinutes ?? 0) >= 30 &&
          !log.activities
              .any((a) => a == 'walk_30min' || a == 'gym_resistance')) {
        apply('walk_30min', activityDeltas['walk_30min#now']);
      }
    }

    final scores = <String, HormoneScore>{};
    for (final id in hormoneIds) {
      final clamped = totals[id]!.clamp(0, 100).toDouble();
      final contributors = impacts[id]!.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      scores[id] = HormoneScore(
        hormoneId: id,
        score: (clamped * 10).round() / 10,
        status: clamped < lowMax
            ? BarStatus.low
            : clamped > balancedMax
                ? BarStatus.high
                : BarStatus.balanced,
        topContributors: [for (final e in contributors.take(2)) e.key],
      );
    }

    final n = log.selectionCount;
    final confidence =
        n >= 3 ? Confidence.medium : Confidence.low; // high needs history (V1)

    return DailyEstimate(scores: scores, confidence: confidence);
  }
}

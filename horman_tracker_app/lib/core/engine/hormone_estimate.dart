// Pure-Dart estimation models. No Flutter imports so unit tests stay fast.

/// What the user logged today. IDs only — labels live in arb files.
class DailyLogInput {
  const DailyLogInput({
    this.feelings = const [],
    this.activities = const [],
    this.foods = const [],
  });

  final List<String> feelings;
  final List<String> activities;
  final List<String> foods;

  int get selectionCount =>
      feelings.length + activities.length + foods.length;

  Map<String, dynamic> toJson() => {
        'feelings': feelings,
        'activities': activities,
        'foods': foods,
      };

  factory DailyLogInput.fromJson(Map<String, dynamic> json) => DailyLogInput(
        feelings: [for (final f in (json['feelings'] as List? ?? [])) '$f'],
        activities: [for (final a in (json['activities'] as List? ?? [])) '$a'],
        foods: [for (final f in (json['foods'] as List? ?? [])) '$f'],
      );
}

/// Optional wearable summary. Proxies only — never lab values.
class HealthSummary {
  const HealthSummary({this.sleepHours, this.workoutMinutes});

  final double? sleepHours;
  final int? workoutMinutes;
}

enum Confidence { low, medium, high }

enum BarStatus { low, balanced, high }

class HormoneScore {
  const HormoneScore({
    required this.hormoneId,
    required this.score,
    required this.status,
    required this.topContributors,
  });

  final String hormoneId;
  final double score;
  final BarStatus status;
  final List<String> topContributors;
}

class DailyEstimate {
  const DailyEstimate({required this.scores, required this.confidence});

  final Map<String, HormoneScore> scores;
  final Confidence confidence;
}

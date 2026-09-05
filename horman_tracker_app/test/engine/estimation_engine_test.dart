import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/core/engine/estimation_engine.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';

/// Unit tests for the pure estimation engine (no assets, no Flutter binding).
EstimationEngine _testEngine() => EstimationEngine(
      hormoneIds: const ['dopamine', 'serotonin', 'cortisol', 'melatonin'],
      activityDeltas: const {
        'sleep_short#now': {'cortisol': 8.0, 'serotonin': -6.0},
        'sleep_short#later': {},
        'walk_30min#now': {'serotonin': 7.0, 'cortisol': -6.0},
        'walk_30min#later': {},
        'soda_proxy#now': {'dopamine': 3.0},
        'soda_proxy#later': {'dopamine': -5.0},
      },
      foodDeltas: const {
        'soda#now': {'dopamine': 3.0},
        'soda#later': {'dopamine': -5.0},
      },
      baseline: 50,
      lowMax: 40,
      balancedMax: 70,
    );

void main() {
  test('Empty log stays at baseline with low confidence', () {
    final estimate = _testEngine().compute(const DailyLogInput());
    for (final score in estimate.scores.values) {
      expect(score.score, 50);
      expect(score.status, BarStatus.balanced);
    }
    expect(estimate.confidence, Confidence.low);
  });

  test('Short sleep raises cortisol and lowers serotonin', () {
    final estimate = _testEngine().compute(
      const DailyLogInput(activities: ['sleep_short', 'walk_30min']),
    );
    expect(estimate.scores['cortisol']!.score, 52); // 50+8-6
    expect(estimate.scores['serotonin']!.score, 51); // 50-6+7
    expect(estimate.scores['cortisol']!.status, BarStatus.balanced);
  });

  test('Delayed crash applies at half weight (soda honesty)', () {
    final estimate = _testEngine().compute(
      const DailyLogInput(foods: ['soda', 'soda', 'soda']),
    );
    // 50 + 3*3 immediate - 0.5*3*5 delayed = 51.5
    expect(estimate.scores['dopamine']!.score, 51.5);
  });

  test('Scores clamp to 0..100 and flag high status', () {
    final estimate = _testEngine().compute(
      const DailyLogInput(
        activities: [
          'sleep_short',
          'sleep_short',
          'sleep_short',
          'sleep_short',
          'sleep_short',
        ],
      ),
    );
    expect(estimate.scores['cortisol']!.score, 90);
    expect(estimate.scores['cortisol']!.status, BarStatus.high);
    expect(
      estimate.scores['cortisol']!.topContributors.first,
      'sleep_short',
    );
  });

  test('Three or more selections raise confidence to medium', () {
    final estimate = _testEngine().compute(
      const DailyLogInput(activities: ['walk_30min'], foods: ['soda', 'soda']),
    );
    expect(estimate.confidence, Confidence.medium);
  });

  test('Health proxy fills in unlogged short sleep', () {
    final withProxy = _testEngine().compute(
      const DailyLogInput(),
      health: const HealthSummary(sleepHours: 5),
    );
    expect(withProxy.scores['cortisol']!.score, 58);
    final manual = _testEngine().compute(
      const DailyLogInput(activities: ['sleep_short']),
      health: const HealthSummary(sleepHours: 5),
    );
    expect(manual.scores['cortisol']!.score, 58); // no double count
  });
}

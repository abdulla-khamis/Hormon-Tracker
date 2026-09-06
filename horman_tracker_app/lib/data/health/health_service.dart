import 'dart:io';

import 'package:health/health.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';

/// Health sync status. Health data NEVER leaves the device (file 09 lock):
/// samples are summarized locally into [HealthSummary] and discarded.
enum HealthSyncStatus { granted, denied, unavailable }

class HealthSyncResult {
  const HealthSyncResult({required this.status, this.summary, this.steps});

  final HealthSyncStatus status;
  final HealthSummary? summary;
  final int? steps;
}

/// Read-only health sync: sleep + steps + workouts for the last day.
/// Every platform call is guarded — denied/unimplemented channels resolve
/// to [HealthSyncStatus.unavailable]/denied instead of crashing (tests,
/// simulators, restricted devices).
class HealthService {
  const HealthService();

  static const _readTypes = [
    HealthDataType.STEPS,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_DEEP,
    HealthDataType.SLEEP_REM,
    HealthDataType.WORKOUT,
  ];

  Future<HealthSyncResult> requestAndFetchLastDay() async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      return const HealthSyncResult(status: HealthSyncStatus.unavailable);
    }
    try {
      final health = Health();
      final granted = await health.requestAuthorization(
        _readTypes,
        permissions: List.filled(
          _readTypes.length,
          HealthDataAccess.READ,
        ),
      );
      if (!granted) {
        return const HealthSyncResult(status: HealthSyncStatus.denied);
      }
      return await fetchLastDay();
    } catch (_) {
      return const HealthSyncResult(status: HealthSyncStatus.unavailable);
    }
  }

  Future<HealthSyncResult> fetchLastDay() async {
    try {
      final now = DateTime.now();
      final points = await Health().getHealthDataFromTypes(
        startTime: now.subtract(const Duration(hours: 36)),
        endTime: now,
        types: _readTypes,
      );
      double sleepMinutes = 0;
      double workoutMinutes = 0;
      var steps = 0;
      for (final p in points) {
        final minutes =
            p.dateTo.difference(p.dateFrom).inMinutes.clamp(0, 16 * 60);
        switch (p.type) {
          case HealthDataType.SLEEP_ASLEEP:
          case HealthDataType.SLEEP_DEEP:
          case HealthDataType.SLEEP_REM:
            sleepMinutes += minutes;
          case HealthDataType.WORKOUT:
            workoutMinutes += minutes;
          case HealthDataType.STEPS:
            final v = p.value;
            if (v is NumericHealthValue) steps += v.numericValue.toInt();
          default:
            break;
        }
      }
      // Cap: overlapping sources must not inflate sleep past reality.
      if (sleepMinutes > 16 * 60) sleepMinutes = 16 * 60;
      return HealthSyncResult(
        status: HealthSyncStatus.granted,
        summary: HealthSummary(
          sleepHours: sleepMinutes / 60,
          workoutMinutes: workoutMinutes.round(),
        ),
        steps: steps,
      );
    } catch (_) {
      return const HealthSyncResult(status: HealthSyncStatus.unavailable);
    }
  }
}

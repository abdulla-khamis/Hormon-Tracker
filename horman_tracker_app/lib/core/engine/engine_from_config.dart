import '../config/config_models.dart';
import 'estimation_engine.dart';

/// Builds a pure [EstimationEngine] from the loaded JSON bundle.
/// Keeps storage keys `<id>#now` / `<id>#later` in one place.
EstimationEngine engineFromBundle(AppConfigBundle bundle) {
  final activityDeltas = <String, Map<String, double>>{};
  for (final a in bundle.activities) {
    activityDeltas['${a.id}#now'] = a.deltas;
    activityDeltas['${a.id}#later'] = a.delayedDeltas;
  }
  final foodDeltas = <String, Map<String, double>>{};
  for (final f in bundle.foods) {
    foodDeltas['${f.id}#now'] = f.deltas;
    foodDeltas['${f.id}#later'] = f.delayedDeltas;
  }
  return EstimationEngine(
    hormoneIds: bundle.displayOrder,
    activityDeltas: activityDeltas,
    foodDeltas: foodDeltas,
    baseline: bundle.thresholds.baseline,
    lowMax: bundle.thresholds.lowMax,
    balancedMax: bundle.thresholds.balancedMax,
  );
}

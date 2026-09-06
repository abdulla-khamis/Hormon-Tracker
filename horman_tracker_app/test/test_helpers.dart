import 'package:flutter_test/flutter_test.dart';

/// Shared widget-test helpers. Explicit stepped pumps + polling so tests
/// never depend on single-pump timing (asset loads, chart animations,
/// route transitions each need their own frames).
Future<void> stepPumps(WidgetTester tester, [int steps = 10]) async {
  for (var i = 0; i < steps; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

/// Pumps until [finder] matches or fails after ~5 seconds.
Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
  for (var i = 0; i < 50; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isNotEmpty) return;
  }
  fail('pumpUntilFound timed out waiting for $finder');
}

/// Pumps until [finder] is gone or fails after ~5 seconds.
Future<void> pumpUntilGone(WidgetTester tester, Finder finder) async {
  for (var i = 0; i < 50; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (finder.evaluate().isEmpty) return;
  }
  fail('pumpUntilGone timed out waiting for $finder to disappear');
}

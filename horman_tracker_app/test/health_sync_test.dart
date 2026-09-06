import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/app.dart';

import 'test_helpers.dart';

/// M3 health sync: primer dialog shows, Skip closes it safely, and Allow
/// on a channel-less test device resolves to the unavailable message
/// instead of crashing.
Future<void> _enterHome(WidgetTester tester) async {
  await tester.pumpWidget(const HormanTrackerApp());
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Continue as Guest'));
  await pumpUntilFound(tester, find.text('Log my day'));
}

void main() {
  testWidgets('Health primer shows and Skip closes it', (tester) async {
    await _enterHome(tester);

    await tester.tap(find.byIcon(Icons.sync_outlined));
    await pumpUntilFound(tester, find.text('Why connect?'));
    await tester.tap(find.text('Skip'));
    await stepPumps(tester);
    expect(find.text('Why connect?'), findsNothing);
    expect(find.text('Log my day'), findsOneWidget);
  });

  testWidgets('Health Allow without channels shows unavailable, no crash',
      (tester) async {
    await _enterHome(tester);

    await tester.tap(find.byIcon(Icons.sync_outlined));
    await pumpUntilFound(tester, find.text('Why connect?'));
    await tester.tap(find.text('Allow'));
    await pumpUntilFound(
      tester,
      find.text('Health data unavailable on this device.'),
    );
  });
}

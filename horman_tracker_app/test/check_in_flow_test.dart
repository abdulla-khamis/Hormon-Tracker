import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/app.dart';
import 'package:horman_tracker_app/features/checkin/check_in_screen.dart';

/// Check-in flow: opens from home, walks 3 steps, submits a log.
Future<void> _stepPumps(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('Check-in opens, completes 3 steps and updates home',
      (tester) async {
    await tester.pumpWidget(const HormanTrackerApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('Continue as Guest'));
    await _stepPumps(tester);

    await tester.tap(find.text('Log my day'));
    await _stepPumps(tester);
    expect(find.byType(CheckInScreen), findsOneWidget);
    expect(find.text('How do you feel today?'), findsOneWidget);

    // Step 1: feelings.
    await tester.tap(find.text('Anxious'));
    await tester.tap(find.text('Calm'));
    await tester.tap(find.text('Next'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('What did you do?'), findsOneWidget);

    // Step 2: habits.
    await tester.tap(find.text('Short sleep'));
    await tester.tap(find.text('Walk 30 min'));
    await tester.tap(find.text('Next'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('What did you eat and drink?'), findsOneWidget);

    // Step 3: foods + done.
    await tester.tap(find.text('Soda'));
    await tester.tap(find.text('Done'));
    await _stepPumps(tester);

    // Back home: estimate updated, why-chips visible.
    expect(find.byType(CheckInScreen), findsNothing);
    expect(find.text('Why?'), findsOneWidget);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/app.dart';
import 'package:horman_tracker_app/features/hormone_detail/hormone_detail_screen.dart';
import 'package:horman_tracker_app/features/library/library_screen.dart';
import 'package:horman_tracker_app/features/library/state_detail_screen.dart';

import 'test_helpers.dart';

/// M2 flows: bar tap opens hormone detail with tips; library pattern shows
/// demo chart, helping tips and the support card.
Future<void> _enterHome(WidgetTester tester) async {
  await tester.pumpWidget(const HormanTrackerApp());
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Continue as Guest'));
  await pumpUntilGone(tester, find.text('Continue as Guest'));
  await pumpUntilFound(tester, find.text('Log my day'));
}

void main() {
  testWidgets('Bar tap opens hormone detail with grouped tips',
      (tester) async {
    await _enterHome(tester);

    await tester.tap(find.text('Cortisol'));
    await pumpUntilFound(tester, find.byType(HormoneDetailScreen));
    expect(find.byType(HormoneDetailScreen), findsOneWidget);
    expect(find.text('Do'), findsOneWidget);
    expect(find.text('Avoid'), findsOneWidget);
  });

  testWidgets('Library pattern shows demo note and helping tips',
      (tester) async {
    await _enterHome(tester);

    await tester.tap(find.text('How do you feel?'));
    await pumpUntilFound(tester, find.byType(LibraryScreen));
    expect(find.byType(LibraryScreen), findsOneWidget);

    await tester.tap(find.text('Anxious'));
    await pumpUntilFound(tester, find.byType(StateDetailScreen));
    expect(find.byType(StateDetailScreen), findsOneWidget);
    expect(
      find.text('Typical example — not your diagnosis.'),
      findsOneWidget,
    );
    expect(find.text('What helps'), findsOneWidget);
  });
}

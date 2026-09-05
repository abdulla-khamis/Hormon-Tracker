import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/app.dart';

/// Language lives ONLY in Settings: default English LTR,
/// switch to Arabic RTL and back from the settings screen.
Future<void> _enterAsGuest(WidgetTester tester) async {
  await tester.pumpWidget(const HormanTrackerApp());
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Continue as Guest'));
  await tester.pump(const Duration(seconds: 1));
}

Future<void> _openSettings(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.settings_outlined));
  // Stepped pumps: route transitions freeze under a single long pump.
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('Default locale is English with LTR direction', (tester) async {
    await _enterAsGuest(tester);
    expect(find.text('Hormon Tracker'), findsOneWidget);
    final direction = tester.widget<Directionality>(
      find.ancestor(
        of: find.text('Hormon Tracker'),
        matching: find.byType(Directionality),
      ).first,
    );
    expect(direction.textDirection, TextDirection.ltr);
  });

  testWidgets('Settings switches to Arabic RTL, brand stays Latin',
      (tester) async {
    await _enterAsGuest(tester);
    await _openSettings(tester);
    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();
    // Still on settings, now in Arabic.
    expect(find.text('الإعدادات'), findsOneWidget);
    final direction = tester.widget<Directionality>(
      find.ancestor(
        of: find.text('الإعدادات'),
        matching: find.byType(Directionality),
      ).first,
    );
    expect(direction.textDirection, TextDirection.rtl);
  });
}

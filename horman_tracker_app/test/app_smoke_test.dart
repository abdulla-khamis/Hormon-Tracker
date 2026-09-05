import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/app.dart';

/// Smoke tests for the launch flow: login first, guest enters home.
void main() {
  testWidgets('App launches on login with untranslated brand name',
      (tester) async {
    await tester.pumpWidget(const HormanTrackerApp());
    await tester.pumpAndSettle();
    expect(find.text('Hormon Tracker'), findsWidgets);
    expect(find.text('Continue as Guest'), findsOneWidget);
  });

  testWidgets('Continue as guest opens home with settings entry',
      (tester) async {
    await tester.pumpWidget(const HormanTrackerApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue as Guest'));
    await tester.pumpAndSettle();
    expect(find.text('Hormon Tracker'), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
  });
}

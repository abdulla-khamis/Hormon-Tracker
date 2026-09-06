import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/app.dart';
import 'package:horman_tracker_app/data/local/guest_store.dart';

import 'test_helpers.dart';

/// Profile sex: selectable in Settings, persisted locally, no SOS anywhere.
Future<void> _enterSettings(WidgetTester tester) async {
  await tester.pumpWidget(const HormanTrackerApp());
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text('Continue as Guest'));
  await pumpUntilFound(tester, find.text('Log my day'));
  await tester.tap(find.byIcon(Icons.settings_outlined));
  await pumpUntilFound(tester, find.text('Settings'));
}

void main() {
  testWidgets('Sex selector persists male then unset', (tester) async {
    await _enterSettings(tester);

    await tester.tap(find.text('Male'));
    await stepPumps(tester);
    expect(GuestStore.instance.loadSex(), 'male');
    // Visual feedback regression: one check per group (language + sex).
    expect(find.byIcon(Icons.check), findsNWidgets(2));

    await tester.tap(find.text('Prefer not to say'));
    await stepPumps(tester);
    expect(GuestStore.instance.loadSex(), 'unset');
    expect(find.byIcon(Icons.check), findsNWidgets(2));

    // Every tap fires with the right value (no dead rows).
    await tester.tap(find.text('Female'));
    await stepPumps(tester);
    expect(GuestStore.instance.loadSex(), 'female');
    await tester.tap(find.text('Male'));
    await stepPumps(tester);
    expect(GuestStore.instance.loadSex(), 'male');
  });

  testWidgets('Language rows show check on the active language',
      (tester) async {
    await _enterSettings(tester);

    // English checked by default (locale) + unset checked (sex) = 2 checks.
    expect(find.byIcon(Icons.check), findsNWidgets(2));

    await tester.tap(find.text('العربية'));
    await stepPumps(tester);
    expect(find.byIcon(Icons.check), findsNWidgets(2));
    expect(find.text('الإعدادات'), findsOneWidget);
  });
}

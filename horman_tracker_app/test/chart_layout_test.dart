import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:horman_tracker_app/core/engine/hormone_estimate.dart';
import 'package:horman_tracker_app/widgets/hormone_balance_chart.dart';
/// Chart layout: full labels without ellipsis — narrow screens scroll.
List<ChartBarData> _bars() => [
      for (final id in ['dopamine', 'serotonin', 'cortisol'])
        ChartBarData(
          hormoneId: id,
          label: 'TestosteroneLong',
          icon: Icons.circle_outlined,
          score: 50,
          status: BarStatus.balanced,
          invert: false,
        ),
    ];

Map<BarStatus, String> get _labels => {
      BarStatus.low: 'Low',
      BarStatus.balanced: 'Balanced',
      BarStatus.high: 'High',
    };

void main() {
  testWidgets('Wide screen stretches bars with no scroll', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.ltr,
            child:
                HormoneBalanceChart(bars: _bars(), statusLabels: _labels),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.byType(SingleChildScrollView), findsNothing);
    expect(find.text('TestosteroneLong'), findsNWidgets(3));
  });

  testWidgets('Narrow screen scrolls instead of squeezing labels',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: SizedBox(
              width: 200,
              child:
                  HormoneBalanceChart(bars: _bars(), statusLabels: _labels),
            ),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });
}

import 'package:flutter/material.dart';

import '../core/engine/hormone_estimate.dart';

/// One bar of the unified hormone chart.
class ChartBarData {
  const ChartBarData({
    required this.hormoneId,
    required this.label,
    required this.icon,
    required this.score,
    required this.status,
    required this.invert,
  });

  final String hormoneId;
  final String label;
  final IconData icon;
  final double score;
  final BarStatus status;
  final bool invert;
}

/// THE unified chart. Used on home, detail, library and history —
/// only values change, never the component (file 08 rule).
class HormoneBalanceChart extends StatelessWidget {
  const HormoneBalanceChart({
    super.key,
    required this.bars,
    required this.statusLabels,
    this.onTapBar,
    this.maxBarHeight = 150,
  });

  final List<ChartBarData> bars;
  final Map<BarStatus, String> statusLabels;
  final void Function(String hormoneId)? onTapBar;
  final double maxBarHeight;

  Color _barColor(BuildContext context, ChartBarData bar) {
    final scheme = Theme.of(context).colorScheme;
    return switch (bar.status) {
      BarStatus.low => Colors.blue,
      BarStatus.balanced => Colors.green,
      BarStatus.high => bar.invert ? scheme.error : Colors.amber.shade700,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (final bar in bars)
          Expanded(
            child: InkWell(
              onTap: onTapBar == null ? null : () => onTapBar!(bar.hormoneId),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${bar.score.round()}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(height: 4),
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: bar.score / 100),
                    duration: const Duration(milliseconds: 600),
                    builder: (context, fraction, _) => Container(
                      height: 8 + fraction * maxBarHeight,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: _barColor(context, bar),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Icon(bar.icon, size: 20),
                  const SizedBox(height: 2),
                  Text(
                    bar.label,
                    style: Theme.of(context).textTheme.labelSmall,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    statusLabels[bar.status] ?? '',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _barColor(context, bar),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

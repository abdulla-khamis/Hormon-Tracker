import 'package:flutter/material.dart';
import 'package:horman_tracker_app/core/theme/app_colors.dart';
import 'package:horman_tracker_app/core/theme/app_durations.dart';
import 'package:horman_tracker_app/core/theme/app_spacing.dart';

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
    this.maxBarHeight = AppSpacing.barMaxHeight,
  });

  final List<ChartBarData> bars;
  final Map<BarStatus, String> statusLabels;
  final void Function(String hormoneId)? onTapBar;
  final double maxBarHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final row = Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final bar in bars)
              Expanded(
                child: Semantics(
                  button: true,
                  label: '${bar.label}: ${bar.score.round()}',
                  child: InkWell(
                    onTap: onTapBar == null
                        ? null
                        : () => onTapBar!(bar.hormoneId),
                    child: _BarColumn(
                      bar: bar,
                      maxBarHeight: maxBarHeight,
                      statusLabels: statusLabels,
                    ),
                  ),
                ),
              ),
          ],
        );
        // Narrow screens (11 bars): scroll instead of squeezing text.
        final minNeeded = bars.length * AppSpacing.minChartBarWidth;
        if (constraints.maxWidth.isFinite &&
            constraints.maxWidth < minNeeded) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: minNeeded,
              child: row,
            ),
          );
        }
        return row;
      },
    );
  }
}

/// Single bar column, extracted so the scroll fallback reuses it.
class _BarColumn extends StatelessWidget {
  const _BarColumn({
    required this.bar,
    required this.maxBarHeight,
    required this.statusLabels,
  });

  final ChartBarData bar;
  final double maxBarHeight;
  final Map<BarStatus, String> statusLabels;

  @override
  Widget build(BuildContext context) {
    final color = AppColors.chartBarColor(
      bar.status,
      invert: bar.invert,
      errorColor: Theme.of(context).colorScheme.error,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '${bar.score.round()}',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: bar.score / 100),
          duration: AppDurations.barAnimation,
          builder: (context, fraction, _) => Container(
            height: AppSpacing.barMinHeight + fraction * maxBarHeight,
            margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Icon(bar.icon, size: AppSpacing.iconMd),
        const SizedBox(height: AppSpacing.xxs),
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
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}

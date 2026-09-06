import 'package:flutter/material.dart';

import '../engine/hormone_estimate.dart';

/// Every color in the app comes from here. No `Colors.xxx` or hex values
/// in screens or widgets — file 07 rule.
abstract final class AppColors {
  /// Brand purple sampled from the owner logo.
  static const Color brandPurple = Color(0xFF7C5CBF);

  /// Chart bar colors. High-cortisol-style (inverted) uses the scheme error.
  static const Color chartLow = Colors.blue;
  static const Color chartBalanced = Colors.green;
  static const Color chartHigh = Color(0xFFFF8F00); // amber 700

  static Color chartBarColor(
    BarStatus status, {
    required bool invert,
    required Color errorColor,
  }) =>
      switch (status) {
        BarStatus.low => chartLow,
        BarStatus.balanced => chartBalanced,
        BarStatus.high => invert ? errorColor : chartHigh,
      };
}

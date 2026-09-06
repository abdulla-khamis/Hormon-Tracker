import 'package:flutter/material.dart';

/// Every spacing, radius, icon size and bar height in the app comes from
/// here. No magic numbers in screens or widgets — file 07 rule.
abstract final class AppSpacing {
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;

  static const double radiusSm = 10;
  static const double radiusMd = 24;
  static const double radiusLg = 28;

  static const double iconSm = 18;
  static const double iconMd = 20;

  static const double barMaxHeight = 150;
  static const double barMinHeight = 8;

  /// Minimum bar width so full hormone names (e.g. تستوستيرون) fit without
  /// ellipsis. Narrower screens scroll horizontally instead of squeezing.
  static const double minChartBarWidth = 76;
  static const double logoSize = 120;
  static const double loginLogoSize = 110;

  static const EdgeInsets pagePadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
}

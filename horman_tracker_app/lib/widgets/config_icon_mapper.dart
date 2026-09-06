import 'package:flutter/material.dart';

/// Maps config `icon` names (from hormones.json / activities.json) to
/// Material icons. Unknown names fall back to a neutral dot — never crash.
IconData configIcon(String name) => switch (name) {
      'bolt' => Icons.bolt_outlined,
      'wb_sunny' => Icons.wb_sunny_outlined,
      'favorite' => Icons.favorite_outline,
      'directions_run' => Icons.directions_run,
      'speed' => Icons.speed,
      'bedtime' => Icons.bedtime_outlined,
      'monitor_heart' => Icons.monitor_heart_outlined,
      'restaurant' => Icons.restaurant_outlined,
      'flash_on' => Icons.flash_on_outlined,
      'self_improvement' => Icons.self_improvement_outlined,
      'alarm' => Icons.alarm,
      'nightlight' => Icons.nightlight_round,
      'directions_walk' => Icons.directions_walk,
      'fitness_center' => Icons.fitness_center,
      'coffee' => Icons.coffee_outlined,
      'emoji_food_beverage' => Icons.emoji_food_beverage_outlined,
      'smoke_free' => Icons.smoke_free,
      'smoking_rooms' => Icons.smoking_rooms_outlined,
      'smartphone' => Icons.smartphone,
      'sports_esports' => Icons.sports_esports_outlined,
      'work' => Icons.work_outline,
      'mosque' => Icons.mosque_outlined,
      'ramadan' => Icons.nights_stay_outlined,
      'trending_up' => Icons.trending_up,
      'waves' => Icons.waves,
      _ => Icons.circle_outlined,
    };

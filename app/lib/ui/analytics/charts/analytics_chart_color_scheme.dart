import 'package:flutter/material.dart';

class AnalyticsChartColorScheme {
  final ColorScheme _colorScheme;

  AnalyticsChartColorScheme._({required ColorScheme colorScheme})
      : _colorScheme = colorScheme;

  factory AnalyticsChartColorScheme.of(BuildContext context) {
    return AnalyticsChartColorScheme._(
        colorScheme: Theme.of(context).colorScheme);
  }

  Color get mainGridLine => _colorScheme.surfaceDim;
  Color get border => _colorScheme.outline;
  Color get tooltip => _colorScheme.surfaceContainer;
}

import 'package:flutter/material.dart';

extension AnalyticsChartColors on Color {
  static Color get production => Colors.amber;
  static Color get consumption => Colors.blue;
  static Color get gridConsumption => Colors.red;
  static Color get gridFeedIn => Colors.green;

  Color toBarAreaColor() => withValues(alpha: 0.067);
}

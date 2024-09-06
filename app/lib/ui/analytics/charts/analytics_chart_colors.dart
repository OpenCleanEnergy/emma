import 'package:flutter/cupertino.dart';

extension AnalyticsChartColors on Color {
  static Color get production => CupertinoColors.systemYellow;
  static Color get home => CupertinoColors.systemBlue;
  static Color get gridConsumption => CupertinoColors.systemRed;
  static Color get gridFeedIn => CupertinoColors.systemGreen;

  Color toBarAreaColor() => withOpacity(0.067);
}

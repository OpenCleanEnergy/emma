import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_colors.dart';

abstract final class LineChartBarDataFactory {
  static LineChartBarData create({
    required bool show,
    required Color color,
    required List<FlSpot> spots,
  }) {
    return LineChartBarData(
      show: show,
      spots: spots,
      color: color,
      isCurved: true,
      preventCurveOverShooting: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.toBarAreaColor(),
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:openems/ui/analytics/charts/nice_scale.dart';

typedef GetTitleFunction = String Function(double value);

abstract final class LineChartDataFactory {
  static LineChartData create({
    required BuildContext context,
    required NiceScale yScale,
    required double minX,
    required double maxX,
    required double intervalX,
    required GetTitleFunction leftTitleBuilder,
    required GetTitleFunction bottomTitleBuilder,
    required List<LineChartBarData> lineBarsData,
  }) {
    final colorScheme = AnalyticsChartColorScheme.of(context);

    return LineChartData(
      minY: yScale.min,
      maxY: yScale.max,
      minX: minX,
      maxX: maxX,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: yScale.tickInterval,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorScheme.mainGridLine,
            strokeWidth: 1,
            dashArray: [8, 8],
          );
        },
      ),
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 48,
            interval: yScale.tickInterval,
            getTitlesWidget: (value, meta) => _DefaultLeftSideTitleWidget(
              title: leftTitleBuilder(value),
              axisSide: meta.axisSide,
            ),
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 48,
            interval: intervalX,
            getTitlesWidget: (value, meta) => _DefaultBottomSideTitleWidget(
              title: bottomTitleBuilder(value),
              axisSide: meta.axisSide,
            ),
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(bottom: BorderSide(color: colorScheme.border)),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => colorScheme.tooltip,
            tooltipBorder: BorderSide(color: colorScheme.border)),
      ),
      lineBarsData: lineBarsData,
    );
  }
}

final class _DefaultLeftSideTitleWidget extends StatelessWidget {
  final String title;
  final AxisSide axisSide;

  const _DefaultLeftSideTitleWidget({
    required this.title,
    required this.axisSide,
  });

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      axisSide: axisSide,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

final class _DefaultBottomSideTitleWidget extends StatelessWidget {
  final String title;
  final AxisSide axisSide;

  const _DefaultBottomSideTitleWidget({
    required this.title,
    required this.axisSide,
  });

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      axisSide: axisSide,
      angle: title.length >= 4 ? -45 : 0,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:openems/ui/analytics/charts/factories/bottom_side_title_widget.dart';
import 'package:openems/ui/analytics/charts/factories/left_side_title_widget.dart';
import 'package:openems/ui/analytics/charts/factories/scale.dart';
import 'package:openems/ui/shared/unit_text.dart';

typedef GetLeftSideTitleWidgetFunction = LeftSideTitleWidget Function(
    double value);
typedef GetBottomSideTitleWidgetFunction = BottomSideTitleWidget Function(
    double value);

abstract final class LineChartFactory {
  static LineChart create({
    required BuildContext context,
    required Scale yScale,
    required Scale xScale,
    required GetLeftSideTitleWidgetFunction leftTitleBuilder,
    required GetBottomSideTitleWidgetFunction bottomTitleBuilder,
    required String unitOfMeasurement,
    required List<LineChartBarData> lineBarsData,
  }) {
    final data = _createData(
      context: context,
      yScale: yScale,
      xScale: xScale,
      leftTitleBuilder: leftTitleBuilder,
      bottomTitleBuilder: bottomTitleBuilder,
      unitOfMeasurement: unitOfMeasurement,
      lineBarsData: lineBarsData,
    );

    return LineChart(
      data,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  static LineChartData _createData({
    required BuildContext context,
    required Scale yScale,
    required Scale xScale,
    required GetLeftSideTitleWidgetFunction leftTitleBuilder,
    required GetBottomSideTitleWidgetFunction bottomTitleBuilder,
    required String unitOfMeasurement,
    required List<LineChartBarData> lineBarsData,
  }) {
    final colorScheme = AnalyticsChartColorScheme.of(context);

    return LineChartData(
      minY: yScale.min,
      maxY: yScale.max,
      minX: xScale.min,
      maxX: xScale.max,
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
            reservedSize: 56,
            interval: yScale.tickInterval,
            getTitlesWidget: (value, _) => leftTitleBuilder(value),
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
            interval: xScale.tickInterval,
            maxIncluded: (xScale.max % xScale.tickInterval) == 0,
            getTitlesWidget: (value, _) => bottomTitleBuilder(value),
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
          tooltipBorder: BorderSide(color: colorScheme.border),
          getTooltipItems: (touchedSpots) => _buildLineTooltipItems(
            context: context,
            unitOfMeasurement: unitOfMeasurement,
            touchedSpots: touchedSpots,
          ),
        ),
      ),
      lineBarsData: lineBarsData,
    );
  }

  static List<LineTooltipItem> _buildLineTooltipItems({
    required BuildContext context,
    required String unitOfMeasurement,
    required List<LineBarSpot> touchedSpots,
  }) {
    return touchedSpots.map((LineBarSpot touchedSpot) {
      final color =
          touchedSpot.bar.gradient?.colors.first ?? touchedSpot.bar.color;
      return LineTooltipItem(
        "",
        const TextStyle(),
        children: [
          UnitText.span(context, touchedSpot.y, unitOfMeasurement, color)
        ],
      );
    }).toList();
  }
}

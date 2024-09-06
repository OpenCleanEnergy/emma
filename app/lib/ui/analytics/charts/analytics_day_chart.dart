import 'package:emma/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:emma/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsDayChart extends StatelessWidget {
  const AnalyticsDayChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(
        Theme.of(context).textTheme,
        AnalyticsChartColorScheme.of(context),
      ),
    );
  }

  LineChartData mainData(
      TextTheme textTheme, AnalyticsChartColorScheme colorScheme) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorScheme.mainGridLine,
            strokeWidth: 1,
            dashArray: [8, 8],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) =>
                xAxisTitleWidgets(textTheme, value, meta),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: (value, meta) =>
                yAxisTitleWidgets(textTheme, value, meta),
            reservedSize: 42,
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
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          color: AnalyticsChartColors.production,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: AnalyticsChartColors.production.toBarAreaColor(),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 5),
            FlSpot(2.6, 1),
            FlSpot(4.9, 5),
            FlSpot(6.8, 5.1),
            FlSpot(8, 2),
            FlSpot(9.5, 2),
            FlSpot(11, 3),
          ],
          isCurved: true,
          color: AnalyticsChartColors.home,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: AnalyticsChartColors.home.toBarAreaColor(),
          ),
        ),
      ],
    );
  }

  Widget yAxisTitleWidgets(TextTheme theme, double value, TitleMeta meta) {
    final text = switch (value.toInt()) {
      1 => '10k',
      3 => '30k',
      5 => '50k',
      _ => '',
    };

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: theme.labelSmall),
    );
  }

  Widget xAxisTitleWidgets(TextTheme theme, double value, TitleMeta meta) {
    late final String text;
    final hour = value.toInt();
    if (hour % 2 == 0) {
      text = '$hour:00';
    } else {
      text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -45,
      child: Text(text, style: theme.labelSmall),
    );
  }
}

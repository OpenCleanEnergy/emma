import 'package:emma/ui/analytics/analytics_view_model.dart';
import 'package:emma/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:emma/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsDayChart extends StatelessWidget {
  const AnalyticsDayChart({super.key, required this.viewModel});

  final AnalyticsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("Leistungsverlauf", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 1.333,
          child: Watch(
            (context) => LineChart(
              mainData(
                Theme.of(context).textTheme,
                AnalyticsChartColorScheme.of(context),
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(
      TextTheme textTheme, AnalyticsChartColorScheme colorScheme) {
    final maxX = viewModel.day.value.end
        .difference(viewModel.day.value.start)
        .inMinutes
        .toDouble();

    const horizontalInterval = 50.0;
    const verticalInterval = 120.0;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: horizontalInterval,
        verticalInterval: verticalInterval,
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
            interval: verticalInterval,
            getTitlesWidget: (value, meta) =>
                xAxisTitleWidgets(textTheme, value, meta),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: horizontalInterval,
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
      maxX: maxX,
      minY: 0,
      maxY: 500,
      lineBarsData: [
        LineChartBarData(
          show: viewModel.showProduction.value,
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
          show: viewModel.showHome.value,
          spots: viewModel.day.value.home
              .map(
                (p) => FlSpot(
                  p.time
                      .difference(viewModel.day.value.start)
                      .inMinutes
                      .toDouble(),
                  p.power,
                ),
              )
              .toList(),
          isCurved: true,
          color: AnalyticsChartColors.home,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            color: AnalyticsChartColors.home.toBarAreaColor(),
          ),
        ),
      ],
    );
  }

  Widget yAxisTitleWidgets(TextTheme theme, double value, TitleMeta meta) {
    late final String text;
    final power = value.toInt();
    if (power % 50 == 0) {
      text = '${power}W';
    } else {
      text = '';
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: theme.labelSmall),
    );
  }

  Widget xAxisTitleWidgets(TextTheme theme, double value, TitleMeta meta) {
    final minutes = value.toInt();
    final text = '${minutes ~/ 60}:${minutes % 60}';
    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -45,
      child: Text(text, style: theme.labelSmall),
    );
  }
}

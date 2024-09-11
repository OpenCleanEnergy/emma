import 'dart:math' as math;

import 'package:emma/application/analytics/power_data_point_dto.dart';
import 'package:emma/ui/analytics/analytics_view_model.dart';
import 'package:emma/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:emma/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:emma/ui/analytics/charts/nice_scale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsDayChart extends StatelessWidget {
  static final _minutesFormat = NumberFormat('00');
  static final _hoursFormat = NumberFormat('#0');

  const AnalyticsDayChart({super.key, required this.viewModel});

  final AnalyticsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Leistungsverlauf", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 16),
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
        ),
      ],
    );
  }

  LineChartData mainData(
      TextTheme textTheme, AnalyticsChartColorScheme colorScheme) {
    final maxValue = [
      if (viewModel.chartControl.showHome.value) ...viewModel.day.value.home,
      if (viewModel.chartControl.showProduction.value)
        ...viewModel.day.value.production,
      if (viewModel.chartControl.showGridConsume.value)
        ...viewModel.day.value.gridConsume,
      if (viewModel.chartControl.showGridFeedIn.value)
        ...viewModel.day.value.gridFeedIn,
    ].map((x) => x.power).fold(100.0, math.max);

    final niceScale = NiceScale.calculate(
      maxTicks: 10,
      min: 0,
      max: maxValue,
    );

    const timeAxisInterval = 120.0;
    return LineChartData(
      minY: niceScale.min,
      maxY: niceScale.max,
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: niceScale.tickInterval,
        verticalInterval: timeAxisInterval,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: colorScheme.mainGridLine,
            strokeWidth: 1,
            dashArray: [8, 8],
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 48,
            interval: timeAxisInterval,
            getTitlesWidget: (value, meta) =>
                _buildTimeAxisTitleWidget(textTheme, value, meta),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: niceScale.tickInterval,
            getTitlesWidget: (value, meta) =>
                _buildPowerAxisTitleWidget(textTheme, value, meta),
            reservedSize: 48,
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
      lineBarsData: [
        _getLineChartData(
            show: viewModel.chartControl.showProduction.value,
            data: viewModel.day.value.production,
            color: AnalyticsChartColors.production),
        _getLineChartData(
            show: viewModel.chartControl.showHome.value,
            data: viewModel.day.value.home,
            color: AnalyticsChartColors.home),
        _getLineChartData(
            show: viewModel.chartControl.showGridConsume.value,
            data: viewModel.day.value.gridConsume,
            color: AnalyticsChartColors.gridConsumption),
        _getLineChartData(
            show: viewModel.chartControl.showGridFeedIn.value,
            data: viewModel.day.value.gridFeedIn,
            color: AnalyticsChartColors.gridFeedIn),
      ],
    );
  }

  static Widget _buildPowerAxisTitleWidget(
      TextTheme theme, double value, TitleMeta meta) {
    final text = '${value.toInt()}W';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: theme.labelSmall),
    );
  }

  static Widget _buildTimeAxisTitleWidget(
      TextTheme theme, double value, TitleMeta meta) {
    final hours = _hoursFormat.format(value ~/ 60);
    final minutes = _minutesFormat.format(value % 60);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -45,
      child: Text('$hours:$minutes', style: theme.labelSmall),
    );
  }

  static LineChartBarData _getLineChartData({
    required bool show,
    required Iterable<PowerDataPointDto> data,
    required Color color,
  }) {
    final start = data.isNotEmpty ? data.first.time : DateTime.now();
    var spots = data
        .map(
          (p) => FlSpot(
            p.time.difference(start).inMinutes.toDouble(),
            p.power,
          ),
        )
        .toList();

    return LineChartBarData(
      show: show,
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.toBarAreaColor(),
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:openems/application/backend_api/swagger_generated_code/backend_api.models.swagger.dart';
import 'package:openems/application/backend_api/value_objects.dart';
import 'package:openems/ui/analytics/analysis_view_model.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:openems/ui/analytics/charts/nice_scale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsDayChart extends StatelessWidget {
  static final _minutesFormat = NumberFormat('00');
  static final _hoursFormat = NumberFormat('#0');

  const AnalyticsDayChart({
    super.key,
    required this.chartControlViewModel,
    required this.dailyAnalysisViewModel,
  });

  final AnalyticsChartControlViewModel chartControlViewModel;
  final DailyAnalysisViewModel dailyAnalysisViewModel;

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
      if (chartControlViewModel.showHome.value)
        ...dailyAnalysisViewModel.home.value,
      if (chartControlViewModel.showProduction.value)
        ...dailyAnalysisViewModel.production.value,
      if (chartControlViewModel.showGridConsume.value)
        ...dailyAnalysisViewModel.gridConsume.value,
      if (chartControlViewModel.showGridFeedIn.value)
        ...dailyAnalysisViewModel.gridFeedIn.value,
    ].map((x) => x.power).fold(const Watt(100.0), math.max);

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
            show: chartControlViewModel.showProduction.value,
            data: dailyAnalysisViewModel.production.value,
            color: AnalyticsChartColors.production),
        _getLineChartData(
            show: chartControlViewModel.showHome.value,
            data: dailyAnalysisViewModel.home.value,
            color: AnalyticsChartColors.home),
        _getLineChartData(
            show: chartControlViewModel.showGridConsume.value,
            data: dailyAnalysisViewModel.gridConsume.value,
            color: AnalyticsChartColors.gridConsumption),
        _getLineChartData(
            show: chartControlViewModel.showGridFeedIn.value,
            data: dailyAnalysisViewModel.gridFeedIn.value,
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
    final start = data.isNotEmpty ? data.first.timestamp : DateTime.now();
    var spots = data
        .map(
          (p) => FlSpot(
            p.timestamp.difference(start).inMinutes.toDouble(),
            p.power.toDouble(),
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

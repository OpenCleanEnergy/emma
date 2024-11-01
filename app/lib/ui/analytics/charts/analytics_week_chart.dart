import 'dart:math' as math;

import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/analytics/analysis_view_model.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:openems/ui/analytics/charts/nice_scale.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/shared/translate.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsWeekChart extends StatelessWidget {
  static const _daysAWeek = 7;

  const AnalyticsWeekChart({
    super.key,
    required this.chartControlViewModel,
    required this.analysisViewModel,
  });

  final AnalyticsChartControlViewModel chartControlViewModel;
  final WeeklyAnalysisViewModel analysisViewModel;

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
      if (chartControlViewModel.showConsumption.value)
        ...analysisViewModel.consumers.value,
      if (chartControlViewModel.showProduction.value)
        ...analysisViewModel.producers.value,
      if (chartControlViewModel.showGridConsume.value)
        ...analysisViewModel.electricityMetersConsumption.value,
      if (chartControlViewModel.showGridFeedIn.value)
        ...analysisViewModel.electricityMetersFeedIn.value,
    ].map((x) => x.energy).fold(const WattHours(100.0), math.max);

    final niceScale = NiceScale.calculate(
      maxTicks: 10,
      min: 0,
      max: maxValue,
    );

    const timeAxisInterval = 1.0;
    return LineChartData(
      minY: niceScale.min,
      maxY: niceScale.max,
      minX: 0,
      maxX: _daysAWeek - 1,
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
            getTitlesWidget: (value, meta) => _buildTimeAxisTitleWidget(
                analysisViewModel.firstDayOfWeek.value, textTheme, value, meta),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: niceScale.tickInterval,
            getTitlesWidget: (value, meta) =>
                _buildEnergyAxisTitleWidget(textTheme, value, meta),
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
            firstDayOfWeek: analysisViewModel.firstDayOfWeek.value,
            data: analysisViewModel.producers.value,
            color: AnalyticsChartColors.production),
        _getLineChartData(
            show: chartControlViewModel.showConsumption.value,
            firstDayOfWeek: analysisViewModel.firstDayOfWeek.value,
            data: analysisViewModel.consumers.value,
            color: AnalyticsChartColors.consumption),
        _getLineChartData(
            show: chartControlViewModel.showGridConsume.value,
            firstDayOfWeek: analysisViewModel.firstDayOfWeek.value,
            data: analysisViewModel.electricityMetersConsumption.value,
            color: AnalyticsChartColors.gridConsumption),
        _getLineChartData(
            show: chartControlViewModel.showGridFeedIn.value,
            firstDayOfWeek: analysisViewModel.firstDayOfWeek.value,
            data: analysisViewModel.electricityMetersFeedIn.value,
            color: AnalyticsChartColors.gridFeedIn),
      ],
    );
  }

  static Widget _buildEnergyAxisTitleWidget(
      TextTheme theme, double value, TitleMeta meta) {
    final text = '${value.toInt()}${WattHours.unit}';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: theme.labelSmall),
    );
  }

  static Widget _buildTimeAxisTitleWidget(
      DayOfWeek firstDayOfWeek, TextTheme theme, double value, TitleMeta meta) {
    final dayOfWeek =
        DayOfWeek.values[((firstDayOfWeek.index - 1 + value.toInt()) % 7) + 1];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: -45,
      child: Text(Translate.dayOfWeek(dayOfWeek), style: theme.labelSmall),
    );
  }

  static LineChartBarData _getLineChartData({
    required bool show,
    required DayOfWeek firstDayOfWeek,
    required Iterable<WeeklyEnergyDataPointDto> data,
    required Color color,
  }) {
    var spots = data
        .map(
          (p) => FlSpot(
            ((p.dayOfWeek.index - firstDayOfWeek.index) % _daysAWeek)
                .toDouble(),
            p.energy.roundToDouble(),
          ),
        )
        .toList();

    return LineChartBarData(
      show: show,
      spots: spots,
      isCurved: true,
      preventCurveOverShooting: true,
      color: color,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.toBarAreaColor(),
      ),
    );
  }
}

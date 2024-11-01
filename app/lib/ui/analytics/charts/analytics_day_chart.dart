import 'dart:math' as math;

import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/analytics/analysis_view_model.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:openems/ui/analytics/charts/factories/line_chart_bar_data_factory.dart';
import 'package:openems/ui/analytics/charts/factories/line_chart_data_factory.dart';
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
    required this.analysisViewModel,
  });

  final AnalyticsChartControlViewModel chartControlViewModel;
  final DailyAnalysisViewModel analysisViewModel;

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
              (context) => LineChart(mainData(context)),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(BuildContext context) {
    final maxValue = [
      if (chartControlViewModel.showConsumption.value)
        ...analysisViewModel.consumers.value,
      if (chartControlViewModel.showProduction.value)
        ...analysisViewModel.producers.value,
      if (chartControlViewModel.showGridConsume.value)
        ...analysisViewModel.electricityMetersConsume.value,
      if (chartControlViewModel.showGridFeedIn.value)
        ...analysisViewModel.electricityMetersFeedIn.value,
    ].map((x) => x.power).fold(const Watt(100.0), math.max);

    final niceScale = NiceScale.calculate(
      maxTicks: 10,
      min: 0,
      max: maxValue,
    );

    const timeAxisInterval = 120.0;
    return LineChartDataFactory.create(
      context: context,
      yScale: niceScale,
      minX: 0,
      maxX: 24 * 60,
      intervalX: timeAxisInterval,
      leftTitleBuilder: _buildPowerAxisTitle,
      bottomTitleBuilder: _buildTimeAxisTitle,
      lineBarsData: [
        _getLineChartData(
            show: chartControlViewModel.showProduction.value,
            start: analysisViewModel.start.value,
            data: analysisViewModel.producers.value,
            color: AnalyticsChartColors.production),
        _getLineChartData(
            show: chartControlViewModel.showConsumption.value,
            start: analysisViewModel.start.value,
            data: analysisViewModel.consumers.value,
            color: AnalyticsChartColors.consumption),
        _getLineChartData(
            show: chartControlViewModel.showGridConsume.value,
            start: analysisViewModel.start.value,
            data: analysisViewModel.electricityMetersConsume.value,
            color: AnalyticsChartColors.gridConsumption),
        _getLineChartData(
            show: chartControlViewModel.showGridFeedIn.value,
            start: analysisViewModel.start.value,
            data: analysisViewModel.electricityMetersFeedIn.value,
            color: AnalyticsChartColors.gridFeedIn),
      ],
    );
  }

  static String _buildPowerAxisTitle(double value) {
    return '${value.toInt()}${Watt.unit}';
  }

  static String _buildTimeAxisTitle(double value) {
    final hours = _hoursFormat.format(value ~/ 60);
    final minutes = _minutesFormat.format(value % 60);

    return '$hours:$minutes';
  }

  static LineChartBarData _getLineChartData({
    required bool show,
    required DateTime start,
    required Iterable<PowerDataPointDto> data,
    required Color color,
  }) {
    var spots = data
        .map(
          (p) => FlSpot(
            p.timestamp.difference(start).inMinutes.toDouble(),
            p.power.roundToDouble(),
          ),
        )
        .toList();

    return LineChartBarDataFactory.create(
      show: show,
      color: color,
      spots: spots,
    );
  }
}

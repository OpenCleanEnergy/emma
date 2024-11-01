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
import 'package:openems/ui/shared/translate.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsWeekChart extends StatelessWidget {
  static const _daysAWeek = 7;
  static const _kilo = 1000;

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
        Text("Energieverlauf", style: Theme.of(context).textTheme.bodyLarge),
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
        ...analysisViewModel.electricityMetersConsumption.value,
      if (chartControlViewModel.showGridFeedIn.value)
        ...analysisViewModel.electricityMetersFeedIn.value,
    ].map((x) => x.energy).fold(const WattHours(_kilo), math.max);

    final niceScale = NiceScale.calculate(
      maxTicks: 10,
      min: 0,
      max: maxValue,
    );

    const timeAxisInterval = 1.0;
    return LineChartDataFactory.create(
      context: context,
      yScale: niceScale,
      minX: 0,
      maxX: _daysAWeek - 1,
      intervalX: timeAxisInterval,
      leftTitleBuilder: _buildEnergyAxisTitle,
      bottomTitleBuilder: (value) =>
          _buildTimeAxisTitle(analysisViewModel.firstDayOfWeek.value, value),
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

  static String _buildEnergyAxisTitle(double value) {
    return '${value / _kilo}k{WattHours.unit}';
  }

  static String _buildTimeAxisTitle(DayOfWeek firstDayOfWeek, double value) {
    final dayOfWeek =
        DayOfWeek.values[((firstDayOfWeek.index - 1 + value.toInt()) % 7) + 1];

    return Translate.dayOfWeek(dayOfWeek);
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

    return LineChartBarDataFactory.create(
      show: show,
      color: color,
      spots: spots,
    );
  }
}

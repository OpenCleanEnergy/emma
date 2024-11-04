import 'dart:math' as math;

import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/analytics/analysis_view_model.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:openems/ui/analytics/charts/factories.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/shared/translate.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsWeekChart extends StatelessWidget {
  static const _daysPerWeek = 7;
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
            child: Watch((context) => _buildLineChart(context)),
          ),
        ),
      ],
    );
  }

  LineChart _buildLineChart(BuildContext context) {
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

    final niceScale = Scale.nice(
      maxTicks: 10,
      min: 0,
      max: maxValue,
    );

    return LineChartFactory.create(
      context: context,
      yScale: niceScale,
      xScale: Scale(min: 0, max: _daysPerWeek - 1, tickInterval: 1),
      leftTitleBuilder: _buildEnergyAxisTitle,
      bottomTitleBuilder: (value) =>
          _buildTimeAxisTitle(analysisViewModel.firstDayOfWeek.value, value),
      unitOfMeasurement: WattHours.unit,
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

  static LeftSideTitleWidget _buildEnergyAxisTitle(double value) {
    final kWh = (value / _kilo).toStringAsFixed(1);
    return LeftSideTitleWidget(title: '${kWh}k${WattHours.unit}');
  }

  static BottomSideTitleWidget _buildTimeAxisTitle(
      DayOfWeek firstDayOfWeek, double value) {
    final dayOfWeek = _DayOfWeek.fromInt(
        (_DayOfWeek.toInt(firstDayOfWeek) + value.toInt()) % _daysPerWeek);

    return BottomSideTitleWidget.horizontal(
        title: Translate.dayOfWeek(dayOfWeek).substring(0, 2));
  }

  static LineChartBarData _getLineChartData({
    required bool show,
    required DayOfWeek firstDayOfWeek,
    required Iterable<WeeklyEnergyDataPointDto> data,
    required Color color,
  }) {
    var spots = data.map(
      (p) {
        final dayOfWeek =
            (_DayOfWeek.toInt(p.dayOfWeek) - _DayOfWeek.toInt(firstDayOfWeek)) %
                _daysPerWeek;

        return FlSpot(
          dayOfWeek.toDouble(),
          p.energy.toDouble(),
        );
      },
    ).toList();

    return LineChartBarDataFactory.create(
      show: show,
      color: color,
      spots: spots,
    );
  }
}

abstract final class _DayOfWeek {
  static int toInt(DayOfWeek dayOfWeek) {
    return switch (dayOfWeek) {
      DayOfWeek.swaggerGeneratedUnknown => -1,
      DayOfWeek.sunday => 0,
      DayOfWeek.monday => 1,
      DayOfWeek.tuesday => 2,
      DayOfWeek.wednesday => 3,
      DayOfWeek.thursday => 4,
      DayOfWeek.friday => 5,
      DayOfWeek.saturday => 6,
    };
  }

  static DayOfWeek fromInt(int dayOfWeek) {
    return switch (dayOfWeek) {
      0 => DayOfWeek.sunday,
      1 => DayOfWeek.monday,
      2 => DayOfWeek.tuesday,
      3 => DayOfWeek.wednesday,
      4 => DayOfWeek.thursday,
      5 => DayOfWeek.friday,
      6 => DayOfWeek.saturday,
      _ => DayOfWeek.swaggerGeneratedUnknown,
    };
  }
}

import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/analytics/analysis_view_model.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:openems/ui/analytics/charts/factories.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsYearChart extends StatelessWidget {
  static const _kilo = 1000;

  const AnalyticsYearChart({
    super.key,
    required this.chartControlViewModel,
    required this.analysisViewModel,
  });

  final AnalyticsChartControlViewModel chartControlViewModel;
  final AnnualAnalysisViewModel analysisViewModel;

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

    final yScale = Scale.nice(
      maxTicks: 10,
      min: 0,
      max: maxValue,
    );

    return LineChartFactory.create(
      context: context,
      yScale: yScale,
      xScale: Scale(min: 1, max: 12, tickInterval: 1),
      leftTitleBuilder: _buildEnergyAxisTitle,
      bottomTitleBuilder: _buildTimeAxisTitle,
      unitOfMeasurement: WattHours.unit,
      lineBarsData: [
        _getLineChartData(
            show: chartControlViewModel.showProduction.value,
            data: analysisViewModel.producers.value,
            color: AnalyticsChartColors.production),
        _getLineChartData(
            show: chartControlViewModel.showConsumption.value,
            data: analysisViewModel.consumers.value,
            color: AnalyticsChartColors.consumption),
        _getLineChartData(
            show: chartControlViewModel.showGridConsume.value,
            data: analysisViewModel.electricityMetersConsumption.value,
            color: AnalyticsChartColors.gridConsumption),
        _getLineChartData(
            show: chartControlViewModel.showGridFeedIn.value,
            data: analysisViewModel.electricityMetersFeedIn.value,
            color: AnalyticsChartColors.gridFeedIn),
      ],
    );
  }

  static LeftSideTitleWidget _buildEnergyAxisTitle(double value) {
    final kWh = (value / _kilo).toStringAsFixed(1);
    return LeftSideTitleWidget(title: '${kWh}k${WattHours.unit}');
  }

  static BottomSideTitleWidget _buildTimeAxisTitle(double value) {
    return BottomSideTitleWidget.horizontal(title: value.toInt().toString());
  }

  static LineChartBarData _getLineChartData({
    required bool show,
    required Iterable<AnnualEnergyDataPointDto> data,
    required Color color,
  }) {
    var spots = data
        .map((p) => FlSpot(p.month.toDouble(), p.energy.toDouble()))
        .toList();

    return LineChartBarDataFactory.create(
      show: show,
      color: color,
      spots: spots,
    );
  }
}

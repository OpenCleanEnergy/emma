import 'package:openems/ui/analytics/analytics_period.dart';
import 'package:openems/ui/analytics/analytics_view_model.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_color_scheme.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_container.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control.dart';
import 'package:openems/ui/analytics/charts/analytics_day_chart.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsChart extends StatelessWidget {
  const AnalyticsChart({super.key, required this.viewModel});

  final AnalyticsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnalyticsChartContainer(
          child: Watch(
            (context) => switch (viewModel.period.value) {
              AnalyticsPeriod.day => AnalyticsDayChart(viewModel: viewModel),
              _ => _ComingSoonChart(),
            },
          ),
        ),
        const SizedBox(height: 16),
        AnalyticsChartControl(viewModel: viewModel.chartControl),
      ],
    );
  }
}

class _ComingSoonChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = AnalyticsChartColorScheme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colorScheme.border)),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: const Center(
        child: Text("Bald verfügbar."),
      ),
    );
  }
}

import 'package:emma/ui/analytics/analytics_view_model.dart';
import 'package:emma/ui/analytics/charts/analytics_chart_control.dart';
import 'package:emma/ui/analytics/charts/analytics_day_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsChart extends StatelessWidget {
  const AnalyticsChart({super.key, required this.viewModel});

  final AnalyticsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 16,
        bottom: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnalyticsDayChart(viewModel: viewModel),
          const SizedBox(height: 8),
          AnalyticsChartControl(viewModel: viewModel)
        ],
      ),
    );
  }
}

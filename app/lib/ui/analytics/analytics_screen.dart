import 'package:emma/ui/analytics/analytics_range_picker.dart';
import 'package:emma/ui/analytics/analytics_view_model.dart';
import 'package:emma/ui/analytics/charts/analytics_chart.dart';
import 'package:emma/ui/analytics/metrics/analytics_metrics_container.dart';
import 'package:flutter/material.dart';

// AutomaticKeepAliveClientMixin to keep alive
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final _vm = AnalyticsViewModel();

  @override
  Widget build(BuildContext context) {
    return Banner(
      message: "DEMO",
      location: BannerLocation.topEnd,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: AnalyticsRangePicker(viewModel: _vm),
            ),
            const SizedBox(height: 32),
            const AnalyticsMetricsContainer(),
            const SizedBox(height: 32),
            AnalyticsChart(viewModel: _vm),
          ],
        ),
      ),
    );
  }
}

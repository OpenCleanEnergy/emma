import 'package:openems/ui/analytics/analytics_range_picker.dart';
import 'package:openems/ui/analytics/analytics_view_model.dart';
import 'package:openems/ui/analytics/charts/analytics_chart.dart';
import 'package:openems/ui/analytics/metrics/analytics_metrics_container.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';

// AutomaticKeepAliveClientMixin to keep alive
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  late final AnalyticsViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = locator.get<AnalyticsViewModel>();
    _vm.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: AnalyticsRangePicker(viewModel: _vm),
              ),
              AppBarCommandProgressIndicator(command: _vm.fetch),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 16),
          AnalyticsMetricsContainer(viewModel: _vm.metrics),
          const SizedBox(height: 32),
          AnalyticsChart(viewModel: _vm),
        ],
      ),
    );
  }
}

import 'package:openems/ui/analytics/metrics/analytics_metrics_view_model.dart';
import 'package:openems/ui/analytics/metrics/own_consumption_metric_view.dart';
import 'package:openems/ui/analytics/metrics/self_sufficiency_metric_view.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsMetricsContainer extends StatelessWidget {
  static const _minWidthOfSingleMetric = 320;
  const AnalyticsMetricsContainer({
    super.key,
    required this.viewModel,
  });

  final AnalyticsMetricsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Watch((context) => _buildMetrics(size));
  }

  Widget _buildMetrics(Size size) {
    if (size.width > _minWidthOfSingleMetric * 2) {
      return Row(
        children: [
          Expanded(
            child:
                SelfSufficiencyMetricView(dto: viewModel.selfSufficiency.value),
          ),
          Expanded(
            child:
                OwnConsumptionMetricView(dto: viewModel.ownConsumption.value),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SelfSufficiencyMetricView(dto: viewModel.selfSufficiency.value),
          OwnConsumptionMetricView(dto: viewModel.ownConsumption.value),
        ],
      );
    }
  }
}

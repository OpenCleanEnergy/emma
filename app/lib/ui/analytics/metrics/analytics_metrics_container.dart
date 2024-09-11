import 'package:openems/ui/analytics/metrics/own_consumption_metric_view.dart';
import 'package:openems/ui/analytics/metrics/self_sufficiency_metric_view.dart';
import 'package:flutter/material.dart';

class AnalyticsMetricsContainer extends StatelessWidget {
  static const _minWidthOfSingleMetric = 320;
  const AnalyticsMetricsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width > _minWidthOfSingleMetric * 2) {
      return const Row(
        children: [
          Expanded(child: SelfSufficiencyMetricView()),
          Expanded(child: OwnConsumptionMetricView()),
        ],
      );
    } else {
      return const Column(
        children: [
          SelfSufficiencyMetricView(),
          OwnConsumptionMetricView(),
        ],
      );
    }
  }
}

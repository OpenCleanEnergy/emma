import 'package:emma/ui/analytics/charts/analytics_day_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsChart extends StatelessWidget {
  const AnalyticsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Leistungsverlauf", style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        const AspectRatio(
          aspectRatio: 1.3,
          child: Padding(
            padding: EdgeInsets.only(
              right: 16,
              bottom: 16,
            ),
            child: AnalyticsDayChart(),
          ),
        ),
      ],
    );
  }
}

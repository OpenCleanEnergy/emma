import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

final class LeftSideTitleWidget extends StatelessWidget {
  final String title;

  const LeftSideTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      axisSide: AxisSide.left,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

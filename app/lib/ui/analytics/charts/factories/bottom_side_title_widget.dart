import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

final class BottomSideTitleWidget extends StatelessWidget {
  const BottomSideTitleWidget.diagonal({
    super.key,
    required this.title,
  }) : angle = -45;

  const BottomSideTitleWidget.horizontal({
    super.key,
    required this.title,
  }) : angle = 0;

  final String title;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      angle: angle,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}

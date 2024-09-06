import 'package:emma/ui/shared/circular_value_indicator.dart';
import 'package:emma/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';

class AnalyticsCircularPercentageIndicator extends StatelessWidget {
  const AnalyticsCircularPercentageIndicator._({
    required this.percentage,
    required this.size,
    this.strokeWidth,
    required this.child,
  });

  factory AnalyticsCircularPercentageIndicator.small(
      {required double percentage}) {
    return AnalyticsCircularPercentageIndicator._(
      percentage: percentage,
      size: 32,
      child: null,
    );
  }

  factory AnalyticsCircularPercentageIndicator.detailed(
      {required double percentage}) {
    return AnalyticsCircularPercentageIndicator._(
        percentage: percentage,
        size: 64,
        child: UnitText.percentage(percentage));
  }

  final double percentage;
  final double size;
  final double? strokeWidth;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircularValueIndicator(
      value: percentage,
      size: size,
      strokeWidth: strokeWidth,
      child: child,
    );
  }
}

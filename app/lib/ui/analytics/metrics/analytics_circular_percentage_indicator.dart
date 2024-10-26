import 'package:openems/application/backend_api/value_objects.dart';
import 'package:openems/ui/shared/circular_value_indicator.dart';
import 'package:openems/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';

class AnalyticsCircularPercentageIndicator extends StatelessWidget {
  const AnalyticsCircularPercentageIndicator._({
    required this.percentage,
    required this.size,
    required this.child,
  });

  factory AnalyticsCircularPercentageIndicator.small(
      {required Percentage percentage}) {
    return AnalyticsCircularPercentageIndicator._(
      percentage: percentage,
      size: 32,
      child: null,
    );
  }

  factory AnalyticsCircularPercentageIndicator.detailed(
      {required Percentage percentage}) {
    return AnalyticsCircularPercentageIndicator._(
        percentage: percentage,
        size: 64,
        child: UnitText.percentage(percentage));
  }

  final Percentage percentage;
  final double size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircularValueIndicator(
      value: percentage,
      size: size,
      child: child,
    );
  }
}

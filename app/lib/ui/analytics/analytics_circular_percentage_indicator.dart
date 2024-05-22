import 'package:emma/ui/analytics/dual_circular_progress_indicator.dart';
import 'package:emma/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';

class AnalyticsCircularPercentageIndicator extends StatelessWidget {
  static const double _indicatorSize = 96;

  const AnalyticsCircularPercentageIndicator({
    super.key,
    required this.percentage,
    this.maximalPossiblePercentage,
  });

  final double percentage;
  final double? maximalPossiblePercentage;

  @override
  Widget build(BuildContext context) {
    var texts = <Widget>[UnitText.percentage(percentage)];

    if (maximalPossiblePercentage != null) {
      texts = [
        ...texts,
        Text.rich(TextSpan(text: "max. ", children: [
          UnitText.percentageSpan(context, maximalPossiblePercentage!)
        ]))
      ];
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: _indicatorSize,
          width: _indicatorSize,
          child: DualCircularProgressIndicator(
            primaryValue: percentage,
            secondaryValue: maximalPossiblePercentage ?? 0,
            strokeWidth: 8,
          ),
        ),
        Column(
          children: texts,
        ),
      ],
    );
  }
}

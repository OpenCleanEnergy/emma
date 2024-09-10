import 'dart:math';

import 'package:flutter/material.dart';

class AnalyticsChartContainer extends StatelessWidget {
  // Aspect ratio = width / height
  static const _aspectRatio = 1.333;
  static const _maxHeight = 360;

  const AnalyticsChartContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: buildLayout);
  }

  Widget buildLayout(BuildContext context, BoxConstraints constraints) {
    assert(
      constraints.maxWidth.isFinite,
      () => "Only works with finite width for $runtimeType.",
    );

    final width = constraints.maxWidth;
    final height = min(_maxHeight, width / _aspectRatio).toDouble();
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }
}

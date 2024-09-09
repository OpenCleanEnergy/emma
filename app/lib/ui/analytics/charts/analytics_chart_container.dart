import 'dart:math';

import 'package:flutter/material.dart';

class AnalyticsChartContainer extends StatelessWidget {
  const AnalyticsChartContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
        delegate: _AnalyticsChartContainerLayoutDelegate(), child: child);
  }
}

class _AnalyticsChartContainerLayoutDelegate extends SingleChildLayoutDelegate {
  // Aspect ratio = width / height
  static const aspectRatio = 1.333;
  static const maxHeight = 360;

  Size _size = Size.zero;

  @override
  Size getSize(BoxConstraints constraints) {
    assert(
      constraints.maxWidth.isFinite,
      () => "Only works with finite width for $runtimeType.",
    );

    final width = constraints.maxWidth;
    final height = min(maxHeight, width / aspectRatio).toDouble();
    return _size = Size(width, height);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.tight(_size);
  }

  @override
  bool shouldRelayout(
      covariant _AnalyticsChartContainerLayoutDelegate oldDelegate) {
    return false;
  }
}

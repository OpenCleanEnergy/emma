import 'package:flutter/material.dart';

class DualCircularProgressIndicator extends StatelessWidget {
  const DualCircularProgressIndicator({
    super.key,
    this.primaryValue,
    this.secondaryValue,
    this.strokeWidth = 4.0,
  });

  final double? primaryValue;
  final double? secondaryValue;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      children: [
        CircularProgressIndicator(
          value: secondaryValue,
          valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.inversePrimary),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          strokeWidth: strokeWidth,
        ),
        CircularProgressIndicator(
          value: primaryValue,
          backgroundColor: Colors.transparent,
          strokeWidth: strokeWidth,
        ),
      ],
    );
  }
}

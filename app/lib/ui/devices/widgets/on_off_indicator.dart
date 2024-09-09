import 'package:emma/ui/shared/circular_value_indicator.dart';
import 'package:flutter/material.dart';

class OnOffIndicator extends StatelessWidget {
  const OnOffIndicator({required this.status, super.key});

  final bool status;
  get _flipX => !status;

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: _flipX,
      child: CircularValueIndicator(
        value: status ? 1 : 0,
        previousValue: status ? 0 : 1,
        size: 24,
        strokeWidth: 4,
      ),
    );
  }
}

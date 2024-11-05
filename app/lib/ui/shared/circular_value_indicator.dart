import 'package:flutter/material.dart';

class CircularValueIndicator extends StatelessWidget {
  static const _defaultSize = 36.0;
  static const _defaultStrokeWidth = 4.0;

  const CircularValueIndicator({
    super.key,
    required num value,
    double size = _defaultSize,
    double? strokeWidth,
    Widget? child,
  })  : _value = value,
        _size = size,
        _strokeWidth = strokeWidth ?? _defaultStrokeWidth / _defaultSize * size,
        _child = child;

  final num _value;
  final double _size;
  final double _strokeWidth;
  final Widget? _child;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).colorScheme.secondaryContainer;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: _size,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: 0.0,
              end: _value.toDouble(),
            ),
            duration: Durations.medium4,
            curve: Curves.easeInOut,
            builder: (context, value, _) => CircularProgressIndicator(
              value: value,
              strokeWidth: _strokeWidth,
              backgroundColor: backgroundColor,
            ),
          ),
        ),
        if (_child != null) _child,
      ],
    );
  }
}

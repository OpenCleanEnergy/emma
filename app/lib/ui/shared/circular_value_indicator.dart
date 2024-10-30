import 'package:flutter/material.dart';

class CircularValueIndicator extends StatelessWidget {
  static const _defaultSize = 36.0;
  static const _defaultStrokeWidth = 4.0;

  CircularValueIndicator({
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

  late final _tween = Tween<double>(
    begin: 0.0,
    end: _value.toDouble(),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.square(
          dimension: _size,
          child: TweenAnimationBuilder<double>(
            tween: _tween,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            builder: (context, value, _) => CircularProgressIndicator(
              value: value,
              strokeWidth: _strokeWidth,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        ),
        if (_child != null) _child,
      ],
    );
  }
}

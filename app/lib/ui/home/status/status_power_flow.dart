import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class StatusPowerFlow extends StatelessWidget {
  static const double _spacing = 16;
  static const Duration _duration = Duration(seconds: 2);

  static final _offsetProperty = MovieTweenProperty<double>();
  static final _opacityProperty = MovieTweenProperty<double>();
  static final _tween = MovieTween()
    ..scene(duration: _duration, curve: Curves.easeInOutCubic)
        .tween(
            _offsetProperty, Tween(begin: -0.5 * _spacing, end: 0.5 * _spacing))
        .tween(_opacityProperty, Tween(begin: 0.0, end: 1.0));

  const StatusPowerFlow({super.key, required this.direction});

  final StatusPowerFlowDirection direction;

  @override
  Widget build(BuildContext context) {
    final iconSize = 48.0;

    final inner = switch (direction) {
      StatusPowerFlowDirection.none => Transform.rotate(
          angle: pi / 2,
          child: Icon(
            Icons.remove,
            size: iconSize,
          )),
      _ => LoopAnimationBuilder(
          duration: _duration,
          tween: _tween,
          builder: (context, value, child) {
            return Stack(
              children: [
                Transform.translate(
                    offset: Offset(0, value.get(_offsetProperty) - _spacing),
                    child: Opacity(
                      opacity: value.get(_opacityProperty),
                      child: child,
                    )),
                Transform.translate(
                  offset: Offset(0, value.get(_offsetProperty)),
                  child: child,
                ),
                Transform.translate(
                  offset: Offset(0, value.get(_offsetProperty) + _spacing),
                  child: Opacity(
                    opacity: 1.0 - value.get(_opacityProperty),
                    child: child,
                  ),
                )
              ],
            );
          },
          child: Transform.rotate(
              angle: pi / 2,
              child: Icon(
                Icons.chevron_right_rounded,
                size: iconSize,
              )),
        ),
    };

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: switch (direction) {
          StatusPowerFlowDirection.none => inner,
          StatusPowerFlowDirection.down => inner,
          StatusPowerFlowDirection.up =>
            Transform.rotate(angle: pi, child: inner),
        });
  }
}

enum StatusPowerFlowDirection {
  none,
  down,
  up,
}

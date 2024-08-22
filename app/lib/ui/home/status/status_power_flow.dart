import 'dart:math' as math;

import 'package:flutter/material.dart';

class StatusPowerFlow extends StatelessWidget {
  static const _spacing = 16.0;

  static final _opacityTween = Tween<double>(
    begin: 0.0,
    end: 1.0,
  );

  static final _offsetTween = Tween(
    begin: -0.5 * _spacing,
    end: 0.5 * _spacing,
  );

  final Animation<double> _opacity;
  final Animation<double> _offset;
  final double _radian;

  StatusPowerFlow({
    super.key,
    required this.controller,
    required this.direction,
  })  : _opacity = _opacityTween.animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _offset = _offsetTween.animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _radian = switch (direction) {
          StatusPowerFlowDirection.none => 0,
          StatusPowerFlowDirection.down => math.pi * 0.5,
          StatusPowerFlowDirection.up => math.pi * 1.5,
        };

  final AnimationController controller;
  final StatusPowerFlowDirection direction;

  @override
  Widget build(BuildContext context) {
    const iconSize = 48.0;

    final inner = switch (direction) {
      StatusPowerFlowDirection.none => RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.remove,
            size: iconSize,
          ),
        ),
      _ => AnimatedBuilder(
          animation: controller,
          builder: _buildAnimation,
          child: Transform.rotate(
            angle: _radian,
            child: Icon(
              Icons.chevron_right_rounded,
              size: iconSize,
            ),
          ),
        )
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: inner,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    assert(child != null);

    final fadeIn = Transform.translate(
        offset: Offset.fromDirection(_radian * -1, _spacing),
        child: Opacity(
          opacity: _opacity.value,
          child: child,
        ));

    final fadeOut = Transform.translate(
      offset: Offset.fromDirection(_radian, _spacing),
      child: Opacity(
        opacity: 1.0 - _opacity.value,
        child: child,
      ),
    );

    return Transform.translate(
        offset: Offset.fromDirection(_radian, _offset.value),
        child: Stack(
          children: [
            fadeOut,
            fadeIn,
            child!,
          ],
        ));
  }
}

enum StatusPowerFlowDirection {
  none,
  down,
  up,
}

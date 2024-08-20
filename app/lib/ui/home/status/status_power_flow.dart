import 'package:flutter/material.dart';

class StatusPowerFlow extends StatelessWidget {
  static const double _spacing = 16;

  final Animation<double> _opacity;
  final Animation<double> _offset;

  StatusPowerFlow({
    super.key,
    required this.controller,
    required this.direction,
  })  : _opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _offset = Tween(
          begin: -0.5 * _spacing,
          end: 0.5 * _spacing,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ));

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
          child: RotatedBox(
            quarterTurns: switch (direction) {
              StatusPowerFlowDirection.none => 0,
              StatusPowerFlowDirection.down => 1,
              StatusPowerFlowDirection.up => 3,
            },
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
    final directionFactor = switch (direction) {
      StatusPowerFlowDirection.none => 0.0,
      StatusPowerFlowDirection.down => 1.0,
      StatusPowerFlowDirection.up => -1.0,
    };

    final fadeIn = Transform.translate(
        offset: Offset(0, -1 * directionFactor * _spacing),
        child: Opacity(
          opacity: _opacity.value,
          child: child,
        ));

    final fadeOut = Transform.translate(
      offset: Offset(0, directionFactor * _spacing),
      child: Opacity(
        opacity: 1.0 - _opacity.value,
        child: child,
      ),
    );

    return Transform.translate(
        offset: Offset(0, directionFactor * _offset.value),
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

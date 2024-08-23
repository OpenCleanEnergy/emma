import 'dart:math' as math;

import 'package:emma/ui/app_icons.dart';
import 'package:flutter/material.dart';

class StatusPowerFlow extends StatelessWidget {
  static const _iconSize = 48.0;
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
    this.type = StatusPowerFlowType.neutral,
  })  : _opacity = _opacityTween.animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _offset = _offsetTween.animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        )),
        _radian = switch (direction) {
          StatusPowerFlowDirection.noneHorizontal => 0,
          StatusPowerFlowDirection.noneVertical => math.pi * 0.5,
          StatusPowerFlowDirection.right => 0,
          StatusPowerFlowDirection.down => math.pi * 0.5,
          StatusPowerFlowDirection.left => math.pi * 1.0,
          StatusPowerFlowDirection.up => math.pi * 1.5,
        };

  final AnimationController controller;
  final StatusPowerFlowDirection direction;
  final StatusPowerFlowType type;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = switch (type) {
      StatusPowerFlowType.neutral => null,
      StatusPowerFlowType.good => theme.colorScheme.primary,
      StatusPowerFlowType.bad => theme.colorScheme.error,
    };

    final inner = switch (direction) {
      StatusPowerFlowDirection.noneVertical ||
      StatusPowerFlowDirection.noneHorizontal =>
        Transform.rotate(
          angle: _radian,
          child: Icon(
            Icons.remove,
            size: _iconSize,
            color: color,
          ),
        ),
      _ => AnimatedBuilder(
          animation: controller,
          builder: _buildAnimation,
          child: Transform.rotate(
            angle: _radian,
            child: Icon(
              AppIcons.arrow_flow_right,
              size: _iconSize,
              color: color,
            ),
          ),
        )
    };

    return Padding(
      padding: const EdgeInsets.all(12),
      child: inner,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? child) {
    assert(child != null);

    final fadeIn = Transform.translate(
        offset: Offset.fromDirection(_radian + math.pi, _spacing),
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
  noneHorizontal,
  noneVertical,
  right,
  down,
  left,
  up,
}

extension StatusPowerFlowDirectionExtensions on StatusPowerFlowDirection {
  StatusPowerFlowDirection toLandscape() {
    return switch (this) {
      StatusPowerFlowDirection.noneHorizontal =>
        StatusPowerFlowDirection.noneHorizontal,
      StatusPowerFlowDirection.noneVertical =>
        StatusPowerFlowDirection.noneHorizontal,
      StatusPowerFlowDirection.right => StatusPowerFlowDirection.right,
      StatusPowerFlowDirection.down => StatusPowerFlowDirection.right,
      StatusPowerFlowDirection.left => StatusPowerFlowDirection.left,
      StatusPowerFlowDirection.up => StatusPowerFlowDirection.left,
    };
  }
}

enum StatusPowerFlowType {
  neutral,
  good,
  bad,
}

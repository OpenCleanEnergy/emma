import 'package:openems/ui/shared/circular_value_indicator.dart';
import 'package:openems/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class StatusIndicator extends StatefulWidget {
  const StatusIndicator({
    super.key,
    required this.icon,
    required this.value,
    required this.unit,
    this.maxValue,
  });

  final ReadonlySignal<IconData> icon;
  final ReadonlySignal<double> value;
  final ReadonlySignal<double>? maxValue;
  final String unit;

  @override
  State<StatusIndicator> createState() => _StatusIndicatorState();
}

class _StatusIndicatorState extends State<StatusIndicator> {
  static const double _indicatorSize = 96;
  static const double _iconSize = 32;

  late final _indicatorValue = computed(
    () {
      final value = widget.value.value.round();
      final maxValue = widget.maxValue?.value.round() ?? 0;

      if (value == 0) {
        return 0.0;
      } else if (maxValue == 0) {
        return 1.0;
      } else if (maxValue < value) {
        return 1.0;
      }

      final fraction = value / maxValue;
      // Round to 2 decimal places
      final rounded = (fraction * 100).round() / 100;

      // As long as the value is greater than 0,
      // the rounded value should be at least 0.01
      return value > 0 && rounded == 0 ? 0.01 : rounded;
    },
    debugLabel: "statusIndicator.indicatorValue",
  );

  @override
  void dispose() {
    _indicatorValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => CircularValueIndicator(
        value: _indicatorValue.value,
        previousValue: _indicatorValue.previousValue ?? 0,
        size: _indicatorSize,
        strokeWidth: 8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 2),
            Icon(widget.icon.value, size: _iconSize),
            const SizedBox(height: 4),
            Transform.scale(
              scale: 1.125,
              child: UnitText(widget.value.value, widget.unit),
            ),
          ],
        ),
      ),
    );
  }
}

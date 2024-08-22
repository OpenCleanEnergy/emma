import 'package:emma/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class StatusIndicator extends StatelessWidget {
  static const double _indicatorSize = 96;
  static const double _iconSize = 32;

  StatusIndicator({
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

  late final _indicatorValue = computed(() {
    if (value.value == 0) {
      return 0;
    } else if (maxValue == null || maxValue!.value == 0) {
      return 1;
    } else if (maxValue!.value < value.value) {
      return 1;
    } else {
      return value.value / maxValue!.value;
    }
  });

  late final _tween = computed(() => Tween<double>(
        begin: _indicatorValue.previousValue?.toDouble() ?? 0.0,
        end: _indicatorValue.value.toDouble(),
      ));

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Watch((context) => Icon(icon.value, size: _iconSize)),
            Watch((context) => UnitText(value.value, unit)),
          ],
        ),
        SizedBox.square(
          dimension: _indicatorSize,
          child: Watch(
            (context) => TweenAnimationBuilder<double>(
              tween: _tween.value,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (context, value, _) => CircularProgressIndicator(
                value: value,
                strokeWidth: 8,
                backgroundColor:
                    Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ),
        )
      ],
    );
  }
}

enum StatusIndicatorDirection { none, up, down }

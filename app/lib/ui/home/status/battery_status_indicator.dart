import 'package:openems/ui/app_icons.dart';
import 'package:openems/ui/home/home_view_model.dart';
import 'package:openems/ui/home/status/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class BatteryStatusIndicator extends StatelessWidget {
  static const double _maxValue = 100;
  BatteryStatusIndicator({super.key, required this.viewModel});

  final BatteryStatusViewModel viewModel;

  late final _icon = computed(
    _getBatteryIcon,
    debugLabel: "batteryStatusIndicator.icon",
  );

  @override
  Widget build(BuildContext context) {
    return StatusIndicator(
      icon: _icon,
      value: viewModel.charge,
      maxValue: signal(_maxValue),
      unit: "%",
    );
  }

  IconData _getBatteryIcon() {
    const icons = [
      AppIcons.battery_empty,
      AppIcons.battery_1_bar,
      AppIcons.battery_2_bar,
      AppIcons.battery_3_bar,
      AppIcons.battery_full,
    ];

    final value = viewModel.charge.value / _maxValue;
    final index = (value * (icons.length - 1)).round();
    return icons[index];
  }
}

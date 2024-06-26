import 'package:emma/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/status/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class BatteryStatusIndicator extends StatelessWidget {
  static const double _maxValue = 100;
  BatteryStatusIndicator({super.key, required this.viewModel});

  final BatteryStatusViewModel viewModel;

  late final _icon = computed(_getBatteryIcon);
  late final _direction = computed(_getDirection);

  @override
  Widget build(BuildContext context) {
    return StatusIndicator(
      icon: _icon,
      value: viewModel.charge,
      maxValue: signal(_maxValue),
      unit: "%",
      direction: _direction,
    );
  }

  IconData _getBatteryIcon() {
    const icons = [
      AppIcons.battery_0_bar,
      AppIcons.battery_1_bar,
      AppIcons.battery_2_bar,
      AppIcons.battery_3_bar,
      AppIcons.battery_4_bar,
      AppIcons.battery_5_bar,
      AppIcons.battery_6_bar,
      AppIcons.battery_full,
    ];

    final value = viewModel.charge.value / _maxValue;
    final index = (value * (icons.length - 1)).round();
    return icons[index];
  }

  StatusIndicatorDirection _getDirection() {
    return switch (viewModel.chargeStatus.value) {
      BatteryChargeStatus.swaggerGeneratedUnknown =>
        StatusIndicatorDirection.none,
      BatteryChargeStatus.idle => StatusIndicatorDirection.none,
      BatteryChargeStatus.charging => StatusIndicatorDirection.up,
      BatteryChargeStatus.discharging => StatusIndicatorDirection.down
    };
  }
}

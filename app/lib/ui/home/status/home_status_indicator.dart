import 'package:openems/application/backend_api/value_objects.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/home/home_view_model.dart';
import 'package:openems/ui/home/status/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomeStatusIndicator extends StatelessWidget {
  const HomeStatusIndicator({super.key, required this.viewModel});
  final ConsumerStatusViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return StatusIndicator(
      icon: signal(AppIcons.home),
      value: viewModel.currentPowerConsumption,
      maxValue: viewModel.maximumPowerConsumption,
      unit: Watt.unit,
    );
  }
}

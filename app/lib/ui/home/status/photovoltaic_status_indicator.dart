import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/home/home_view_model.dart';
import 'package:openems/ui/home/status/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class PhotovoltaicStatusIndicator extends StatelessWidget {
  const PhotovoltaicStatusIndicator({super.key, required this.viewModel});

  final ProducerStatusViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return StatusIndicator(
      icon: signal(AppIcons.solar_power),
      value: viewModel.currentPowerProduction,
      maxValue: viewModel.maximumPowerProduction,
      unit: "W",
    );
  }
}

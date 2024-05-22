import 'package:emma/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/status/status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class GridStatusIndicator extends StatelessWidget {
  GridStatusIndicator({super.key, required this.viewModel});

  final GridStatusViewModel viewModel;

  late final _direction = computed(() {
    return switch (viewModel.currentPowerDirection.value) {
      GridPowerDirection.swaggerGeneratedUnknown =>
        StatusIndicatorDirection.none,
      GridPowerDirection.none => StatusIndicatorDirection.none,
      GridPowerDirection.consume => StatusIndicatorDirection.down,
      GridPowerDirection.feedin => StatusIndicatorDirection.up,
    };
  });

  late final _maximumPower = computed(() => switch (_direction.value) {
        StatusIndicatorDirection.none => 1.0,
        // Import
        StatusIndicatorDirection.up => viewModel.maximumPowerFeedIn.value,
        // Export
        StatusIndicatorDirection.down =>
          viewModel.maximumPowerConsumption.value,
      });

  @override
  Widget build(BuildContext context) {
    return StatusIndicator(
      icon: signal(AppIcons.transmission_tower),
      value: viewModel.currentPower,
      maxValue: _maximumPower,
      unit: "W",
      direction: _direction,
    );
  }
}

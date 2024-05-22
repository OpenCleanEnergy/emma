import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/status/battery_status_indicator.dart';
import 'package:emma/ui/home/status/grid_status_indicator.dart';
import 'package:emma/ui/home/status/home_status_indicator.dart';
import 'package:emma/ui/home/status/photovoltaic_status_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomeStatusView extends StatelessWidget {
  const HomeStatusView({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => Wrap(
        spacing: 24,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children: [
          if (viewModel.batteryStatus.isAvailable.value)
            BatteryStatusIndicator(viewModel: viewModel.batteryStatus),
          if (viewModel.gridStatus.isAvailable.value)
            GridStatusIndicator(viewModel: viewModel.gridStatus),
          if (viewModel.consumerStatus.isAvailable.value)
            HomeStatusIndicator(viewModel: viewModel.consumerStatus),
          if (viewModel.producerStatus.isAvailable.value)
            PhotovoltaicStatusIndicator(viewModel: viewModel.producerStatus)
        ],
      ),
    );
  }
}

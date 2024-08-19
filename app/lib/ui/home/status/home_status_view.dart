import 'package:emma/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/status/grid_status_indicator.dart';
import 'package:emma/ui/home/status/home_status_indicator.dart';
import 'package:emma/ui/home/status/photovoltaic_status_indicator.dart';
import 'package:emma/ui/home/status/status_power_flow.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomeStatusView extends StatelessWidget {
  HomeStatusView({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  // Avoid redraw of flow on each value change.
  late final _producerFlowDirection = computed(() {
    return viewModel.producerStatus.currentPowerProduction.value > 0
        ? StatusPowerFlowDirection.down
        : StatusPowerFlowDirection.none;
  });

  late final _gridFlowDirection = computed(() {
    return switch (viewModel.gridStatus.currentPowerDirection.value) {
      GridPowerDirection.swaggerGeneratedUnknown =>
        StatusPowerFlowDirection.none,
      GridPowerDirection.none => StatusPowerFlowDirection.none,
      GridPowerDirection.consume => StatusPowerFlowDirection.up,
      GridPowerDirection.feedin => StatusPowerFlowDirection.down,
    };
  });

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (viewModel.producerStatus.isAvailable.value) ...[
            PhotovoltaicStatusIndicator(viewModel: viewModel.producerStatus),
            StatusPowerFlow(
              direction: _producerFlowDirection.value,
            )
          ],
          HomeStatusIndicator(viewModel: viewModel.consumerStatus),
          if (viewModel.gridStatus.isAvailable.value) ...[
            StatusPowerFlow(
              direction: _gridFlowDirection.value,
            ),
            GridStatusIndicator(viewModel: viewModel.gridStatus),
          ]
        ],
      ),
    );
  }
}

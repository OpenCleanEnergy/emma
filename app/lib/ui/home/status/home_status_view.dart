import 'package:emma/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/status/grid_status_indicator.dart';
import 'package:emma/ui/home/status/home_status_indicator.dart';
import 'package:emma/ui/home/status/photovoltaic_status_indicator.dart';
import 'package:emma/ui/home/status/status_power_flow.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomeStatusView extends StatefulWidget {
  const HomeStatusView({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  State<HomeStatusView> createState() => _HomeStatusViewState();
}

class _HomeStatusViewState extends State<HomeStatusView>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  // Avoid redraw of flow on each value change.
  late final _producerFlowDirection = computed(() {
    return widget.viewModel.producerStatus.currentPowerProduction.value > 0
        ? StatusPowerFlowDirection.down
        : StatusPowerFlowDirection.none;
  });

  late final _producerFlowType = computed(() {
    return widget.viewModel.producerStatus.currentPowerProduction.value > 0
        ? StatusPowerFlowType.good
        : StatusPowerFlowType.bad;
  });

  late final _gridFlowDirection = computed(() {
    return switch (widget.viewModel.gridStatus.currentPowerDirection.value) {
      GridPowerDirection.swaggerGeneratedUnknown =>
        StatusPowerFlowDirection.none,
      GridPowerDirection.none => StatusPowerFlowDirection.none,
      GridPowerDirection.consume => StatusPowerFlowDirection.up,
      GridPowerDirection.feedin => StatusPowerFlowDirection.down,
    };
  });

  late final _gridFlowType = computed(() {
    return switch (widget.viewModel.gridStatus.currentPowerDirection.value) {
      GridPowerDirection.swaggerGeneratedUnknown => StatusPowerFlowType.neutral,
      GridPowerDirection.none => StatusPowerFlowType.neutral,
      GridPowerDirection.consume => StatusPowerFlowType.bad,
      GridPowerDirection.feedin => StatusPowerFlowType.good,
    };
  });

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _producerFlowDirection.dispose();
    _gridFlowDirection.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.viewModel.producerStatus.isAvailable.value) ...[
            PhotovoltaicStatusIndicator(
                viewModel: widget.viewModel.producerStatus),
            StatusPowerFlow(
              controller: _controller,
              direction: _producerFlowDirection.value,
              type: _producerFlowType.value,
            )
          ],
          HomeStatusIndicator(viewModel: widget.viewModel.consumerStatus),
          if (widget.viewModel.gridStatus.isAvailable.value) ...[
            StatusPowerFlow(
              controller: _controller,
              direction: _gridFlowDirection.value,
              type: _gridFlowType.value,
            ),
            GridStatusIndicator(viewModel: widget.viewModel.gridStatus),
          ]
        ],
      ),
    );
  }
}

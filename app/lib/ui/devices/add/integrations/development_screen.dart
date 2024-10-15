import 'package:openems/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:openems/application/backend_api/swagger_generated_code/backend_api.models.swagger.dart';
import 'package:openems/domain/integrations/known_integrations.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/add/add_consumer_screen.dart';
import 'package:openems/ui/devices/add/add_electricity_meter_screen.dart';
import 'package:openems/ui/devices/add/add_producer_screen.dart';
import 'package:openems/ui/devices/add/integrations/development_view_model.dart';
import 'package:openems/ui/devices/add/translate.dart';
import 'package:openems/ui/devices/add/widgets/abort_add_button.dart';
import 'package:openems/ui/devices/add/widgets/add_device_step_explanation.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:openems/ui/shared/noop.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class DevelopmentScreen extends StatefulWidget {
  const DevelopmentScreen({super.key, required this.deviceCategory});

  final DeviceCategory deviceCategory;
  @override
  State<DevelopmentScreen> createState() => _DevelopmentScreenState();
}

class _DevelopmentScreenState extends State<DevelopmentScreen> {
  late final DevelopmentViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<DevelopmentViewModel>();
    viewModel.init(widget.deviceCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${Translate.deviceCategory(widget.deviceCategory)} hinzufügen"),
        actions: const [AbortAddButton()],
        bottom: AppBarCommandProgressIndicator(command: viewModel.init),
      ),
      body: ListView(
        children: [
          const AddDeviceStepExplanation(
              title: "Development Gerät hinzufügen.",
              explanation: "Wähle ein Gerät aus."),
          ListTile(
              title: const Text("Verfügbare Geräte:"),
              titleTextStyle: Theme.of(context).textTheme.titleLarge),
          Watch(
            (context) {
              if (viewModel.addableDevices.isEmpty) {
                return const Center(child: Text("Keine Geräte vorhanden."));
              }
              final deviceTiles =
                  viewModel.addableDevices.value.map((device) => ListTile(
                        title: Text(device.deviceName),
                        trailing: const Icon(AppIcons.arrow_next),
                        onTap: () => _select(device),
                      ));
              return Column(
                children: [
                  ...ListTile.divideTiles(context: context, tiles: deviceTiles)
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _select(AddableDevelopmentDeviceDto selectedDevice) {
    final integration = IntegrationIdentifier(
      integration: KnownIntegrations.development,
      device: selectedDevice.deviceId,
    );

    switch (widget.deviceCategory) {
      case DeviceCategory.swaggerGeneratedUnknown:
        noop();
        return;

      case DeviceCategory.consumer:
        AppNavigator.push(AddConsumerScreen(
          integration: integration,
          deviceName: selectedDevice.deviceName,
        ));
        return;

      case DeviceCategory.producer:
        AppNavigator.push(AddProducerScreen(
          integration: integration,
          deviceName: selectedDevice.deviceName,
        ));
        return;

      case DeviceCategory.electricitymeter:
        AppNavigator.push(AddElectricityMeterScreen(
          integration: integration,
          deviceName: selectedDevice.deviceName,
        ));
        return;
    }
  }
}

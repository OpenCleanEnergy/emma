import 'dart:async';

import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/domain/integrations/known_integrations.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/add/add_consumer_screen.dart';
import 'package:openems/ui/devices/add/add_electricity_meter_screen.dart';
import 'package:openems/ui/devices/add/add_producer_screen.dart';
import 'package:openems/ui/devices/add/translate.dart';
import 'package:openems/ui/devices/add/widgets/abort_add_button.dart';
import 'package:openems/ui/devices/add/widgets/add_device_step_explanation.dart';
import 'package:openems/ui/devices/add/integrations/shelly_view_model.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/noop.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:signals/signals_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ShellyScreen extends StatefulWidget {
  const ShellyScreen({super.key, required this.deviceCategory});

  final DeviceCategory deviceCategory;

  @override
  State<ShellyScreen> createState() => _ShellyScreenState();
}

class _ShellyScreenState extends State<ShellyScreen> {
  late final Timer? _timer;

  late final ShellyViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<ShellyViewModel>();
    viewModel.init(widget.deviceCategory);
    _timer = Timer.periodic(const Duration(seconds: 3), _handlePolling);
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${Translate.deviceCategory(widget.deviceCategory)} hinzufügen"),
        actions: const [AbortAddButton()],
        bottom: AppBarCommandProgressIndicator(
            commands: [viewModel.init, viewModel.poll]),
      ),
      body: ListView(
        children: [
          const AddDeviceStepExplanation(
              title: "Shelly-Account verknüpfen.",
              explanation:
                  "Du musst deine Geräte erst mit EMMA verknüpfen. Danach werden dir deine verfügbaren Geräte angezeigt."),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Watch((context) => OutlinedButton(
                    onPressed: viewModel.permissionGrantUri.value == null
                        ? null
                        : _launchUrl,
                    child: const Text("Geräte verknüpfen"),
                  )),
            ),
          ),
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

  Future<void> _launchUrl() async {
    if (viewModel.permissionGrantUri.value == null) {
      return;
    }

    await launchUrl(viewModel.permissionGrantUri.value!);
  }

  Future<void> _handlePolling(Timer _) async {
    final logger = Logger("shelly");

    try {
      await viewModel.poll();
    } catch (error) {
      logger.warning("Polling failed", error);
    }
  }

  void _select(AddableShellyDeviceDto selectedDevice) {
    final integration = IntegrationIdentifier(
      integration: KnownIntegrations.shelly,
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

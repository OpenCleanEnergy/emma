import 'package:openems/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:openems/domain/integrations/known_integrations.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/add/integrations/development_screen.dart';
import 'package:openems/ui/devices/add/widgets/abort_add_button.dart';
import 'package:openems/ui/devices/add/widgets/add_device_step_explanation.dart';
import 'package:openems/ui/devices/add/integrations/shelly_screen.dart';
import 'package:openems/ui/devices/add/select_integration_view_model.dart';
import 'package:openems/ui/shared/translate.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/noop.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class SelectIntegrationScreen extends StatefulWidget {
  const SelectIntegrationScreen({super.key, required this.category});

  final DeviceCategory category;

  @override
  State<SelectIntegrationScreen> createState() =>
      _SelectIntegrationScreenState();
}

class _SelectIntegrationScreenState extends State<SelectIntegrationScreen> {
  late final SelectIntegrationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<SelectIntegrationViewModel>();
    viewModel.init(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${Translate.deviceCategory(widget.category)} hinzufügen"),
        actions: const [AbortAddButton()],
        bottom: AppBarCommandProgressIndicator(command: viewModel.init),
      ),
      body: ListView(
        children: [
          const AddDeviceStepExplanation(
            title: "Hersteller auswählen",
            explanation: "Wähle den Hersteller von deinem Gerät aus.",
          ),
          Watch((context) {
            final integrations =
                viewModel.integrations.map((integration) => ListTile(
                      title: Text(integration.name),
                      subtitle: _getSubtitle(integration.id),
                      trailing: const Icon(AppIcons.arrow_next),
                      onTap: () => _selectIntegration(integration.id),
                    ));
            return Column(
              children: [
                ...ListTile.divideTiles(context: context, tiles: integrations)
              ],
            );
          })
        ],
      ),
    );
  }

  void _selectIntegration(String integrationId) {
    switch (integrationId) {
      case KnownIntegrations.development:
        AppNavigator.push(DevelopmentScreen(
          deviceCategory: widget.category,
        ));
        return;

      case KnownIntegrations.shelly:
        AppNavigator.push(ShellyScreen(deviceCategory: widget.category));
        return;

      default:
        noop();
        return;
    }
  }

  Widget? _getSubtitle(String integrationId) {
    return switch (integrationId) {
      KnownIntegrations.development => null,
      KnownIntegrations.shelly => null,
      _ => const Text("Bald verfügbar")
    };
  }
}

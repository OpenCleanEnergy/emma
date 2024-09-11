import 'package:openems/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:openems/ui/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/add/widgets/abort_add_button.dart';
import 'package:openems/ui/devices/add/widgets/add_device_step_explanation.dart';
import 'package:openems/ui/devices/add/select_integration_screen.dart';
import 'package:openems/ui/devices/add/translate.dart';
import 'package:flutter/material.dart';

class SelectDeviceCategoryScreen extends StatelessWidget {
  const SelectDeviceCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = DeviceCategory.values
        .where((category) => category != DeviceCategory.swaggerGeneratedUnknown)
        .map((category) => ListTile(
              title: Text(Translate.deviceCategory(category)),
              trailing: const Icon(AppIcons.arrow_next),
              onTap: () => _selectCategory(category),
            ));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerät hinzufügen"),
        actions: const [AbortAddButton()],
      ),
      body: ListView(
        children: [
          const AddDeviceStepExplanation(
            title: "Kategorie auswählen",
            explanation: "Wähle die Kategorie von deinem Gerät aus.",
          ),
          ...ListTile.divideTiles(context: context, tiles: categories)
        ],
      ),
    );
  }

  void _selectCategory(DeviceCategory category) {
    AppNavigator.push(SelectIntegrationScreen(category: category));
  }
}

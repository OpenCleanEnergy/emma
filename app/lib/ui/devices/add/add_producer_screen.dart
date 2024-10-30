import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/app_messenger.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/add/add_producer_view_model.dart';
import 'package:openems/ui/devices/add/translate.dart';
import 'package:openems/ui/devices/add/widgets/abort_add_button.dart';
import 'package:openems/ui/devices/add/widgets/add_device_step_explanation.dart';
import 'package:openems/ui/devices/widgets/device_name_form_field.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AddProducerScreen extends StatefulWidget {
  final IntegrationIdentifier _integration;
  final String _deviceName;

  const AddProducerScreen(
      {super.key,
      required IntegrationIdentifier integration,
      required String deviceName})
      : _integration = integration,
        _deviceName = deviceName;

  @override
  State<AddProducerScreen> createState() => _AddProducerScreenState();
}

class _AddProducerScreenState extends State<AddProducerScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  late final AddProducerViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<AddProducerViewModel>();
    _nameController.text = widget._deviceName;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const divider = SizedBox(height: 16);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${Translate.deviceCategory(DeviceCategory.electricitymeter)} hinzufügen"),
        actions: const [AbortAddButton()],
        bottom: AppBarCommandProgressIndicator(command: viewModel.add),
      ),
      body: ListView(
        children: [
          const AddDeviceStepExplanation(
              title: "Einstellungen", explanation: "Konfiguriere dein Gerät."),
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DeviceNameFormField(
                      controller: _nameController, autoFocus: true),
                  divider,
                  Watch((context) => FilledButton(
                      onPressed: viewModel.add.isRunning.value ? null : _submit,
                      child: const Text("Hinzufügen"))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      AppMessenger.info("Bitte prüfe deine Eingaben.");
      return;
    }

    final command = AddProducerCommand(
      integration: widget._integration,
      deviceName: _nameController.text,
    );

    if (await viewModel.add(command)) {
      AppMessenger.success("${command.deviceName} hinzugefügt");
      AppNavigator.popUntilFirst();
    }
  }
}

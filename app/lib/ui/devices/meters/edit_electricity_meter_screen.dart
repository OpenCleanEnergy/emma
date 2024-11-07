import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/meters/electricity_meter_view_model.dart';
import 'package:openems/ui/devices/widgets/device_name_form_field.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:openems/ui/shared/confirm.dart';
import 'package:openems/ui/shared/debounce.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/shared/destructive_button.dart';
import 'package:signals/signals_flutter.dart';

// https://pub.dev/packages/formz
class EditElectricityMeterScreen extends StatefulWidget {
  const EditElectricityMeterScreen({super.key, required this.viewModel});

  final ElectricityMeterViewModel viewModel;

  @override
  State<EditElectricityMeterScreen> createState() =>
      _EditElectricityMeterScreenState();
}

class _EditElectricityMeterScreenState
    extends State<EditElectricityMeterScreen> {
  final _formKey = GlobalKey<FormState>();
  late final Debounce _debounceName;
  late final TextEditingController _nameController;

  ElectricityMeterViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    _debounceName = Debounce(action: _autoSubmit);

    _nameController = TextEditingController(text: viewModel.name.value);
    _nameController.addListener(_debounceName.call);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.removeListener(_debounceName.call);
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${viewModel.name} bearbeiten"),
        bottom: AppBarCommandProgressIndicator(
            commands: [viewModel.delete, viewModel.edit]),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DeviceNameFormField(
                    controller: _nameController, autoFocus: true),
                const SizedBox(height: 16),
                Watch((context) => DestructiveButton.outlined(
                    onPressed: viewModel.delete.isRunning.value
                        ? null
                        : () => _delete(context),
                    child: const Text("Löschen"))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _autoSubmit() async {
    if (!_formKey.currentState!.validate()) {
      // Skip on invalid form
      return;
    }

    if (_nameController.text == viewModel.name.value) {
      // Skip on initial value
      return;
    }

    await viewModel.edit((name: _nameController.text));
  }

  Future<void> _delete(BuildContext context) async {
    final confirmed = await confirm(
      context,
      content: "Willst du das Gerät wirklich löschen?",
      textOK: "Löschen",
      textCancel: "Abbrechen",
      isDestructive: true,
    );

    if (!confirmed) {
      return;
    }

    if (await widget.viewModel.delete()) {
      AppNavigator.pop();
    }
  }
}

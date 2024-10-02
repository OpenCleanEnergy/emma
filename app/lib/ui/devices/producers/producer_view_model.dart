import 'package:openems/application/backend_api/value_types.dart';
import 'package:openems/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:signals/signals_flutter.dart';

class ProducerViewModel {
  final BackendApi _api;

  ProducerViewModel({required BackendApi api, required ProducerDto dto})
      : _api = api,
        id = signal(dto.id),
        name = signal(dto.name),
        currentPowerProduction = signal(dto.currentPowerProduction) {
    delete = _delete.toCommand();
    edit = _edit.toCommand();
  }

  final Signal<String> id;
  final Signal<String> name;
  final Signal<Watt?> currentPowerProduction;

  late final NoArgCommand delete;
  late final ArgCommand<({String name})> edit;

  void update(ProducerDto dto) => batch(() {
        id.value = dto.id;
        name.value = dto.name;
        currentPowerProduction.value = dto.currentPowerProduction;
      });

  Future<void> _delete() async {
    await _api.Devices_DeleteProducerCommand(producerId: id.value);
  }

  Future<void> _edit(({String name}) arg) async {
    var response = await _api.Devices_EditProducerCommand(
        body: EditProducerCommand(producerId: id.value, name: arg.name));

    if (response.isSuccessful) {
      name.value == arg.name;
    }
  }
}

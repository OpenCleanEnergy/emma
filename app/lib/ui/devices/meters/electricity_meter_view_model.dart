import 'package:openems/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:signals/signals_flutter.dart';

class ElectricityMeterViewModel {
  final BackendApi _api;

  ElectricityMeterViewModel(
      {required BackendApi api, required ElectricityMeterDto dto})
      : _api = api,
        id = signal(dto.id),
        name = signal(dto.name),
        currentPowerDirection = signal(dto.currentPowerDirection),
        currentPower = signal(dto.currentPower.toDouble()) {
    delete = _delete.toCommand();
    edit = _edit.toCommand();
  }

  final Signal<String> id;
  final Signal<String> name;
  final Signal<GridPowerDirection> currentPowerDirection;
  final Signal<double> currentPower;

  late final NoArgCommand delete;
  late final ArgCommand<({String name})> edit;

  void update(ElectricityMeterDto dto) => batch(() {
        id.value = dto.id;
        name.value = dto.name;
        currentPowerDirection.value = dto.currentPowerDirection;
        currentPower.value = dto.currentPower.toDouble();
      });

  Future<void> _delete() async {
    await _api.Devices_DeleteElectricityMeterCommand(
        electricityMeterId: id.value);
  }

  Future<void> _edit(({String name}) arg) async {
    var response = await _api.Devices_EditElectricityMeterCommand(
        body: EditElectricityMeterCommand(
            electricityMeterId: id.value, name: arg.name));

    if (response.isSuccessful) {
      name.value == arg.name;
    }
  }
}

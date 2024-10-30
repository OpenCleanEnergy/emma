import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/commands/command.dart';

class AddElectricityMeterViewModel {
  final BackendApi _api;

  AddElectricityMeterViewModel({required BackendApi api}) : _api = api {
    add = _add.toCommand();
  }

  late final ArgCommand<AddElectricityMeterCommand> add;

  Future<void> _add(AddElectricityMeterCommand command) async {
    await _api.Devices_AddElectricityMeterCommand(body: command);
  }
}

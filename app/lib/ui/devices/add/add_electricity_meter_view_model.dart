import 'package:emma/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:emma/ui/commands/command.dart';

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

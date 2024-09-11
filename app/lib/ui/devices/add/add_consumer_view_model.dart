import 'package:openems/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:openems/ui/commands/command.dart';

class AddConsumerViewModel {
  final BackendApi _api;

  AddConsumerViewModel({required BackendApi api}) : _api = api {
    add = _add.toCommand();
  }

  late final ArgCommand<AddSwitchConsumerCommand> add;

  Future<void> _add(AddSwitchConsumerCommand command) async {
    await _api.Devices_AddSwitchConsumerCommand(body: command);
  }
}

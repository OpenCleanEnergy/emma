import 'package:openems/application/backend_api/backend_api.dart';
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

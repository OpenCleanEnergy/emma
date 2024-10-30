import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/commands/command.dart';

class AddProducerViewModel {
  final BackendApi _api;

  AddProducerViewModel({required BackendApi api}) : _api = api {
    add = _add.toCommand();
  }

  late final ArgCommand<AddProducerCommand> add;

  Future<void> _add(AddProducerCommand command) async {
    await _api.Devices_AddProducerCommand(body: command);
  }
}

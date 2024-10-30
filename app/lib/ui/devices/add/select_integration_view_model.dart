import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:signals/signals_flutter.dart';

class SelectIntegrationViewModel {
  final BackendApi _api;

  SelectIntegrationViewModel({required BackendApi api}) : _api = api {
    init = _init.toCommand();
  }

  final integrations = listSignal<IntegrationDescriptionDto>([]);

  late final ArgCommand<DeviceCategory> init;

  Future<void> _init(DeviceCategory category) async {
    var response =
        await _api.Integrations_IntegrationsQuery(deviceCategory: category);
    integrations.value = [...?response.body];
  }
}

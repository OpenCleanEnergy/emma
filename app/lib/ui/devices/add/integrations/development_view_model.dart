import 'package:emma/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:signals/signals_flutter.dart';

class DevelopmentViewModel {
  final BackendApi _api;

  DeviceCategory? _deviceCategory;

  DevelopmentViewModel({required BackendApi api}) : _api = api {
    init = _init.toCommand();
  }

  final addableDevices = listSignal<AddableDevelopmentDeviceDto>([]);
  final permissionGrantUri = signal<Uri?>(null);

  late final ArgCommand<DeviceCategory> init;

  Future<void> _init(DeviceCategory deviceCategory) async {
    _deviceCategory = deviceCategory;

    final response = await _api.Development_AddableDevelopmentDevicesQuery(
        deviceCategory: _deviceCategory);

    final devices = [...?response.body];
    devices.sort((a, b) => a.deviceName.compareTo(b.deviceName));
    addableDevices.value = devices;
  }
}

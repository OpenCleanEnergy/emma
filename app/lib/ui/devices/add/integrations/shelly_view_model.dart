import 'package:emma/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:signals/signals_flutter.dart';

class ShellyViewModel {
  final BackendApi _api;

  DeviceCategory? _deviceCategory;

  ShellyViewModel({required BackendApi api}) : _api = api {
    init = _init.toCommand();
    poll = _poll.toCommand();
  }

  final addableDevices = listSignal<AddableShellyDeviceDto>([]);
  final permissionGrantUri = signal<Uri?>(null);

  late final ArgCommand<DeviceCategory> init;
  late final NoArgCommand poll;

  Future<void> _init(DeviceCategory deviceCategory) async {
    _deviceCategory = deviceCategory;
    final response = await _api.Shelly_ShellyPermissionGrantUriQuery();
    permissionGrantUri.value = Uri.tryParse(response.body?.uri ?? "");
    await _poll();
  }

  Future<void> _poll() async {
    if (_deviceCategory == null) {
      return;
    }

    final response =
        await _api.Shelly_AddableDevicesQuery(deviceCategory: _deviceCategory);

    final devices = [...?response.body];
    devices.sort((a, b) => a.deviceName.compareTo(b.deviceName));
    addableDevices.value = devices;
  }
}

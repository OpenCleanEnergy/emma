import 'package:emma/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';
import 'package:emma/application/devices/integrations/shelly/discovered_shelly_device_dto.dart';

abstract interface class ShellyRepository {
  Future<Iterable<DiscoveredShellyDeviceDto>> getDiscoveredDevices(
      DeviceCategory deviceCategory);
}

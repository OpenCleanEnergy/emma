import 'package:emma/application/backend_api/swagger_generated_code/backend_api.enums.swagger.dart';

abstract class Translate {
  static String deviceCategory(DeviceCategory input) {
    return switch (input) {
      DeviceCategory.consumer => "Verbraucher",
      DeviceCategory.producer => "Produzent",
      DeviceCategory.electricitymeter => "Stromzähler",
      DeviceCategory.swaggerGeneratedUnknown => "Unbekannt",
    };
  }
}

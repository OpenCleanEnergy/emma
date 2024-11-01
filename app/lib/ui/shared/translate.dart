import 'package:openems/application/backend_api/backend_api.dart';

abstract final class Translate {
  static String deviceCategory(DeviceCategory input) {
    return switch (input) {
      DeviceCategory.consumer => "Verbraucher",
      DeviceCategory.producer => "Produzent",
      DeviceCategory.electricitymeter => "Stromzähler",
      DeviceCategory.swaggerGeneratedUnknown => "Unbekannt",
    };
  }

  static String dayOfWeek(DayOfWeek input) {
    return switch (input) {
      DayOfWeek.sunday => "So",
      DayOfWeek.monday => "Mo",
      DayOfWeek.tuesday => "Di",
      DayOfWeek.wednesday => "Mi",
      DayOfWeek.thursday => "Do",
      DayOfWeek.friday => "Fr",
      DayOfWeek.saturday => "Sa",
      DayOfWeek.swaggerGeneratedUnknown => "Unbekannt",
    };
  }
}

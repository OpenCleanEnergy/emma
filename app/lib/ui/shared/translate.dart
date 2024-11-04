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
      DayOfWeek.sunday => "Sonntag",
      DayOfWeek.monday => "Montag",
      DayOfWeek.tuesday => "Dienstag",
      DayOfWeek.wednesday => "Mittwoch",
      DayOfWeek.thursday => "Donnerstag",
      DayOfWeek.friday => "Freitag",
      DayOfWeek.saturday => "Samstag",
      DayOfWeek.swaggerGeneratedUnknown => "Unbekannt",
    };
  }
}

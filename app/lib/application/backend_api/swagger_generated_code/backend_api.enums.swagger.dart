import 'package:json_annotation/json_annotation.dart';

enum BatteryChargeStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Idle')
  idle('Idle'),
  @JsonValue('Charging')
  charging('Charging'),
  @JsonValue('Discharging')
  discharging('Discharging');

  final String? value;

  const BatteryChargeStatus(this.value);
}

enum ControlMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Manual')
  manual('Manual'),
  @JsonValue('Smart')
  smart('Smart');

  final String? value;

  const ControlMode(this.value);
}

enum DeviceCategory {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Consumer')
  consumer('Consumer'),
  @JsonValue('Producer')
  producer('Producer'),
  @JsonValue('ElectricityMeter')
  electricitymeter('ElectricityMeter');

  final String? value;

  const DeviceCategory(this.value);
}

enum GridPowerDirection {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('None')
  none('None'),
  @JsonValue('Consume')
  consume('Consume'),
  @JsonValue('FeedIn')
  feedin('FeedIn');

  final String? value;

  const GridPowerDirection(this.value);
}

enum HealthStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Unhealthy')
  unhealthy('Unhealthy'),
  @JsonValue('Degraded')
  degraded('Degraded'),
  @JsonValue('Healthy')
  healthy('Healthy');

  final String? value;

  const HealthStatus(this.value);
}

enum SwitchStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('Off')
  off('Off'),
  @JsonValue('On')
  on('On');

  final String? value;

  const SwitchStatus(this.value);
}

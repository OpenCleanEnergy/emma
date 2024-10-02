// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'backend_api.enums.swagger.dart' as enums;
import '../value_types.dart';

part 'backend_api.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class AddElectricityMeterCommand {
  const AddElectricityMeterCommand({
    required this.integration,
    required this.deviceName,
  });

  factory AddElectricityMeterCommand.fromJson(Map<String, dynamic> json) =>
      _$AddElectricityMeterCommandFromJson(json);

  static const toJsonFactory = _$AddElectricityMeterCommandToJson;
  Map<String, dynamic> toJson() => _$AddElectricityMeterCommandToJson(this);

  @JsonKey(name: 'integration')
  final IntegrationIdentifier integration;
  @JsonKey(name: 'deviceName')
  final String deviceName;
  static const fromJsonFactory = _$AddElectricityMeterCommandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddElectricityMeterCommand &&
            (identical(other.integration, integration) ||
                const DeepCollectionEquality()
                    .equals(other.integration, integration)) &&
            (identical(other.deviceName, deviceName) ||
                const DeepCollectionEquality()
                    .equals(other.deviceName, deviceName)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(integration) ^
      const DeepCollectionEquality().hash(deviceName) ^
      runtimeType.hashCode;
}

extension $AddElectricityMeterCommandExtension on AddElectricityMeterCommand {
  AddElectricityMeterCommand copyWith(
      {IntegrationIdentifier? integration, String? deviceName}) {
    return AddElectricityMeterCommand(
        integration: integration ?? this.integration,
        deviceName: deviceName ?? this.deviceName);
  }

  AddElectricityMeterCommand copyWithWrapped(
      {Wrapped<IntegrationIdentifier>? integration,
      Wrapped<String>? deviceName}) {
    return AddElectricityMeterCommand(
        integration:
            (integration != null ? integration.value : this.integration),
        deviceName: (deviceName != null ? deviceName.value : this.deviceName));
  }
}

@JsonSerializable(explicitToJson: true)
class AddProducerCommand {
  const AddProducerCommand({
    required this.integration,
    required this.deviceName,
  });

  factory AddProducerCommand.fromJson(Map<String, dynamic> json) =>
      _$AddProducerCommandFromJson(json);

  static const toJsonFactory = _$AddProducerCommandToJson;
  Map<String, dynamic> toJson() => _$AddProducerCommandToJson(this);

  @JsonKey(name: 'integration')
  final IntegrationIdentifier integration;
  @JsonKey(name: 'deviceName')
  final String deviceName;
  static const fromJsonFactory = _$AddProducerCommandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddProducerCommand &&
            (identical(other.integration, integration) ||
                const DeepCollectionEquality()
                    .equals(other.integration, integration)) &&
            (identical(other.deviceName, deviceName) ||
                const DeepCollectionEquality()
                    .equals(other.deviceName, deviceName)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(integration) ^
      const DeepCollectionEquality().hash(deviceName) ^
      runtimeType.hashCode;
}

extension $AddProducerCommandExtension on AddProducerCommand {
  AddProducerCommand copyWith(
      {IntegrationIdentifier? integration, String? deviceName}) {
    return AddProducerCommand(
        integration: integration ?? this.integration,
        deviceName: deviceName ?? this.deviceName);
  }

  AddProducerCommand copyWithWrapped(
      {Wrapped<IntegrationIdentifier>? integration,
      Wrapped<String>? deviceName}) {
    return AddProducerCommand(
        integration:
            (integration != null ? integration.value : this.integration),
        deviceName: (deviceName != null ? deviceName.value : this.deviceName));
  }
}

@JsonSerializable(explicitToJson: true)
class AddSwitchConsumerCommand {
  const AddSwitchConsumerCommand({
    required this.integration,
    required this.deviceName,
  });

  factory AddSwitchConsumerCommand.fromJson(Map<String, dynamic> json) =>
      _$AddSwitchConsumerCommandFromJson(json);

  static const toJsonFactory = _$AddSwitchConsumerCommandToJson;
  Map<String, dynamic> toJson() => _$AddSwitchConsumerCommandToJson(this);

  @JsonKey(name: 'integration')
  final IntegrationIdentifier integration;
  @JsonKey(name: 'deviceName')
  final String deviceName;
  static const fromJsonFactory = _$AddSwitchConsumerCommandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddSwitchConsumerCommand &&
            (identical(other.integration, integration) ||
                const DeepCollectionEquality()
                    .equals(other.integration, integration)) &&
            (identical(other.deviceName, deviceName) ||
                const DeepCollectionEquality()
                    .equals(other.deviceName, deviceName)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(integration) ^
      const DeepCollectionEquality().hash(deviceName) ^
      runtimeType.hashCode;
}

extension $AddSwitchConsumerCommandExtension on AddSwitchConsumerCommand {
  AddSwitchConsumerCommand copyWith(
      {IntegrationIdentifier? integration, String? deviceName}) {
    return AddSwitchConsumerCommand(
        integration: integration ?? this.integration,
        deviceName: deviceName ?? this.deviceName);
  }

  AddSwitchConsumerCommand copyWithWrapped(
      {Wrapped<IntegrationIdentifier>? integration,
      Wrapped<String>? deviceName}) {
    return AddSwitchConsumerCommand(
        integration:
            (integration != null ? integration.value : this.integration),
        deviceName: (deviceName != null ? deviceName.value : this.deviceName));
  }
}

@JsonSerializable(explicitToJson: true)
class AddableDevelopmentDeviceDto {
  const AddableDevelopmentDeviceDto({
    required this.deviceId,
    required this.deviceName,
  });

  factory AddableDevelopmentDeviceDto.fromJson(Map<String, dynamic> json) =>
      _$AddableDevelopmentDeviceDtoFromJson(json);

  static const toJsonFactory = _$AddableDevelopmentDeviceDtoToJson;
  Map<String, dynamic> toJson() => _$AddableDevelopmentDeviceDtoToJson(this);

  @JsonKey(name: 'deviceId')
  final String deviceId;
  @JsonKey(name: 'deviceName')
  final String deviceName;
  static const fromJsonFactory = _$AddableDevelopmentDeviceDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddableDevelopmentDeviceDto &&
            (identical(other.deviceId, deviceId) ||
                const DeepCollectionEquality()
                    .equals(other.deviceId, deviceId)) &&
            (identical(other.deviceName, deviceName) ||
                const DeepCollectionEquality()
                    .equals(other.deviceName, deviceName)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(deviceId) ^
      const DeepCollectionEquality().hash(deviceName) ^
      runtimeType.hashCode;
}

extension $AddableDevelopmentDeviceDtoExtension on AddableDevelopmentDeviceDto {
  AddableDevelopmentDeviceDto copyWith({String? deviceId, String? deviceName}) {
    return AddableDevelopmentDeviceDto(
        deviceId: deviceId ?? this.deviceId,
        deviceName: deviceName ?? this.deviceName);
  }

  AddableDevelopmentDeviceDto copyWithWrapped(
      {Wrapped<String>? deviceId, Wrapped<String>? deviceName}) {
    return AddableDevelopmentDeviceDto(
        deviceId: (deviceId != null ? deviceId.value : this.deviceId),
        deviceName: (deviceName != null ? deviceName.value : this.deviceName));
  }
}

@JsonSerializable(explicitToJson: true)
class AddableShellyDeviceDto {
  const AddableShellyDeviceDto({
    required this.deviceId,
    required this.deviceName,
  });

  factory AddableShellyDeviceDto.fromJson(Map<String, dynamic> json) =>
      _$AddableShellyDeviceDtoFromJson(json);

  static const toJsonFactory = _$AddableShellyDeviceDtoToJson;
  Map<String, dynamic> toJson() => _$AddableShellyDeviceDtoToJson(this);

  @JsonKey(name: 'deviceId')
  final String deviceId;
  @JsonKey(name: 'deviceName')
  final String deviceName;
  static const fromJsonFactory = _$AddableShellyDeviceDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddableShellyDeviceDto &&
            (identical(other.deviceId, deviceId) ||
                const DeepCollectionEquality()
                    .equals(other.deviceId, deviceId)) &&
            (identical(other.deviceName, deviceName) ||
                const DeepCollectionEquality()
                    .equals(other.deviceName, deviceName)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(deviceId) ^
      const DeepCollectionEquality().hash(deviceName) ^
      runtimeType.hashCode;
}

extension $AddableShellyDeviceDtoExtension on AddableShellyDeviceDto {
  AddableShellyDeviceDto copyWith({String? deviceId, String? deviceName}) {
    return AddableShellyDeviceDto(
        deviceId: deviceId ?? this.deviceId,
        deviceName: deviceName ?? this.deviceName);
  }

  AddableShellyDeviceDto copyWithWrapped(
      {Wrapped<String>? deviceId, Wrapped<String>? deviceName}) {
    return AddableShellyDeviceDto(
        deviceId: (deviceId != null ? deviceId.value : this.deviceId),
        deviceName: (deviceName != null ? deviceName.value : this.deviceName));
  }
}

@JsonSerializable(explicitToJson: true)
class BatteryStatusDto {
  const BatteryStatusDto({
    this.isAvailable,
    required this.chargeStatus,
    required this.charge,
  });

  factory BatteryStatusDto.fromJson(Map<String, dynamic> json) =>
      _$BatteryStatusDtoFromJson(json);

  static const toJsonFactory = _$BatteryStatusDtoToJson;
  Map<String, dynamic> toJson() => _$BatteryStatusDtoToJson(this);

  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  @JsonKey(
    name: 'chargeStatus',
    toJson: batteryChargeStatusToJson,
    fromJson: batteryChargeStatusFromJson,
  )
  final enums.BatteryChargeStatus chargeStatus;
  @JsonKey(name: 'charge')
  final num charge;
  static const fromJsonFactory = _$BatteryStatusDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is BatteryStatusDto &&
            (identical(other.isAvailable, isAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.isAvailable, isAvailable)) &&
            (identical(other.chargeStatus, chargeStatus) ||
                const DeepCollectionEquality()
                    .equals(other.chargeStatus, chargeStatus)) &&
            (identical(other.charge, charge) ||
                const DeepCollectionEquality().equals(other.charge, charge)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isAvailable) ^
      const DeepCollectionEquality().hash(chargeStatus) ^
      const DeepCollectionEquality().hash(charge) ^
      runtimeType.hashCode;
}

extension $BatteryStatusDtoExtension on BatteryStatusDto {
  BatteryStatusDto copyWith(
      {bool? isAvailable,
      enums.BatteryChargeStatus? chargeStatus,
      num? charge}) {
    return BatteryStatusDto(
        isAvailable: isAvailable ?? this.isAvailable,
        chargeStatus: chargeStatus ?? this.chargeStatus,
        charge: charge ?? this.charge);
  }

  BatteryStatusDto copyWithWrapped(
      {Wrapped<bool?>? isAvailable,
      Wrapped<enums.BatteryChargeStatus>? chargeStatus,
      Wrapped<num>? charge}) {
    return BatteryStatusDto(
        isAvailable:
            (isAvailable != null ? isAvailable.value : this.isAvailable),
        chargeStatus:
            (chargeStatus != null ? chargeStatus.value : this.chargeStatus),
        charge: (charge != null ? charge.value : this.charge));
  }
}

@JsonSerializable(explicitToJson: true)
class ConsumerStatusDto {
  const ConsumerStatusDto({
    this.isAvailable,
    required this.currentPowerConsumption,
    required this.maximumPowerConsumption,
  });

  factory ConsumerStatusDto.fromJson(Map<String, dynamic> json) =>
      _$ConsumerStatusDtoFromJson(json);

  static const toJsonFactory = _$ConsumerStatusDtoToJson;
  Map<String, dynamic> toJson() => _$ConsumerStatusDtoToJson(this);

  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  @JsonKey(name: 'currentPowerConsumption')
  final num currentPowerConsumption;
  @JsonKey(name: 'maximumPowerConsumption')
  final num maximumPowerConsumption;
  static const fromJsonFactory = _$ConsumerStatusDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ConsumerStatusDto &&
            (identical(other.isAvailable, isAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.isAvailable, isAvailable)) &&
            (identical(
                    other.currentPowerConsumption, currentPowerConsumption) ||
                const DeepCollectionEquality().equals(
                    other.currentPowerConsumption, currentPowerConsumption)) &&
            (identical(
                    other.maximumPowerConsumption, maximumPowerConsumption) ||
                const DeepCollectionEquality().equals(
                    other.maximumPowerConsumption, maximumPowerConsumption)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isAvailable) ^
      const DeepCollectionEquality().hash(currentPowerConsumption) ^
      const DeepCollectionEquality().hash(maximumPowerConsumption) ^
      runtimeType.hashCode;
}

extension $ConsumerStatusDtoExtension on ConsumerStatusDto {
  ConsumerStatusDto copyWith(
      {bool? isAvailable,
      num? currentPowerConsumption,
      num? maximumPowerConsumption}) {
    return ConsumerStatusDto(
        isAvailable: isAvailable ?? this.isAvailable,
        currentPowerConsumption:
            currentPowerConsumption ?? this.currentPowerConsumption,
        maximumPowerConsumption:
            maximumPowerConsumption ?? this.maximumPowerConsumption);
  }

  ConsumerStatusDto copyWithWrapped(
      {Wrapped<bool?>? isAvailable,
      Wrapped<num>? currentPowerConsumption,
      Wrapped<num>? maximumPowerConsumption}) {
    return ConsumerStatusDto(
        isAvailable:
            (isAvailable != null ? isAvailable.value : this.isAvailable),
        currentPowerConsumption: (currentPowerConsumption != null
            ? currentPowerConsumption.value
            : this.currentPowerConsumption),
        maximumPowerConsumption: (maximumPowerConsumption != null
            ? maximumPowerConsumption.value
            : this.maximumPowerConsumption));
  }
}

@JsonSerializable(explicitToJson: true)
class DevicesDto {
  const DevicesDto({
    required this.switchConsumers,
    required this.producers,
    required this.electricityMeters,
  });

  factory DevicesDto.fromJson(Map<String, dynamic> json) =>
      _$DevicesDtoFromJson(json);

  static const toJsonFactory = _$DevicesDtoToJson;
  Map<String, dynamic> toJson() => _$DevicesDtoToJson(this);

  @JsonKey(name: 'switchConsumers', defaultValue: <SwitchConsumerDto>[])
  final List<SwitchConsumerDto> switchConsumers;
  @JsonKey(name: 'producers', defaultValue: <ProducerDto>[])
  final List<ProducerDto> producers;
  @JsonKey(name: 'electricityMeters', defaultValue: <ElectricityMeterDto>[])
  final List<ElectricityMeterDto> electricityMeters;
  static const fromJsonFactory = _$DevicesDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DevicesDto &&
            (identical(other.switchConsumers, switchConsumers) ||
                const DeepCollectionEquality()
                    .equals(other.switchConsumers, switchConsumers)) &&
            (identical(other.producers, producers) ||
                const DeepCollectionEquality()
                    .equals(other.producers, producers)) &&
            (identical(other.electricityMeters, electricityMeters) ||
                const DeepCollectionEquality()
                    .equals(other.electricityMeters, electricityMeters)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(switchConsumers) ^
      const DeepCollectionEquality().hash(producers) ^
      const DeepCollectionEquality().hash(electricityMeters) ^
      runtimeType.hashCode;
}

extension $DevicesDtoExtension on DevicesDto {
  DevicesDto copyWith(
      {List<SwitchConsumerDto>? switchConsumers,
      List<ProducerDto>? producers,
      List<ElectricityMeterDto>? electricityMeters}) {
    return DevicesDto(
        switchConsumers: switchConsumers ?? this.switchConsumers,
        producers: producers ?? this.producers,
        electricityMeters: electricityMeters ?? this.electricityMeters);
  }

  DevicesDto copyWithWrapped(
      {Wrapped<List<SwitchConsumerDto>>? switchConsumers,
      Wrapped<List<ProducerDto>>? producers,
      Wrapped<List<ElectricityMeterDto>>? electricityMeters}) {
    return DevicesDto(
        switchConsumers: (switchConsumers != null
            ? switchConsumers.value
            : this.switchConsumers),
        producers: (producers != null ? producers.value : this.producers),
        electricityMeters: (electricityMeters != null
            ? electricityMeters.value
            : this.electricityMeters));
  }
}

@JsonSerializable(explicitToJson: true)
class EditElectricityMeterCommand {
  const EditElectricityMeterCommand({
    required this.electricityMeterId,
    required this.name,
  });

  factory EditElectricityMeterCommand.fromJson(Map<String, dynamic> json) =>
      _$EditElectricityMeterCommandFromJson(json);

  static const toJsonFactory = _$EditElectricityMeterCommandToJson;
  Map<String, dynamic> toJson() => _$EditElectricityMeterCommandToJson(this);

  @JsonKey(name: 'electricityMeterId')
  final String electricityMeterId;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$EditElectricityMeterCommandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EditElectricityMeterCommand &&
            (identical(other.electricityMeterId, electricityMeterId) ||
                const DeepCollectionEquality()
                    .equals(other.electricityMeterId, electricityMeterId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(electricityMeterId) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $EditElectricityMeterCommandExtension on EditElectricityMeterCommand {
  EditElectricityMeterCommand copyWith(
      {String? electricityMeterId, String? name}) {
    return EditElectricityMeterCommand(
        electricityMeterId: electricityMeterId ?? this.electricityMeterId,
        name: name ?? this.name);
  }

  EditElectricityMeterCommand copyWithWrapped(
      {Wrapped<String>? electricityMeterId, Wrapped<String>? name}) {
    return EditElectricityMeterCommand(
        electricityMeterId: (electricityMeterId != null
            ? electricityMeterId.value
            : this.electricityMeterId),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class EditProducerCommand {
  const EditProducerCommand({
    required this.producerId,
    required this.name,
  });

  factory EditProducerCommand.fromJson(Map<String, dynamic> json) =>
      _$EditProducerCommandFromJson(json);

  static const toJsonFactory = _$EditProducerCommandToJson;
  Map<String, dynamic> toJson() => _$EditProducerCommandToJson(this);

  @JsonKey(name: 'producerId')
  final String producerId;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$EditProducerCommandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EditProducerCommand &&
            (identical(other.producerId, producerId) ||
                const DeepCollectionEquality()
                    .equals(other.producerId, producerId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(producerId) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $EditProducerCommandExtension on EditProducerCommand {
  EditProducerCommand copyWith({String? producerId, String? name}) {
    return EditProducerCommand(
        producerId: producerId ?? this.producerId, name: name ?? this.name);
  }

  EditProducerCommand copyWithWrapped(
      {Wrapped<String>? producerId, Wrapped<String>? name}) {
    return EditProducerCommand(
        producerId: (producerId != null ? producerId.value : this.producerId),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class EditSwitchConsumerCommand {
  const EditSwitchConsumerCommand({
    required this.switchConsumerId,
    required this.name,
  });

  factory EditSwitchConsumerCommand.fromJson(Map<String, dynamic> json) =>
      _$EditSwitchConsumerCommandFromJson(json);

  static const toJsonFactory = _$EditSwitchConsumerCommandToJson;
  Map<String, dynamic> toJson() => _$EditSwitchConsumerCommandToJson(this);

  @JsonKey(name: 'switchConsumerId')
  final String switchConsumerId;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$EditSwitchConsumerCommandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EditSwitchConsumerCommand &&
            (identical(other.switchConsumerId, switchConsumerId) ||
                const DeepCollectionEquality()
                    .equals(other.switchConsumerId, switchConsumerId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(switchConsumerId) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $EditSwitchConsumerCommandExtension on EditSwitchConsumerCommand {
  EditSwitchConsumerCommand copyWith({String? switchConsumerId, String? name}) {
    return EditSwitchConsumerCommand(
        switchConsumerId: switchConsumerId ?? this.switchConsumerId,
        name: name ?? this.name);
  }

  EditSwitchConsumerCommand copyWithWrapped(
      {Wrapped<String>? switchConsumerId, Wrapped<String>? name}) {
    return EditSwitchConsumerCommand(
        switchConsumerId: (switchConsumerId != null
            ? switchConsumerId.value
            : this.switchConsumerId),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class ElectricityMeterDto {
  const ElectricityMeterDto({
    required this.id,
    required this.name,
    required this.currentPowerDirection,
    this.currentPower,
  });

  factory ElectricityMeterDto.fromJson(Map<String, dynamic> json) =>
      _$ElectricityMeterDtoFromJson(json);

  static const toJsonFactory = _$ElectricityMeterDtoToJson;
  Map<String, dynamic> toJson() => _$ElectricityMeterDtoToJson(this);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'currentPowerDirection',
    toJson: gridPowerDirectionToJson,
    fromJson: gridPowerDirectionFromJson,
  )
  final enums.GridPowerDirection currentPowerDirection;
  @JsonKey(name: 'currentPower')
  final Watt? currentPower;
  static const fromJsonFactory = _$ElectricityMeterDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ElectricityMeterDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.currentPowerDirection, currentPowerDirection) ||
                const DeepCollectionEquality().equals(
                    other.currentPowerDirection, currentPowerDirection)) &&
            (identical(other.currentPower, currentPower) ||
                const DeepCollectionEquality()
                    .equals(other.currentPower, currentPower)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(currentPowerDirection) ^
      const DeepCollectionEquality().hash(currentPower) ^
      runtimeType.hashCode;
}

extension $ElectricityMeterDtoExtension on ElectricityMeterDto {
  ElectricityMeterDto copyWith(
      {String? id,
      String? name,
      enums.GridPowerDirection? currentPowerDirection,
      Watt? currentPower}) {
    return ElectricityMeterDto(
        id: id ?? this.id,
        name: name ?? this.name,
        currentPowerDirection:
            currentPowerDirection ?? this.currentPowerDirection,
        currentPower: currentPower ?? this.currentPower);
  }

  ElectricityMeterDto copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? name,
      Wrapped<enums.GridPowerDirection>? currentPowerDirection,
      Wrapped<Watt?>? currentPower}) {
    return ElectricityMeterDto(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        currentPowerDirection: (currentPowerDirection != null
            ? currentPowerDirection.value
            : this.currentPowerDirection),
        currentPower:
            (currentPower != null ? currentPower.value : this.currentPower));
  }
}

@JsonSerializable(explicitToJson: true)
class GridStatusDto {
  const GridStatusDto({
    this.isAvailable,
    required this.currentPowerDirection,
    required this.currentPower,
    required this.maximumPowerConsumption,
    required this.maximumPowerFeedIn,
  });

  factory GridStatusDto.fromJson(Map<String, dynamic> json) =>
      _$GridStatusDtoFromJson(json);

  static const toJsonFactory = _$GridStatusDtoToJson;
  Map<String, dynamic> toJson() => _$GridStatusDtoToJson(this);

  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  @JsonKey(
    name: 'currentPowerDirection',
    toJson: gridPowerDirectionToJson,
    fromJson: gridPowerDirectionFromJson,
  )
  final enums.GridPowerDirection currentPowerDirection;
  @JsonKey(name: 'currentPower')
  final num currentPower;
  @JsonKey(name: 'maximumPowerConsumption')
  final num maximumPowerConsumption;
  @JsonKey(name: 'maximumPowerFeedIn')
  final num maximumPowerFeedIn;
  static const fromJsonFactory = _$GridStatusDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GridStatusDto &&
            (identical(other.isAvailable, isAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.isAvailable, isAvailable)) &&
            (identical(other.currentPowerDirection, currentPowerDirection) ||
                const DeepCollectionEquality().equals(
                    other.currentPowerDirection, currentPowerDirection)) &&
            (identical(other.currentPower, currentPower) ||
                const DeepCollectionEquality()
                    .equals(other.currentPower, currentPower)) &&
            (identical(
                    other.maximumPowerConsumption, maximumPowerConsumption) ||
                const DeepCollectionEquality().equals(
                    other.maximumPowerConsumption, maximumPowerConsumption)) &&
            (identical(other.maximumPowerFeedIn, maximumPowerFeedIn) ||
                const DeepCollectionEquality()
                    .equals(other.maximumPowerFeedIn, maximumPowerFeedIn)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isAvailable) ^
      const DeepCollectionEquality().hash(currentPowerDirection) ^
      const DeepCollectionEquality().hash(currentPower) ^
      const DeepCollectionEquality().hash(maximumPowerConsumption) ^
      const DeepCollectionEquality().hash(maximumPowerFeedIn) ^
      runtimeType.hashCode;
}

extension $GridStatusDtoExtension on GridStatusDto {
  GridStatusDto copyWith(
      {bool? isAvailable,
      enums.GridPowerDirection? currentPowerDirection,
      num? currentPower,
      num? maximumPowerConsumption,
      num? maximumPowerFeedIn}) {
    return GridStatusDto(
        isAvailable: isAvailable ?? this.isAvailable,
        currentPowerDirection:
            currentPowerDirection ?? this.currentPowerDirection,
        currentPower: currentPower ?? this.currentPower,
        maximumPowerConsumption:
            maximumPowerConsumption ?? this.maximumPowerConsumption,
        maximumPowerFeedIn: maximumPowerFeedIn ?? this.maximumPowerFeedIn);
  }

  GridStatusDto copyWithWrapped(
      {Wrapped<bool?>? isAvailable,
      Wrapped<enums.GridPowerDirection>? currentPowerDirection,
      Wrapped<num>? currentPower,
      Wrapped<num>? maximumPowerConsumption,
      Wrapped<num>? maximumPowerFeedIn}) {
    return GridStatusDto(
        isAvailable:
            (isAvailable != null ? isAvailable.value : this.isAvailable),
        currentPowerDirection: (currentPowerDirection != null
            ? currentPowerDirection.value
            : this.currentPowerDirection),
        currentPower:
            (currentPower != null ? currentPower.value : this.currentPower),
        maximumPowerConsumption: (maximumPowerConsumption != null
            ? maximumPowerConsumption.value
            : this.maximumPowerConsumption),
        maximumPowerFeedIn: (maximumPowerFeedIn != null
            ? maximumPowerFeedIn.value
            : this.maximumPowerFeedIn));
  }
}

@JsonSerializable(explicitToJson: true)
class HealthReportDto {
  const HealthReportDto({
    required this.name,
    required this.version,
    required this.status,
    required this.totalDuration,
  });

  factory HealthReportDto.fromJson(Map<String, dynamic> json) =>
      _$HealthReportDtoFromJson(json);

  static const toJsonFactory = _$HealthReportDtoToJson;
  Map<String, dynamic> toJson() => _$HealthReportDtoToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'version')
  final String version;
  @JsonKey(
    name: 'status',
    toJson: healthStatusToJson,
    fromJson: healthStatusFromJson,
  )
  final enums.HealthStatus status;
  @JsonKey(name: 'totalDuration')
  final String totalDuration;
  static const fromJsonFactory = _$HealthReportDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is HealthReportDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality()
                    .equals(other.version, version)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.totalDuration, totalDuration) ||
                const DeepCollectionEquality()
                    .equals(other.totalDuration, totalDuration)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(version) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(totalDuration) ^
      runtimeType.hashCode;
}

extension $HealthReportDtoExtension on HealthReportDto {
  HealthReportDto copyWith(
      {String? name,
      String? version,
      enums.HealthStatus? status,
      String? totalDuration}) {
    return HealthReportDto(
        name: name ?? this.name,
        version: version ?? this.version,
        status: status ?? this.status,
        totalDuration: totalDuration ?? this.totalDuration);
  }

  HealthReportDto copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? version,
      Wrapped<enums.HealthStatus>? status,
      Wrapped<String>? totalDuration}) {
    return HealthReportDto(
        name: (name != null ? name.value : this.name),
        version: (version != null ? version.value : this.version),
        status: (status != null ? status.value : this.status),
        totalDuration:
            (totalDuration != null ? totalDuration.value : this.totalDuration));
  }
}

@JsonSerializable(explicitToJson: true)
class HomeStatusDto {
  const HomeStatusDto({
    required this.batteryStatus,
    required this.gridStatus,
    required this.consumerStatus,
    required this.producerStatus,
  });

  factory HomeStatusDto.fromJson(Map<String, dynamic> json) =>
      _$HomeStatusDtoFromJson(json);

  static const toJsonFactory = _$HomeStatusDtoToJson;
  Map<String, dynamic> toJson() => _$HomeStatusDtoToJson(this);

  @JsonKey(name: 'batteryStatus')
  final BatteryStatusDto batteryStatus;
  @JsonKey(name: 'gridStatus')
  final GridStatusDto gridStatus;
  @JsonKey(name: 'consumerStatus')
  final ConsumerStatusDto consumerStatus;
  @JsonKey(name: 'producerStatus')
  final ProducerStatusDto producerStatus;
  static const fromJsonFactory = _$HomeStatusDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is HomeStatusDto &&
            (identical(other.batteryStatus, batteryStatus) ||
                const DeepCollectionEquality()
                    .equals(other.batteryStatus, batteryStatus)) &&
            (identical(other.gridStatus, gridStatus) ||
                const DeepCollectionEquality()
                    .equals(other.gridStatus, gridStatus)) &&
            (identical(other.consumerStatus, consumerStatus) ||
                const DeepCollectionEquality()
                    .equals(other.consumerStatus, consumerStatus)) &&
            (identical(other.producerStatus, producerStatus) ||
                const DeepCollectionEquality()
                    .equals(other.producerStatus, producerStatus)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(batteryStatus) ^
      const DeepCollectionEquality().hash(gridStatus) ^
      const DeepCollectionEquality().hash(consumerStatus) ^
      const DeepCollectionEquality().hash(producerStatus) ^
      runtimeType.hashCode;
}

extension $HomeStatusDtoExtension on HomeStatusDto {
  HomeStatusDto copyWith(
      {BatteryStatusDto? batteryStatus,
      GridStatusDto? gridStatus,
      ConsumerStatusDto? consumerStatus,
      ProducerStatusDto? producerStatus}) {
    return HomeStatusDto(
        batteryStatus: batteryStatus ?? this.batteryStatus,
        gridStatus: gridStatus ?? this.gridStatus,
        consumerStatus: consumerStatus ?? this.consumerStatus,
        producerStatus: producerStatus ?? this.producerStatus);
  }

  HomeStatusDto copyWithWrapped(
      {Wrapped<BatteryStatusDto>? batteryStatus,
      Wrapped<GridStatusDto>? gridStatus,
      Wrapped<ConsumerStatusDto>? consumerStatus,
      Wrapped<ProducerStatusDto>? producerStatus}) {
    return HomeStatusDto(
        batteryStatus:
            (batteryStatus != null ? batteryStatus.value : this.batteryStatus),
        gridStatus: (gridStatus != null ? gridStatus.value : this.gridStatus),
        consumerStatus: (consumerStatus != null
            ? consumerStatus.value
            : this.consumerStatus),
        producerStatus: (producerStatus != null
            ? producerStatus.value
            : this.producerStatus));
  }
}

@JsonSerializable(explicitToJson: true)
class IntegrationDescriptionDto {
  const IntegrationDescriptionDto({
    required this.id,
    required this.name,
  });

  factory IntegrationDescriptionDto.fromJson(Map<String, dynamic> json) =>
      _$IntegrationDescriptionDtoFromJson(json);

  static const toJsonFactory = _$IntegrationDescriptionDtoToJson;
  Map<String, dynamic> toJson() => _$IntegrationDescriptionDtoToJson(this);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$IntegrationDescriptionDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IntegrationDescriptionDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $IntegrationDescriptionDtoExtension on IntegrationDescriptionDto {
  IntegrationDescriptionDto copyWith({String? id, String? name}) {
    return IntegrationDescriptionDto(
        id: id ?? this.id, name: name ?? this.name);
  }

  IntegrationDescriptionDto copyWithWrapped(
      {Wrapped<String>? id, Wrapped<String>? name}) {
    return IntegrationDescriptionDto(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class IntegrationIdentifier {
  const IntegrationIdentifier({
    required this.integration,
    required this.device,
  });

  factory IntegrationIdentifier.fromJson(Map<String, dynamic> json) =>
      _$IntegrationIdentifierFromJson(json);

  static const toJsonFactory = _$IntegrationIdentifierToJson;
  Map<String, dynamic> toJson() => _$IntegrationIdentifierToJson(this);

  @JsonKey(name: 'integration')
  final String integration;
  @JsonKey(name: 'device')
  final String device;
  static const fromJsonFactory = _$IntegrationIdentifierFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IntegrationIdentifier &&
            (identical(other.integration, integration) ||
                const DeepCollectionEquality()
                    .equals(other.integration, integration)) &&
            (identical(other.device, device) ||
                const DeepCollectionEquality().equals(other.device, device)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(integration) ^
      const DeepCollectionEquality().hash(device) ^
      runtimeType.hashCode;
}

extension $IntegrationIdentifierExtension on IntegrationIdentifier {
  IntegrationIdentifier copyWith({String? integration, String? device}) {
    return IntegrationIdentifier(
        integration: integration ?? this.integration,
        device: device ?? this.device);
  }

  IntegrationIdentifier copyWithWrapped(
      {Wrapped<String>? integration, Wrapped<String>? device}) {
    return IntegrationIdentifier(
        integration:
            (integration != null ? integration.value : this.integration),
        device: (device != null ? device.value : this.device));
  }
}

@JsonSerializable(explicitToJson: true)
class ManuallySwitchSwitchConsumerCommand {
  const ManuallySwitchSwitchConsumerCommand({
    required this.switchConsumerId,
    required this.status,
  });

  factory ManuallySwitchSwitchConsumerCommand.fromJson(
          Map<String, dynamic> json) =>
      _$ManuallySwitchSwitchConsumerCommandFromJson(json);

  static const toJsonFactory = _$ManuallySwitchSwitchConsumerCommandToJson;
  Map<String, dynamic> toJson() =>
      _$ManuallySwitchSwitchConsumerCommandToJson(this);

  @JsonKey(name: 'switchConsumerId')
  final String switchConsumerId;
  @JsonKey(
    name: 'status',
    toJson: switchStatusToJson,
    fromJson: switchStatusFromJson,
  )
  final enums.SwitchStatus status;
  static const fromJsonFactory = _$ManuallySwitchSwitchConsumerCommandFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ManuallySwitchSwitchConsumerCommand &&
            (identical(other.switchConsumerId, switchConsumerId) ||
                const DeepCollectionEquality()
                    .equals(other.switchConsumerId, switchConsumerId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(switchConsumerId) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $ManuallySwitchSwitchConsumerCommandExtension
    on ManuallySwitchSwitchConsumerCommand {
  ManuallySwitchSwitchConsumerCommand copyWith(
      {String? switchConsumerId, enums.SwitchStatus? status}) {
    return ManuallySwitchSwitchConsumerCommand(
        switchConsumerId: switchConsumerId ?? this.switchConsumerId,
        status: status ?? this.status);
  }

  ManuallySwitchSwitchConsumerCommand copyWithWrapped(
      {Wrapped<String>? switchConsumerId,
      Wrapped<enums.SwitchStatus>? status}) {
    return ManuallySwitchSwitchConsumerCommand(
        switchConsumerId: (switchConsumerId != null
            ? switchConsumerId.value
            : this.switchConsumerId),
        status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class MeDto {
  const MeDto({
    this.name,
    this.authenticationType,
    required this.claims,
  });

  factory MeDto.fromJson(Map<String, dynamic> json) => _$MeDtoFromJson(json);

  static const toJsonFactory = _$MeDtoToJson;
  Map<String, dynamic> toJson() => _$MeDtoToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'authenticationType')
  final String? authenticationType;
  @JsonKey(name: 'claims')
  final Map<String, dynamic> claims;
  static const fromJsonFactory = _$MeDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MeDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.authenticationType, authenticationType) ||
                const DeepCollectionEquality()
                    .equals(other.authenticationType, authenticationType)) &&
            (identical(other.claims, claims) ||
                const DeepCollectionEquality().equals(other.claims, claims)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(authenticationType) ^
      const DeepCollectionEquality().hash(claims) ^
      runtimeType.hashCode;
}

extension $MeDtoExtension on MeDto {
  MeDto copyWith(
      {String? name,
      String? authenticationType,
      Map<String, dynamic>? claims}) {
    return MeDto(
        name: name ?? this.name,
        authenticationType: authenticationType ?? this.authenticationType,
        claims: claims ?? this.claims);
  }

  MeDto copyWithWrapped(
      {Wrapped<String?>? name,
      Wrapped<String?>? authenticationType,
      Wrapped<Map<String, dynamic>>? claims}) {
    return MeDto(
        name: (name != null ? name.value : this.name),
        authenticationType: (authenticationType != null
            ? authenticationType.value
            : this.authenticationType),
        claims: (claims != null ? claims.value : this.claims));
  }
}

@JsonSerializable(explicitToJson: true)
class ProducerDto {
  const ProducerDto({
    required this.id,
    required this.name,
    this.currentPowerProduction,
  });

  factory ProducerDto.fromJson(Map<String, dynamic> json) =>
      _$ProducerDtoFromJson(json);

  static const toJsonFactory = _$ProducerDtoToJson;
  Map<String, dynamic> toJson() => _$ProducerDtoToJson(this);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'currentPowerProduction')
  final Watt? currentPowerProduction;
  static const fromJsonFactory = _$ProducerDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProducerDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.currentPowerProduction, currentPowerProduction) ||
                const DeepCollectionEquality().equals(
                    other.currentPowerProduction, currentPowerProduction)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(currentPowerProduction) ^
      runtimeType.hashCode;
}

extension $ProducerDtoExtension on ProducerDto {
  ProducerDto copyWith(
      {String? id, String? name, Watt? currentPowerProduction}) {
    return ProducerDto(
        id: id ?? this.id,
        name: name ?? this.name,
        currentPowerProduction:
            currentPowerProduction ?? this.currentPowerProduction);
  }

  ProducerDto copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? name,
      Wrapped<Watt?>? currentPowerProduction}) {
    return ProducerDto(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        currentPowerProduction: (currentPowerProduction != null
            ? currentPowerProduction.value
            : this.currentPowerProduction));
  }
}

@JsonSerializable(explicitToJson: true)
class ProducerStatusDto {
  const ProducerStatusDto({
    this.isAvailable,
    required this.currentPowerProduction,
    required this.maximumPowerProduction,
  });

  factory ProducerStatusDto.fromJson(Map<String, dynamic> json) =>
      _$ProducerStatusDtoFromJson(json);

  static const toJsonFactory = _$ProducerStatusDtoToJson;
  Map<String, dynamic> toJson() => _$ProducerStatusDtoToJson(this);

  @JsonKey(name: 'isAvailable')
  final bool? isAvailable;
  @JsonKey(name: 'currentPowerProduction')
  final num currentPowerProduction;
  @JsonKey(name: 'maximumPowerProduction')
  final num maximumPowerProduction;
  static const fromJsonFactory = _$ProducerStatusDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ProducerStatusDto &&
            (identical(other.isAvailable, isAvailable) ||
                const DeepCollectionEquality()
                    .equals(other.isAvailable, isAvailable)) &&
            (identical(other.currentPowerProduction, currentPowerProduction) ||
                const DeepCollectionEquality().equals(
                    other.currentPowerProduction, currentPowerProduction)) &&
            (identical(other.maximumPowerProduction, maximumPowerProduction) ||
                const DeepCollectionEquality().equals(
                    other.maximumPowerProduction, maximumPowerProduction)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isAvailable) ^
      const DeepCollectionEquality().hash(currentPowerProduction) ^
      const DeepCollectionEquality().hash(maximumPowerProduction) ^
      runtimeType.hashCode;
}

extension $ProducerStatusDtoExtension on ProducerStatusDto {
  ProducerStatusDto copyWith(
      {bool? isAvailable,
      num? currentPowerProduction,
      num? maximumPowerProduction}) {
    return ProducerStatusDto(
        isAvailable: isAvailable ?? this.isAvailable,
        currentPowerProduction:
            currentPowerProduction ?? this.currentPowerProduction,
        maximumPowerProduction:
            maximumPowerProduction ?? this.maximumPowerProduction);
  }

  ProducerStatusDto copyWithWrapped(
      {Wrapped<bool?>? isAvailable,
      Wrapped<num>? currentPowerProduction,
      Wrapped<num>? maximumPowerProduction}) {
    return ProducerStatusDto(
        isAvailable:
            (isAvailable != null ? isAvailable.value : this.isAvailable),
        currentPowerProduction: (currentPowerProduction != null
            ? currentPowerProduction.value
            : this.currentPowerProduction),
        maximumPowerProduction: (maximumPowerProduction != null
            ? maximumPowerProduction.value
            : this.maximumPowerProduction));
  }
}

@JsonSerializable(explicitToJson: true)
class ShellyPermissionGrantUriResponse {
  const ShellyPermissionGrantUriResponse({
    required this.uri,
  });

  factory ShellyPermissionGrantUriResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ShellyPermissionGrantUriResponseFromJson(json);

  static const toJsonFactory = _$ShellyPermissionGrantUriResponseToJson;
  Map<String, dynamic> toJson() =>
      _$ShellyPermissionGrantUriResponseToJson(this);

  @JsonKey(name: 'uri')
  final String uri;
  static const fromJsonFactory = _$ShellyPermissionGrantUriResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ShellyPermissionGrantUriResponse &&
            (identical(other.uri, uri) ||
                const DeepCollectionEquality().equals(other.uri, uri)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(uri) ^ runtimeType.hashCode;
}

extension $ShellyPermissionGrantUriResponseExtension
    on ShellyPermissionGrantUriResponse {
  ShellyPermissionGrantUriResponse copyWith({String? uri}) {
    return ShellyPermissionGrantUriResponse(uri: uri ?? this.uri);
  }

  ShellyPermissionGrantUriResponse copyWithWrapped({Wrapped<String>? uri}) {
    return ShellyPermissionGrantUriResponse(
        uri: (uri != null ? uri.value : this.uri));
  }
}

@JsonSerializable(explicitToJson: true)
class SwitchConsumerDto {
  const SwitchConsumerDto({
    required this.id,
    required this.name,
    required this.mode,
    required this.switchStatus,
    this.currentPowerConsumption,
  });

  factory SwitchConsumerDto.fromJson(Map<String, dynamic> json) =>
      _$SwitchConsumerDtoFromJson(json);

  static const toJsonFactory = _$SwitchConsumerDtoToJson;
  Map<String, dynamic> toJson() => _$SwitchConsumerDtoToJson(this);

  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'mode',
    toJson: controlModeToJson,
    fromJson: controlModeFromJson,
  )
  final enums.ControlMode mode;
  @JsonKey(
    name: 'switchStatus',
    toJson: switchStatusToJson,
    fromJson: switchStatusFromJson,
  )
  final enums.SwitchStatus switchStatus;
  @JsonKey(name: 'currentPowerConsumption')
  final Watt? currentPowerConsumption;
  static const fromJsonFactory = _$SwitchConsumerDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SwitchConsumerDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.mode, mode) ||
                const DeepCollectionEquality().equals(other.mode, mode)) &&
            (identical(other.switchStatus, switchStatus) ||
                const DeepCollectionEquality()
                    .equals(other.switchStatus, switchStatus)) &&
            (identical(
                    other.currentPowerConsumption, currentPowerConsumption) ||
                const DeepCollectionEquality().equals(
                    other.currentPowerConsumption, currentPowerConsumption)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(mode) ^
      const DeepCollectionEquality().hash(switchStatus) ^
      const DeepCollectionEquality().hash(currentPowerConsumption) ^
      runtimeType.hashCode;
}

extension $SwitchConsumerDtoExtension on SwitchConsumerDto {
  SwitchConsumerDto copyWith(
      {String? id,
      String? name,
      enums.ControlMode? mode,
      enums.SwitchStatus? switchStatus,
      Watt? currentPowerConsumption}) {
    return SwitchConsumerDto(
        id: id ?? this.id,
        name: name ?? this.name,
        mode: mode ?? this.mode,
        switchStatus: switchStatus ?? this.switchStatus,
        currentPowerConsumption:
            currentPowerConsumption ?? this.currentPowerConsumption);
  }

  SwitchConsumerDto copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? name,
      Wrapped<enums.ControlMode>? mode,
      Wrapped<enums.SwitchStatus>? switchStatus,
      Wrapped<Watt?>? currentPowerConsumption}) {
    return SwitchConsumerDto(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        mode: (mode != null ? mode.value : this.mode),
        switchStatus:
            (switchStatus != null ? switchStatus.value : this.switchStatus),
        currentPowerConsumption: (currentPowerConsumption != null
            ? currentPowerConsumption.value
            : this.currentPowerConsumption));
  }
}

String? batteryChargeStatusNullableToJson(
    enums.BatteryChargeStatus? batteryChargeStatus) {
  return batteryChargeStatus?.value;
}

String? batteryChargeStatusToJson(
    enums.BatteryChargeStatus batteryChargeStatus) {
  return batteryChargeStatus.value;
}

enums.BatteryChargeStatus batteryChargeStatusFromJson(
  Object? batteryChargeStatus, [
  enums.BatteryChargeStatus? defaultValue,
]) {
  return enums.BatteryChargeStatus.values
          .firstWhereOrNull((e) => e.value == batteryChargeStatus) ??
      defaultValue ??
      enums.BatteryChargeStatus.swaggerGeneratedUnknown;
}

enums.BatteryChargeStatus? batteryChargeStatusNullableFromJson(
  Object? batteryChargeStatus, [
  enums.BatteryChargeStatus? defaultValue,
]) {
  if (batteryChargeStatus == null) {
    return null;
  }
  return enums.BatteryChargeStatus.values
          .firstWhereOrNull((e) => e.value == batteryChargeStatus) ??
      defaultValue;
}

String batteryChargeStatusExplodedListToJson(
    List<enums.BatteryChargeStatus>? batteryChargeStatus) {
  return batteryChargeStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> batteryChargeStatusListToJson(
    List<enums.BatteryChargeStatus>? batteryChargeStatus) {
  if (batteryChargeStatus == null) {
    return [];
  }

  return batteryChargeStatus.map((e) => e.value!).toList();
}

List<enums.BatteryChargeStatus> batteryChargeStatusListFromJson(
  List? batteryChargeStatus, [
  List<enums.BatteryChargeStatus>? defaultValue,
]) {
  if (batteryChargeStatus == null) {
    return defaultValue ?? [];
  }

  return batteryChargeStatus
      .map((e) => batteryChargeStatusFromJson(e.toString()))
      .toList();
}

List<enums.BatteryChargeStatus>? batteryChargeStatusNullableListFromJson(
  List? batteryChargeStatus, [
  List<enums.BatteryChargeStatus>? defaultValue,
]) {
  if (batteryChargeStatus == null) {
    return defaultValue;
  }

  return batteryChargeStatus
      .map((e) => batteryChargeStatusFromJson(e.toString()))
      .toList();
}

String? controlModeNullableToJson(enums.ControlMode? controlMode) {
  return controlMode?.value;
}

String? controlModeToJson(enums.ControlMode controlMode) {
  return controlMode.value;
}

enums.ControlMode controlModeFromJson(
  Object? controlMode, [
  enums.ControlMode? defaultValue,
]) {
  return enums.ControlMode.values
          .firstWhereOrNull((e) => e.value == controlMode) ??
      defaultValue ??
      enums.ControlMode.swaggerGeneratedUnknown;
}

enums.ControlMode? controlModeNullableFromJson(
  Object? controlMode, [
  enums.ControlMode? defaultValue,
]) {
  if (controlMode == null) {
    return null;
  }
  return enums.ControlMode.values
          .firstWhereOrNull((e) => e.value == controlMode) ??
      defaultValue;
}

String controlModeExplodedListToJson(List<enums.ControlMode>? controlMode) {
  return controlMode?.map((e) => e.value!).join(',') ?? '';
}

List<String> controlModeListToJson(List<enums.ControlMode>? controlMode) {
  if (controlMode == null) {
    return [];
  }

  return controlMode.map((e) => e.value!).toList();
}

List<enums.ControlMode> controlModeListFromJson(
  List? controlMode, [
  List<enums.ControlMode>? defaultValue,
]) {
  if (controlMode == null) {
    return defaultValue ?? [];
  }

  return controlMode.map((e) => controlModeFromJson(e.toString())).toList();
}

List<enums.ControlMode>? controlModeNullableListFromJson(
  List? controlMode, [
  List<enums.ControlMode>? defaultValue,
]) {
  if (controlMode == null) {
    return defaultValue;
  }

  return controlMode.map((e) => controlModeFromJson(e.toString())).toList();
}

String? deviceCategoryNullableToJson(enums.DeviceCategory? deviceCategory) {
  return deviceCategory?.value;
}

String? deviceCategoryToJson(enums.DeviceCategory deviceCategory) {
  return deviceCategory.value;
}

enums.DeviceCategory deviceCategoryFromJson(
  Object? deviceCategory, [
  enums.DeviceCategory? defaultValue,
]) {
  return enums.DeviceCategory.values
          .firstWhereOrNull((e) => e.value == deviceCategory) ??
      defaultValue ??
      enums.DeviceCategory.swaggerGeneratedUnknown;
}

enums.DeviceCategory? deviceCategoryNullableFromJson(
  Object? deviceCategory, [
  enums.DeviceCategory? defaultValue,
]) {
  if (deviceCategory == null) {
    return null;
  }
  return enums.DeviceCategory.values
          .firstWhereOrNull((e) => e.value == deviceCategory) ??
      defaultValue;
}

String deviceCategoryExplodedListToJson(
    List<enums.DeviceCategory>? deviceCategory) {
  return deviceCategory?.map((e) => e.value!).join(',') ?? '';
}

List<String> deviceCategoryListToJson(
    List<enums.DeviceCategory>? deviceCategory) {
  if (deviceCategory == null) {
    return [];
  }

  return deviceCategory.map((e) => e.value!).toList();
}

List<enums.DeviceCategory> deviceCategoryListFromJson(
  List? deviceCategory, [
  List<enums.DeviceCategory>? defaultValue,
]) {
  if (deviceCategory == null) {
    return defaultValue ?? [];
  }

  return deviceCategory
      .map((e) => deviceCategoryFromJson(e.toString()))
      .toList();
}

List<enums.DeviceCategory>? deviceCategoryNullableListFromJson(
  List? deviceCategory, [
  List<enums.DeviceCategory>? defaultValue,
]) {
  if (deviceCategory == null) {
    return defaultValue;
  }

  return deviceCategory
      .map((e) => deviceCategoryFromJson(e.toString()))
      .toList();
}

String? gridPowerDirectionNullableToJson(
    enums.GridPowerDirection? gridPowerDirection) {
  return gridPowerDirection?.value;
}

String? gridPowerDirectionToJson(enums.GridPowerDirection gridPowerDirection) {
  return gridPowerDirection.value;
}

enums.GridPowerDirection gridPowerDirectionFromJson(
  Object? gridPowerDirection, [
  enums.GridPowerDirection? defaultValue,
]) {
  return enums.GridPowerDirection.values
          .firstWhereOrNull((e) => e.value == gridPowerDirection) ??
      defaultValue ??
      enums.GridPowerDirection.swaggerGeneratedUnknown;
}

enums.GridPowerDirection? gridPowerDirectionNullableFromJson(
  Object? gridPowerDirection, [
  enums.GridPowerDirection? defaultValue,
]) {
  if (gridPowerDirection == null) {
    return null;
  }
  return enums.GridPowerDirection.values
          .firstWhereOrNull((e) => e.value == gridPowerDirection) ??
      defaultValue;
}

String gridPowerDirectionExplodedListToJson(
    List<enums.GridPowerDirection>? gridPowerDirection) {
  return gridPowerDirection?.map((e) => e.value!).join(',') ?? '';
}

List<String> gridPowerDirectionListToJson(
    List<enums.GridPowerDirection>? gridPowerDirection) {
  if (gridPowerDirection == null) {
    return [];
  }

  return gridPowerDirection.map((e) => e.value!).toList();
}

List<enums.GridPowerDirection> gridPowerDirectionListFromJson(
  List? gridPowerDirection, [
  List<enums.GridPowerDirection>? defaultValue,
]) {
  if (gridPowerDirection == null) {
    return defaultValue ?? [];
  }

  return gridPowerDirection
      .map((e) => gridPowerDirectionFromJson(e.toString()))
      .toList();
}

List<enums.GridPowerDirection>? gridPowerDirectionNullableListFromJson(
  List? gridPowerDirection, [
  List<enums.GridPowerDirection>? defaultValue,
]) {
  if (gridPowerDirection == null) {
    return defaultValue;
  }

  return gridPowerDirection
      .map((e) => gridPowerDirectionFromJson(e.toString()))
      .toList();
}

String? healthStatusNullableToJson(enums.HealthStatus? healthStatus) {
  return healthStatus?.value;
}

String? healthStatusToJson(enums.HealthStatus healthStatus) {
  return healthStatus.value;
}

enums.HealthStatus healthStatusFromJson(
  Object? healthStatus, [
  enums.HealthStatus? defaultValue,
]) {
  return enums.HealthStatus.values
          .firstWhereOrNull((e) => e.value == healthStatus) ??
      defaultValue ??
      enums.HealthStatus.swaggerGeneratedUnknown;
}

enums.HealthStatus? healthStatusNullableFromJson(
  Object? healthStatus, [
  enums.HealthStatus? defaultValue,
]) {
  if (healthStatus == null) {
    return null;
  }
  return enums.HealthStatus.values
          .firstWhereOrNull((e) => e.value == healthStatus) ??
      defaultValue;
}

String healthStatusExplodedListToJson(List<enums.HealthStatus>? healthStatus) {
  return healthStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> healthStatusListToJson(List<enums.HealthStatus>? healthStatus) {
  if (healthStatus == null) {
    return [];
  }

  return healthStatus.map((e) => e.value!).toList();
}

List<enums.HealthStatus> healthStatusListFromJson(
  List? healthStatus, [
  List<enums.HealthStatus>? defaultValue,
]) {
  if (healthStatus == null) {
    return defaultValue ?? [];
  }

  return healthStatus.map((e) => healthStatusFromJson(e.toString())).toList();
}

List<enums.HealthStatus>? healthStatusNullableListFromJson(
  List? healthStatus, [
  List<enums.HealthStatus>? defaultValue,
]) {
  if (healthStatus == null) {
    return defaultValue;
  }

  return healthStatus.map((e) => healthStatusFromJson(e.toString())).toList();
}

String? switchStatusNullableToJson(enums.SwitchStatus? switchStatus) {
  return switchStatus?.value;
}

String? switchStatusToJson(enums.SwitchStatus switchStatus) {
  return switchStatus.value;
}

enums.SwitchStatus switchStatusFromJson(
  Object? switchStatus, [
  enums.SwitchStatus? defaultValue,
]) {
  return enums.SwitchStatus.values
          .firstWhereOrNull((e) => e.value == switchStatus) ??
      defaultValue ??
      enums.SwitchStatus.swaggerGeneratedUnknown;
}

enums.SwitchStatus? switchStatusNullableFromJson(
  Object? switchStatus, [
  enums.SwitchStatus? defaultValue,
]) {
  if (switchStatus == null) {
    return null;
  }
  return enums.SwitchStatus.values
          .firstWhereOrNull((e) => e.value == switchStatus) ??
      defaultValue;
}

String switchStatusExplodedListToJson(List<enums.SwitchStatus>? switchStatus) {
  return switchStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> switchStatusListToJson(List<enums.SwitchStatus>? switchStatus) {
  if (switchStatus == null) {
    return [];
  }

  return switchStatus.map((e) => e.value!).toList();
}

List<enums.SwitchStatus> switchStatusListFromJson(
  List? switchStatus, [
  List<enums.SwitchStatus>? defaultValue,
]) {
  if (switchStatus == null) {
    return defaultValue ?? [];
  }

  return switchStatus.map((e) => switchStatusFromJson(e.toString())).toList();
}

List<enums.SwitchStatus>? switchStatusNullableListFromJson(
  List? switchStatus, [
  List<enums.SwitchStatus>? defaultValue,
]) {
  if (switchStatus == null) {
    return defaultValue;
  }

  return switchStatus.map((e) => switchStatusFromJson(e.toString())).toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}

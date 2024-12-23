// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'backend_api.enums.swagger.dart' as enums;
import '../value_objects.dart';

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
class AnalyticsMetricsDto {
  const AnalyticsMetricsDto({
    required this.ownConsumption,
    required this.selfSufficiency,
  });

  factory AnalyticsMetricsDto.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsMetricsDtoFromJson(json);

  static const toJsonFactory = _$AnalyticsMetricsDtoToJson;
  Map<String, dynamic> toJson() => _$AnalyticsMetricsDtoToJson(this);

  @JsonKey(name: 'ownConsumption')
  final OwnConsumptionMetricDto ownConsumption;
  @JsonKey(name: 'selfSufficiency')
  final SelfSufficiencyMetricDto selfSufficiency;
  static const fromJsonFactory = _$AnalyticsMetricsDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnalyticsMetricsDto &&
            (identical(other.ownConsumption, ownConsumption) ||
                const DeepCollectionEquality()
                    .equals(other.ownConsumption, ownConsumption)) &&
            (identical(other.selfSufficiency, selfSufficiency) ||
                const DeepCollectionEquality()
                    .equals(other.selfSufficiency, selfSufficiency)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(ownConsumption) ^
      const DeepCollectionEquality().hash(selfSufficiency) ^
      runtimeType.hashCode;
}

extension $AnalyticsMetricsDtoExtension on AnalyticsMetricsDto {
  AnalyticsMetricsDto copyWith(
      {OwnConsumptionMetricDto? ownConsumption,
      SelfSufficiencyMetricDto? selfSufficiency}) {
    return AnalyticsMetricsDto(
        ownConsumption: ownConsumption ?? this.ownConsumption,
        selfSufficiency: selfSufficiency ?? this.selfSufficiency);
  }

  AnalyticsMetricsDto copyWithWrapped(
      {Wrapped<OwnConsumptionMetricDto>? ownConsumption,
      Wrapped<SelfSufficiencyMetricDto>? selfSufficiency}) {
    return AnalyticsMetricsDto(
        ownConsumption: (ownConsumption != null
            ? ownConsumption.value
            : this.ownConsumption),
        selfSufficiency: (selfSufficiency != null
            ? selfSufficiency.value
            : this.selfSufficiency));
  }
}

@JsonSerializable(explicitToJson: true)
class AnnualAnalysisDto {
  const AnnualAnalysisDto({
    required this.energyHistory,
    required this.metrics,
  });

  factory AnnualAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$AnnualAnalysisDtoFromJson(json);

  static const toJsonFactory = _$AnnualAnalysisDtoToJson;
  Map<String, dynamic> toJson() => _$AnnualAnalysisDtoToJson(this);

  @JsonKey(name: 'energyHistory')
  final AnnualEnergyHistoryDto energyHistory;
  @JsonKey(name: 'metrics')
  final AnalyticsMetricsDto metrics;
  static const fromJsonFactory = _$AnnualAnalysisDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnnualAnalysisDto &&
            (identical(other.energyHistory, energyHistory) ||
                const DeepCollectionEquality()
                    .equals(other.energyHistory, energyHistory)) &&
            (identical(other.metrics, metrics) ||
                const DeepCollectionEquality().equals(other.metrics, metrics)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(energyHistory) ^
      const DeepCollectionEquality().hash(metrics) ^
      runtimeType.hashCode;
}

extension $AnnualAnalysisDtoExtension on AnnualAnalysisDto {
  AnnualAnalysisDto copyWith(
      {AnnualEnergyHistoryDto? energyHistory, AnalyticsMetricsDto? metrics}) {
    return AnnualAnalysisDto(
        energyHistory: energyHistory ?? this.energyHistory,
        metrics: metrics ?? this.metrics);
  }

  AnnualAnalysisDto copyWithWrapped(
      {Wrapped<AnnualEnergyHistoryDto>? energyHistory,
      Wrapped<AnalyticsMetricsDto>? metrics}) {
    return AnnualAnalysisDto(
        energyHistory:
            (energyHistory != null ? energyHistory.value : this.energyHistory),
        metrics: (metrics != null ? metrics.value : this.metrics));
  }
}

@JsonSerializable(explicitToJson: true)
class AnnualEnergyDataPointDto {
  const AnnualEnergyDataPointDto({
    required this.month,
    required this.energy,
  });

  factory AnnualEnergyDataPointDto.fromJson(Map<String, dynamic> json) =>
      _$AnnualEnergyDataPointDtoFromJson(json);

  static const toJsonFactory = _$AnnualEnergyDataPointDtoToJson;
  Map<String, dynamic> toJson() => _$AnnualEnergyDataPointDtoToJson(this);

  @JsonKey(name: 'month')
  final int month;
  @JsonKey(name: 'energy')
  final WattHours energy;
  static const fromJsonFactory = _$AnnualEnergyDataPointDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnnualEnergyDataPointDto &&
            (identical(other.month, month) ||
                const DeepCollectionEquality().equals(other.month, month)) &&
            (identical(other.energy, energy) ||
                const DeepCollectionEquality().equals(other.energy, energy)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(month) ^
      const DeepCollectionEquality().hash(energy) ^
      runtimeType.hashCode;
}

extension $AnnualEnergyDataPointDtoExtension on AnnualEnergyDataPointDto {
  AnnualEnergyDataPointDto copyWith({int? month, WattHours? energy}) {
    return AnnualEnergyDataPointDto(
        month: month ?? this.month, energy: energy ?? this.energy);
  }

  AnnualEnergyDataPointDto copyWithWrapped(
      {Wrapped<int>? month, Wrapped<WattHours>? energy}) {
    return AnnualEnergyDataPointDto(
        month: (month != null ? month.value : this.month),
        energy: (energy != null ? energy.value : this.energy));
  }
}

@JsonSerializable(explicitToJson: true)
class AnnualEnergyHistoryDto {
  const AnnualEnergyHistoryDto({
    required this.consumers,
    required this.producers,
    required this.electricityMetersConsumption,
    required this.electricityMetersFeedIn,
  });

  factory AnnualEnergyHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$AnnualEnergyHistoryDtoFromJson(json);

  static const toJsonFactory = _$AnnualEnergyHistoryDtoToJson;
  Map<String, dynamic> toJson() => _$AnnualEnergyHistoryDtoToJson(this);

  @JsonKey(name: 'consumers', defaultValue: <AnnualEnergyDataPointDto>[])
  final List<AnnualEnergyDataPointDto> consumers;
  @JsonKey(name: 'producers', defaultValue: <AnnualEnergyDataPointDto>[])
  final List<AnnualEnergyDataPointDto> producers;
  @JsonKey(
      name: 'electricityMetersConsumption',
      defaultValue: <AnnualEnergyDataPointDto>[])
  final List<AnnualEnergyDataPointDto> electricityMetersConsumption;
  @JsonKey(
      name: 'electricityMetersFeedIn',
      defaultValue: <AnnualEnergyDataPointDto>[])
  final List<AnnualEnergyDataPointDto> electricityMetersFeedIn;
  static const fromJsonFactory = _$AnnualEnergyHistoryDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AnnualEnergyHistoryDto &&
            (identical(other.consumers, consumers) ||
                const DeepCollectionEquality()
                    .equals(other.consumers, consumers)) &&
            (identical(other.producers, producers) ||
                const DeepCollectionEquality()
                    .equals(other.producers, producers)) &&
            (identical(other.electricityMetersConsumption,
                    electricityMetersConsumption) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersConsumption,
                    electricityMetersConsumption)) &&
            (identical(
                    other.electricityMetersFeedIn, electricityMetersFeedIn) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersFeedIn, electricityMetersFeedIn)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(consumers) ^
      const DeepCollectionEquality().hash(producers) ^
      const DeepCollectionEquality().hash(electricityMetersConsumption) ^
      const DeepCollectionEquality().hash(electricityMetersFeedIn) ^
      runtimeType.hashCode;
}

extension $AnnualEnergyHistoryDtoExtension on AnnualEnergyHistoryDto {
  AnnualEnergyHistoryDto copyWith(
      {List<AnnualEnergyDataPointDto>? consumers,
      List<AnnualEnergyDataPointDto>? producers,
      List<AnnualEnergyDataPointDto>? electricityMetersConsumption,
      List<AnnualEnergyDataPointDto>? electricityMetersFeedIn}) {
    return AnnualEnergyHistoryDto(
        consumers: consumers ?? this.consumers,
        producers: producers ?? this.producers,
        electricityMetersConsumption:
            electricityMetersConsumption ?? this.electricityMetersConsumption,
        electricityMetersFeedIn:
            electricityMetersFeedIn ?? this.electricityMetersFeedIn);
  }

  AnnualEnergyHistoryDto copyWithWrapped(
      {Wrapped<List<AnnualEnergyDataPointDto>>? consumers,
      Wrapped<List<AnnualEnergyDataPointDto>>? producers,
      Wrapped<List<AnnualEnergyDataPointDto>>? electricityMetersConsumption,
      Wrapped<List<AnnualEnergyDataPointDto>>? electricityMetersFeedIn}) {
    return AnnualEnergyHistoryDto(
        consumers: (consumers != null ? consumers.value : this.consumers),
        producers: (producers != null ? producers.value : this.producers),
        electricityMetersConsumption: (electricityMetersConsumption != null
            ? electricityMetersConsumption.value
            : this.electricityMetersConsumption),
        electricityMetersFeedIn: (electricityMetersFeedIn != null
            ? electricityMetersFeedIn.value
            : this.electricityMetersFeedIn));
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
  final Percentage charge;
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
      Percentage? charge}) {
    return BatteryStatusDto(
        isAvailable: isAvailable ?? this.isAvailable,
        chargeStatus: chargeStatus ?? this.chargeStatus,
        charge: charge ?? this.charge);
  }

  BatteryStatusDto copyWithWrapped(
      {Wrapped<bool?>? isAvailable,
      Wrapped<enums.BatteryChargeStatus>? chargeStatus,
      Wrapped<Percentage>? charge}) {
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
  final Watt currentPowerConsumption;
  @JsonKey(name: 'maximumPowerConsumption')
  final Watt maximumPowerConsumption;
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
      Watt? currentPowerConsumption,
      Watt? maximumPowerConsumption}) {
    return ConsumerStatusDto(
        isAvailable: isAvailable ?? this.isAvailable,
        currentPowerConsumption:
            currentPowerConsumption ?? this.currentPowerConsumption,
        maximumPowerConsumption:
            maximumPowerConsumption ?? this.maximumPowerConsumption);
  }

  ConsumerStatusDto copyWithWrapped(
      {Wrapped<bool?>? isAvailable,
      Wrapped<Watt>? currentPowerConsumption,
      Wrapped<Watt>? maximumPowerConsumption}) {
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
class DailyAnalysisDto {
  const DailyAnalysisDto({
    required this.powerHistory,
    required this.metrics,
  });

  factory DailyAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$DailyAnalysisDtoFromJson(json);

  static const toJsonFactory = _$DailyAnalysisDtoToJson;
  Map<String, dynamic> toJson() => _$DailyAnalysisDtoToJson(this);

  @JsonKey(name: 'powerHistory')
  final PowerHistoryDto powerHistory;
  @JsonKey(name: 'metrics')
  final AnalyticsMetricsDto metrics;
  static const fromJsonFactory = _$DailyAnalysisDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DailyAnalysisDto &&
            (identical(other.powerHistory, powerHistory) ||
                const DeepCollectionEquality()
                    .equals(other.powerHistory, powerHistory)) &&
            (identical(other.metrics, metrics) ||
                const DeepCollectionEquality().equals(other.metrics, metrics)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(powerHistory) ^
      const DeepCollectionEquality().hash(metrics) ^
      runtimeType.hashCode;
}

extension $DailyAnalysisDtoExtension on DailyAnalysisDto {
  DailyAnalysisDto copyWith(
      {PowerHistoryDto? powerHistory, AnalyticsMetricsDto? metrics}) {
    return DailyAnalysisDto(
        powerHistory: powerHistory ?? this.powerHistory,
        metrics: metrics ?? this.metrics);
  }

  DailyAnalysisDto copyWithWrapped(
      {Wrapped<PowerHistoryDto>? powerHistory,
      Wrapped<AnalyticsMetricsDto>? metrics}) {
    return DailyAnalysisDto(
        powerHistory:
            (powerHistory != null ? powerHistory.value : this.powerHistory),
        metrics: (metrics != null ? metrics.value : this.metrics));
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
  final Watt currentPower;
  @JsonKey(name: 'maximumPowerConsumption')
  final Watt maximumPowerConsumption;
  @JsonKey(name: 'maximumPowerFeedIn')
  final Watt maximumPowerFeedIn;
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
      Watt? currentPower,
      Watt? maximumPowerConsumption,
      Watt? maximumPowerFeedIn}) {
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
      Wrapped<Watt>? currentPower,
      Wrapped<Watt>? maximumPowerConsumption,
      Wrapped<Watt>? maximumPowerFeedIn}) {
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
class MonthlyAnalysisDto {
  const MonthlyAnalysisDto({
    required this.energyHistory,
    required this.metrics,
  });

  factory MonthlyAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlyAnalysisDtoFromJson(json);

  static const toJsonFactory = _$MonthlyAnalysisDtoToJson;
  Map<String, dynamic> toJson() => _$MonthlyAnalysisDtoToJson(this);

  @JsonKey(name: 'energyHistory')
  final MonthlyEnergyHistoryDto energyHistory;
  @JsonKey(name: 'metrics')
  final AnalyticsMetricsDto metrics;
  static const fromJsonFactory = _$MonthlyAnalysisDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MonthlyAnalysisDto &&
            (identical(other.energyHistory, energyHistory) ||
                const DeepCollectionEquality()
                    .equals(other.energyHistory, energyHistory)) &&
            (identical(other.metrics, metrics) ||
                const DeepCollectionEquality().equals(other.metrics, metrics)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(energyHistory) ^
      const DeepCollectionEquality().hash(metrics) ^
      runtimeType.hashCode;
}

extension $MonthlyAnalysisDtoExtension on MonthlyAnalysisDto {
  MonthlyAnalysisDto copyWith(
      {MonthlyEnergyHistoryDto? energyHistory, AnalyticsMetricsDto? metrics}) {
    return MonthlyAnalysisDto(
        energyHistory: energyHistory ?? this.energyHistory,
        metrics: metrics ?? this.metrics);
  }

  MonthlyAnalysisDto copyWithWrapped(
      {Wrapped<MonthlyEnergyHistoryDto>? energyHistory,
      Wrapped<AnalyticsMetricsDto>? metrics}) {
    return MonthlyAnalysisDto(
        energyHistory:
            (energyHistory != null ? energyHistory.value : this.energyHistory),
        metrics: (metrics != null ? metrics.value : this.metrics));
  }
}

@JsonSerializable(explicitToJson: true)
class MonthlyEnergyDataPointDto {
  const MonthlyEnergyDataPointDto({
    required this.dayOfMonth,
    required this.energy,
  });

  factory MonthlyEnergyDataPointDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlyEnergyDataPointDtoFromJson(json);

  static const toJsonFactory = _$MonthlyEnergyDataPointDtoToJson;
  Map<String, dynamic> toJson() => _$MonthlyEnergyDataPointDtoToJson(this);

  @JsonKey(name: 'dayOfMonth')
  final int dayOfMonth;
  @JsonKey(name: 'energy')
  final WattHours energy;
  static const fromJsonFactory = _$MonthlyEnergyDataPointDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MonthlyEnergyDataPointDto &&
            (identical(other.dayOfMonth, dayOfMonth) ||
                const DeepCollectionEquality()
                    .equals(other.dayOfMonth, dayOfMonth)) &&
            (identical(other.energy, energy) ||
                const DeepCollectionEquality().equals(other.energy, energy)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dayOfMonth) ^
      const DeepCollectionEquality().hash(energy) ^
      runtimeType.hashCode;
}

extension $MonthlyEnergyDataPointDtoExtension on MonthlyEnergyDataPointDto {
  MonthlyEnergyDataPointDto copyWith({int? dayOfMonth, WattHours? energy}) {
    return MonthlyEnergyDataPointDto(
        dayOfMonth: dayOfMonth ?? this.dayOfMonth,
        energy: energy ?? this.energy);
  }

  MonthlyEnergyDataPointDto copyWithWrapped(
      {Wrapped<int>? dayOfMonth, Wrapped<WattHours>? energy}) {
    return MonthlyEnergyDataPointDto(
        dayOfMonth: (dayOfMonth != null ? dayOfMonth.value : this.dayOfMonth),
        energy: (energy != null ? energy.value : this.energy));
  }
}

@JsonSerializable(explicitToJson: true)
class MonthlyEnergyHistoryDto {
  const MonthlyEnergyHistoryDto({
    required this.consumers,
    required this.producers,
    required this.electricityMetersConsumption,
    required this.electricityMetersFeedIn,
  });

  factory MonthlyEnergyHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlyEnergyHistoryDtoFromJson(json);

  static const toJsonFactory = _$MonthlyEnergyHistoryDtoToJson;
  Map<String, dynamic> toJson() => _$MonthlyEnergyHistoryDtoToJson(this);

  @JsonKey(name: 'consumers', defaultValue: <MonthlyEnergyDataPointDto>[])
  final List<MonthlyEnergyDataPointDto> consumers;
  @JsonKey(name: 'producers', defaultValue: <MonthlyEnergyDataPointDto>[])
  final List<MonthlyEnergyDataPointDto> producers;
  @JsonKey(
      name: 'electricityMetersConsumption',
      defaultValue: <MonthlyEnergyDataPointDto>[])
  final List<MonthlyEnergyDataPointDto> electricityMetersConsumption;
  @JsonKey(
      name: 'electricityMetersFeedIn',
      defaultValue: <MonthlyEnergyDataPointDto>[])
  final List<MonthlyEnergyDataPointDto> electricityMetersFeedIn;
  static const fromJsonFactory = _$MonthlyEnergyHistoryDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MonthlyEnergyHistoryDto &&
            (identical(other.consumers, consumers) ||
                const DeepCollectionEquality()
                    .equals(other.consumers, consumers)) &&
            (identical(other.producers, producers) ||
                const DeepCollectionEquality()
                    .equals(other.producers, producers)) &&
            (identical(other.electricityMetersConsumption,
                    electricityMetersConsumption) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersConsumption,
                    electricityMetersConsumption)) &&
            (identical(
                    other.electricityMetersFeedIn, electricityMetersFeedIn) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersFeedIn, electricityMetersFeedIn)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(consumers) ^
      const DeepCollectionEquality().hash(producers) ^
      const DeepCollectionEquality().hash(electricityMetersConsumption) ^
      const DeepCollectionEquality().hash(electricityMetersFeedIn) ^
      runtimeType.hashCode;
}

extension $MonthlyEnergyHistoryDtoExtension on MonthlyEnergyHistoryDto {
  MonthlyEnergyHistoryDto copyWith(
      {List<MonthlyEnergyDataPointDto>? consumers,
      List<MonthlyEnergyDataPointDto>? producers,
      List<MonthlyEnergyDataPointDto>? electricityMetersConsumption,
      List<MonthlyEnergyDataPointDto>? electricityMetersFeedIn}) {
    return MonthlyEnergyHistoryDto(
        consumers: consumers ?? this.consumers,
        producers: producers ?? this.producers,
        electricityMetersConsumption:
            electricityMetersConsumption ?? this.electricityMetersConsumption,
        electricityMetersFeedIn:
            electricityMetersFeedIn ?? this.electricityMetersFeedIn);
  }

  MonthlyEnergyHistoryDto copyWithWrapped(
      {Wrapped<List<MonthlyEnergyDataPointDto>>? consumers,
      Wrapped<List<MonthlyEnergyDataPointDto>>? producers,
      Wrapped<List<MonthlyEnergyDataPointDto>>? electricityMetersConsumption,
      Wrapped<List<MonthlyEnergyDataPointDto>>? electricityMetersFeedIn}) {
    return MonthlyEnergyHistoryDto(
        consumers: (consumers != null ? consumers.value : this.consumers),
        producers: (producers != null ? producers.value : this.producers),
        electricityMetersConsumption: (electricityMetersConsumption != null
            ? electricityMetersConsumption.value
            : this.electricityMetersConsumption),
        electricityMetersFeedIn: (electricityMetersFeedIn != null
            ? electricityMetersFeedIn.value
            : this.electricityMetersFeedIn));
  }
}

@JsonSerializable(explicitToJson: true)
class OwnConsumptionMetricDto {
  const OwnConsumptionMetricDto({
    required this.percentage,
    required this.ownConsumption,
    required this.gridFeedIn,
    required this.production,
  });

  factory OwnConsumptionMetricDto.fromJson(Map<String, dynamic> json) =>
      _$OwnConsumptionMetricDtoFromJson(json);

  static const toJsonFactory = _$OwnConsumptionMetricDtoToJson;
  Map<String, dynamic> toJson() => _$OwnConsumptionMetricDtoToJson(this);

  @JsonKey(name: 'percentage')
  final Percentage percentage;
  @JsonKey(name: 'ownConsumption')
  final WattHours ownConsumption;
  @JsonKey(name: 'gridFeedIn')
  final WattHours gridFeedIn;
  @JsonKey(name: 'production')
  final WattHours production;
  static const fromJsonFactory = _$OwnConsumptionMetricDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OwnConsumptionMetricDto &&
            (identical(other.percentage, percentage) ||
                const DeepCollectionEquality()
                    .equals(other.percentage, percentage)) &&
            (identical(other.ownConsumption, ownConsumption) ||
                const DeepCollectionEquality()
                    .equals(other.ownConsumption, ownConsumption)) &&
            (identical(other.gridFeedIn, gridFeedIn) ||
                const DeepCollectionEquality()
                    .equals(other.gridFeedIn, gridFeedIn)) &&
            (identical(other.production, production) ||
                const DeepCollectionEquality()
                    .equals(other.production, production)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(percentage) ^
      const DeepCollectionEquality().hash(ownConsumption) ^
      const DeepCollectionEquality().hash(gridFeedIn) ^
      const DeepCollectionEquality().hash(production) ^
      runtimeType.hashCode;
}

extension $OwnConsumptionMetricDtoExtension on OwnConsumptionMetricDto {
  OwnConsumptionMetricDto copyWith(
      {Percentage? percentage,
      WattHours? ownConsumption,
      WattHours? gridFeedIn,
      WattHours? production}) {
    return OwnConsumptionMetricDto(
        percentage: percentage ?? this.percentage,
        ownConsumption: ownConsumption ?? this.ownConsumption,
        gridFeedIn: gridFeedIn ?? this.gridFeedIn,
        production: production ?? this.production);
  }

  OwnConsumptionMetricDto copyWithWrapped(
      {Wrapped<Percentage>? percentage,
      Wrapped<WattHours>? ownConsumption,
      Wrapped<WattHours>? gridFeedIn,
      Wrapped<WattHours>? production}) {
    return OwnConsumptionMetricDto(
        percentage: (percentage != null ? percentage.value : this.percentage),
        ownConsumption: (ownConsumption != null
            ? ownConsumption.value
            : this.ownConsumption),
        gridFeedIn: (gridFeedIn != null ? gridFeedIn.value : this.gridFeedIn),
        production: (production != null ? production.value : this.production));
  }
}

@JsonSerializable(explicitToJson: true)
class PowerDataPointDto {
  const PowerDataPointDto({
    required this.timestamp,
    required this.power,
  });

  factory PowerDataPointDto.fromJson(Map<String, dynamic> json) =>
      _$PowerDataPointDtoFromJson(json);

  static const toJsonFactory = _$PowerDataPointDtoToJson;
  Map<String, dynamic> toJson() => _$PowerDataPointDtoToJson(this);

  @JsonKey(name: 'timestamp')
  final DateTime timestamp;
  @JsonKey(name: 'power')
  final Watt power;
  static const fromJsonFactory = _$PowerDataPointDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PowerDataPointDto &&
            (identical(other.timestamp, timestamp) ||
                const DeepCollectionEquality()
                    .equals(other.timestamp, timestamp)) &&
            (identical(other.power, power) ||
                const DeepCollectionEquality().equals(other.power, power)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(timestamp) ^
      const DeepCollectionEquality().hash(power) ^
      runtimeType.hashCode;
}

extension $PowerDataPointDtoExtension on PowerDataPointDto {
  PowerDataPointDto copyWith({DateTime? timestamp, Watt? power}) {
    return PowerDataPointDto(
        timestamp: timestamp ?? this.timestamp, power: power ?? this.power);
  }

  PowerDataPointDto copyWithWrapped(
      {Wrapped<DateTime>? timestamp, Wrapped<Watt>? power}) {
    return PowerDataPointDto(
        timestamp: (timestamp != null ? timestamp.value : this.timestamp),
        power: (power != null ? power.value : this.power));
  }
}

@JsonSerializable(explicitToJson: true)
class PowerHistoryDto {
  const PowerHistoryDto({
    required this.consumers,
    required this.producers,
    required this.electricityMetersConsume,
    required this.electricityMetersFeedIn,
  });

  factory PowerHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$PowerHistoryDtoFromJson(json);

  static const toJsonFactory = _$PowerHistoryDtoToJson;
  Map<String, dynamic> toJson() => _$PowerHistoryDtoToJson(this);

  @JsonKey(name: 'consumers', defaultValue: <PowerDataPointDto>[])
  final List<PowerDataPointDto> consumers;
  @JsonKey(name: 'producers', defaultValue: <PowerDataPointDto>[])
  final List<PowerDataPointDto> producers;
  @JsonKey(
      name: 'electricityMetersConsume', defaultValue: <PowerDataPointDto>[])
  final List<PowerDataPointDto> electricityMetersConsume;
  @JsonKey(name: 'electricityMetersFeedIn', defaultValue: <PowerDataPointDto>[])
  final List<PowerDataPointDto> electricityMetersFeedIn;
  static const fromJsonFactory = _$PowerHistoryDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PowerHistoryDto &&
            (identical(other.consumers, consumers) ||
                const DeepCollectionEquality()
                    .equals(other.consumers, consumers)) &&
            (identical(other.producers, producers) ||
                const DeepCollectionEquality()
                    .equals(other.producers, producers)) &&
            (identical(
                    other.electricityMetersConsume, electricityMetersConsume) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersConsume,
                    electricityMetersConsume)) &&
            (identical(
                    other.electricityMetersFeedIn, electricityMetersFeedIn) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersFeedIn, electricityMetersFeedIn)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(consumers) ^
      const DeepCollectionEquality().hash(producers) ^
      const DeepCollectionEquality().hash(electricityMetersConsume) ^
      const DeepCollectionEquality().hash(electricityMetersFeedIn) ^
      runtimeType.hashCode;
}

extension $PowerHistoryDtoExtension on PowerHistoryDto {
  PowerHistoryDto copyWith(
      {List<PowerDataPointDto>? consumers,
      List<PowerDataPointDto>? producers,
      List<PowerDataPointDto>? electricityMetersConsume,
      List<PowerDataPointDto>? electricityMetersFeedIn}) {
    return PowerHistoryDto(
        consumers: consumers ?? this.consumers,
        producers: producers ?? this.producers,
        electricityMetersConsume:
            electricityMetersConsume ?? this.electricityMetersConsume,
        electricityMetersFeedIn:
            electricityMetersFeedIn ?? this.electricityMetersFeedIn);
  }

  PowerHistoryDto copyWithWrapped(
      {Wrapped<List<PowerDataPointDto>>? consumers,
      Wrapped<List<PowerDataPointDto>>? producers,
      Wrapped<List<PowerDataPointDto>>? electricityMetersConsume,
      Wrapped<List<PowerDataPointDto>>? electricityMetersFeedIn}) {
    return PowerHistoryDto(
        consumers: (consumers != null ? consumers.value : this.consumers),
        producers: (producers != null ? producers.value : this.producers),
        electricityMetersConsume: (electricityMetersConsume != null
            ? electricityMetersConsume.value
            : this.electricityMetersConsume),
        electricityMetersFeedIn: (electricityMetersFeedIn != null
            ? electricityMetersFeedIn.value
            : this.electricityMetersFeedIn));
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
  final Watt currentPowerProduction;
  @JsonKey(name: 'maximumPowerProduction')
  final Watt maximumPowerProduction;
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
      Watt? currentPowerProduction,
      Watt? maximumPowerProduction}) {
    return ProducerStatusDto(
        isAvailable: isAvailable ?? this.isAvailable,
        currentPowerProduction:
            currentPowerProduction ?? this.currentPowerProduction,
        maximumPowerProduction:
            maximumPowerProduction ?? this.maximumPowerProduction);
  }

  ProducerStatusDto copyWithWrapped(
      {Wrapped<bool?>? isAvailable,
      Wrapped<Watt>? currentPowerProduction,
      Wrapped<Watt>? maximumPowerProduction}) {
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
class SelfSufficiencyMetricDto {
  const SelfSufficiencyMetricDto({
    required this.percentage,
    required this.ownConsumption,
    required this.gridConsumption,
    required this.totalConsumption,
  });

  factory SelfSufficiencyMetricDto.fromJson(Map<String, dynamic> json) =>
      _$SelfSufficiencyMetricDtoFromJson(json);

  static const toJsonFactory = _$SelfSufficiencyMetricDtoToJson;
  Map<String, dynamic> toJson() => _$SelfSufficiencyMetricDtoToJson(this);

  @JsonKey(name: 'percentage')
  final Percentage percentage;
  @JsonKey(name: 'ownConsumption')
  final WattHours ownConsumption;
  @JsonKey(name: 'gridConsumption')
  final WattHours gridConsumption;
  @JsonKey(name: 'totalConsumption')
  final WattHours totalConsumption;
  static const fromJsonFactory = _$SelfSufficiencyMetricDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SelfSufficiencyMetricDto &&
            (identical(other.percentage, percentage) ||
                const DeepCollectionEquality()
                    .equals(other.percentage, percentage)) &&
            (identical(other.ownConsumption, ownConsumption) ||
                const DeepCollectionEquality()
                    .equals(other.ownConsumption, ownConsumption)) &&
            (identical(other.gridConsumption, gridConsumption) ||
                const DeepCollectionEquality()
                    .equals(other.gridConsumption, gridConsumption)) &&
            (identical(other.totalConsumption, totalConsumption) ||
                const DeepCollectionEquality()
                    .equals(other.totalConsumption, totalConsumption)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(percentage) ^
      const DeepCollectionEquality().hash(ownConsumption) ^
      const DeepCollectionEquality().hash(gridConsumption) ^
      const DeepCollectionEquality().hash(totalConsumption) ^
      runtimeType.hashCode;
}

extension $SelfSufficiencyMetricDtoExtension on SelfSufficiencyMetricDto {
  SelfSufficiencyMetricDto copyWith(
      {Percentage? percentage,
      WattHours? ownConsumption,
      WattHours? gridConsumption,
      WattHours? totalConsumption}) {
    return SelfSufficiencyMetricDto(
        percentage: percentage ?? this.percentage,
        ownConsumption: ownConsumption ?? this.ownConsumption,
        gridConsumption: gridConsumption ?? this.gridConsumption,
        totalConsumption: totalConsumption ?? this.totalConsumption);
  }

  SelfSufficiencyMetricDto copyWithWrapped(
      {Wrapped<Percentage>? percentage,
      Wrapped<WattHours>? ownConsumption,
      Wrapped<WattHours>? gridConsumption,
      Wrapped<WattHours>? totalConsumption}) {
    return SelfSufficiencyMetricDto(
        percentage: (percentage != null ? percentage.value : this.percentage),
        ownConsumption: (ownConsumption != null
            ? ownConsumption.value
            : this.ownConsumption),
        gridConsumption: (gridConsumption != null
            ? gridConsumption.value
            : this.gridConsumption),
        totalConsumption: (totalConsumption != null
            ? totalConsumption.value
            : this.totalConsumption));
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

@JsonSerializable(explicitToJson: true)
class WeeklyAnalysisDto {
  const WeeklyAnalysisDto({
    required this.energyHistory,
    required this.metrics,
  });

  factory WeeklyAnalysisDto.fromJson(Map<String, dynamic> json) =>
      _$WeeklyAnalysisDtoFromJson(json);

  static const toJsonFactory = _$WeeklyAnalysisDtoToJson;
  Map<String, dynamic> toJson() => _$WeeklyAnalysisDtoToJson(this);

  @JsonKey(name: 'energyHistory')
  final WeeklyEnergyHistoryDto energyHistory;
  @JsonKey(name: 'metrics')
  final AnalyticsMetricsDto metrics;
  static const fromJsonFactory = _$WeeklyAnalysisDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WeeklyAnalysisDto &&
            (identical(other.energyHistory, energyHistory) ||
                const DeepCollectionEquality()
                    .equals(other.energyHistory, energyHistory)) &&
            (identical(other.metrics, metrics) ||
                const DeepCollectionEquality().equals(other.metrics, metrics)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(energyHistory) ^
      const DeepCollectionEquality().hash(metrics) ^
      runtimeType.hashCode;
}

extension $WeeklyAnalysisDtoExtension on WeeklyAnalysisDto {
  WeeklyAnalysisDto copyWith(
      {WeeklyEnergyHistoryDto? energyHistory, AnalyticsMetricsDto? metrics}) {
    return WeeklyAnalysisDto(
        energyHistory: energyHistory ?? this.energyHistory,
        metrics: metrics ?? this.metrics);
  }

  WeeklyAnalysisDto copyWithWrapped(
      {Wrapped<WeeklyEnergyHistoryDto>? energyHistory,
      Wrapped<AnalyticsMetricsDto>? metrics}) {
    return WeeklyAnalysisDto(
        energyHistory:
            (energyHistory != null ? energyHistory.value : this.energyHistory),
        metrics: (metrics != null ? metrics.value : this.metrics));
  }
}

@JsonSerializable(explicitToJson: true)
class WeeklyEnergyDataPointDto {
  const WeeklyEnergyDataPointDto({
    required this.dayOfWeek,
    required this.energy,
  });

  factory WeeklyEnergyDataPointDto.fromJson(Map<String, dynamic> json) =>
      _$WeeklyEnergyDataPointDtoFromJson(json);

  static const toJsonFactory = _$WeeklyEnergyDataPointDtoToJson;
  Map<String, dynamic> toJson() => _$WeeklyEnergyDataPointDtoToJson(this);

  @JsonKey(
    name: 'dayOfWeek',
    toJson: dayOfWeekToJson,
    fromJson: dayOfWeekFromJson,
  )
  final enums.DayOfWeek dayOfWeek;
  @JsonKey(name: 'energy')
  final WattHours energy;
  static const fromJsonFactory = _$WeeklyEnergyDataPointDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WeeklyEnergyDataPointDto &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                const DeepCollectionEquality()
                    .equals(other.dayOfWeek, dayOfWeek)) &&
            (identical(other.energy, energy) ||
                const DeepCollectionEquality().equals(other.energy, energy)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dayOfWeek) ^
      const DeepCollectionEquality().hash(energy) ^
      runtimeType.hashCode;
}

extension $WeeklyEnergyDataPointDtoExtension on WeeklyEnergyDataPointDto {
  WeeklyEnergyDataPointDto copyWith(
      {enums.DayOfWeek? dayOfWeek, WattHours? energy}) {
    return WeeklyEnergyDataPointDto(
        dayOfWeek: dayOfWeek ?? this.dayOfWeek, energy: energy ?? this.energy);
  }

  WeeklyEnergyDataPointDto copyWithWrapped(
      {Wrapped<enums.DayOfWeek>? dayOfWeek, Wrapped<WattHours>? energy}) {
    return WeeklyEnergyDataPointDto(
        dayOfWeek: (dayOfWeek != null ? dayOfWeek.value : this.dayOfWeek),
        energy: (energy != null ? energy.value : this.energy));
  }
}

@JsonSerializable(explicitToJson: true)
class WeeklyEnergyHistoryDto {
  const WeeklyEnergyHistoryDto({
    required this.consumers,
    required this.producers,
    required this.electricityMetersConsumption,
    required this.electricityMetersFeedIn,
  });

  factory WeeklyEnergyHistoryDto.fromJson(Map<String, dynamic> json) =>
      _$WeeklyEnergyHistoryDtoFromJson(json);

  static const toJsonFactory = _$WeeklyEnergyHistoryDtoToJson;
  Map<String, dynamic> toJson() => _$WeeklyEnergyHistoryDtoToJson(this);

  @JsonKey(name: 'consumers', defaultValue: <WeeklyEnergyDataPointDto>[])
  final List<WeeklyEnergyDataPointDto> consumers;
  @JsonKey(name: 'producers', defaultValue: <WeeklyEnergyDataPointDto>[])
  final List<WeeklyEnergyDataPointDto> producers;
  @JsonKey(
      name: 'electricityMetersConsumption',
      defaultValue: <WeeklyEnergyDataPointDto>[])
  final List<WeeklyEnergyDataPointDto> electricityMetersConsumption;
  @JsonKey(
      name: 'electricityMetersFeedIn',
      defaultValue: <WeeklyEnergyDataPointDto>[])
  final List<WeeklyEnergyDataPointDto> electricityMetersFeedIn;
  static const fromJsonFactory = _$WeeklyEnergyHistoryDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WeeklyEnergyHistoryDto &&
            (identical(other.consumers, consumers) ||
                const DeepCollectionEquality()
                    .equals(other.consumers, consumers)) &&
            (identical(other.producers, producers) ||
                const DeepCollectionEquality()
                    .equals(other.producers, producers)) &&
            (identical(other.electricityMetersConsumption,
                    electricityMetersConsumption) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersConsumption,
                    electricityMetersConsumption)) &&
            (identical(
                    other.electricityMetersFeedIn, electricityMetersFeedIn) ||
                const DeepCollectionEquality().equals(
                    other.electricityMetersFeedIn, electricityMetersFeedIn)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(consumers) ^
      const DeepCollectionEquality().hash(producers) ^
      const DeepCollectionEquality().hash(electricityMetersConsumption) ^
      const DeepCollectionEquality().hash(electricityMetersFeedIn) ^
      runtimeType.hashCode;
}

extension $WeeklyEnergyHistoryDtoExtension on WeeklyEnergyHistoryDto {
  WeeklyEnergyHistoryDto copyWith(
      {List<WeeklyEnergyDataPointDto>? consumers,
      List<WeeklyEnergyDataPointDto>? producers,
      List<WeeklyEnergyDataPointDto>? electricityMetersConsumption,
      List<WeeklyEnergyDataPointDto>? electricityMetersFeedIn}) {
    return WeeklyEnergyHistoryDto(
        consumers: consumers ?? this.consumers,
        producers: producers ?? this.producers,
        electricityMetersConsumption:
            electricityMetersConsumption ?? this.electricityMetersConsumption,
        electricityMetersFeedIn:
            electricityMetersFeedIn ?? this.electricityMetersFeedIn);
  }

  WeeklyEnergyHistoryDto copyWithWrapped(
      {Wrapped<List<WeeklyEnergyDataPointDto>>? consumers,
      Wrapped<List<WeeklyEnergyDataPointDto>>? producers,
      Wrapped<List<WeeklyEnergyDataPointDto>>? electricityMetersConsumption,
      Wrapped<List<WeeklyEnergyDataPointDto>>? electricityMetersFeedIn}) {
    return WeeklyEnergyHistoryDto(
        consumers: (consumers != null ? consumers.value : this.consumers),
        producers: (producers != null ? producers.value : this.producers),
        electricityMetersConsumption: (electricityMetersConsumption != null
            ? electricityMetersConsumption.value
            : this.electricityMetersConsumption),
        electricityMetersFeedIn: (electricityMetersFeedIn != null
            ? electricityMetersFeedIn.value
            : this.electricityMetersFeedIn));
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

String? dayOfWeekNullableToJson(enums.DayOfWeek? dayOfWeek) {
  return dayOfWeek?.value;
}

String? dayOfWeekToJson(enums.DayOfWeek dayOfWeek) {
  return dayOfWeek.value;
}

enums.DayOfWeek dayOfWeekFromJson(
  Object? dayOfWeek, [
  enums.DayOfWeek? defaultValue,
]) {
  return enums.DayOfWeek.values.firstWhereOrNull((e) => e.value == dayOfWeek) ??
      defaultValue ??
      enums.DayOfWeek.swaggerGeneratedUnknown;
}

enums.DayOfWeek? dayOfWeekNullableFromJson(
  Object? dayOfWeek, [
  enums.DayOfWeek? defaultValue,
]) {
  if (dayOfWeek == null) {
    return null;
  }
  return enums.DayOfWeek.values.firstWhereOrNull((e) => e.value == dayOfWeek) ??
      defaultValue;
}

String dayOfWeekExplodedListToJson(List<enums.DayOfWeek>? dayOfWeek) {
  return dayOfWeek?.map((e) => e.value!).join(',') ?? '';
}

List<String> dayOfWeekListToJson(List<enums.DayOfWeek>? dayOfWeek) {
  if (dayOfWeek == null) {
    return [];
  }

  return dayOfWeek.map((e) => e.value!).toList();
}

List<enums.DayOfWeek> dayOfWeekListFromJson(
  List? dayOfWeek, [
  List<enums.DayOfWeek>? defaultValue,
]) {
  if (dayOfWeek == null) {
    return defaultValue ?? [];
  }

  return dayOfWeek.map((e) => dayOfWeekFromJson(e.toString())).toList();
}

List<enums.DayOfWeek>? dayOfWeekNullableListFromJson(
  List? dayOfWeek, [
  List<enums.DayOfWeek>? defaultValue,
]) {
  if (dayOfWeek == null) {
    return defaultValue;
  }

  return dayOfWeek.map((e) => dayOfWeekFromJson(e.toString())).toList();
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

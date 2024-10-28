// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddElectricityMeterCommand _$AddElectricityMeterCommandFromJson(
        Map<String, dynamic> json) =>
    AddElectricityMeterCommand(
      integration: IntegrationIdentifier.fromJson(
          json['integration'] as Map<String, dynamic>),
      deviceName: json['deviceName'] as String,
    );

Map<String, dynamic> _$AddElectricityMeterCommandToJson(
        AddElectricityMeterCommand instance) =>
    <String, dynamic>{
      'integration': instance.integration.toJson(),
      'deviceName': instance.deviceName,
    };

AddProducerCommand _$AddProducerCommandFromJson(Map<String, dynamic> json) =>
    AddProducerCommand(
      integration: IntegrationIdentifier.fromJson(
          json['integration'] as Map<String, dynamic>),
      deviceName: json['deviceName'] as String,
    );

Map<String, dynamic> _$AddProducerCommandToJson(AddProducerCommand instance) =>
    <String, dynamic>{
      'integration': instance.integration.toJson(),
      'deviceName': instance.deviceName,
    };

AddSwitchConsumerCommand _$AddSwitchConsumerCommandFromJson(
        Map<String, dynamic> json) =>
    AddSwitchConsumerCommand(
      integration: IntegrationIdentifier.fromJson(
          json['integration'] as Map<String, dynamic>),
      deviceName: json['deviceName'] as String,
    );

Map<String, dynamic> _$AddSwitchConsumerCommandToJson(
        AddSwitchConsumerCommand instance) =>
    <String, dynamic>{
      'integration': instance.integration.toJson(),
      'deviceName': instance.deviceName,
    };

AddableDevelopmentDeviceDto _$AddableDevelopmentDeviceDtoFromJson(
        Map<String, dynamic> json) =>
    AddableDevelopmentDeviceDto(
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String,
    );

Map<String, dynamic> _$AddableDevelopmentDeviceDtoToJson(
        AddableDevelopmentDeviceDto instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
    };

AddableShellyDeviceDto _$AddableShellyDeviceDtoFromJson(
        Map<String, dynamic> json) =>
    AddableShellyDeviceDto(
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String,
    );

Map<String, dynamic> _$AddableShellyDeviceDtoToJson(
        AddableShellyDeviceDto instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
    };

BatteryStatusDto _$BatteryStatusDtoFromJson(Map<String, dynamic> json) =>
    BatteryStatusDto(
      isAvailable: json['isAvailable'] as bool?,
      chargeStatus: batteryChargeStatusFromJson(json['chargeStatus']),
      charge: Percentage.fromJson(json['charge'] as num),
    );

Map<String, dynamic> _$BatteryStatusDtoToJson(BatteryStatusDto instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'chargeStatus': batteryChargeStatusToJson(instance.chargeStatus),
      'charge': instance.charge.toJson(),
    };

ConsumerStatusDto _$ConsumerStatusDtoFromJson(Map<String, dynamic> json) =>
    ConsumerStatusDto(
      isAvailable: json['isAvailable'] as bool?,
      currentPowerConsumption:
          Watt.fromJson(json['currentPowerConsumption'] as num),
      maximumPowerConsumption:
          Watt.fromJson(json['maximumPowerConsumption'] as num),
    );

Map<String, dynamic> _$ConsumerStatusDtoToJson(ConsumerStatusDto instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'currentPowerConsumption': instance.currentPowerConsumption.toJson(),
      'maximumPowerConsumption': instance.maximumPowerConsumption.toJson(),
    };

DailyAnalysisDto _$DailyAnalysisDtoFromJson(Map<String, dynamic> json) =>
    DailyAnalysisDto(
      day: DateTime.parse(json['day'] as String),
      powerHistory: PowerHistoryDto.fromJson(
          json['powerHistory'] as Map<String, dynamic>),
      totalEnergy: TotalEnergyDataDto.fromJson(
          json['totalEnergy'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DailyAnalysisDtoToJson(DailyAnalysisDto instance) =>
    <String, dynamic>{
      'day': _dateToJson(instance.day),
      'powerHistory': instance.powerHistory.toJson(),
      'totalEnergy': instance.totalEnergy.toJson(),
    };

DevicesDto _$DevicesDtoFromJson(Map<String, dynamic> json) => DevicesDto(
      switchConsumers: (json['switchConsumers'] as List<dynamic>?)
              ?.map(
                  (e) => SwitchConsumerDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      producers: (json['producers'] as List<dynamic>?)
              ?.map((e) => ProducerDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      electricityMeters: (json['electricityMeters'] as List<dynamic>?)
              ?.map((e) =>
                  ElectricityMeterDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$DevicesDtoToJson(DevicesDto instance) =>
    <String, dynamic>{
      'switchConsumers':
          instance.switchConsumers.map((e) => e.toJson()).toList(),
      'producers': instance.producers.map((e) => e.toJson()).toList(),
      'electricityMeters':
          instance.electricityMeters.map((e) => e.toJson()).toList(),
    };

EditElectricityMeterCommand _$EditElectricityMeterCommandFromJson(
        Map<String, dynamic> json) =>
    EditElectricityMeterCommand(
      electricityMeterId: json['electricityMeterId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EditElectricityMeterCommandToJson(
        EditElectricityMeterCommand instance) =>
    <String, dynamic>{
      'electricityMeterId': instance.electricityMeterId,
      'name': instance.name,
    };

EditProducerCommand _$EditProducerCommandFromJson(Map<String, dynamic> json) =>
    EditProducerCommand(
      producerId: json['producerId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EditProducerCommandToJson(
        EditProducerCommand instance) =>
    <String, dynamic>{
      'producerId': instance.producerId,
      'name': instance.name,
    };

EditSwitchConsumerCommand _$EditSwitchConsumerCommandFromJson(
        Map<String, dynamic> json) =>
    EditSwitchConsumerCommand(
      switchConsumerId: json['switchConsumerId'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$EditSwitchConsumerCommandToJson(
        EditSwitchConsumerCommand instance) =>
    <String, dynamic>{
      'switchConsumerId': instance.switchConsumerId,
      'name': instance.name,
    };

ElectricityMeterDto _$ElectricityMeterDtoFromJson(Map<String, dynamic> json) =>
    ElectricityMeterDto(
      id: json['id'] as String,
      name: json['name'] as String,
      currentPowerDirection:
          gridPowerDirectionFromJson(json['currentPowerDirection']),
      currentPower: json['currentPower'] == null
          ? null
          : Watt.fromJson(json['currentPower'] as num),
    );

Map<String, dynamic> _$ElectricityMeterDtoToJson(
        ElectricityMeterDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currentPowerDirection':
          gridPowerDirectionToJson(instance.currentPowerDirection),
      'currentPower': instance.currentPower?.toJson(),
    };

GridStatusDto _$GridStatusDtoFromJson(Map<String, dynamic> json) =>
    GridStatusDto(
      isAvailable: json['isAvailable'] as bool?,
      currentPowerDirection:
          gridPowerDirectionFromJson(json['currentPowerDirection']),
      currentPower: Watt.fromJson(json['currentPower'] as num),
      maximumPowerConsumption:
          Watt.fromJson(json['maximumPowerConsumption'] as num),
      maximumPowerFeedIn: Watt.fromJson(json['maximumPowerFeedIn'] as num),
    );

Map<String, dynamic> _$GridStatusDtoToJson(GridStatusDto instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'currentPowerDirection':
          gridPowerDirectionToJson(instance.currentPowerDirection),
      'currentPower': instance.currentPower.toJson(),
      'maximumPowerConsumption': instance.maximumPowerConsumption.toJson(),
      'maximumPowerFeedIn': instance.maximumPowerFeedIn.toJson(),
    };

HealthReportDto _$HealthReportDtoFromJson(Map<String, dynamic> json) =>
    HealthReportDto(
      name: json['name'] as String,
      version: json['version'] as String,
      status: healthStatusFromJson(json['status']),
      totalDuration: json['totalDuration'] as String,
    );

Map<String, dynamic> _$HealthReportDtoToJson(HealthReportDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'version': instance.version,
      'status': healthStatusToJson(instance.status),
      'totalDuration': instance.totalDuration,
    };

HomeStatusDto _$HomeStatusDtoFromJson(Map<String, dynamic> json) =>
    HomeStatusDto(
      batteryStatus: BatteryStatusDto.fromJson(
          json['batteryStatus'] as Map<String, dynamic>),
      gridStatus:
          GridStatusDto.fromJson(json['gridStatus'] as Map<String, dynamic>),
      consumerStatus: ConsumerStatusDto.fromJson(
          json['consumerStatus'] as Map<String, dynamic>),
      producerStatus: ProducerStatusDto.fromJson(
          json['producerStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeStatusDtoToJson(HomeStatusDto instance) =>
    <String, dynamic>{
      'batteryStatus': instance.batteryStatus.toJson(),
      'gridStatus': instance.gridStatus.toJson(),
      'consumerStatus': instance.consumerStatus.toJson(),
      'producerStatus': instance.producerStatus.toJson(),
    };

IntegrationDescriptionDto _$IntegrationDescriptionDtoFromJson(
        Map<String, dynamic> json) =>
    IntegrationDescriptionDto(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$IntegrationDescriptionDtoToJson(
        IntegrationDescriptionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

IntegrationIdentifier _$IntegrationIdentifierFromJson(
        Map<String, dynamic> json) =>
    IntegrationIdentifier(
      integration: json['integration'] as String,
      device: json['device'] as String,
    );

Map<String, dynamic> _$IntegrationIdentifierToJson(
        IntegrationIdentifier instance) =>
    <String, dynamic>{
      'integration': instance.integration,
      'device': instance.device,
    };

ManuallySwitchSwitchConsumerCommand
    _$ManuallySwitchSwitchConsumerCommandFromJson(Map<String, dynamic> json) =>
        ManuallySwitchSwitchConsumerCommand(
          switchConsumerId: json['switchConsumerId'] as String,
          status: switchStatusFromJson(json['status']),
        );

Map<String, dynamic> _$ManuallySwitchSwitchConsumerCommandToJson(
        ManuallySwitchSwitchConsumerCommand instance) =>
    <String, dynamic>{
      'switchConsumerId': instance.switchConsumerId,
      'status': switchStatusToJson(instance.status),
    };

MeDto _$MeDtoFromJson(Map<String, dynamic> json) => MeDto(
      name: json['name'] as String?,
      authenticationType: json['authenticationType'] as String?,
      claims: json['claims'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$MeDtoToJson(MeDto instance) => <String, dynamic>{
      'name': instance.name,
      'authenticationType': instance.authenticationType,
      'claims': instance.claims,
    };

PowerDataPointDto _$PowerDataPointDtoFromJson(Map<String, dynamic> json) =>
    PowerDataPointDto(
      timestamp: DateTime.parse(json['timestamp'] as String),
      power: Watt.fromJson(json['power'] as num),
    );

Map<String, dynamic> _$PowerDataPointDtoToJson(PowerDataPointDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'power': instance.power.toJson(),
    };

PowerHistoryDto _$PowerHistoryDtoFromJson(Map<String, dynamic> json) =>
    PowerHistoryDto(
      consumers: (json['consumers'] as List<dynamic>?)
              ?.map(
                  (e) => PowerDataPointDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      producers: (json['producers'] as List<dynamic>?)
              ?.map(
                  (e) => PowerDataPointDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      electricityMetersConsume: (json['electricityMetersConsume']
                  as List<dynamic>?)
              ?.map(
                  (e) => PowerDataPointDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      electricityMetersFeedIn: (json['electricityMetersFeedIn']
                  as List<dynamic>?)
              ?.map(
                  (e) => PowerDataPointDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$PowerHistoryDtoToJson(PowerHistoryDto instance) =>
    <String, dynamic>{
      'consumers': instance.consumers.map((e) => e.toJson()).toList(),
      'producers': instance.producers.map((e) => e.toJson()).toList(),
      'electricityMetersConsume':
          instance.electricityMetersConsume.map((e) => e.toJson()).toList(),
      'electricityMetersFeedIn':
          instance.electricityMetersFeedIn.map((e) => e.toJson()).toList(),
    };

ProducerDto _$ProducerDtoFromJson(Map<String, dynamic> json) => ProducerDto(
      id: json['id'] as String,
      name: json['name'] as String,
      currentPowerProduction: json['currentPowerProduction'] == null
          ? null
          : Watt.fromJson(json['currentPowerProduction'] as num),
    );

Map<String, dynamic> _$ProducerDtoToJson(ProducerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'currentPowerProduction': instance.currentPowerProduction?.toJson(),
    };

ProducerStatusDto _$ProducerStatusDtoFromJson(Map<String, dynamic> json) =>
    ProducerStatusDto(
      isAvailable: json['isAvailable'] as bool?,
      currentPowerProduction:
          Watt.fromJson(json['currentPowerProduction'] as num),
      maximumPowerProduction:
          Watt.fromJson(json['maximumPowerProduction'] as num),
    );

Map<String, dynamic> _$ProducerStatusDtoToJson(ProducerStatusDto instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'currentPowerProduction': instance.currentPowerProduction.toJson(),
      'maximumPowerProduction': instance.maximumPowerProduction.toJson(),
    };

ShellyPermissionGrantUriResponse _$ShellyPermissionGrantUriResponseFromJson(
        Map<String, dynamic> json) =>
    ShellyPermissionGrantUriResponse(
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$ShellyPermissionGrantUriResponseToJson(
        ShellyPermissionGrantUriResponse instance) =>
    <String, dynamic>{
      'uri': instance.uri,
    };

SwitchConsumerDto _$SwitchConsumerDtoFromJson(Map<String, dynamic> json) =>
    SwitchConsumerDto(
      id: json['id'] as String,
      name: json['name'] as String,
      mode: controlModeFromJson(json['mode']),
      switchStatus: switchStatusFromJson(json['switchStatus']),
      currentPowerConsumption: json['currentPowerConsumption'] == null
          ? null
          : Watt.fromJson(json['currentPowerConsumption'] as num),
    );

Map<String, dynamic> _$SwitchConsumerDtoToJson(SwitchConsumerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mode': controlModeToJson(instance.mode),
      'switchStatus': switchStatusToJson(instance.switchStatus),
      'currentPowerConsumption': instance.currentPowerConsumption?.toJson(),
    };

TotalEnergyDataDto _$TotalEnergyDataDtoFromJson(Map<String, dynamic> json) =>
    TotalEnergyDataDto(
      totalEnergyProduction:
          WattHours.fromJson(json['totalEnergyProduction'] as num),
      totalGridEnergyConsumption:
          WattHours.fromJson(json['totalGridEnergyConsumption'] as num),
      totalGridEnergyFeedIn:
          WattHours.fromJson(json['totalGridEnergyFeedIn'] as num),
    );

Map<String, dynamic> _$TotalEnergyDataDtoToJson(TotalEnergyDataDto instance) =>
    <String, dynamic>{
      'totalEnergyProduction': instance.totalEnergyProduction.toJson(),
      'totalGridEnergyConsumption':
          instance.totalGridEnergyConsumption.toJson(),
      'totalGridEnergyFeedIn': instance.totalGridEnergyFeedIn.toJson(),
    };

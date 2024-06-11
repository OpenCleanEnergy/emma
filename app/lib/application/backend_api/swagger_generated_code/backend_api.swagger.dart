// ignore_for_file: type=lint

import 'backend_api.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart' as chopper;
import 'backend_api.enums.swagger.dart' as enums;
export 'backend_api.enums.swagger.dart';
export 'backend_api.models.swagger.dart';

part 'backend_api.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class BackendApi extends ChopperService {
  static BackendApi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$BackendApi(client);
    }

    final newClient = ChopperClient(
        services: [_$BackendApi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$BackendApi(newClient);
  }

  ///
  ///@param DeviceCategory
  Future<chopper.Response<List<AddableDevelopmentDeviceDto>>>
      Development_AddableDevelopmentDevicesQuery(
          {required enums.DeviceCategory? deviceCategory}) {
    generatedMapping.putIfAbsent(AddableDevelopmentDeviceDto,
        () => AddableDevelopmentDeviceDto.fromJsonFactory);

    return _Development_AddableDevelopmentDevicesQuery(
        deviceCategory: deviceCategory?.value?.toString());
  }

  ///
  ///@param DeviceCategory
  @Get(path: '/integrations/development/v1/addable-devices')
  Future<chopper.Response<List<AddableDevelopmentDeviceDto>>>
      _Development_AddableDevelopmentDevicesQuery(
          {@Query('DeviceCategory') required String? deviceCategory});

  ///
  Future<chopper.Response<DevicesDto>> Devices_DevicesQuery() {
    generatedMapping.putIfAbsent(DevicesDto, () => DevicesDto.fromJsonFactory);

    return _Devices_DevicesQuery();
  }

  ///
  @Get(path: '/v1/devices')
  Future<chopper.Response<DevicesDto>> _Devices_DevicesQuery();

  ///
  Future<chopper.Response<DevicesDto>> Devices_DevicesQuery_LongPolling() {
    generatedMapping.putIfAbsent(DevicesDto, () => DevicesDto.fromJsonFactory);

    return _Devices_DevicesQuery_LongPolling();
  }

  ///
  @Get(path: '/v1/devices/long-polling')
  Future<chopper.Response<DevicesDto>> _Devices_DevicesQuery_LongPolling();

  ///
  Future<chopper.Response> Devices_AddSwitchConsumerCommand(
      {required AddSwitchConsumerCommand? body}) {
    return _Devices_AddSwitchConsumerCommand(body: body);
  }

  ///
  @Post(
    path: '/v1/devices/switch-consumers',
    optionalBody: true,
  )
  Future<chopper.Response> _Devices_AddSwitchConsumerCommand(
      {@Body() required AddSwitchConsumerCommand? body});

  ///
  Future<chopper.Response> Devices_EditSwitchConsumerCommand(
      {required EditSwitchConsumerCommand? body}) {
    return _Devices_EditSwitchConsumerCommand(body: body);
  }

  ///
  @Put(
    path: '/v1/devices/switch-consumers',
    optionalBody: true,
  )
  Future<chopper.Response> _Devices_EditSwitchConsumerCommand(
      {@Body() required EditSwitchConsumerCommand? body});

  ///
  ///@param SwitchConsumerId
  Future<chopper.Response> Devices_DeleteSwitchConsumerCommand(
      {required String? switchConsumerId}) {
    return _Devices_DeleteSwitchConsumerCommand(
        switchConsumerId: switchConsumerId);
  }

  ///
  ///@param SwitchConsumerId
  @Delete(path: '/v1/devices/switch-consumers/{SwitchConsumerId}')
  Future<chopper.Response> _Devices_DeleteSwitchConsumerCommand(
      {@Path('SwitchConsumerId') required String? switchConsumerId});

  ///
  Future<chopper.Response> Devices_ManuallySwitchSwitchConsumerCommand(
      {required ManuallySwitchSwitchConsumerCommand? body}) {
    return _Devices_ManuallySwitchSwitchConsumerCommand(body: body);
  }

  ///
  @Put(
    path: '/v1/devices/switch-consumers/manually-switch',
    optionalBody: true,
  )
  Future<chopper.Response> _Devices_ManuallySwitchSwitchConsumerCommand(
      {@Body() required ManuallySwitchSwitchConsumerCommand? body});

  ///
  Future<chopper.Response> Devices_AddProducerCommand(
      {required AddProducerCommand? body}) {
    return _Devices_AddProducerCommand(body: body);
  }

  ///
  @Post(
    path: '/v1/devices/producers',
    optionalBody: true,
  )
  Future<chopper.Response> _Devices_AddProducerCommand(
      {@Body() required AddProducerCommand? body});

  ///
  Future<chopper.Response> Devices_EditProducerCommand(
      {required EditProducerCommand? body}) {
    return _Devices_EditProducerCommand(body: body);
  }

  ///
  @Put(
    path: '/v1/devices/producers',
    optionalBody: true,
  )
  Future<chopper.Response> _Devices_EditProducerCommand(
      {@Body() required EditProducerCommand? body});

  ///
  ///@param ProducerId
  Future<chopper.Response> Devices_DeleteProducerCommand(
      {required String? producerId}) {
    return _Devices_DeleteProducerCommand(producerId: producerId);
  }

  ///
  ///@param ProducerId
  @Delete(path: '/v1/devices/producers/{ProducerId}')
  Future<chopper.Response> _Devices_DeleteProducerCommand(
      {@Path('ProducerId') required String? producerId});

  ///
  Future<chopper.Response> Devices_AddElectricityMeterCommand(
      {required AddElectricityMeterCommand? body}) {
    return _Devices_AddElectricityMeterCommand(body: body);
  }

  ///
  @Post(
    path: '/v1/devices/electricity-meters',
    optionalBody: true,
  )
  Future<chopper.Response> _Devices_AddElectricityMeterCommand(
      {@Body() required AddElectricityMeterCommand? body});

  ///
  Future<chopper.Response> Devices_EditElectricityMeterCommand(
      {required EditElectricityMeterCommand? body}) {
    return _Devices_EditElectricityMeterCommand(body: body);
  }

  ///
  @Put(
    path: '/v1/devices/electricity-meters',
    optionalBody: true,
  )
  Future<chopper.Response> _Devices_EditElectricityMeterCommand(
      {@Body() required EditElectricityMeterCommand? body});

  ///
  ///@param ElectricityMeterId
  Future<chopper.Response> Devices_DeleteElectricityMeterCommand(
      {required String? electricityMeterId}) {
    return _Devices_DeleteElectricityMeterCommand(
        electricityMeterId: electricityMeterId);
  }

  ///
  ///@param ElectricityMeterId
  @Delete(path: '/v1/devices/electricity-meters/{ElectricityMeterId}')
  Future<chopper.Response> _Devices_DeleteElectricityMeterCommand(
      {@Path('ElectricityMeterId') required String? electricityMeterId});

  ///
  Future<chopper.Response<HealthReportDto>> Health_GetHealthReport() {
    generatedMapping.putIfAbsent(
        HealthReportDto, () => HealthReportDto.fromJsonFactory);

    return _Health_GetHealthReport();
  }

  ///
  @Get(path: '/health')
  Future<chopper.Response<HealthReportDto>> _Health_GetHealthReport();

  ///
  Future<chopper.Response<MeDto>> Hello_Me() {
    generatedMapping.putIfAbsent(MeDto, () => MeDto.fromJsonFactory);

    return _Hello_Me();
  }

  ///
  @Get(path: '/v1/hello/me')
  Future<chopper.Response<MeDto>> _Hello_Me();

  ///
  Future<chopper.Response<HomeStatusDto>> Home_HomeStatusQuery() {
    generatedMapping.putIfAbsent(
        HomeStatusDto, () => HomeStatusDto.fromJsonFactory);

    return _Home_HomeStatusQuery();
  }

  ///
  @Get(path: '/v1/home')
  Future<chopper.Response<HomeStatusDto>> _Home_HomeStatusQuery();

  ///
  Future<chopper.Response<HomeStatusDto>> Home_HomeStatusQuery_LongPolling() {
    generatedMapping.putIfAbsent(
        HomeStatusDto, () => HomeStatusDto.fromJsonFactory);

    return _Home_HomeStatusQuery_LongPolling();
  }

  ///
  @Get(path: '/v1/home/long-polling')
  Future<chopper.Response<HomeStatusDto>> _Home_HomeStatusQuery_LongPolling();

  ///
  ///@param DeviceCategory
  Future<chopper.Response<List<IntegrationDescriptionDto>>>
      Integrations_IntegrationsQuery(
          {required enums.DeviceCategory? deviceCategory}) {
    generatedMapping.putIfAbsent(IntegrationDescriptionDto,
        () => IntegrationDescriptionDto.fromJsonFactory);

    return _Integrations_IntegrationsQuery(
        deviceCategory: deviceCategory?.value?.toString());
  }

  ///
  ///@param DeviceCategory
  @Get(path: '/v1/integrations')
  Future<chopper.Response<List<IntegrationDescriptionDto>>>
      _Integrations_IntegrationsQuery(
          {@Query('DeviceCategory') required String? deviceCategory});

  ///
  Future<chopper.Response<ShellyPermissionGrantUriResponse>>
      Shelly_ShellyPermissionGrantUriQuery() {
    generatedMapping.putIfAbsent(ShellyPermissionGrantUriResponse,
        () => ShellyPermissionGrantUriResponse.fromJsonFactory);

    return _Shelly_ShellyPermissionGrantUriQuery();
  }

  ///
  @Get(path: '/integrations/shelly/v1/grant')
  Future<chopper.Response<ShellyPermissionGrantUriResponse>>
      _Shelly_ShellyPermissionGrantUriQuery();

  ///
  ///@param DeviceCategory
  Future<chopper.Response<List<AddableShellyDeviceDto>>>
      Shelly_AddableShellyDevicesQuery(
          {required enums.DeviceCategory? deviceCategory}) {
    generatedMapping.putIfAbsent(
        AddableShellyDeviceDto, () => AddableShellyDeviceDto.fromJsonFactory);

    return _Shelly_AddableShellyDevicesQuery(
        deviceCategory: deviceCategory?.value?.toString());
  }

  ///
  ///@param DeviceCategory
  @Get(path: '/integrations/shelly/v1/addable-devices')
  Future<chopper.Response<List<AddableShellyDeviceDto>>>
      _Shelly_AddableShellyDevicesQuery(
          {@Query('DeviceCategory') required String? deviceCategory});
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

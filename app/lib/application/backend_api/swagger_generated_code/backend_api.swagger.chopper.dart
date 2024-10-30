//Generated code

part of 'backend_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$BackendApi extends BackendApi {
  _$BackendApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = BackendApi;

  @override
  Future<Response<DailyAnalysisDto>> _Analytics_DailyAnalysisQuery({
    required int? year,
    required int? month,
    required int? day,
    required String? timeZoneOffset,
  }) {
    final Uri $url = Uri.parse('/v1/analytics/daily');
    final Map<String, dynamic> $params = <String, dynamic>{
      'Year': year,
      'Month': month,
      'Day': day,
      'TimeZoneOffset': timeZoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<DailyAnalysisDto, DailyAnalysisDto>($request);
  }

  @override
  Future<Response<WeeklyAnalysisDto>> _Analytics_WeeklyAnalysisQuery({
    required int? year,
    required int? month,
    required int? firstDayOfWeek,
    required String? timeZoneOffset,
  }) {
    final Uri $url = Uri.parse('/v1/analytics/weekly');
    final Map<String, dynamic> $params = <String, dynamic>{
      'Year': year,
      'Month': month,
      'FirstDayOfWeek': firstDayOfWeek,
      'TimeZoneOffset': timeZoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<WeeklyAnalysisDto, WeeklyAnalysisDto>($request);
  }

  @override
  Future<Response<MonthlyAnalysisDto>> _Analytics_MonthlyAnalysisQuery({
    required int? year,
    required int? month,
    required String? timeZoneOffset,
  }) {
    final Uri $url = Uri.parse('/v1/analytics/monthly');
    final Map<String, dynamic> $params = <String, dynamic>{
      'Year': year,
      'Month': month,
      'TimeZoneOffset': timeZoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MonthlyAnalysisDto, MonthlyAnalysisDto>($request);
  }

  @override
  Future<Response<AnnualAnalysisDto>> _Analytics_AnnualAnalysisQuery({
    required int? year,
    required String? timeZoneOffset,
  }) {
    final Uri $url = Uri.parse('/v1/analytics/annual');
    final Map<String, dynamic> $params = <String, dynamic>{
      'Year': year,
      'TimeZoneOffset': timeZoneOffset,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<AnnualAnalysisDto, AnnualAnalysisDto>($request);
  }

  @override
  Future<Response<List<AddableDevelopmentDeviceDto>>>
      _Development_AddableDevelopmentDevicesQuery(
          {required String? deviceCategory}) {
    final Uri $url = Uri.parse('/integrations/development/v1/addable-devices');
    final Map<String, dynamic> $params = <String, dynamic>{
      'DeviceCategory': deviceCategory
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<AddableDevelopmentDeviceDto>,
        AddableDevelopmentDeviceDto>($request);
  }

  @override
  Future<Response<DevicesDto>> _Devices_DevicesQuery() {
    final Uri $url = Uri.parse('/v1/devices');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DevicesDto, DevicesDto>($request);
  }

  @override
  Future<Response<DevicesDto>> _Devices_DevicesQuery_LongPolling() {
    final Uri $url = Uri.parse('/v1/devices/long-polling');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<DevicesDto, DevicesDto>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_AddSwitchConsumerCommand(
      {required AddSwitchConsumerCommand? body}) {
    final Uri $url = Uri.parse('/v1/devices/switch-consumers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_EditSwitchConsumerCommand(
      {required EditSwitchConsumerCommand? body}) {
    final Uri $url = Uri.parse('/v1/devices/switch-consumers');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_DeleteSwitchConsumerCommand(
      {required String? switchConsumerId}) {
    final Uri $url =
        Uri.parse('/v1/devices/switch-consumers/${switchConsumerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_ManuallySwitchSwitchConsumerCommand(
      {required ManuallySwitchSwitchConsumerCommand? body}) {
    final Uri $url = Uri.parse('/v1/devices/switch-consumers/manually-switch');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_AddProducerCommand(
      {required AddProducerCommand? body}) {
    final Uri $url = Uri.parse('/v1/devices/producers');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_EditProducerCommand(
      {required EditProducerCommand? body}) {
    final Uri $url = Uri.parse('/v1/devices/producers');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_DeleteProducerCommand(
      {required String? producerId}) {
    final Uri $url = Uri.parse('/v1/devices/producers/${producerId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_AddElectricityMeterCommand(
      {required AddElectricityMeterCommand? body}) {
    final Uri $url = Uri.parse('/v1/devices/electricity-meters');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_EditElectricityMeterCommand(
      {required EditElectricityMeterCommand? body}) {
    final Uri $url = Uri.parse('/v1/devices/electricity-meters');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _Devices_DeleteElectricityMeterCommand(
      {required String? electricityMeterId}) {
    final Uri $url =
        Uri.parse('/v1/devices/electricity-meters/${electricityMeterId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<HealthReportDto>> _Health_GetHealthReport() {
    final Uri $url = Uri.parse('/health');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<HealthReportDto, HealthReportDto>($request);
  }

  @override
  Future<Response<MeDto>> _Hello_Me() {
    final Uri $url = Uri.parse('/v1/hello/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MeDto, MeDto>($request);
  }

  @override
  Future<Response<HomeStatusDto>> _Home_HomeStatusQuery() {
    final Uri $url = Uri.parse('/v1/home');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<HomeStatusDto, HomeStatusDto>($request);
  }

  @override
  Future<Response<HomeStatusDto>> _Home_HomeStatusQuery_LongPolling() {
    final Uri $url = Uri.parse('/v1/home/long-polling');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<HomeStatusDto, HomeStatusDto>($request);
  }

  @override
  Future<Response<List<IntegrationDescriptionDto>>>
      _Integrations_IntegrationsQuery({required String? deviceCategory}) {
    final Uri $url = Uri.parse('/v1/integrations');
    final Map<String, dynamic> $params = <String, dynamic>{
      'DeviceCategory': deviceCategory
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<IntegrationDescriptionDto>,
        IntegrationDescriptionDto>($request);
  }

  @override
  Future<Response<ShellyPermissionGrantUriResponse>>
      _Shelly_ShellyPermissionGrantUriQuery() {
    final Uri $url = Uri.parse('/integrations/shelly/v1/grant');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ShellyPermissionGrantUriResponse,
        ShellyPermissionGrantUriResponse>($request);
  }

  @override
  Future<Response<List<AddableShellyDeviceDto>>>
      _Shelly_AddableShellyDevicesQuery({required String? deviceCategory}) {
    final Uri $url = Uri.parse('/integrations/shelly/v1/addable-devices');
    final Map<String, dynamic> $params = <String, dynamic>{
      'DeviceCategory': deviceCategory
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<AddableShellyDeviceDto>, AddableShellyDeviceDto>($request);
  }
}

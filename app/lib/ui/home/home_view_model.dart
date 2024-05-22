import 'package:emma/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:signals/signals_flutter.dart';

class HomeViewModel {
  final BackendApi _api;

  HomeViewModel({required BackendApi api}) : _api = api {
    init = _init.toCommand();
    refresh = _refresh.toCommand();
  }

  late final NoArgCommand init;
  late final NoArgCommand refresh;

  final batteryStatus = BatteryStatusViewModel();
  final gridStatus = GridStatusViewModel();
  final consumerStatus = ConsumerStatusViewModel();
  final producerStatus = ProducerStatusViewModel();

  Future<void> _init() async {
    final response = await _api.Home_HomeStatusQuery();
    _update(response.bodyOrThrow);
  }

  Future<void> _refresh() async {
    final response = await _api.Home_HomeStatusQuery_LongPolling();
    _update(response.bodyOrThrow);
  }

  void _update(HomeStatusDto dto) {
    batch(() {
      batteryStatus.update(dto.batteryStatus);
      gridStatus.update(dto.gridStatus);
      consumerStatus.update(dto.consumerStatus);
      producerStatus.update(dto.producerStatus);
    });
  }
}

class BatteryStatusViewModel {
  final Signal<bool> isAvailable = signal(false);
  final Signal<double> charge = signal(0.0);
  final Signal<BatteryChargeStatus> chargeStatus =
      signal(BatteryChargeStatus.idle);

  void update(BatteryStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    charge.value = dto.charge.toDouble();
    chargeStatus.value = _normalizeStatus(dto.chargeStatus);
  }

  static BatteryChargeStatus _normalizeStatus(
      BatteryChargeStatus chargeStatus) {
    return switch (chargeStatus) {
      BatteryChargeStatus.swaggerGeneratedUnknown => BatteryChargeStatus.idle,
      _ => chargeStatus,
    };
  }
}

class GridStatusViewModel {
  final isAvailable = signal(false);
  final currentPowerDirection = signal(GridPowerDirection.none);
  final currentPower = signal(0.0);
  final maximumPowerConsumption = signal(0.0);
  final maximumPowerFeedIn = signal(0.0);

  void update(GridStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    currentPowerDirection.value = dto.currentPowerDirection;
    currentPower.value = dto.currentPower.toDouble();
    maximumPowerConsumption.value = dto.maximumPowerConsumption.toDouble();
    maximumPowerFeedIn.value = dto.maximumPowerFeedIn.toDouble();
  }
}

class ConsumerStatusViewModel {
  final Signal<bool> isAvailable = signal(false);
  final Signal<double> currentPowerConsumption = signal(0.0);
  final Signal<double> maximumPowerConsumption = signal(0.0);

  void update(ConsumerStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    currentPowerConsumption.value = dto.currentPowerConsumption.toDouble();
    maximumPowerConsumption.value = dto.maximumPowerConsumption.toDouble();
  }
}

class ProducerStatusViewModel {
  final Signal<bool> isAvailable = signal(false);
  final Signal<double> currentPowerProduction = signal(0.0);
  final Signal<double> maximumPowerProduction = signal(0.0);

  void update(ProducerStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    currentPowerProduction.value = dto.currentPowerProduction.toDouble();
    maximumPowerProduction.value = dto.maximumPowerProduction.toDouble();
  }
}

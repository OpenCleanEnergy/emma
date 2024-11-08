import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:signals/signals.dart';

class HomeViewModel {
  final BackendApi _api;

  HomeViewModel({required BackendApi api}) : _api = api {
    init = _init.toCommand('home.init');
    refresh = _refresh.toCommand('home.refresh');
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
    final response = await _api.Home_HomeStatusQuery_LongPolling(
      session: LongPollingSession.instance,
    );

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
  final Signal<Percentage> charge = signal(Percentage.zero);
  final Signal<BatteryChargeStatus> chargeStatus =
      signal(BatteryChargeStatus.idle);

  void update(BatteryStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    charge.value = dto.charge;
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
  final currentPower = signal(Watt.zero);
  final maximumPowerConsumption = signal(Watt.zero);
  final maximumPowerFeedIn = signal(Watt.zero);

  void update(GridStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    currentPowerDirection.value = dto.currentPowerDirection;
    currentPower.value = dto.currentPower;
    maximumPowerConsumption.value = dto.maximumPowerConsumption;
    maximumPowerFeedIn.value = dto.maximumPowerFeedIn;
  }
}

class ConsumerStatusViewModel {
  final isAvailable = signal(false);
  final currentPowerConsumption = signal(Watt.zero);
  final maximumPowerConsumption = signal(Watt.zero);

  void update(ConsumerStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    currentPowerConsumption.value = dto.currentPowerConsumption;
    maximumPowerConsumption.value = dto.maximumPowerConsumption;
  }
}

class ProducerStatusViewModel {
  final isAvailable = signal(false);
  final currentPowerProduction = signal(Watt.zero);
  final maximumPowerProduction = signal(Watt.zero);

  void update(ProducerStatusDto dto) {
    isAvailable.value = dto.isAvailable ?? false;
    currentPowerProduction.value = dto.currentPowerProduction;
    maximumPowerProduction.value = dto.maximumPowerProduction;
  }
}

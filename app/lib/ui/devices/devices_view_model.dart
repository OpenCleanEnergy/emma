import 'dart:math';

import 'package:emma/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:emma/ui/devices/consumers/switch_consumer_view_model.dart';
import 'package:emma/ui/devices/meters/electricity_meter_view_model.dart';
import 'package:emma/ui/devices/producers/producer_view_model.dart';
import 'package:signals/signals_flutter.dart';

class DevicesViewModel {
  final BackendApi _api;

  DevicesViewModel({required BackendApi api}) : _api = api {
    init = _init.toCommand('devices.init');
    refresh = _refresh.toCommand('devices.refresh');
  }

  final switchConsumers = listSignal<SwitchConsumerViewModel>([]);
  final producers = listSignal<ProducerViewModel>([]);
  final electricityMeters = listSignal<ElectricityMeterViewModel>([]);

  late final NoArgCommand init;
  late final NoArgCommand refresh;

  Future<void> _init() async {
    final response = await _api.Devices_DevicesQuery();

    batch(() {
      _refreshSwitchConsumers(response.body?.switchConsumers);
      _refreshProducers(response.body?.producers);
      _refreshElectricityMeters(response.body?.electricityMeters);
    });
  }

  Future<void> _refresh() async {
    final response = await _api.Devices_DevicesQuery_LongPolling();

    batch(() {
      _refreshSwitchConsumers(response.body?.switchConsumers);
      _refreshProducers(response.body?.producers);
      _refreshElectricityMeters(response.body?.electricityMeters);
    });
  }

  void _refreshSwitchConsumers(List<SwitchConsumerDto>? dtos) {
    dtos ??= [];

    final length = max(switchConsumers.length, dtos.length);

    for (var i = 0; i < length; i++) {
      if (i < switchConsumers.length && i < dtos.length) {
        // update
        switchConsumers[i].update(dtos[i]);
      } else if (i == switchConsumers.length) {
        // add
        switchConsumers.add(SwitchConsumerViewModel(api: _api, dto: dtos[i]));
      } else {
        // remove
        switchConsumers.removeLast();
      }
    }
  }

  void _refreshProducers(List<ProducerDto>? dtos) {
    dtos ??= [];

    final length = max(producers.length, dtos.length);

    for (var i = 0; i < length; i++) {
      if (i < producers.length && i < dtos.length) {
        // update
        producers[i].update(dtos[i]);
      } else if (i == producers.length) {
        // add
        producers.add(ProducerViewModel(api: _api, dto: dtos[i]));
      } else {
        // remove
        producers.removeLast();
      }
    }
  }

  void _refreshElectricityMeters(List<ElectricityMeterDto>? dtos) {
    dtos ??= [];

    final length = max(electricityMeters.length, dtos.length);

    for (var i = 0; i < length; i++) {
      if (i < electricityMeters.length && i < dtos.length) {
        // update
        electricityMeters[i].update(dtos[i]);
      } else if (i == electricityMeters.length) {
        // add
        electricityMeters
            .add(ElectricityMeterViewModel(api: _api, dto: dtos[i]));
      } else {
        // remove
        electricityMeters.removeLast();
      }
    }
  }
}

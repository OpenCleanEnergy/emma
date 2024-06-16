import 'dart:async';

import 'package:emma/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:emma/ui/shared/noop.dart';
import 'package:signals/signals_flutter.dart';

class SwitchConsumerViewModel {
  final BackendApi _api;

  SwitchConsumerViewModel(
      {required BackendApi api, required SwitchConsumerDto dto})
      : _api = api,
        id = signal(dto.id),
        name = signal(dto.name),
        mode = signal(_convertMode(dto.mode, dto.switchStatus)),
        status = signal(_convertStatus(dto.switchStatus)),
        hasReportedPowerConsumption = signal(dto.hasReportedPowerConsumption),
        currentPowerConsumption =
            signal(dto.currentPowerConsumption.toDouble()) {
    delete = _delete.toCommand();
    edit = _edit.toCommand();
    switchOn = _switchOn.toCommand();
    switchOff = _switchOff.toCommand();
  }

  final Signal<String> id;
  final Signal<String> name;
  final Signal<SwitchConsumerMode> mode;
  final Signal<SwitchConsumerStatus> status;
  final Signal<bool> hasReportedPowerConsumption;
  final Signal<double> currentPowerConsumption;

  late final NoArgCommand delete;
  late final ArgCommand<({String name})> edit;
  late final NoArgCommand switchOn;
  late final NoArgCommand switchOff;

  void update(SwitchConsumerDto dto) => batch(() {
        id.value = dto.id;
        name.value = dto.name;
        mode.value = _convertMode(dto.mode, dto.switchStatus);
        status.value = _convertStatus(dto.switchStatus);
        hasReportedPowerConsumption.value = dto.hasReportedPowerConsumption;
        currentPowerConsumption.value = dto.currentPowerConsumption.toDouble();
      });

  void activateSmartMode() {
    noop();
  }

  Future<void> _delete() async {
    await _api.Devices_DeleteSwitchConsumerCommand(switchConsumerId: id.value);
  }

  Future<void> _edit(({String name}) arg) async {
    var response = await _api.Devices_EditSwitchConsumerCommand(
        body: EditSwitchConsumerCommand(
            switchConsumerId: id.value, name: arg.name));

    if (response.isSuccessful) {
      name.value == arg.name;
    }
  }

  Future<void> _switchOn() async {
    await _api.Devices_ManuallySwitchSwitchConsumerCommand(
        body: ManuallySwitchSwitchConsumerCommand(
            switchConsumerId: id.value, status: SwitchStatus.on));

    batch(() {
      mode.value = SwitchConsumerMode.on;
      status.value = SwitchConsumerStatus.on;
    });
  }

  Future<void> _switchOff() async {
    await _api.Devices_ManuallySwitchSwitchConsumerCommand(
        body: ManuallySwitchSwitchConsumerCommand(
            switchConsumerId: id.value, status: SwitchStatus.off));
    batch(() {
      mode.value = SwitchConsumerMode.off;
      status.value = SwitchConsumerStatus.off;
    });
  }

  static SwitchConsumerMode _convertMode(
      ControlMode mode, SwitchStatus status) {
    return switch (mode) {
      ControlMode.swaggerGeneratedUnknown => SwitchConsumerMode.off,
      ControlMode.smart => SwitchConsumerMode.smart,
      ControlMode.manual => switch (status) {
          SwitchStatus.swaggerGeneratedUnknown => SwitchConsumerMode.off,
          SwitchStatus.off => SwitchConsumerMode.off,
          SwitchStatus.on => SwitchConsumerMode.on,
        }
    };
  }

  static SwitchConsumerStatus _convertStatus(SwitchStatus status) {
    return switch (status) {
      SwitchStatus.swaggerGeneratedUnknown => SwitchConsumerStatus.off,
      SwitchStatus.off => SwitchConsumerStatus.off,
      SwitchStatus.on => SwitchConsumerStatus.on,
    };
  }
}

enum SwitchConsumerMode {
  off,
  on,
  smart,
}

enum SwitchConsumerStatus {
  off,
  on,
}

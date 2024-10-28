import 'package:flutter/material.dart';
import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/application/backend_api/models.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:signals/signals.dart';

sealed class AnalysisViewModel {
  abstract final ArgCommand<DateTimeRange> fetch;
}

class DailyAnalysisViewModel implements AnalysisViewModel {
  final BackendApi _api;

  DailyAnalysisViewModel.empty({
    required BackendApi api,
    required DateTime start,
    required DateTime end,
  })  : _api = api,
        start = signal(start),
        end = signal(end) {
    fetch = _fetch.toCommand();
  }

  final Signal<DateTime> start;
  final Signal<DateTime> end;
  final Signal<List<PowerDataPointDto>> home =
      signal<List<PowerDataPointDto>>([]);
  final Signal<List<PowerDataPointDto>> production =
      signal<List<PowerDataPointDto>>([]);
  final Signal<List<PowerDataPointDto>> gridConsume =
      signal<List<PowerDataPointDto>>([]);
  final Signal<List<PowerDataPointDto>> gridFeedIn =
      signal<List<PowerDataPointDto>>([]);

  late final ArgCommand<DateTimeRange> fetch;

  Future _fetch(DateTimeRange period) async {
    final response = await _api.Analytics_DailyAnalysisQuery(
      day: "${period.start.year}-${period.start.month}-${period.start.day}",
      timeZoneOffset: period.start.timeZoneOffset.toString(),
    );

    final dto = response.bodyOrThrow;

    batch(() {
      start.value = period.start;
      end.value = period.end;
      home.value = dto.powerHistory.consumers;
      production.value = dto.powerHistory.producers;
      gridConsume.value = dto.powerHistory.electricityMetersConsume;
      gridFeedIn.value = dto.powerHistory.electricityMetersFeedIn;
    });
  }
}

class ComingSoonAnalysisViewModel implements AnalysisViewModel {
  ComingSoonAnalysisViewModel() {
    fetch = _fetch.toCommand();
  }

  late final ArgCommand<DateTimeRange> fetch;
  Future _fetch(DateTimeRange period) => Future.delayed(Duration.zero);
}

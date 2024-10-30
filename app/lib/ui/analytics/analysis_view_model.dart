import 'package:openems/application/backend_api/models.dart';
import 'package:signals/signals.dart';

sealed class AnalysisViewModel {}

class DailyAnalysisViewModel implements AnalysisViewModel {
  DailyAnalysisViewModel.empty({
    required DateTime start,
    required DateTime end,
  })  : start = signal(start),
        end = signal(end),
        home = signal([]),
        production = signal([]),
        gridConsume = signal([]),
        gridFeedIn = signal([]);

  void update({
    required DateTime start,
    required DateTime end,
    required DailyAnalysisDto dto,
  }) {
    batch(() {
      this.start.value = start;
      this.end.value = end;
      home.value = dto.powerHistory.consumers;
      production.value = dto.powerHistory.producers;
      gridConsume.value = dto.powerHistory.electricityMetersConsume;
      gridFeedIn.value = dto.powerHistory.electricityMetersFeedIn;
    });
  }

  final Signal<DateTime> start;
  final Signal<DateTime> end;
  final Signal<List<PowerDataPointDto>> home;
  final Signal<List<PowerDataPointDto>> production;
  final Signal<List<PowerDataPointDto>> gridConsume;
  final Signal<List<PowerDataPointDto>> gridFeedIn;
}

class ComingSoonAnalysisViewModel implements AnalysisViewModel {}

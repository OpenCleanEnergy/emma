import 'package:openems/application/backend_api/backend_api.dart';
import 'package:signals/signals.dart';

sealed class AnalysisViewModel {}

class DailyAnalysisViewModel implements AnalysisViewModel {
  DailyAnalysisViewModel.empty({
    required DateTime start,
    required DateTime end,
  })  : start = signal(start),
        end = signal(end),
        consumers = signal([]),
        producers = signal([]),
        electricityMetersConsume = signal([]),
        electricityMetersFeedIn = signal([]);

  void update({
    required DateTime start,
    required DateTime end,
    required DailyAnalysisDto dto,
  }) {
    batch(() {
      this.start.value = start;
      this.end.value = end;
      consumers.value = dto.powerHistory.consumers;
      producers.value = dto.powerHistory.producers;
      electricityMetersConsume.value =
          dto.powerHistory.electricityMetersConsume;
      electricityMetersFeedIn.value = dto.powerHistory.electricityMetersFeedIn;
    });
  }

  final Signal<DateTime> start;
  final Signal<DateTime> end;
  final Signal<List<PowerDataPointDto>> consumers;
  final Signal<List<PowerDataPointDto>> producers;
  final Signal<List<PowerDataPointDto>> electricityMetersConsume;
  final Signal<List<PowerDataPointDto>> electricityMetersFeedIn;
}

class ComingSoonAnalysisViewModel implements AnalysisViewModel {}

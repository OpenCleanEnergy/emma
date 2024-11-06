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

class WeeklyAnalysisViewModel implements AnalysisViewModel {
  WeeklyAnalysisViewModel.empty({
    required DayOfWeek firstDayOfWeek,
  })  : firstDayOfWeek = signal(firstDayOfWeek),
        consumers = signal([]),
        producers = signal([]),
        electricityMetersConsumption = signal([]),
        electricityMetersFeedIn = signal([]);

  void update({
    required DayOfWeek firstDayOfWeek,
    required WeeklyAnalysisDto dto,
  }) {
    batch(() {
      this.firstDayOfWeek.value = firstDayOfWeek;
      consumers.value = dto.energyHistory.consumers;
      producers.value = dto.energyHistory.producers;
      electricityMetersConsumption.value =
          dto.energyHistory.electricityMetersConsumption;
      electricityMetersFeedIn.value = dto.energyHistory.electricityMetersFeedIn;
    });
  }

  final Signal<DayOfWeek> firstDayOfWeek;
  final Signal<List<WeeklyEnergyDataPointDto>> consumers;
  final Signal<List<WeeklyEnergyDataPointDto>> producers;
  final Signal<List<WeeklyEnergyDataPointDto>> electricityMetersConsumption;
  final Signal<List<WeeklyEnergyDataPointDto>> electricityMetersFeedIn;
}

class MonthlyAnalysisViewModel implements AnalysisViewModel {
  MonthlyAnalysisViewModel.empty({
    required int month,
    required int daysInMonth,
  })  : month = signal(month),
        daysInMonth = signal(daysInMonth),
        consumers = signal([]),
        producers = signal([]),
        electricityMetersConsumption = signal([]),
        electricityMetersFeedIn = signal([]);

  void update({
    required int month,
    required int daysInMonth,
    required MonthlyAnalysisDto dto,
  }) {
    batch(() {
      this.month.value = month;
      this.daysInMonth.value = daysInMonth;
      consumers.value = dto.energyHistory.consumers;
      producers.value = dto.energyHistory.producers;
      electricityMetersConsumption.value =
          dto.energyHistory.electricityMetersConsumption;
      electricityMetersFeedIn.value = dto.energyHistory.electricityMetersFeedIn;
    });
  }

  final Signal<int> month;
  final Signal<int> daysInMonth;
  final Signal<List<MonthlyEnergyDataPointDto>> consumers;
  final Signal<List<MonthlyEnergyDataPointDto>> producers;
  final Signal<List<MonthlyEnergyDataPointDto>> electricityMetersConsumption;
  final Signal<List<MonthlyEnergyDataPointDto>> electricityMetersFeedIn;
}

class AnnualAnalysisViewModel implements AnalysisViewModel {
  AnnualAnalysisViewModel.empty()
      : consumers = signal([]),
        producers = signal([]),
        electricityMetersConsumption = signal([]),
        electricityMetersFeedIn = signal([]);

  void update({required AnnualAnalysisDto dto}) {
    batch(() {
      consumers.value = dto.energyHistory.consumers;
      producers.value = dto.energyHistory.producers;
      electricityMetersConsumption.value =
          dto.energyHistory.electricityMetersConsumption;
      electricityMetersFeedIn.value = dto.energyHistory.electricityMetersFeedIn;
    });
  }

  final Signal<List<AnnualEnergyDataPointDto>> consumers;
  final Signal<List<AnnualEnergyDataPointDto>> producers;
  final Signal<List<AnnualEnergyDataPointDto>> electricityMetersConsumption;
  final Signal<List<AnnualEnergyDataPointDto>> electricityMetersFeedIn;
}

class ComingSoonAnalysisViewModel implements AnalysisViewModel {}

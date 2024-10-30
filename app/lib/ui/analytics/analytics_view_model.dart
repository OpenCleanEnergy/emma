import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/analytics/analysis_view_model.dart';
import 'package:openems/ui/analytics/analytics_period.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:signals/signals.dart';

class AnalyticsViewModel {
  final BackendApi _api;

  final _period = signal(
    AnalyticsPeriod.day,
    debugLabel: "analytics.vm.period",
  );

  final _range = signal(
    DateTimeRange(
      start: _today(),
      end: _today().add(const Duration(days: 1)),
    ),
    debugLabel: "analytics.vm.range",
  );

  late final Signal<AnalysisViewModel> _analysis;

  AnalyticsViewModel({required BackendApi api}) : _api = api {
    _analysis = signal<AnalysisViewModel>(
      DailyAnalysisViewModel.empty(
        start: _today(),
        end: _today().add(const Duration(days: 1)),
      ),
      debugLabel: "analytics.vm.analysis",
    );

    fetch = _fetch.toCommand();
  }

  final chartControl = AnalyticsChartControlViewModel();

  ReadonlySignal<AnalyticsPeriod> get period => _period;
  ReadonlySignal<DateTimeRange> get range => _range;
  ReadonlySignal<AnalysisViewModel> get analysis => _analysis;

  late final ReadonlySignal<bool> canSetNextRange = computed(
    () {
      final max = _computeDateRange(_period.value, _today());
      return _range.value.start.isBefore(max.start);
    },
    debugLabel: "analytics.vm.canSetNextRange",
  );

  late final NoArgCommand fetch;

  void setPeriod(AnalyticsPeriod period) {
    final range = _computeDateRange(period, _today());
    batch(() {
      _period.value = period;
      _range.value = range;
      _analysis.value = switch (period) {
        AnalyticsPeriod.day => DailyAnalysisViewModel.empty(
            start: range.start,
            end: range.end,
          ),
        AnalyticsPeriod.week => ComingSoonAnalysisViewModel(),
        AnalyticsPeriod.month => ComingSoonAnalysisViewModel(),
        AnalyticsPeriod.year => ComingSoonAnalysisViewModel(),
      };
    });
  }

  void setNextRange() {
    if (!canSetNextRange.value) {
      return;
    }

    _range.value = _computeDateRange(
      _period.value,
      _range.value.end.add(const Duration(hours: 1)),
    );
  }

  void setPreviousRange() {
    _range.value = _computeDateRange(
      _period.value,
      _range.value.start.subtract(const Duration(hours: 1)),
    );
  }

  Future _fetch() async {
    final start = _range.value.start;
    final end = _range.value.end;

    switch (_analysis.value) {
      case DailyAnalysisViewModel daily:
        final response = await _api.Analytics_DailyAnalysisQuery(
          day: "${start.year}-${start.month}-${start.day}",
          timeZoneOffset: start.timeZoneOffset.toString(),
        );

        final dto = response.bodyOrThrow;
        daily.update(start: start, end: end, dto: dto);
      case ComingSoonAnalysisViewModel _:
        break;
    }
  }

  static DateTimeRange _computeDateRange(
    AnalyticsPeriod period,
    DateTime seed,
  ) {
    final dateOnlySeed = DateTime(seed.year, seed.month, seed.day);

    switch (period) {
      case AnalyticsPeriod.day:
        return DateTimeRange(
          start: dateOnlySeed,
          end: dateOnlySeed.add(const Duration(days: 1)),
        );
      case AnalyticsPeriod.week:
        // Monday = 1
        final dayOfWeek = dateOnlySeed.weekday;
        final start = dateOnlySeed.subtract(Duration(days: dayOfWeek - 1));
        final end = start
            .add(const Duration(days: 7))
            .subtract(const Duration(milliseconds: 1));
        return DateTimeRange(start: start, end: end);
      case AnalyticsPeriod.month:
        return DateTimeRange(
          start: DateTime(seed.year, seed.month),
          end: DateTime(seed.year, seed.month + 1),
        );
      case AnalyticsPeriod.year:
        return DateTimeRange(
          start: DateTime(seed.year),
          end: DateTime(seed.year + 1),
        );
    }
  }

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}

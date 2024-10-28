import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/analytics/analysis_view_model.dart';
import 'package:openems/ui/analytics/analytics_period.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:flutter/material.dart';
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

  final Signal<AnalysisViewModel> _analysis;

  AnalyticsViewModel({required BackendApi api})
      : _api = api,
        _analysis = signal<AnalysisViewModel>(
          DailyAnalysisViewModel.empty(
            api: api,
            start: _today(),
            end: _today().add(const Duration(days: 1)),
          ),
          debugLabel: "analytics.vm.analysis",
        );

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

  Future setPeriod(AnalyticsPeriod period) async {
    batch(() {
      _period.value = period;
      _range.value = _computeDateRange(period, _today());
    });

    await Future.delayed(Duration.zero);

    _analysis.value = switch (period) {
      AnalyticsPeriod.day => DailyAnalysisViewModel.empty(
          api: _api,
          start: _range.value.start,
          end: _range.value.end,
        ),
      AnalyticsPeriod.week => ComingSoonAnalysisViewModel(),
      AnalyticsPeriod.month => ComingSoonAnalysisViewModel(),
      AnalyticsPeriod.year => ComingSoonAnalysisViewModel(),
    };

    await _analysis.value.fetch(_range.value);
  }

  Future setNextRange() async {
    if (!canSetNextRange.value) {
      return;
    }

    _range.value = _computeDateRange(
      _period.value,
      _range.value.end.add(const Duration(days: 1)),
    );

    await _analysis.value.fetch(_range.value);
  }

  Future setPreviousRange() async {
    _range.value = _computeDateRange(
      _period.value,
      _range.value.start.subtract(const Duration(days: 1)),
    );

    await _analysis.value.fetch(_range.value);
  }

  static DateTimeRange _computeDateRange(
    AnalyticsPeriod period,
    DateTime seed,
  ) {
    switch (period) {
      case AnalyticsPeriod.day:
        return DateTimeRange(
          start: seed,
          end: seed.add(const Duration(days: 1)),
        );
      case AnalyticsPeriod.week:
        // Monday = 1
        final dayOfWeek = seed.weekday;
        final start = seed.subtract(Duration(days: dayOfWeek - 1));
        final end = start.add(const Duration(days: 7));
        return DateTimeRange(start: start, end: end);
      case AnalyticsPeriod.month:
        return DateTimeRange(
            start: DateTime(seed.year, seed.month),
            end: DateTime(seed.year, seed.month + 1));
      case AnalyticsPeriod.year:
        return DateTimeRange(
            start: DateTime(seed.year), end: DateTime(seed.year + 1));
    }
  }

  static DateTime _today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}

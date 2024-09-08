import 'package:emma/application/analytics/analytics_demo_data.dart';
import 'package:emma/ui/analytics/analytics_period.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

class AnalyticsViewModel {
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

  final showProduction = signal(true);
  final showHome = signal(true);
  final showGridFeedIn = signal(true);
  final showGridConsume = signal(true);

  ReadonlySignal<AnalyticsPeriod> get period => _period;
  ReadonlySignal<DateTimeRange> get range => _range;
  late final ReadonlySignal<bool> canSetNextRange = computed(
    () {
      final max = _computeDateRange(_period.value, _today());
      return _range.value.start.isBefore(max.start);
    },
    debugLabel: "analytics.vm.canSetNextRange",
  );

  late final day = computed(() => AnalyticsDemoData.day(_range.value.start));

  void setPeriod(AnalyticsPeriod period) {
    batch(() {
      _period.value = period;
      _range.value = _computeDateRange(period, _today());
    });
  }

  void setNextRange() {
    if (!canSetNextRange.value) {
      return;
    }

    _range.value = _computeDateRange(
      _period.value,
      _range.value.end.add(const Duration(days: 1)),
    );
  }

  void setPreviousRange() {
    _range.value = _computeDateRange(
      _period.value,
      _range.value.start.subtract(const Duration(days: 1)),
    );
  }

  static DateTimeRange _computeDateRange(
      AnalyticsPeriod period, DateTime seed) {
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

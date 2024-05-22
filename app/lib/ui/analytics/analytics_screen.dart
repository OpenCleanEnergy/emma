import 'package:emma/ui/analytics/consumption_overview.dart';
import 'package:emma/ui/analytics/production_overview.dart';
import 'package:emma/ui/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// AutomaticKeepAliveClientMixin to keep alive
// https://pub.dev/packages/month_year_picker
class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

enum AnalyticsPeriod {
  day,
  week,
  month,
  year,
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  var _period = AnalyticsPeriod.day;
  var _range = DateTimeRange(start: _today(), end: _today());

  String get _periodText {
    return switch (_period) {
      AnalyticsPeriod.day => "Tag",
      AnalyticsPeriod.week => "Woche",
      AnalyticsPeriod.month => "Monat",
      AnalyticsPeriod.year => "Jahr",
    };
  }

  String get _rangeText {
    final start = _range.start;
    switch (_period) {
      case AnalyticsPeriod.day:
        return DateFormat.yMd().format(start);
      case AnalyticsPeriod.week:
        final end = _range.end.subtract(const Duration(seconds: 1));
        final f = DateFormat.yMd();
        return "${f.format(start)} - ${f.format(end)}";
      case AnalyticsPeriod.month:
        return DateFormat.yMMM().format(start);
      case AnalyticsPeriod.year:
        return DateFormat.y().format(start);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          runSpacing: 32,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: _setPreviousPeriod,
                        icon: const Icon(AppIcons.arrow_prev)),
                    Expanded(
                        child: Center(
                      child: Text(_periodText),
                    )),
                    IconButton(
                        onPressed: _setNextPeriod,
                        icon: const Icon(AppIcons.arrow_next)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: _setPreviousRange,
                        icon: const Icon(AppIcons.arrow_prev)),
                    Expanded(
                        child: Center(
                      child: Text(_rangeText),
                    )),
                    IconButton(
                        onPressed: _canSetNextRange() ? _setNextRange : null,
                        icon: const Icon(AppIcons.arrow_next)),
                  ],
                ),
              ],
            ),
            const ProductionOverview(),
            const ConsumptionOverview(),
          ],
        ),
      ),
    );
  }

  void _setNextPeriod() {
    var index = AnalyticsPeriod.values.indexOf(_period);
    index = (index + 1) % AnalyticsPeriod.values.length;
    _setPeriod(AnalyticsPeriod.values[index]);
  }

  void _setPreviousPeriod() {
    var index = AnalyticsPeriod.values.indexOf(_period);
    index = (index - 1) % AnalyticsPeriod.values.length;
    _setPeriod(AnalyticsPeriod.values[index]);
  }

  void _setPeriod(AnalyticsPeriod period) {
    setState(() {
      _period = period;
      _range = _computeDateRange(period, _today());
    });
  }

  void _setPreviousRange() {
    final DateTimeRange range = _computeDateRange(
        _period, _range.start.subtract(const Duration(days: 1)));

    setState(() {
      _range = range;
    });
  }

  bool _canSetNextRange() {
    final max = _computeDateRange(_period, _today());
    return _range.start.isBefore(max.start);
  }

  void _setNextRange() {
    final DateTimeRange range =
        _computeDateRange(_period, _range.end.add(const Duration(days: 1)));

    setState(() {
      _range = range;
    });
  }

  static DateTimeRange _computeDateRange(
      AnalyticsPeriod period, DateTime seed) {
    switch (period) {
      case AnalyticsPeriod.day:
        return DateTimeRange(start: seed, end: seed);
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

import 'dart:math';

import 'package:collection/collection.dart';
import 'package:openems/application/analytics/analytics_day_data_dto.dart';
import 'package:openems/application/backend_api/backend_api.dart';

abstract final class AnalyticsDemoData {
  static AnalyticsDayDataDto day(DateTime start) {
    final consumption = _randomize(
      start,
      _consumption.map((x) => _toDto(start, x)),
    );

    final production = _randomize(
      start,
      _production.map((x) => _toDto(start, x)).toList(),
    );

    final grid = IterableZip([production, consumption])
        .map((x) => (time: x[0].timestamp, power: x[0].power - x[1].power))
        .toList();

    final gridConsume = grid
        .map((x) => PowerDataPointDto(
              timestamp: x.time,
              power: Watt(min(0, x.power).abs().toDouble()),
            ))
        .toList();

    final gridFeedIn = grid
        .map((x) => PowerDataPointDto(
              timestamp: x.time,
              power: Watt(max(0, x.power).toDouble()),
            ))
        .toList();

    return AnalyticsDayDataDto(
      start: start,
      end: start.add(const Duration(days: 1)),
      home: consumption,
      production: production,
      gridConsume: gridConsume,
      gridFeedIn: gridFeedIn,
    );
  }

  static List<PowerDataPointDto> _randomize(
      DateTime start, Iterable<PowerDataPointDto> data) {
    final rnd = Random(start.millisecondsSinceEpoch);
    final scales = [for (var i = 0; i < 12; i++) _getRandomScale(rnd)];
    return data.indexed.map((x) {
      final scale = scales[x.$1 * scales.length ~/ data.length];
      return PowerDataPointDto(
        timestamp: x.$2.timestamp,
        power: Watt((x.$2.power * scale).roundToDouble()),
      );
    }).toList();
  }

  // returns value in range of 0.9 - 1.1
  static double _getRandomScale(Random random) {
    // 0 ... 0.1
    final r = random.nextInt(21) / 100;
    return 0.9 + r;
  }

  static PowerDataPointDto _toDto(
      DateTime start, ({Duration time, double power}) x) {
    return PowerDataPointDto(
      timestamp: start.add(x.time),
      power: Watt(x.power),
    );
  }

  static const _kwP = 0.75;
  static const _sunrise = Duration(hours: 06, minutes: 00);
  static const _sunset = Duration(hours: 20, minutes: 00);
  static final _production = [
    for (var time = Duration.zero;
        time <= const Duration(hours: 24);
        time += const Duration(minutes: 15))
      (
        time: time,
        power: _getProduction(time),
      ),
  ];

  static double _getProduction(Duration time) {
    if (time < _sunrise || time > _sunset) {
      return 0;
    }

    final f = 1 / (_sunset.inMinutes - _sunrise.inMinutes) / 2;
    final t = time.inMinutes - _sunrise.inMinutes;
    final power = pow(sin(2 * pi * f * t), 2) * _kwP * 1000;
    return power.toDouble();
  }

  static final _consumption =
      _defaultHomePower.map((x) => (time: x.time, power: x.power * _factor));

  static const _factor = 2.7;
  static final _defaultHomePower = [
    (time: const Duration(hours: 00, minutes: 00), power: 96.5),
    (time: const Duration(hours: 0, minutes: 15), power: 86.3),
    (time: const Duration(hours: 0, minutes: 30), power: 76.9),
    (time: const Duration(hours: 0, minutes: 45), power: 68.8),
    (time: const Duration(hours: 1, minutes: 00), power: 62.4),
    (time: const Duration(hours: 1, minutes: 15), power: 58.0),
    (time: const Duration(hours: 1, minutes: 30), power: 55.3),
    (time: const Duration(hours: 1, minutes: 45), power: 53.6),
    (time: const Duration(hours: 2, minutes: 00), power: 52.4),
    (time: const Duration(hours: 2, minutes: 15), power: 51.3),
    (time: const Duration(hours: 2, minutes: 30), power: 50.3),
    (time: const Duration(hours: 2, minutes: 45), power: 49.2),
    (time: const Duration(hours: 3, minutes: 00), power: 48.3),
    (time: const Duration(hours: 3, minutes: 15), power: 47.5),
    (time: const Duration(hours: 3, minutes: 30), power: 46.9),
    (time: const Duration(hours: 3, minutes: 45), power: 46.5),
    (time: const Duration(hours: 4, minutes: 00), power: 46.6),
    (time: const Duration(hours: 4, minutes: 15), power: 47.1),
    (time: const Duration(hours: 4, minutes: 30), power: 48.0),
    (time: const Duration(hours: 4, minutes: 45), power: 49.3),
    (time: const Duration(hours: 5, minutes: 00), power: 50.8),
    (time: const Duration(hours: 5, minutes: 15), power: 52.7),
    (time: const Duration(hours: 5, minutes: 30), power: 55.6),
    (time: const Duration(hours: 5, minutes: 45), power: 60.5),
    (time: const Duration(hours: 6, minutes: 00), power: 68.2),
    (time: const Duration(hours: 6, minutes: 15), power: 79.2),
    (time: const Duration(hours: 6, minutes: 30), power: 92.0),
    (time: const Duration(hours: 6, minutes: 45), power: 104.7),
    (time: const Duration(hours: 7, minutes: 00), power: 115.7),
    (time: const Duration(hours: 7, minutes: 15), power: 123.5),
    (time: const Duration(hours: 7, minutes: 30), power: 128.6),
    (time: const Duration(hours: 7, minutes: 45), power: 132.0),
    (time: const Duration(hours: 8, minutes: 00), power: 134.8),
    (time: const Duration(hours: 8, minutes: 15), power: 137.8),
    (time: const Duration(hours: 8, minutes: 30), power: 140.7),
    (time: const Duration(hours: 8, minutes: 45), power: 143.2),
    (time: const Duration(hours: 9, minutes: 00), power: 144.8),
    (time: const Duration(hours: 9, minutes: 15), power: 145.3),
    (time: const Duration(hours: 9, minutes: 30), power: 144.9),
    (time: const Duration(hours: 9, minutes: 45), power: 143.8),
    (time: const Duration(hours: 10, minutes: 00), power: 142.3),
    (time: const Duration(hours: 10, minutes: 15), power: 140.8),
    (time: const Duration(hours: 10, minutes: 30), power: 139.5),
    (time: const Duration(hours: 10, minutes: 45), power: 138.5),
    (time: const Duration(hours: 11, minutes: 00), power: 138.2),
    (time: const Duration(hours: 11, minutes: 15), power: 138.6),
    (time: const Duration(hours: 11, minutes: 30), power: 140.1),
    (time: const Duration(hours: 11, minutes: 45), power: 142.6),
    (time: const Duration(hours: 12, minutes: 00), power: 146.5),
    (time: const Duration(hours: 12, minutes: 15), power: 151.5),
    (time: const Duration(hours: 12, minutes: 30), power: 156.7),
    (time: const Duration(hours: 12, minutes: 45), power: 160.7),
    (time: const Duration(hours: 13, minutes: 00), power: 162.3),
    (time: const Duration(hours: 13, minutes: 15), power: 160.5),
    (time: const Duration(hours: 13, minutes: 30), power: 156.1),
    (time: const Duration(hours: 13, minutes: 45), power: 150.2),
    (time: const Duration(hours: 14, minutes: 00), power: 144.0),
    (time: const Duration(hours: 14, minutes: 15), power: 138.4),
    (time: const Duration(hours: 14, minutes: 30), power: 133.6),
    (time: const Duration(hours: 14, minutes: 45), power: 129.4),
    (time: const Duration(hours: 15, minutes: 00), power: 125.7),
    (time: const Duration(hours: 15, minutes: 15), power: 122.4),
    (time: const Duration(hours: 15, minutes: 30), power: 119.6),
    (time: const Duration(hours: 15, minutes: 45), power: 117.4),
    (time: const Duration(hours: 16, minutes: 00), power: 115.7),
    (time: const Duration(hours: 16, minutes: 15), power: 114.6),
    (time: const Duration(hours: 16, minutes: 30), power: 114.2),
    (time: const Duration(hours: 16, minutes: 45), power: 114.6),
    (time: const Duration(hours: 17, minutes: 00), power: 115.7),
    (time: const Duration(hours: 17, minutes: 15), power: 117.6),
    (time: const Duration(hours: 17, minutes: 30), power: 120.3),
    (time: const Duration(hours: 17, minutes: 45), power: 123.9),
    (time: const Duration(hours: 18, minutes: 00), power: 128.2),
    (time: const Duration(hours: 18, minutes: 15), power: 133.2),
    (time: const Duration(hours: 18, minutes: 30), power: 138.9),
    (time: const Duration(hours: 18, minutes: 45), power: 145.1),
    (time: const Duration(hours: 19, minutes: 00), power: 151.5),
    (time: const Duration(hours: 19, minutes: 15), power: 157.9),
    (time: const Duration(hours: 19, minutes: 30), power: 163.8),
    (time: const Duration(hours: 19, minutes: 45), power: 168.3),
    (time: const Duration(hours: 20, minutes: 00), power: 170.6),
    (time: const Duration(hours: 20, minutes: 15), power: 170.4),
    (time: const Duration(hours: 20, minutes: 30), power: 168.3),
    (time: const Duration(hours: 20, minutes: 45), power: 165.3),
    (time: const Duration(hours: 21, minutes: 00), power: 162.3),
    (time: const Duration(hours: 21, minutes: 15), power: 160.1),
    (time: const Duration(hours: 21, minutes: 30), power: 158.4),
    (time: const Duration(hours: 21, minutes: 45), power: 156.8),
    (time: const Duration(hours: 22, minutes: 00), power: 154.8),
    (time: const Duration(hours: 22, minutes: 15), power: 151.9),
    (time: const Duration(hours: 22, minutes: 30), power: 147.9),
    (time: const Duration(hours: 22, minutes: 45), power: 142.5),
    (time: const Duration(hours: 23, minutes: 00), power: 135.7),
    (time: const Duration(hours: 23, minutes: 15), power: 127.2),
    (time: const Duration(hours: 23, minutes: 30), power: 117.5),
    (time: const Duration(hours: 23, minutes: 45), power: 107.1),
    (time: const Duration(hours: 24, minutes: 00), power: 96.5),
  ];
}

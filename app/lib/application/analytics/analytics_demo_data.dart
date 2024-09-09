import 'dart:math';

import 'package:emma/application/analytics/analytics_day_data_dto.dart';
import 'package:emma/application/analytics/power_data_point_dto.dart';

abstract final class AnalyticsDemoData {
  static AnalyticsDayDataDto day(DateTime start) {
    return AnalyticsDayDataDto(
      start: start,
      end: start.add(const Duration(days: 1)),
      home: _randomize(
        start,
        _defaultHomePower
            .map((x) => PowerDataPointDto(
                  start.add(x.time),
                  x.watts * _factor,
                ))
            .toList(),
      ),
    );
  }

  static List<PowerDataPointDto> _randomize(
      DateTime start, List<PowerDataPointDto> data) {
    final rnd = Random(start.millisecondsSinceEpoch);
    final scales = [for (var i = 0; i < 6; i++) _getRandomScale(rnd)];
    return data.indexed.map((x) {
      final scale = scales[x.$1 * scales.length ~/ data.length];
      return PowerDataPointDto(x.$2.time, (x.$2.power * scale).roundToDouble());
    }).toList();
  }

  // returns value in range of 0.95 - 1.05
  static double _getRandomScale(Random random) {
    // 0 ... 0.1
    final r = random.nextInt(101) / 1000;
    return 0.95 + r;
  }

  static const _factor = 2.7;
  static final _defaultHomePower = [
    (time: const Duration(hours: 00, minutes: 00), watts: 96.5),
    (time: const Duration(hours: 0, minutes: 15), watts: 86.3),
    (time: const Duration(hours: 0, minutes: 30), watts: 76.9),
    (time: const Duration(hours: 0, minutes: 45), watts: 68.8),
    (time: const Duration(hours: 1, minutes: 00), watts: 62.4),
    (time: const Duration(hours: 1, minutes: 15), watts: 58.0),
    (time: const Duration(hours: 1, minutes: 30), watts: 55.3),
    (time: const Duration(hours: 1, minutes: 45), watts: 53.6),
    (time: const Duration(hours: 2, minutes: 00), watts: 52.4),
    (time: const Duration(hours: 2, minutes: 15), watts: 51.3),
    (time: const Duration(hours: 2, minutes: 30), watts: 50.3),
    (time: const Duration(hours: 2, minutes: 45), watts: 49.2),
    (time: const Duration(hours: 3, minutes: 00), watts: 48.3),
    (time: const Duration(hours: 3, minutes: 15), watts: 47.5),
    (time: const Duration(hours: 3, minutes: 30), watts: 46.9),
    (time: const Duration(hours: 3, minutes: 45), watts: 46.5),
    (time: const Duration(hours: 4, minutes: 00), watts: 46.6),
    (time: const Duration(hours: 4, minutes: 15), watts: 47.1),
    (time: const Duration(hours: 4, minutes: 30), watts: 48.0),
    (time: const Duration(hours: 4, minutes: 45), watts: 49.3),
    (time: const Duration(hours: 5, minutes: 00), watts: 50.8),
    (time: const Duration(hours: 5, minutes: 15), watts: 52.7),
    (time: const Duration(hours: 5, minutes: 30), watts: 55.6),
    (time: const Duration(hours: 5, minutes: 45), watts: 60.5),
    (time: const Duration(hours: 6, minutes: 00), watts: 68.2),
    (time: const Duration(hours: 6, minutes: 15), watts: 79.2),
    (time: const Duration(hours: 6, minutes: 30), watts: 92.0),
    (time: const Duration(hours: 6, minutes: 45), watts: 104.7),
    (time: const Duration(hours: 7, minutes: 00), watts: 115.7),
    (time: const Duration(hours: 7, minutes: 15), watts: 123.5),
    (time: const Duration(hours: 7, minutes: 30), watts: 128.6),
    (time: const Duration(hours: 7, minutes: 45), watts: 132.0),
    (time: const Duration(hours: 8, minutes: 00), watts: 134.8),
    (time: const Duration(hours: 8, minutes: 15), watts: 137.8),
    (time: const Duration(hours: 8, minutes: 30), watts: 140.7),
    (time: const Duration(hours: 8, minutes: 45), watts: 143.2),
    (time: const Duration(hours: 9, minutes: 00), watts: 144.8),
    (time: const Duration(hours: 9, minutes: 15), watts: 145.3),
    (time: const Duration(hours: 9, minutes: 30), watts: 144.9),
    (time: const Duration(hours: 9, minutes: 45), watts: 143.8),
    (time: const Duration(hours: 10, minutes: 00), watts: 142.3),
    (time: const Duration(hours: 10, minutes: 15), watts: 140.8),
    (time: const Duration(hours: 10, minutes: 30), watts: 139.5),
    (time: const Duration(hours: 10, minutes: 45), watts: 138.5),
    (time: const Duration(hours: 11, minutes: 00), watts: 138.2),
    (time: const Duration(hours: 11, minutes: 15), watts: 138.6),
    (time: const Duration(hours: 11, minutes: 30), watts: 140.1),
    (time: const Duration(hours: 11, minutes: 45), watts: 142.6),
    (time: const Duration(hours: 12, minutes: 00), watts: 146.5),
    (time: const Duration(hours: 12, minutes: 15), watts: 151.5),
    (time: const Duration(hours: 12, minutes: 30), watts: 156.7),
    (time: const Duration(hours: 12, minutes: 45), watts: 160.7),
    (time: const Duration(hours: 13, minutes: 00), watts: 162.3),
    (time: const Duration(hours: 13, minutes: 15), watts: 160.5),
    (time: const Duration(hours: 13, minutes: 30), watts: 156.1),
    (time: const Duration(hours: 13, minutes: 45), watts: 150.2),
    (time: const Duration(hours: 14, minutes: 00), watts: 144.0),
    (time: const Duration(hours: 14, minutes: 15), watts: 138.4),
    (time: const Duration(hours: 14, minutes: 30), watts: 133.6),
    (time: const Duration(hours: 14, minutes: 45), watts: 129.4),
    (time: const Duration(hours: 15, minutes: 00), watts: 125.7),
    (time: const Duration(hours: 15, minutes: 15), watts: 122.4),
    (time: const Duration(hours: 15, minutes: 30), watts: 119.6),
    (time: const Duration(hours: 15, minutes: 45), watts: 117.4),
    (time: const Duration(hours: 16, minutes: 00), watts: 115.7),
    (time: const Duration(hours: 16, minutes: 15), watts: 114.6),
    (time: const Duration(hours: 16, minutes: 30), watts: 114.2),
    (time: const Duration(hours: 16, minutes: 45), watts: 114.6),
    (time: const Duration(hours: 17, minutes: 00), watts: 115.7),
    (time: const Duration(hours: 17, minutes: 15), watts: 117.6),
    (time: const Duration(hours: 17, minutes: 30), watts: 120.3),
    (time: const Duration(hours: 17, minutes: 45), watts: 123.9),
    (time: const Duration(hours: 18, minutes: 00), watts: 128.2),
    (time: const Duration(hours: 18, minutes: 15), watts: 133.2),
    (time: const Duration(hours: 18, minutes: 30), watts: 138.9),
    (time: const Duration(hours: 18, minutes: 45), watts: 145.1),
    (time: const Duration(hours: 19, minutes: 00), watts: 151.5),
    (time: const Duration(hours: 19, minutes: 15), watts: 157.9),
    (time: const Duration(hours: 19, minutes: 30), watts: 163.8),
    (time: const Duration(hours: 19, minutes: 45), watts: 168.3),
    (time: const Duration(hours: 20, minutes: 00), watts: 170.6),
    (time: const Duration(hours: 20, minutes: 15), watts: 170.4),
    (time: const Duration(hours: 20, minutes: 30), watts: 168.3),
    (time: const Duration(hours: 20, minutes: 45), watts: 165.3),
    (time: const Duration(hours: 21, minutes: 00), watts: 162.3),
    (time: const Duration(hours: 21, minutes: 15), watts: 160.1),
    (time: const Duration(hours: 21, minutes: 30), watts: 158.4),
    (time: const Duration(hours: 21, minutes: 45), watts: 156.8),
    (time: const Duration(hours: 22, minutes: 00), watts: 154.8),
    (time: const Duration(hours: 22, minutes: 15), watts: 151.9),
    (time: const Duration(hours: 22, minutes: 30), watts: 147.9),
    (time: const Duration(hours: 22, minutes: 45), watts: 142.5),
    (time: const Duration(hours: 23, minutes: 00), watts: 135.7),
    (time: const Duration(hours: 23, minutes: 15), watts: 127.2),
    (time: const Duration(hours: 23, minutes: 30), watts: 117.5),
    (time: const Duration(hours: 23, minutes: 45), watts: 107.1),
    (time: const Duration(hours: 24, minutes: 00), watts: 96.5),
  ];
}

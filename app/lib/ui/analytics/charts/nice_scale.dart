import 'dart:math' as math;

// https://stackoverflow.com/a/16363437
class NiceScale {
  NiceScale._(
      {required this.min, required this.max, required this.tickInterval});

  final double min;
  final double max;
  final double tickInterval;

  factory NiceScale.calculate({
    required int maxTicks,
    required num min,
    required num max,
  }) {
    final range = _niceNum(max - min, _NiceNumMethod.ceil);
    final tickInterval = _niceNum(range / (maxTicks - 1), _NiceNumMethod.round);
    final niceMin = (min / tickInterval).floor() * tickInterval;
    final niceMax = (max / tickInterval).ceil() * tickInterval;

    return NiceScale._(
      min: niceMin,
      max: niceMax,
      tickInterval: tickInterval,
    );
  }

  static double _niceNum(num range, _NiceNumMethod method) {
    final exponent = _log10(range).floor();
    final fraction = range / math.pow(10, exponent);

    late final double niceFraction;
    switch (method) {
      case _NiceNumMethod.round:
        switch (fraction) {
          case < 1.5:
            niceFraction = 1;
          case < 3:
            niceFraction = 2;
          case < 7:
            niceFraction = 5;
          default:
            niceFraction = 10;
        }
        break;
      case _NiceNumMethod.ceil:
        switch (fraction) {
          case <= 1:
            niceFraction = 1;
          case <= 2:
            niceFraction = 2;
          case <= 5:
            niceFraction = 5;
          default:
            niceFraction = 10;
        }
        break;
    }

    return niceFraction * math.pow(10, exponent);
  }

  static double _log10(num x) => math.log(x) / math.ln10;
}

enum _NiceNumMethod {
  round,
  ceil,
}

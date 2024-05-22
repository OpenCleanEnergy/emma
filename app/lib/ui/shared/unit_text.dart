import 'package:flutter/material.dart';

class UnitText extends StatelessWidget {
  const UnitText(this.value, this.unit, {this.color, super.key});

  const UnitText.energy(double wattHours, {this.color, super.key})
      : value = wattHours,
        unit = "Wh";

  const UnitText.power(double watts, {this.color, super.key})
      : value = watts,
        unit = "W";

  UnitText.percentage(double percentage, {this.color, super.key})
      : value = (percentage * 100).roundToDouble(),
        unit = "%";

  static TextSpan percentageSpan(BuildContext context, double percentage) =>
      span(context, (percentage * 100).roundToDouble(), "%");

  static TextSpan span(BuildContext context, double value, String unit,
      [Color? color]) {
    final theme = Theme.of(context);
    final converted = _kilo(value, unit);

    final coloredTextStyle = color == null ? null : TextStyle(color: color);
    return TextSpan(
      text: converted.value.toStringAsFixed(converted.decimalPlaces),
      style: theme.textTheme.bodyLarge?.apply(color: color) ?? coloredTextStyle,
      children: [
        TextSpan(
            text: converted.unit,
            style: theme.textTheme.bodySmall?.apply(color: color) ??
                coloredTextStyle)
      ],
    );
  }

  final double value;
  final String unit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(span(context, value, unit, color));
  }

  static ({double value, String unit, int decimalPlaces}) _kilo(
      double value, String unit) {
    return value < 1000
        ? (value: value, unit: unit, decimalPlaces: 0)
        : (value: value / 1000.0, unit: "k$unit", decimalPlaces: 2);
  }
}

import 'package:flutter/material.dart';
import 'package:openems/application/backend_api/value_types.dart';

class UnitText extends StatelessWidget {
  const UnitText(this.value, this.unit, {this.color, super.key});

  const UnitText.energy(num wattHours, {this.color, super.key})
      : value = wattHours,
        unit = "Wh";

  const UnitText.power(Watt watt, {this.color, super.key})
      : value = watt,
        unit = Watt.unit;

  UnitText.percentage(num percentage, {this.color, super.key})
      : value = (percentage * 100).roundToDouble(),
        unit = "%";

  static TextSpan percentageSpan(BuildContext context, num percentage) =>
      span(context, (percentage * 100).roundToDouble(), "%");

  static TextSpan span(BuildContext context, num value, String unit,
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

  final num value;
  final String unit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(span(context, value, unit, color));
  }

  static ({num value, String unit, int decimalPlaces}) _kilo(
      num value, String unit) {
    return value < 1000
        ? (value: value, unit: unit, decimalPlaces: 0)
        : (value: value / 1000.0, unit: "k$unit", decimalPlaces: 2);
  }
}

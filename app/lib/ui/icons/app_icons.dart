import 'package:flutter/material.dart';
import 'package:openems/ui/icons/uicons/uicons.dart';

// ignore_for_file: constant_identifier_names

/// All icons to be used.
abstract final class AppIcons {
  static const Scale scale = Scale._();

  static const add = RegularRounded.plus;
  static const analytics = RegularRounded.chart_simple;
  static const analytics_solid = SolidRounded.chart_simple;
  static const arrow_next = RegularRounded.angle_right;
  static const arrow_prev = RegularRounded.angle_left;
  static const at = RegularRounded.at;
  static const battery_1_bar = RegularRounded.battery_quarter;
  static const battery_2_bar = RegularRounded.battery_half;
  static const battery_3_bar = RegularRounded.battery_three_quarters;
  static const battery_empty = RegularRounded.battery_empty;
  static const battery_full = RegularRounded.battery_full;
  static const circle = Icons.circle;
  static const close = RegularRounded.cross;
  static const device = RegularRounded.plug_cable;
  static const device_solid = SolidRounded.plug_cable;
  static const error = RegularRounded.exclamation;
  static const flow_down_double = RegularRounded.chevron_double_down;
  static const flow_none = RegularRounded.minus_small;
  static const flow_right = RegularRounded.angle_small_right;
  static const flow_up_double = RegularRounded.chevron_double_up;
  static const home = RegularRounded.house_chimney;
  static const home_solid = SolidRounded.house_chimney;
  static const info = RegularRounded.info;
  static const login = RegularRounded.sign_in_alt;
  static const logout = RegularRounded.sign_out_alt;
  static const logs = RegularRounded.terminal;
  static const open_in_new = RegularRounded.up_right_from_square;
  static const person = RegularRounded.user;
  static const power_grid = RegularRounded.meter_bolt;
  static const priority = RegularRounded.priority_arrow;
  static const rotate_right = RegularRounded.rotate_right;
  static const screen = RegularRounded.expand;
  static const solar_power = RegularRounded.solar_panel;
}

final class Scale {
  const Scale._();

  static const double _defaultSize = 24.0;
  static const double _targetSize = 20.0;

  final double size = _targetSize;
  final double opticalSize = _targetSize * 2;
  final double scale = _targetSize / _defaultSize;
}

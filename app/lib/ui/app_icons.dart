// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

/// All icons to be used.
class AppIcons {
  const AppIcons._();

  static const _fontFamily = "materialdesignicons_webfont";

  // Custom: https://pictogrammers.com/library/mdi/
  static const IconData transmission_tower =
      IconData(0xF0D3E, fontFamily: _fontFamily);

  static const IconData circle_slice_8 =
      IconData(0xF0AA5, fontFamily: _fontFamily);

  // Default:
  static const IconData add = Icons.add;

  static const IconData arrow_next = Icons.chevron_right_rounded;
  static const IconData arrow_prev = Icons.chevron_left_rounded;
  static const IconData arrow_flow_right = Icons.chevron_right_rounded;
  static const IconData arrow_flow_down_double =
      Icons.keyboard_double_arrow_down_rounded;
  static const IconData arrow_flow_up_double = Icons.keyboard_arrow_up_rounded;

  static const IconData battery_0_bar = Icons.battery_0_bar_rounded;
  static const IconData battery_1_bar = Icons.battery_1_bar_rounded;
  static const IconData battery_2_bar = Icons.battery_2_bar_rounded;
  static const IconData battery_3_bar = Icons.battery_3_bar_rounded;
  static const IconData battery_4_bar = Icons.battery_4_bar_rounded;
  static const IconData battery_5_bar = Icons.battery_5_bar_rounded;
  static const IconData battery_6_bar = Icons.battery_6_bar_rounded;
  static const IconData battery_full = Icons.battery_full_rounded;

  static const IconData close = Icons.close;

  static const IconData error = Icons.error_outline;

  static const IconData home = Icons.home_rounded;
  static const IconData home_outlined = Icons.home_outlined;

  static const IconData info = Icons.info_outline;

  static const IconData login = Icons.login_rounded;
  static const IconData logout = Icons.logout_rounded;

  static const IconData pie_chart = Icons.pie_chart_rounded;
  static const IconData pie_chart_outlined = Icons.pie_chart_outline_rounded;

  static const IconData person = Icons.person_rounded;
  static const IconData person_outlined = Icons.person_outline_rounded;

  static const IconData power = Icons.power_rounded;
  static const IconData power_outlined = Icons.power_outlined;

  // Alternative: Icons.auto_fix_high_rounded
  static const IconData smart = Icons.auto_awesome_rounded;

  static const IconData solar_power = Icons.solar_power_rounded;
  static const IconData sunny = Icons.sunny;
  static const IconData wind_power = Icons.wind_power_rounded;
}

import 'package:emma/application/analytics/power_data_point_dto.dart';

class AnalyticsDayDataDto {
  final DateTime start;
  final DateTime end;
  final List<PowerDataPointDto> home;

  AnalyticsDayDataDto({
    required this.start,
    required this.end,
    required this.home,
  });
}

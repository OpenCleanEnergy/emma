import 'package:openems/application/backend_api/backend_api.dart';
import 'package:signals/signals.dart';

class AnalyticsMetricsViewModel {
  final Signal<OwnConsumptionMetricDto> _ownConsumption = signal(
    const OwnConsumptionMetricDto(
      percentage: Percentage.zero,
      ownConsumption: WattHours.zero,
      gridFeedIn: WattHours.zero,
      production: WattHours.zero,
    ),
  );

  final Signal<SelfSufficiencyMetricDto> _selfSufficiency = signal(
    const SelfSufficiencyMetricDto(
      percentage: Percentage.zero,
      ownConsumption: WattHours.zero,
      gridConsumption: WattHours.zero,
      totalConsumption: WattHours.zero,
    ),
  );

  ReadonlySignal<OwnConsumptionMetricDto> get ownConsumption => _ownConsumption;
  ReadonlySignal<SelfSufficiencyMetricDto> get selfSufficiency =>
      _selfSufficiency;

  void update(AnalyticsMetricsDto dto) {
    batch(() {
      _ownConsumption.value = dto.ownConsumption;
      _selfSufficiency.value = dto.selfSufficiency;
    });
  }
}

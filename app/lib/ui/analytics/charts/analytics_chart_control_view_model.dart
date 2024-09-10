import 'package:signals/signals.dart';

class AnalyticsChartControlViewModel {
  final _showProduction = signal(true);
  final _showHome = signal(true);
  final _showGridFeedIn = signal(true);
  final _showGridConsume = signal(true);

  late final Iterable<ReadonlySignal<bool>> _all = [
    _showProduction,
    _showHome,
    _showGridFeedIn,
    _showGridConsume,
  ];

  ReadonlySignal<bool> get showProduction => _showProduction;
  ReadonlySignal<bool> get showHome => _showHome;
  ReadonlySignal<bool> get showGridFeedIn => _showGridFeedIn;
  ReadonlySignal<bool> get showGridConsume => _showGridConsume;

  void toggleProduction() => _toggle(_showProduction);
  void toggleHome() => _toggle(_showHome);
  void toggleGridFeedIn() => _toggle(_showGridFeedIn);
  void toggleGridConsume() => _toggle(_showGridConsume);

  void _toggle(Signal<bool> signal) {
    if (!signal.value) {
      signal.value = true;
    } else {
      final canDisable = _all.where((x) => x.value).length > 1;
      if (canDisable) {
        signal.value = false;
      }
    }
  }
}

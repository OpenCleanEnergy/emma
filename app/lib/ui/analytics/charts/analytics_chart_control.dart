import 'package:emma/ui/analytics/analytics_view_model.dart';
import 'package:emma/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsChartControl extends StatelessWidget {
  const AnalyticsChartControl({
    super.key,
    required this.viewModel,
  });

  final AnalyticsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: [
        _ToggleButton(
          label: "Produktion",
          color: AnalyticsChartColors.production,
          state: viewModel.showProduction,
        ),
        _ToggleButton(
          label: "Hausverbrauch",
          color: AnalyticsChartColors.home,
          state: viewModel.showHome,
        ),
        _ToggleButton(
          label: "Einspeisung",
          color: AnalyticsChartColors.gridFeedIn,
          state: viewModel.showGridFeedIn,
        ),
        _ToggleButton(
          label: "Netzbezug",
          color: AnalyticsChartColors.gridConsumption,
          state: viewModel.showGridConsume,
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({
    required this.label,
    required this.color,
    required this.state,
  });

  final String label;
  final Color color;
  final Signal<bool> state;

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => OutlinedButton(
        onPressed: () => state.value = !state.value,
        style: state.value ? _enabled() : _disabled(context),
        child: Text(label),
      ),
    );
  }

  ButtonStyle _enabled() {
    return OutlinedButton.styleFrom(
      side: BorderSide(color: color),
      backgroundColor: color.withOpacity(0.12),
    );
  }

  // from https://m3.material.io/components/buttons/specs#de72d8b1-ba16-4cd7-989e-e2ad3293cf63
  static ButtonStyle _disabled(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;

    return OutlinedButton.styleFrom(
      side: BorderSide(color: color.withOpacity(0.12)),
      foregroundColor: color.withOpacity(0.38),
    );
  }
}

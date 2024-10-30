import 'package:openems/ui/analytics/charts/analytics_chart_colors.dart';
import 'package:openems/ui/analytics/charts/analytics_chart_control_view_model.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsChartControl extends StatelessWidget {
  const AnalyticsChartControl({
    super.key,
    required this.viewModel,
  });

  final AnalyticsChartControlViewModel viewModel;

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
          onPressed: viewModel.toggleProduction,
        ),
        _ToggleButton(
          label: "Verbrauch",
          color: AnalyticsChartColors.consumption,
          state: viewModel.showConsumption,
          onPressed: viewModel.toggleHome,
        ),
        _ToggleButton(
          label: "Einspeisung",
          color: AnalyticsChartColors.gridFeedIn,
          state: viewModel.showGridFeedIn,
          onPressed: viewModel.toggleGridFeedIn,
        ),
        _ToggleButton(
          label: "Netzbezug",
          color: AnalyticsChartColors.gridConsumption,
          state: viewModel.showGridConsume,
          onPressed: viewModel.toggleGridConsume,
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
    required this.onPressed,
  });

  final String label;
  final Color color;
  final ReadonlySignal<bool> state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => OutlinedButton(
        onPressed: onPressed,
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

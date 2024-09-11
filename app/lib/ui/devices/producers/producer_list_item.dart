import 'package:openems/ui/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/producers/edit_producer_screen.dart';
import 'package:openems/ui/devices/producers/producer_view_model.dart';
import 'package:openems/ui/devices/widgets/on_off_indicator.dart';
import 'package:openems/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ProducerListItem extends StatelessWidget {
  const ProducerListItem({super.key, required this.viewModel});

  final ProducerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card.outlined(
      child: ListTile(
        leading: Watch((context) =>
            OnOffIndicator(status: viewModel.currentPowerProduction.value > 0)),
        title: Watch((context) => Text(
              viewModel.name.value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: _getTextColor(
                      colorScheme, viewModel.currentPowerProduction.value)),
            )),
        subtitle: Watch((context) => UnitText.power(
            viewModel.currentPowerProduction.value,
            color: _getTextColor(
                colorScheme, viewModel.currentPowerProduction.value))),
        trailing: IconButton(
          icon: const Icon(AppIcons.arrow_next),
          onPressed: _gotoEdit,
        ),
      ),
    );
  }

  void _gotoEdit() {
    AppNavigator.push(EditProducerScreen(viewModel: viewModel));
  }

  Color _getTextColor(ColorScheme colorScheme, double power) {
    return switch (power) {
      0 => colorScheme.secondary,
      _ => colorScheme.primary,
    };
  }
}

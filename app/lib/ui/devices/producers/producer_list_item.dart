import 'package:openems/application/backend_api/value_types.dart';
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
      clipBehavior: Clip.hardEdge,
      child: Watch(
        (context) => ListTile(
          leading: OnOffIndicator(
            status: viewModel.currentPowerProduction.value != null &&
                (viewModel.currentPowerProduction.value! > Watt.zero),
          ),
          title: Text(
            viewModel.name.value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: _getTextColor(
                    colorScheme, viewModel.currentPowerProduction.value)),
          ),
          subtitle: viewModel.currentPowerProduction.value == null
              ? null
              : UnitText.power(viewModel.currentPowerProduction.value!,
                  color: _getTextColor(
                      colorScheme, viewModel.currentPowerProduction.value)),
          trailing: const Icon(AppIcons.arrow_next),
          onTap: _gotoEdit,
        ),
      ),
    );
  }

  void _gotoEdit() {
    AppNavigator.push(EditProducerScreen(viewModel: viewModel));
  }

  Color _getTextColor(ColorScheme colorScheme, Watt? power) {
    return switch (power) {
      Watt.zero => colorScheme.secondary,
      _ => colorScheme.primary,
    };
  }
}

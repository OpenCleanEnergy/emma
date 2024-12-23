import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/meters/edit_electricity_meter_screen.dart';
import 'package:openems/ui/devices/meters/electricity_meter_view_model.dart';
import 'package:openems/ui/devices/widgets/on_off_indicator.dart';
import 'package:openems/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ElectricityMeterListItem extends StatelessWidget {
  const ElectricityMeterListItem({super.key, required this.viewModel});

  final ElectricityMeterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    const icon = Icon(AppIcons.power_grid);
    final colorScheme = Theme.of(context).colorScheme;

    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: Watch(
        (context) => ListTile(
          leading: Watch<Widget>(
            (context) => switch (viewModel.currentPowerDirection.value) {
              GridPowerDirection.swaggerGeneratedUnknown ||
              GridPowerDirection.none =>
                const OnOffIndicator(
                  status: false,
                  icon: icon,
                ),
              GridPowerDirection.consume => OnOffIndicator(
                  status: true,
                  icon: icon,
                  onColor: colorScheme.error,
                ),
              GridPowerDirection.feedin => const OnOffIndicator(
                  status: true,
                  icon: icon,
                ),
            },
          ),
          title: Text(
            viewModel.name.value,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: _getTextColor(colorScheme, viewModel.currentPower.value),
            ),
          ),
          subtitle: viewModel.currentPower.value == null
              ? null
              : UnitText.power(
                  viewModel.currentPower.value!,
                  color:
                      _getTextColor(colorScheme, viewModel.currentPower.value),
                ),
          trailing: const Icon(AppIcons.arrow_next),
          onTap: _gotoEdit,
        ),
      ),
    );
  }

  void _gotoEdit() {
    AppNavigator.push(EditElectricityMeterScreen(viewModel: viewModel));
  }

  static Color _getTextColor(ColorScheme colorScheme, Watt? power) {
    return switch (power) {
      Watt.zero => colorScheme.secondary,
      _ => colorScheme.primary,
    };
  }
}

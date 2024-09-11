import 'package:openems/ui/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/consumers/edit_switch_consumer_screen.dart';
import 'package:openems/ui/devices/consumers/switch_consumer_view_model.dart';
import 'package:openems/ui/devices/widgets/on_off_indicator.dart';
import 'package:openems/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class SwitchConsumerListItem extends StatelessWidget {
  const SwitchConsumerListItem({super.key, required this.viewModel});

  final SwitchConsumerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card.outlined(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: Watch(
                    (context) => SegmentedButton<SwitchConsumerMode>(
                      segments: const [
                        ButtonSegment(
                          value: SwitchConsumerMode.off,
                          label: Text("Aus"),
                        ),
                        ButtonSegment(
                          value: SwitchConsumerMode.on,
                          label: Text("An"),
                        ),
                        ButtonSegment(
                          value: SwitchConsumerMode.smart,
                          label: Text("Smart"),
                        )
                      ],
                      selected: {viewModel.mode.value},
                      showSelectedIcon: false,
                      onSelectionChanged: _onSelectionChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Watch((context) => ListTile(
                leading: OnOffIndicator(
                  status: _getIndicatorStatus(viewModel.status.value),
                ),
                title: Text(
                  viewModel.name.value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _getTextColor(colorScheme, viewModel.status.value),
                  ),
                ),
                subtitle: viewModel.hasReportedPowerConsumption.value
                    ? UnitText.power(
                        viewModel.currentPowerConsumption.value,
                        color:
                            _getTextColor(colorScheme, viewModel.status.value),
                      )
                    : null,
                trailing: IconButton(
                  icon: const Icon(AppIcons.arrow_next),
                  onPressed: _gotoEdit,
                ),
              )),
        ],
      ),
    );
  }

  Future<void> _onSelectionChanged(Set<SwitchConsumerMode> selection) async {
    var mode = selection.first;
    switch (mode) {
      case SwitchConsumerMode.off:
        await viewModel.switchOff();
        return;

      case SwitchConsumerMode.on:
        await viewModel.switchOn();
        return;

      case SwitchConsumerMode.smart:
        viewModel.activateSmartMode();
        return;
    }
  }

  void _gotoEdit() {
    AppNavigator.push(EditSwitchConsumerScreen(viewModel: viewModel));
  }

  static bool _getIndicatorStatus(SwitchConsumerStatus status) {
    return switch (status) {
      SwitchConsumerStatus.off => false,
      SwitchConsumerStatus.on => true,
    };
  }

  static Color _getTextColor(
      ColorScheme colorScheme, SwitchConsumerStatus status) {
    return switch (status) {
      SwitchConsumerStatus.off => colorScheme.secondary,
      SwitchConsumerStatus.on => colorScheme.primary,
    };
  }
}

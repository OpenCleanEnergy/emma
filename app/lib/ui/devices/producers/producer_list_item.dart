import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/app_navigator.dart';
import 'package:emma/ui/devices/producers/edit_producer_screen.dart';
import 'package:emma/ui/devices/producers/producer_view_model.dart';
import 'package:emma/ui/devices/widgets/on_off_indicator.dart';
import 'package:emma/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ProducerListItem extends StatefulWidget {
  const ProducerListItem({super.key, required this.viewModel});
  final ProducerViewModel viewModel;

  @override
  State<ProducerListItem> createState() => _ProducerListItemState();
}

class _ProducerListItemState extends State<ProducerListItem> {
  ProducerViewModel get viewModel => widget.viewModel;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: ListTile(
        leading: Watch((context) => OnOffIndicator(
            status: widget.viewModel.currentPowerProduction.value > 0)),
        title: Watch((context) => Text(
              viewModel.name.value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: _getTextColor(
                      context, viewModel.currentPowerProduction.value)),
            )),
        subtitle: Watch((context) => UnitText.power(
            viewModel.currentPowerProduction.value,
            color: _getTextColor(
                context, viewModel.currentPowerProduction.value))),
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

  Color _getTextColor(BuildContext context, double power) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (power) {
      0 => colorScheme.secondary,
      _ => colorScheme.primary,
    };
  }
}

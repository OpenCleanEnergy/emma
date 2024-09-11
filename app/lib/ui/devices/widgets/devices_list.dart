import 'package:openems/ui/devices/consumers/switch_consumer_list_item.dart';
import 'package:openems/ui/devices/consumers/switch_consumer_view_model.dart';
import 'package:openems/ui/devices/devices_view_model.dart';
import 'package:openems/ui/devices/meters/electricity_meter_list_item.dart';
import 'package:openems/ui/devices/meters/electricity_meter_view_model.dart';
import 'package:openems/ui/devices/producers/producer_list_item.dart';
import 'package:openems/ui/devices/producers/producer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class DevicesList extends StatelessWidget {
  const DevicesList({super.key, required this.viewModel});

  final DevicesViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final isEmpty = viewModel.switchConsumers.isEmpty &&
          viewModel.producers.isEmpty &&
          viewModel.electricityMeters.isEmpty;
      if (isEmpty) {
        return Center(
            child: Text(
                "Keine Geräte vorhanden.\nFüge jetzt neue Geräte hinzu.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge));
      }

      return ListView(
        children: [
          // Consumer
          if (viewModel.switchConsumers.isNotEmpty)
            const _HeadlineItem("Verbraucher"),
          ...viewModel.switchConsumers
              .map((vm) => [_SwitchConsumerItem(vm), const _Spacer()])
              .expand((e) => e),
          if (viewModel.switchConsumers.isNotEmpty) const _Spacer(),

          // Producer
          if (viewModel.producers.isNotEmpty)
            const _HeadlineItem("Produzenten"),
          ...viewModel.producers
              .map((vm) => [_ProducerItem(vm), const _Spacer()])
              .expand((e) => e),
          if (viewModel.producers.isNotEmpty) const _Spacer(),

          // Electricity Meters
          if (viewModel.electricityMeters.isNotEmpty)
            const _HeadlineItem("Stromzähler"),
          ...viewModel.electricityMeters
              .map((vm) => [_ElectricityMeterItem(vm), const _Spacer()])
              .expand((e) => e),
          if (viewModel.electricityMeters.isNotEmpty) const _Spacer(),
        ],
      );
    });
  }
}

class _HeadlineItem extends StatelessWidget {
  const _HeadlineItem(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ItemPadding(
          child: Text(name, style: Theme.of(context).textTheme.headlineSmall),
        ),
        const Divider()
      ],
    );
  }
}

class _SwitchConsumerItem extends StatelessWidget {
  const _SwitchConsumerItem(this.viewModel);

  final SwitchConsumerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return _ItemPadding(child: SwitchConsumerListItem(viewModel: viewModel));
  }
}

class _ProducerItem extends StatelessWidget {
  const _ProducerItem(this.viewModel);

  final ProducerViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return _ItemPadding(child: ProducerListItem(viewModel: viewModel));
  }
}

class _ElectricityMeterItem extends StatelessWidget {
  const _ElectricityMeterItem(this.viewModel);

  final ElectricityMeterViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return _ItemPadding(child: ElectricityMeterListItem(viewModel: viewModel));
  }
}

class _ItemPadding extends StatelessWidget {
  const _ItemPadding({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: child,
    );
  }
}

class _Spacer extends StatelessWidget {
  const _Spacer();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 8);
  }
}

import 'package:openems/application/backend_api/value_objects.dart';
import 'package:openems/ui/analytics/metrics/analytics_metric_card.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/analytics/metrics/analytics_circular_percentage_indicator.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/shared/unit_text.dart';

class SelfSufficiencyMetricView extends StatelessWidget {
  const SelfSufficiencyMetricView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnalyticsMetricCard(
      title: "Autarkie",
      subtitle: UnitText.percentage(const Percentage(0.31)),
      leading: AnalyticsCircularPercentageIndicator.small(
          percentage: const Percentage(0.31)),
      detailsBuilder: _buildDetails,
    );
  }

  Widget _buildDetails(BuildContext context) {
    const spacer = SizedBox(width: 8, height: 8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnalyticsCircularPercentageIndicator.detailed(
            percentage: const Percentage(0.31)),
        Table(
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(36),
            1: IntrinsicColumnWidth(),
            2: IntrinsicColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Icon(
                  AppIcons.circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const Text("Eigenverbrauch:"),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [spacer, UnitText.energy(WattHours(269400))])
              ],
            ),
            const TableRow(children: [spacer, spacer, spacer]),
            TableRow(
              children: [
                Icon(
                  AppIcons.circle,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                const Text("Zukauf:"),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [spacer, UnitText.energy(WattHours(600210))])
              ],
            ),
            const TableRow(children: [Divider(), Divider(), Divider()]),
            const TableRow(children: [
              spacer,
              Text("Verbrauch:"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [spacer, UnitText.energy(WattHours(869610))])
            ]),
          ],
        )
      ],
    );
  }
}

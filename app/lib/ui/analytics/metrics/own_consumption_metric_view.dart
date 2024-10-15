import 'package:openems/ui/analytics/metrics/analytics_circular_percentage_indicator.dart';
import 'package:openems/ui/analytics/metrics/analytics_metric_card.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';

class OwnConsumptionMetricView extends StatelessWidget {
  const OwnConsumptionMetricView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnalyticsMetricCard(
      title: "Eigenverbrauch",
      subtitle: UnitText.percentage(0.59),
      leading: AnalyticsCircularPercentageIndicator.small(percentage: 0.59),
      detailsBuilder: _buildDetails,
    );
  }

  Widget _buildDetails(BuildContext context) {
    const spacer = SizedBox.square(dimension: 8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnalyticsCircularPercentageIndicator.detailed(
          percentage: 0.59,
        ),
        Table(
          //border: TableBorder.all(),
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
                    children: [spacer, UnitText.energy(269400)])
              ],
            ),
            const TableRow(children: [spacer, spacer, spacer]),
            TableRow(
              children: [
                Icon(
                  AppIcons.circle,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                const Text("Einspeisung:"),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [spacer, UnitText.energy(180810)])
              ],
            ),
            const TableRow(children: [Divider(), Divider(), Divider()]),
            const TableRow(children: [
              spacer,
              Text("Produktion:"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [spacer, UnitText.energy(450210)])
            ]),
          ],
        )
      ],
    );
  }
}

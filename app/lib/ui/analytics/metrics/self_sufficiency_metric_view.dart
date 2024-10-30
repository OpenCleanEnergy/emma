import 'package:openems/application/backend_api/backend_api.dart';
import 'package:openems/ui/analytics/metrics/analytics_metric_card.dart';
import 'package:flutter/material.dart';
import 'package:openems/ui/analytics/metrics/analytics_circular_percentage_indicator.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/shared/unit_text.dart';

class SelfSufficiencyMetricView extends StatelessWidget {
  const SelfSufficiencyMetricView({
    super.key,
    required this.dto,
  });

  final SelfSufficiencyMetricDto dto;

  @override
  Widget build(BuildContext context) {
    return AnalyticsMetricCard(
      title: "Autarkie",
      subtitle: UnitText.percentage(dto.percentage),
      leading: AnalyticsCircularPercentageIndicator.small(
          percentage: dto.percentage),
      detailsBuilder: _buildDetails,
    );
  }

  Widget _buildDetails(BuildContext context) {
    const spacer = SizedBox(width: 8, height: 8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnalyticsCircularPercentageIndicator.detailed(
            percentage: dto.percentage),
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
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [spacer, UnitText.energy(dto.ownConsumption)])
              ],
            ),
            const TableRow(children: [spacer, spacer, spacer]),
            TableRow(
              children: [
                Icon(
                  AppIcons.circle,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
                const Text("Netzbezug:"),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [spacer, UnitText.energy(dto.gridConsumption)])
              ],
            ),
            const TableRow(children: [Divider(), Divider(), Divider()]),
            TableRow(children: [
              spacer,
              const Text("Verbrauch:"),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [spacer, UnitText.energy(dto.totalConsumption)])
            ]),
          ],
        )
      ],
    );
  }
}

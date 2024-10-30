import 'package:openems/application/backend_api/models.dart';
import 'package:openems/ui/analytics/metrics/analytics_circular_percentage_indicator.dart';
import 'package:openems/ui/analytics/metrics/analytics_metric_card.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';

class OwnConsumptionMetricView extends StatelessWidget {
  const OwnConsumptionMetricView({
    super.key,
    required this.dto,
  });

  final OwnConsumptionMetricDto dto;

  @override
  Widget build(BuildContext context) {
    return AnalyticsMetricCard(
      title: "Eigenverbrauch",
      subtitle: UnitText.percentage(dto.percentage),
      leading: AnalyticsCircularPercentageIndicator.small(
          percentage: dto.percentage),
      detailsBuilder: _buildDetails,
    );
  }

  Widget _buildDetails(BuildContext context) {
    const spacer = SizedBox.square(dimension: 8);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        AnalyticsCircularPercentageIndicator.detailed(
          percentage: dto.percentage,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [spacer, UnitText.energy(dto.ownConsumption)],
                )
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [spacer, UnitText.energy(dto.gridFeedIn)],
                )
              ],
            ),
            const TableRow(children: [Divider(), Divider(), Divider()]),
            TableRow(children: [
              spacer,
              const Text("Produktion:"),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [spacer, UnitText.energy(dto.production)],
              )
            ]),
          ],
        )
      ],
    );
  }
}

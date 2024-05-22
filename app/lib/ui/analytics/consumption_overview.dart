import 'package:emma/ui/analytics/analytics_circular_percentage_indicator.dart';
import 'package:emma/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';

class ConsumptionOverview extends StatelessWidget {
  const ConsumptionOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox(width: 8, height: 8);
    return Column(
      children: [
        Text(
          "Autarkie",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: AnalyticsCircularPercentageIndicator(
                percentage: 0.31,
                maximalPossiblePercentage: 0.52,
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Table(
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
                          Icons.circle,
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
                          Icons.circle,
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                        ),
                        const Text("Zukauf:"),
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [spacer, UnitText.energy(600210)])
                      ],
                    ),
                    const TableRow(children: [Divider(), Divider(), Divider()]),
                    const TableRow(children: [
                      spacer,
                      Text("Verbrauch:"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [spacer, UnitText.energy(869610)])
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

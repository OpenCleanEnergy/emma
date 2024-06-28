import 'package:emma/ui/analytics/analytics_circular_percentage_indicator.dart';
import 'package:emma/ui/shared/unit_text.dart';
import 'package:flutter/material.dart';

class ProductionOverview extends StatelessWidget {
  const ProductionOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const spacer = SizedBox.square(dimension: 8);
    return Column(
      children: [
        Text(
          "Eigenverbrauch",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: AnalyticsCircularPercentageIndicator(
                percentage: 0.59,
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
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

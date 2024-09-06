import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          mainData(Theme.of(context).colorScheme),
        ),
      ),
    );
  }

  LineChartData mainData(ColorScheme colorScheme) {
    final mainGridLineColor = colorScheme.surfaceDim;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: mainGridLineColor,
            strokeWidth: 1,
            dashArray: [8, 8],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: mainGridLineColor,
            strokeWidth: 1,
            dashArray: [8, 8],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border(bottom: BorderSide(color: colorScheme.onSurface)),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => colorScheme.surfaceContainer,
            tooltipBorder: BorderSide(color: colorScheme.outline)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          color: colorScheme.primary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: colorScheme.primary.withOpacity(0.067),
          ),
        ),
        LineChartBarData(
          spots: const [
            FlSpot(0, 5),
            FlSpot(2.6, 1),
            FlSpot(4.9, 5),
            FlSpot(6.8, 5.1),
            FlSpot(8, 2),
            FlSpot(9.5, 2),
            FlSpot(11, 3),
          ],
          isCurved: true,
          color: colorScheme.tertiary,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: colorScheme.tertiary.withOpacity(0.067),
          ),
        ),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final text = switch (value.toInt()) {
      1 => '10k',
      3 => '30k',
      5 => '50k',
      _ => '',
    };

    return SideTitleWidget(child: Text(text), axisSide: meta.axisSide);
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 2:
        text = 'MAR';
        break;
      case 5:
        text = 'JUN';
        break;
      case 8:
        text = 'SEP';
        break;
      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text),
    );
  }
}

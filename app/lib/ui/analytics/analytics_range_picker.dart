import 'package:openems/ui/analytics/analytics_period.dart';
import 'package:openems/ui/analytics/analytics_view_model.dart';
import 'package:openems/ui/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:signals/signals_flutter.dart';

class AnalyticsRangePicker extends StatefulWidget {
  const AnalyticsRangePicker({
    super.key,
    required this.viewModel,
  });

  final AnalyticsViewModel viewModel;

  @override
  State<AnalyticsRangePicker> createState() => _AnalyticsRangePickerState();
}

class _AnalyticsRangePickerState extends State<AnalyticsRangePicker> {
  late final TextEditingController _rangeTextController;
  late final void Function() _disposeRangeTextEffect;

  AnalyticsViewModel get _vm => widget.viewModel;

  @override
  void initState() {
    _rangeTextController = TextEditingController(
        text: _getRangeText(_vm.period.value, _vm.range.value));

    _disposeRangeTextEffect = effect(
      () => _rangeTextController.text =
          _getRangeText(_vm.period.value, _vm.range.value),
      debugLabel: "analytics.screen.rangeText",
    );

    super.initState();
  }

  @override
  void dispose() {
    _disposeRangeTextEffect();
    _rangeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Watch(
                (context) => SegmentedButton<AnalyticsPeriod>(
                  segments: const [
                    ButtonSegment(
                      value: AnalyticsPeriod.day,
                      label: Text("Tag"),
                    ),
                    ButtonSegment(
                      value: AnalyticsPeriod.week,
                      label: Text("Woche"),
                    ),
                    ButtonSegment(
                      value: AnalyticsPeriod.month,
                      label: Text("Monat"),
                    ),
                    ButtonSegment(
                      value: AnalyticsPeriod.year,
                      label: Text("Jahr"),
                    )
                  ],
                  selected: {_vm.period.value},
                  showSelectedIcon: false,
                  onSelectionChanged: (selection) =>
                      _vm.setPeriod(selection.first),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: _vm.setPreviousRange,
                icon: const Icon(AppIcons.arrow_prev)),
            Expanded(
              child: TextField(
                controller: _rangeTextController,
                readOnly: true,
                textAlign: TextAlign.center,
              ),
            ),
            Watch(
              (context) => IconButton(
                  onPressed:
                      _vm.canSetNextRange.value ? _vm.setNextRange : null,
                  icon: const Icon(AppIcons.arrow_next)),
            ),
          ],
        ),
      ],
    );
  }

  static String _getRangeText(AnalyticsPeriod period, DateTimeRange range) {
    final start = range.start;
    switch (period) {
      case AnalyticsPeriod.day:
        return DateFormat.yMd().format(start);

      case AnalyticsPeriod.week:
        final end = range.end.subtract(const Duration(seconds: 1));
        final f = DateFormat.yMd();
        return "${f.format(start)} - ${f.format(end)}";

      case AnalyticsPeriod.month:
        return DateFormat.yMMM().format(start);

      case AnalyticsPeriod.year:
        return DateFormat.y().format(start);
    }
  }
}

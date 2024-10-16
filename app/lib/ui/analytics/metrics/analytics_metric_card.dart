import 'package:openems/ui/icons/app_icons.dart';
import 'package:flutter/material.dart';

class AnalyticsMetricCard extends StatelessWidget {
  const AnalyticsMetricCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leading,
    required this.detailsBuilder,
  });

  final String title;
  final Widget subtitle;
  final Widget leading;
  final WidgetBuilder detailsBuilder;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: subtitle,
        leading: leading,
        trailing: const Icon(AppIcons.arrow_next),
        onTap: () => _showDetails(context),
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) {
          return SizedBox(
            height: 256,
            child: Center(
              child: Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).appBarTheme.titleTextStyle ??
                        Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Builder(builder: detailsBuilder),
                  const Spacer()
                ],
              ),
            ),
          );
        });
  }
}

import 'package:emma/ui/app_icons.dart';
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
      child: ListTile(
        title: Text(title),
        subtitle: subtitle,
        leading: leading,
        trailing: IconButton(
          icon: const Icon(AppIcons.arrow_next),
          onPressed: () => _showDetails(context),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 256,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 16),
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

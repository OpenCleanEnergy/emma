import 'package:emma/application/logs/logs_store.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class LogsScreen extends StatefulWidget {
  static const title = "Logs";
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final records = LogsStore.instance.records;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontFamily: 'monospace');

    return Scaffold(
        appBar: AppBar(title: const Text(LogsScreen.title)),
        body: Watch(
          (context) => ListView.separated(
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final record = records[records.length - 1 - index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(record.time.toIso8601String(), style: style),
                    Text(record.toString(), style: style),
                    if (record.error != null)
                      Text(
                        record.error.toString(),
                        style: style.copyWith(
                            color: Theme.of(context).colorScheme.error),
                      )
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: records.length),
        ));
  }
}

import 'package:flutter/material.dart';

class AddDeviceStepExplanation extends StatelessWidget {
  const AddDeviceStepExplanation(
      {super.key, required this.title, required this.explanation});

  final String title;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(explanation),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      isThreeLine: true,
    );
  }
}

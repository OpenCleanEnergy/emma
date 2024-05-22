import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/app_navigator.dart';
import 'package:flutter/material.dart';

class AbortAddButton extends StatelessWidget {
  const AbortAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => AppNavigator.popUntilFirst(),
        icon: const Icon(AppIcons.close));
  }
}

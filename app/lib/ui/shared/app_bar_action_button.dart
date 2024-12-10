import 'package:flutter/material.dart';

class AppBarActionButton extends StatelessWidget {
  static const double padding = 8.0;

  const AppBarActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: padding),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}

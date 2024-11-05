import 'package:flutter/material.dart';

class OnOffIndicator extends StatelessWidget {
  const OnOffIndicator({
    super.key,
    required this.status,
    required this.icon,
    this.onColor,
  });

  final bool status;
  final Icon icon;
  final Color? onColor;

  @override
  Widget build(BuildContext context) {
    final offColor = Theme.of(context).disabledColor;
    final onColor = this.onColor ?? Theme.of(context).colorScheme.primary;

    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: status ? offColor : onColor,
        end: status ? onColor : offColor,
      ),
      duration: Durations.short4,
      curve: Curves.linear,
      builder: (context, value, _) => IconTheme(
        data: IconTheme.of(context).copyWith(color: value),
        child: icon,
      ),
    );
  }
}

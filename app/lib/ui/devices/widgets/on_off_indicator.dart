import 'package:flutter/material.dart';

class OnOffIndicator extends StatelessWidget {
  const OnOffIndicator({required this.status, super.key});

  final bool status;
  get _tween => status
      ? Tween<double>(begin: 0, end: 1)
      : Tween<double>(begin: 1, end: 0);
  get _flipX => !status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 24,
        width: 24,
        child: Transform.flip(
          flipX: _flipX,
          child: TweenAnimationBuilder<double>(
            tween: _tween,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            builder: (context, value, _) => CircularProgressIndicator(
              value: value,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
        ));
  }
}

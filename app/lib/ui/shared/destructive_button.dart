import 'package:flutter/material.dart';

class DestructiveButton extends StatelessWidget {
  final _Variant _variant;

  const DestructiveButton.filled({
    super.key,
    required this.onPressed,
    required this.child,
  }) : _variant = _Variant.filled;

  const DestructiveButton.outlined({
    super.key,
    required this.onPressed,
    required this.child,
  }) : _variant = _Variant.outlined;

  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return switch (_variant) {
      _Variant.filled => _filled(context),
      _Variant.outlined => _outlined(context),
    };
  }

  FilledButton _filled(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = switch (onPressed) {
      null => null,
      _ => FilledButton.styleFrom(
          foregroundColor: colorScheme.onError,
          backgroundColor: colorScheme.error,
        ),
    };

    return FilledButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }

  OutlinedButton _outlined(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final style = switch (onPressed) {
      null => null,
      _ => OutlinedButton.styleFrom(
          foregroundColor: colorScheme.error,
          side: BorderSide(
            color: colorScheme.error,
          ),
        ),
    };

    return OutlinedButton(
      onPressed: onPressed,
      style: style,
      child: child,
    );
  }
}

enum _Variant {
  filled,
  outlined,
}

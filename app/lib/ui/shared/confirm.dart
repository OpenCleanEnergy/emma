import 'package:flutter/material.dart';
import 'package:openems/ui/shared/destructive_button.dart';

Future<bool> confirm(
  BuildContext context, {
  String content = 'Bist du sicher?',
  String? textOK,
  String? textCancel,
  bool isDestructive = false,
}) async {
  final bool? isConfirm = await showModalBottomSheet(
    context: context,
    showDragHandle: true,
    useRootNavigator: true,
    builder: (context) => _build(
      context: context,
      content: content,
      textOK: textOK,
      textCancel: textCancel,
      isDestructive: isDestructive,
    ),
  );

  return isConfirm ?? false;
}

Widget _build({
  required BuildContext context,
  required String content,
  required String? textOK,
  required String? textCancel,
  required bool isDestructive,
}) {
  onCancel() => Navigator.pop(context, false);
  onOK() => Navigator.pop(context, true);

  final childCancel = Text(
    textCancel ?? MaterialLocalizations.of(context).cancelButtonLabel,
  );
  final childOK = Text(
    textOK ?? MaterialLocalizations.of(context).okButtonLabel,
  );

  return SizedBox(
    height: 128,
    child: Column(
      children: [
        const Spacer(),
        Text(content, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(onPressed: onCancel, child: childCancel),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: isDestructive
                  ? DestructiveButton.filled(onPressed: onOK, child: childOK)
                  : FilledButton.tonal(onPressed: onOK, child: childOK),
            ),
            const SizedBox(width: 16),
          ],
        ),
        const SizedBox(height: 32),
      ],
    ),
  );
}

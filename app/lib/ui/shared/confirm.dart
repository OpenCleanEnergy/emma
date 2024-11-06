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
    height: 96,
    child: Center(
      child: Column(
        children: [
          Text(content),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(onPressed: onCancel, child: childCancel),
              isDestructive
                  ? DestructiveButton(onPressed: onOK, child: childOK)
                  : OutlinedButton(onPressed: onOK, child: childOK),
            ],
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}

import 'package:emma/ui/commands/command.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

abstract class AppMessenger {
  static final key = GlobalKey<ScaffoldMessengerState>();

  static ScaffoldMessengerState get _state => key.currentState!;

  static void info(String message) {
    _withIcon(
        Icon(Icons.info_outline,
            color: Theme.of(_state.context).colorScheme.surface),
        message);
  }

  static void success(String message) {
    _withIcon(const Text("🎉"), message);
  }

  static void catchError(Command command) {
    effect(() {
      if (command.hasError.value) {
        error();
      }
    });
  }

  static void error(
      [String message =
          "Es ist ein Fehler aufgetreten.\nVersuche es später noch einmal."]) {
    _withIcon(
        Icon(
          Icons.error_outline,
          color: Theme.of(_state.context).colorScheme.errorContainer,
        ),
        message);
  }

  static void _withIcon(Widget icon, String message) {
    _state.hideCurrentSnackBar();
    _state.showSnackBar(SnackBar(
      content: Row(
        children: [
          icon,
          const SizedBox(
            width: 24,
          ),
          Expanded(child: Text(message)),
        ],
      ),
    ));
  }
}

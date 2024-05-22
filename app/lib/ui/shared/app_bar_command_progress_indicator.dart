import 'package:emma/ui/commands/command.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AppBarCommandProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarCommandProgressIndicator(
      {super.key, Command? command, List<Command>? commands})
      : _command = command,
        _commands = commands;

  final Command? _command;
  final List<Command>? _commands;

  @override
  final Size preferredSize = const Size.fromHeight(4.0);

  @override
  Widget build(BuildContext context) {
    final commands = [if (_command != null) _command, ...?_commands];

    return Watch(
      (context) => Visibility.maintain(
        visible: commands.any((cmd) => cmd.isRunning.value),
        child: const LinearProgressIndicator(),
      ),
    );
  }
}

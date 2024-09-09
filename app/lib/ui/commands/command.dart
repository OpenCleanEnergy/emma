import 'dart:async';

import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

abstract class Command {
  static final StreamController<({String debugLabel, Object error})>
      _errorStreamController =
      StreamController<({String debugLabel, Object error})>.broadcast();

  Command({String? debugLabel}) : _debugLabel = debugLabel ?? 'default' {
    _isRunning = signal(false, debugLabel: "command.$_debugLabel.isRunning");
    _error = signal<Object?>(null, debugLabel: "command.$_debugLabel.error");
    _hasError = computed(
      () => _error.value != null,
      debugLabel: "command.$_debugLabel.hasError",
    );
  }
  final String _debugLabel;
  late final Signal<bool> _isRunning;
  late final Signal<Object?> _error;
  late final Computed<bool> _hasError;

  static Stream<({String debugLabel, Object error})> get onError =>
      _errorStreamController.stream;

  ReadonlySignal<bool> get isRunning => _isRunning;
  ReadonlySignal<Object?> get error => _error;
  ReadonlySignal<bool> get hasError => _hasError;

  void _onBeforeCall() {
    batch(() {
      _error.value = null;
      _isRunning.value = true;
    });
  }

  void _onSuccess() {
    _isRunning.value = false;
  }

  void _onError(Object error) {
    batch(() {
      _error.value = error;
      _isRunning.value = false;
    });

    _errorStreamController.add((debugLabel: _debugLabel, error: error));
  }
}

class ArgCommand<TArg> extends Command {
  final Future<void> Function(TArg) _action;

  ArgCommand(Future<void> Function(TArg) action, {super.debugLabel})
      : _action = action;

  Future<bool> call(TArg arg) async {
    _onBeforeCall();

    try {
      await _action(arg);
      _onSuccess();
      return true;
    } catch (error) {
      _onError(error);
      return false;
    }
  }
}

extension ArgCommandExtension<TArg> on Future<void> Function(TArg) {
  ArgCommand<TArg> toCommand([String? debugLabel]) {
    return ArgCommand(this, debugLabel: debugLabel);
  }
}

class NoArgCommand extends Command {
  final Future<void> Function() _action;

  NoArgCommand(Future<void> Function() action, {super.debugLabel})
      : _action = action;

  Future<bool> call() async {
    _onBeforeCall();

    try {
      await _action();
      _onSuccess();
      return true;
    } catch (error) {
      _onError(error);
      return false;
    }
  }
}

extension NoArgCommandExtension on Future<void> Function() {
  NoArgCommand toCommand([String? debugLabel]) {
    return NoArgCommand(this, debugLabel: debugLabel);
  }
}

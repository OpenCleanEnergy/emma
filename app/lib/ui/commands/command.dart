import 'dart:async';

import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

abstract class Command {
  static final StreamController<Object> _errorStreamController =
      StreamController<Object>.broadcast();

  final _isRunning = signal(false);
  final _error = signal<Object?>(null);

  static Stream<Object> get onError => _errorStreamController.stream;

  ReadonlySignal<bool> get isRunning => _isRunning;
  ReadonlySignal<Object?> get error => _error;
  ReadonlySignal<bool> get hasError => computed(() => error.value != null);

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

    _errorStreamController.add(error);
  }
}

class ArgCommand<TArg> extends Command {
  final Future<void> Function(TArg) _action;

  ArgCommand(Future<void> Function(TArg) action) : _action = action;

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
  ArgCommand<TArg> toCommand() {
    return ArgCommand(this);
  }
}

class NoArgCommand extends Command {
  final Future<void> Function() _action;

  NoArgCommand(Future<void> Function() action) : _action = action;

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
  NoArgCommand toCommand() {
    return NoArgCommand(this);
  }
}

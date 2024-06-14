import 'dart:async';

import 'package:flutter/widgets.dart';

class LongPollingHandler {
  final Future<bool> Function() _longPollingAction;

  late final AppLifecycleListener? _listener;

  Completer _completer = Completer()..complete();
  Timer? _timer;
  
  bool _disposed = false;

  LongPollingHandler(
      Duration startDelay, Future<bool> Function() longPollingAction)
      : _longPollingAction = longPollingAction {
    _listener = AppLifecycleListener(onHide: _onHide, onShow: _onShow);
    _timer = Timer(startDelay, _timerCallback);
  }

  void dispose() {
    if (_disposed) {
      return;
    }

    _disposed = true;
    _listener?.dispose();
    _timer?.cancel();
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }

  void _onHide() {
    if (_completer.isCompleted) {
      _completer = Completer();
    }
  }

  void _onShow() {
    if (!_completer.isCompleted) {
      _completer.complete();
    }
  }

  Future<void> _timerCallback() async {
    var success = true;
    while (!_disposed && success) {
      await _completer.future;
      if (_disposed) {
        return;
      }

      success = await _longPollingAction();
      if (_disposed) {
        return;
      }

      if (!success) {
        // on failure: retry after 30 seconds
        _timer = Timer(const Duration(seconds: 30), _timerCallback);
        return;
      }
    }
  }
}

import 'dart:async';
import 'dart:ui';

class Debounce {
  Timer? _timer;

  final Duration delay;
  final VoidCallback action;

  Debounce({
    required this.action,
    this.delay = const Duration(milliseconds: 500),
  });

  call() {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}

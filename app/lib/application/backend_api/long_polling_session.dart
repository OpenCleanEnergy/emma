import 'dart:math';

extension type const LongPollingSession._(int _value) implements int {
  static final instance = LongPollingSession._(Random().nextInt(0x7FFFFFFF));
}

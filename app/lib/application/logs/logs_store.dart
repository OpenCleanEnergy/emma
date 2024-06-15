import 'package:logging/logging.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

class LogsStore {
  static final LogsStore _instance = LogsStore._();

  LogsStore._();

  static LogsStore get instance => _instance;

  final ListSignal<LogRecord> records = listSignal([]);

  void addLog(LogRecord record) {
    batch(() {
      records.add(record);
      if (records.length > 31) {
        records.removeAt(0);
      }
    });
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:openems/app.dart';
import 'package:openems/application/logs/logs_store.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  // Localization
  Intl.defaultLocale = "de_DE";
  initializeDateFormatting("de_DE");

  // Logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log(record.message,
        name: record.loggerName,
        level: record.level.value,
        time: record.time,
        sequenceNumber: record.sequenceNumber,
        error: record.error,
        stackTrace: record.stackTrace,
        zone: record.zone);
  });

  Logger.root.onRecord.listen(LogsStore.instance.addLog);

  runApp(const App());
}

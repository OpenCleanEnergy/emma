import 'dart:io';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';

abstract class WindowSizeWriter {
  static String _current = "Pixel 7";

  static final sizes = {
    "Pixel 7": const Size(412, 915),
    "Galaxy S8+": const Size(360, 740),
    "iPhone SE": const Size(375, 667),
    "Galaxy Fold": const Size(280, 653),
  };

  static get isSupported => Platform.isLinux || Platform.isWindows;
  static get current => _current;

  static Future<void> setSize([String? key]) async {
    key ??= _current;
    final size = sizes[key];
    if (size == null) {
      return;
    }

    _current = key;
    await DesktopWindow.setWindowSize(size);
  }
}

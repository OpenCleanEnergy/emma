import 'dart:io';
import 'dart:ui';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';

abstract class WindowSizeWriter {
  static bool _orientationToggle = false;
  static String _current = "Pixel 7";

  static final sizes = {
    'Pixel 7': const Size(412, 915),
    'Galaxy S8+': const Size(360, 740),
    'iPhone SE': const Size(375, 667),
    'Galaxy Fold': const Size(280, 653),
    'Phone 9:16': const Size(360, 740),
    'Tablet 7"': const Size(600, 900),
    'Tablet 10"': const Size(800, 1280),
  };

  static get isSupported => !kIsWeb && (Platform.isLinux || Platform.isWindows);
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

  static Future<void> toggleOrientation() async {
    final size = sizes[_current];
    if (size == null) {
      return;
    }

    _orientationToggle = !_orientationToggle;

    await DesktopWindow.setWindowSize(switch (_orientationToggle) {
      false => size,
      true => Size(size.height, size.width),
    });
  }
}

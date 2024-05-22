import 'package:flutter/material.dart';

abstract class AppNavigator {
  static final key = GlobalKey<NavigatorState>();

  static void pushAndRemove(Widget screen) {
    key.currentState!.pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => screen), (route) => false);
  }

  static void push(Widget screen) {
    key.currentState!.push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  static void pop() {
    key.currentState!.pop();
  }

  static void popUntilFirst() {
    key.currentState!.popUntil((route) => route.isFirst);
  }
}

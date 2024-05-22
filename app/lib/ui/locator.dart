import 'package:get_it/get_it.dart';

class Locator {
  Locator._();
  T get<T extends Object>() => GetIt.instance.get<T>();
}

final locator = Locator._();

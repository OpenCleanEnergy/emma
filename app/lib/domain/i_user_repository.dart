import 'package:emma/domain/user_status.dart';
import 'package:signals/signals.dart';

abstract interface class IUserRepository {
  ReadonlySignal<UserStatus> get status;
  String? get accessToken;

  Future<void> login();
  Future<void> logout();
}

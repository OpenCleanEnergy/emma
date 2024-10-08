import 'package:openems/domain/user_status.dart';
import 'package:signals/signals.dart';

abstract interface class IUserRepository {
  ReadonlySignal<UserStatus> get status;
  ReadonlySignal<String> get name;
  String? get accessToken;

  Future<void> register();
  Future<void> login();
  Future<void> logout();

  Future<void> refreshAccessTokenIfAboutToExpire(Duration tolerance);
}

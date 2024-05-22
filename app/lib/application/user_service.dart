import 'package:emma/domain/i_user_repository.dart';
import 'package:emma/domain/user_status.dart';
import 'package:signals/signals.dart';

class UserService {
  final IUserRepository _userRepository;

  UserService(IUserRepository userRepository)
      : _userRepository = userRepository;

  ReadonlySignal<UserStatus> get status => _userRepository.status;

  Future<void> login() async {
    await _userRepository.login();
  }

  Future<void> logout() async {
    await _userRepository.logout();
  }
}

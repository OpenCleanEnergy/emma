import 'package:openems/domain/i_user_repository.dart';
import 'package:openems/domain/user_status.dart';
import 'package:openems/ui/commands/command.dart';
import 'package:signals/signals.dart';

class UserViewModel {
  final IUserRepository _userRepository;
  UserViewModel(IUserRepository userRepository)
      : _userRepository = userRepository,
        register = userRepository.register.toCommand('user.register'),
        login = userRepository.login.toCommand('user.login'),
        logout = userRepository.logout.toCommand('user.logout');

  ReadonlySignal<UserStatus> get status => _userRepository.status;
  ReadonlySignal<String> get name => _userRepository.name;

  final NoArgCommand register;
  final NoArgCommand login;
  final NoArgCommand logout;
}

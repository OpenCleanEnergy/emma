import 'package:emma/domain/i_user_repository.dart';
import 'package:emma/domain/user_status.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:signals/signals.dart';

class UserViewModel {
  final IUserRepository _userRepository;
  UserViewModel(IUserRepository userRepository)
      : _userRepository = userRepository,
        register = userRepository.register.toCommand(),
        login = userRepository.login.toCommand(),
        logout = userRepository.logout.toCommand();

  ReadonlySignal<UserStatus> get status => _userRepository.status;
  ReadonlySignal<String> get name => _userRepository.name;

  final NoArgCommand register;
  final NoArgCommand login;
  final NoArgCommand logout;
}

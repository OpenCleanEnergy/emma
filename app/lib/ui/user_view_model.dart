import 'package:emma/application/user_service.dart';
import 'package:emma/domain/user_status.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:signals/signals.dart';

class UserViewModel {
  final UserService _userService;
  UserViewModel(UserService userService)
      : _userService = userService,
        login = userService.login.toCommand(),
        logout = userService.logout.toCommand();

  ReadonlySignal<UserStatus> get status => _userService.status;
  final NoArgCommand login;
  final NoArgCommand logout;
}

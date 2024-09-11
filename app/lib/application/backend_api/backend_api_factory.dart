import 'package:chopper/chopper.dart';
import 'package:openems/application/backend_api/backend_api_configuration.dart';
import 'package:openems/application/backend_api/interceptors/auth_interceptor.dart';
import 'package:openems/application/backend_api/interceptors/client_info_interceptor.dart';
import 'package:openems/application/backend_api/interceptors/error_interceptor.dart';
import 'package:openems/application/backend_api/interceptors/logging_interceptor.dart';
import 'package:openems/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:openems/domain/i_user_repository.dart';
import 'package:logging/logging.dart';

class BackendApiFactory {
  final BackendApiConfiguration _configuration;
  final IUserRepository _userRepository;

  BackendApiFactory(
      {required BackendApiConfiguration configuration,
      required IUserRepository userRepository})
      : _configuration = configuration,
        _userRepository = userRepository;

  BackendApi create() {
    final logger = Logger("backend-api");
    final interceptors = <Interceptor>[
      ErrorInterceptor(),
      LoggingInterceptor(logger: logger),
      ClientInfoInterceptor(),
      AuthInterceptor(userRepository: _userRepository),
    ];

    return BackendApi.create(
        baseUrl: _configuration.baseUrl, interceptors: interceptors);
  }
}

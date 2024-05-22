import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:emma/domain/i_user_repository.dart';

/// See https://bdaya-dev.github.io/oidc/oidc-usage-accesstoken/
class AuthInterceptor implements Interceptor {
  static const kAuthorizationHeader = 'Authorization';

  final IUserRepository _userRepository;

  AuthInterceptor({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final request = chain.request;
    _tryAddAccessToken(request.headers);
    return chain.proceed(request);
  }

  void _tryAddAccessToken(Map<String, String> headers) {
    if (headers.containsKey(kAuthorizationHeader)) {
      // do nothing if header already exists.
      return;
    }

    final accessToken = _userRepository.accessToken;
    if (accessToken == null) {
      // do nothing if there is no access token.
      return;
    }

    headers[kAuthorizationHeader] = 'Bearer $accessToken';
  }
}

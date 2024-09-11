import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:openems/domain/i_user_repository.dart';
import 'package:mutex/mutex.dart';

/// See https://bdaya-dev.github.io/oidc/oidc-usage-accesstoken/
class AuthInterceptor implements Interceptor {
  static const kAuthorizationHeader = 'Authorization';

  static final Mutex _m = Mutex();
  final IUserRepository _userRepository;

  AuthInterceptor({required IUserRepository userRepository})
      : _userRepository = userRepository;

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final request = chain.request;
    await _tryAddAccessToken(request.headers);
    return chain.proceed(request);
  }

  Future<void> _tryAddAccessToken(Map<String, String> headers) async {
    if (headers.containsKey(kAuthorizationHeader)) {
      // do nothing if header already exists.
      return;
    }

    // refresh access token in case it was not refreshed in time
    // because app was "idle".
    await _m.protect(() => _userRepository
        .refreshAccessTokenIfAboutToExpire(const Duration(seconds: 15)));

    final accessToken = _userRepository.accessToken;
    if (accessToken == null) {
      // do nothing if there is no access token.
      return;
    }

    headers[kAuthorizationHeader] = 'Bearer $accessToken';
  }
}

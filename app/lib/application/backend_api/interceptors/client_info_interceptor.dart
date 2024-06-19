import 'dart:async';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ClientInfoInterceptor implements Interceptor {
  static const kUserAgentHeader = 'User-Agent';

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    if (!kIsWeb) {
      await _setUserAgent(chain);
    }

    return chain.proceed(chain.request);
  }

  Future<void> _setUserAgent(Chain<dynamic> chain) async {
    final info = await PackageInfo.fromPlatform();
    final os = Platform.operatingSystem;
    final userAgent = '${info.packageName}/${info.version} ($os)';

    chain.request.headers[kUserAgentHeader] = userAgent;
  }
}

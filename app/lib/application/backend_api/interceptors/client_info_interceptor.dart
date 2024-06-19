import 'dart:async';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ClientInfoInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    if (!kIsWeb) {
      await _setUserAgent(chain);
    }

    final info = await PackageInfo.fromPlatform();
    final platform = kIsWeb ? 'web' : Platform.operatingSystem;

    if (!kIsWeb) {
      final userAgent = '${info.packageName}/${info.version} ($platform)';
      chain.request.headers['User-Agent'] = userAgent;
    }

    chain.request.headers['OCE-Client-Name'] = info.packageName;
    chain.request.headers['OCE-Client-Version'] = info.version;
    chain.request.headers['OCE-Client-Platform'] = platform;

    return chain.proceed(chain.request);
  }

  Future<void> _setUserAgent(Chain<dynamic> chain) async {}
}

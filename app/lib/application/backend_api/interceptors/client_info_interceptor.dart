import 'dart:async';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ClientInfoInterceptor implements Interceptor {
  static const kUserAgentHeader = 'User-Agent';

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final info = await PackageInfo.fromPlatform();
    final userAgent =
        '${info.packageName}/${info.version} (${Platform.operatingSystem})';

    chain.request.headers[kUserAgentHeader] = userAgent;

    return chain.proceed(chain.request);
  }
}

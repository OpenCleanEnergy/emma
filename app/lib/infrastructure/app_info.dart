import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  AppInfo._();

  late final String version;

  static Future<AppInfo> create() async {
    final appInfo = AppInfo._();
    await appInfo._init();
    return appInfo;
  }

  Future<void> _init() async {
    final info = await PackageInfo.fromPlatform();
    version = info.version;
  }
}

import 'package:emma/application/backend_api/swagger_generated_code/backend_api.swagger.dart';
import 'package:emma/ui/commands/command.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:signals/signals.dart';

class VersionInfoViewModel {
  final BackendApi _api;

  VersionInfoViewModel({required BackendApi api}) : _api = api {
    init = _init.toCommand();
  }
  late final NoArgCommand init;
  final appVersion = signal('---');
  final apiVersion = signal('---');

  Future<void> _init() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;

    try {
      final response = await _api.Health_GetHealthReport();
      apiVersion.value = response.body!.version;
    } catch (_) {
      apiVersion.value = 'Fehler';
    }
  }
}

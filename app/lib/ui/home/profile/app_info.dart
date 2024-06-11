import 'package:emma/ui/app_info_view_model.dart';
import 'package:emma/ui/locator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({super.key});

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  late final AppInfoViewModel _appInfo;

  @override
  void initState() {
    super.initState();
    _appInfo = locator.get<AppInfoViewModel>();
    _appInfo.init();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.center,
      children: [
        Watch(
          (context) => Text(
            "App: ${_appInfo.appVersion}",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        Watch(
          (context) => Text(
            "Backend: ${_appInfo.apiVersion}",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        )
      ],
    );
  }
}

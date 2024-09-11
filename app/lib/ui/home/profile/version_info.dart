import 'package:openems/ui/home/profile/version_info_view_model.dart';
import 'package:openems/ui/locator.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class VersionInfo extends StatefulWidget {
  const VersionInfo({super.key});

  @override
  State<VersionInfo> createState() => _VersionInfoState();
}

class _VersionInfoState extends State<VersionInfo> {
  late final VersionInfoViewModel _appInfo;

  @override
  void initState() {
    super.initState();
    _appInfo = locator.get<VersionInfoViewModel>();
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

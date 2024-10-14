import 'package:openems/infrastructure/window_size_writer.dart';
import 'package:openems/ui/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/home/profile/information_screen.dart';
import 'package:openems/ui/home/profile/version_info.dart';
import 'package:openems/ui/home/profile/development/screen_size_selector.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/logs/logs_screen.dart';
import 'package:openems/ui/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final UserViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = locator.get<UserViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      ListTile(
        leading: const Icon(AppIcons.info),
        title: const Text(AboutScreen.title),
        trailing: const Icon(AppIcons.arrow_next),
        onTap: () => AppNavigator.push(const AboutScreen()),
      ),
      ListTile(
        leading: const Icon(AppIcons.logs),
        title: const Text(LogsScreen.title),
        trailing: const Icon(AppIcons.arrow_next),
        onTap: () => AppNavigator.push(const LogsScreen()),
      ),
      Watch(
        (context) => ListTile(
          leading: const Icon(AppIcons.logout),
          title: const Text("Logout"),
          trailing: const Icon(AppIcons.arrow_next),
          onTap: _vm.logout.call,
          enabled: !_vm.logout.isRunning.value,
        ),
      )
    ];

    if (WindowSizeWriter.isSupported) {
      items.add(const ListTile(
        leading: Icon(AppIcons.screen),
        title: ScreenSizeSelector(),
      ));
    }

    items.add(
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: VersionInfo(),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Watch((context) => Text("Hallo ${_vm.name}")),
      ),
      body: ListView(
        children: [
          ...ListTile.divideTiles(context: context, tiles: items),
        ],
      ),
    );
  }
}

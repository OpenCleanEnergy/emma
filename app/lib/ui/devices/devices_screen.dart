import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/devices/add/select_device_category_screen.dart';
import 'package:openems/ui/devices/devices_view_model.dart';
import 'package:openems/ui/devices/widgets/devices_list.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/app_bar_action_button.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:openems/ui/utils/polling/long_polling_handler.dart';
import 'package:flutter/material.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  LongPollingHandler? _longPollingHandler;

  // The view model has to be stored in the state for it to work.
  // Otherwise the DevicesVieModel would be created multiple times
  // because on every screen change the DevicesScreen ctor is called.
  late final DevicesViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<DevicesViewModel>();
    viewModel.init();
    _longPollingHandler =
        LongPollingHandler(const Duration(seconds: 1), viewModel.refresh.call);
  }

  @override
  void dispose() {
    _longPollingHandler?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            AppBarActionButton(
              onPressed: _startAddFlow,
              icon: const Icon(AppIcons.add),
            ),
          ],
          bottom: AppBarCommandProgressIndicator(command: viewModel.init),
        ),
        body: DevicesList(viewModel: viewModel));
  }

  void _startAddFlow() {
    AppNavigator.push(const SelectDeviceCategoryScreen());
  }
}

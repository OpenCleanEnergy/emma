import 'package:openems/ui/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/home/home_view_model.dart';
import 'package:openems/ui/home/profile/profile_screen.dart';
import 'package:openems/ui/home/status/home_status_view.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/app_bar_action_button.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:openems/ui/utils/polling/long_polling_handler.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LongPollingHandler? _longPollingHandler;

  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<HomeViewModel>();
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
            icon: const Icon(AppIcons.person),
            onPressed: () => AppNavigator.push(const ProfileScreen()),
          ),
        ],
        bottom: AppBarCommandProgressIndicator(command: viewModel.init),
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      body: Center(child: HomeStatusView(viewModel: viewModel)),
    );
  }
}

import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/app_navigator.dart';
import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/profile/profile_screen.dart';
import 'package:emma/ui/home/status/home_status_view.dart';
import 'package:emma/ui/locator.dart';
import 'package:emma/ui/shared/app_bar_action_button.dart';
import 'package:emma/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:emma/ui/utils/polling/long_polling_handler.dart';
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
            icon: const Icon(AppIcons.person_outlined),
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

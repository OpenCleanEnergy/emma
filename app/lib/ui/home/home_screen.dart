import 'package:openems/ui/home/home_onboarding.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/home/home_view_model.dart';
import 'package:openems/ui/home/profile/profile_screen.dart';
import 'package:openems/ui/home/status/home_status_view.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/shared/app_bar_action_button.dart';
import 'package:openems/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:openems/ui/utils/polling/long_polling_handler.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LongPollingHandler? _longPollingHandler;

  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = locator.get<HomeViewModel>();
    _viewModel.init();
    _longPollingHandler =
        LongPollingHandler(const Duration(seconds: 1), _viewModel.refresh.call);
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
        bottom: AppBarCommandProgressIndicator(command: _viewModel.init),
        forceMaterialTransparency: true,
      ),
      extendBodyBehindAppBar: true,
      body: Watch((context) {
        final homeStatusView =
            Center(child: HomeStatusView(viewModel: _viewModel));

        final hasData = _viewModel.batteryStatus.isAvailable.value ||
            _viewModel.consumerStatus.isAvailable.value ||
            _viewModel.producerStatus.isAvailable.value ||
            _viewModel.gridStatus.isAvailable.value;

        if (hasData) {
          return homeStatusView;
        } else {
          return Stack(
            children: [
              homeStatusView,
              const HomeOnboarding(),
            ],
          );
        }
      }),
    );
  }
}

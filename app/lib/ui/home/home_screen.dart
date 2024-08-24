import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/status/home_status_view.dart';
import 'package:emma/ui/locator.dart';
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
    super.dispose();
    _longPollingHandler?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppBarCommandProgressIndicator(command: viewModel.init),
          ),
          Align(
            alignment: Alignment.center,
            child: HomeStatusView(viewModel: viewModel),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/status/home_status_view.dart';
import 'package:emma/ui/locator.dart';
import 'package:emma/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:emma/ui/utils/polling/long_polling_timer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LongPollingTimer? _longPollingTimer;

  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<HomeViewModel>();
    viewModel.init();
    _longPollingTimer = LongPollingTimer(const Duration(seconds: 1), viewModel.refresh.call);
  }

  @override
  void dispose() {
    super.dispose();
    _longPollingTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottom: AppBarCommandProgressIndicator(command: viewModel.init),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
          child: Column(
            children: [
              Center(child: HomeStatusView(viewModel: viewModel)),
              const SizedBox(height: 24),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Image.asset(
                      "assets/isometric-house-collection_1146735_brown.webp"),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }
}

import 'dart:async';

import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/home/home_view_model.dart';
import 'package:emma/ui/home/profile/profile_screen.dart';
import 'package:emma/ui/home/status/home_status_view.dart';
import 'package:emma/ui/app_navigator.dart';
import 'package:emma/ui/locator.dart';
import 'package:emma/ui/shared/app_bar_command_progress_indicator.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _disposed = false;
  Timer? _timer;

  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<HomeViewModel>();
    viewModel.init();
    _timer = Timer(const Duration(seconds: 1), _timerCallback);
  }

  @override
  void dispose() {
    super.dispose();
    _disposed = true;
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => _gotoProfile(context),
                icon: const Icon(AppIcons.person_outlined)),
          ],
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

  void _gotoProfile(BuildContext context) {
    AppNavigator.push(const ProfileScreen());
  }

  Future<void> _timerCallback() async {
    var success = false;
    do {
      success = await viewModel.refresh();
    } while (!_disposed && success);

    if (!success) {
      // on failure: retry after 30 seconds
      _timer = Timer(const Duration(seconds: 30), _timerCallback);
    }
  }
}

import 'package:emma/ui/app_icons.dart';
import 'package:emma/ui/locator.dart';
import 'package:emma/ui/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final UserViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = locator.get<UserViewModel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Watch((context) => FilledButton.icon(
              icon: const Icon(AppIcons.login),
              label: const Text("Login"),
              onPressed: viewModel.login.call,
            )),
      ),
    );
  }
}

import 'package:openems/ui/app_icons.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/user_view_model.dart';
import 'package:flutter/material.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                    dimension: 42,
                    child: Image.asset("assets/icon_foreground_64.webp")),
                const SizedBox(width: 16),
                Text(
                  "EMMA",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
            const SizedBox(height: 48),
            FilledButton.tonalIcon(
              icon: const Icon(AppIcons.login),
              label: const Text("Login"),
              onPressed: viewModel.login.call,
            ),
            const SizedBox(height: 48),
            const Text("Noch keinen Account?"),
            TextButton(
              onPressed: viewModel.register.call,
              child: const Text("Registrieren"),
            ),
          ],
        ),
      ),
    );
  }
}

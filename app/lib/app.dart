import 'package:openems/bootstrap.dart';
import 'package:openems/domain/user_status.dart';
import 'package:openems/ui/app_messenger.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/layout.dart';
import 'package:openems/ui/login_screen.dart';
import 'package:openems/ui/app_navigator.dart';
import 'package:openems/ui/locator.dart';
import 'package:openems/ui/user_view_model.dart';
import 'package:openems/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:signals/signals_flutter.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    final logger = Logger("app");

    try {
      await bootstrap();
      logger.info("bootstrap complete.");
      final vm = locator.get<UserViewModel>();
      effect(() {
        switch (vm.status.value) {
          case UserStatus.unauthenticated:
            AppNavigator.pushAndRemove(const LoginScreen());
            break;

          case UserStatus.authenticated:
            AppNavigator.pushAndRemove(const Layout());
            break;

          default:
            break;
        }
      });
    } catch (error, stackTrace) {
      logger.severe("Error in bootstrap.", error, stackTrace);
      AppMessenger.error("$error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(0xff, 0x5b, 0xc5, 0x77),
        brightness: Brightness.light,
      ),
      fontFamily: "FiraSans",
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) => const Icon(AppIcons.arrow_prev),
        closeButtonIconBuilder: (_) => const Icon(AppIcons.close),
      ),
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EMMA',
        navigatorKey: AppNavigator.key,
        scaffoldMessengerKey: AppMessenger.key,
        theme: theme,
        home: const SplashScreen());
  }
}

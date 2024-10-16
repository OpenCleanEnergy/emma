import 'package:openems/ui/analytics/analytics_screen.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/devices/devices_screen.dart';
import 'package:openems/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

// from
// - https://dev.to/nicks101/state-persistence-techniques-for-the-flutter-bottom-navigation-bar-3ikc
// - https://blog.canopas.com/how-to-maintain-the-state-of-bottomnavigationbar-across-tabs-528b3699f78b
class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  late final PersistentTabController _controller;
  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 1);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeForegroundColor = theme.colorScheme.primary;
    final inactiveForegroundColor = theme.colorScheme.onSurface;

    final tabs = [
      PersistentTabConfig(
        screen: const DevicesScreen(),
        item: ItemConfig(
          icon: const Icon(AppIcons.device),
          title: "Geräte",
          activeForegroundColor: activeForegroundColor,
          inactiveForegroundColor: inactiveForegroundColor,
        ),
      ),
      PersistentTabConfig(
        screen: const HomeScreen(),
        item: ItemConfig(
          icon: const Icon(AppIcons.home),
          title: "Zuhause",
          activeForegroundColor: activeForegroundColor,
          inactiveForegroundColor: inactiveForegroundColor,
        ),
      ),
      PersistentTabConfig(
        screen: const AnalyticsScreen(),
        item: ItemConfig(
          icon: const Icon(AppIcons.analytics),
          title: "Auswertung",
          activeForegroundColor: activeForegroundColor,
          inactiveForegroundColor: inactiveForegroundColor,
        ),
      ),
    ];

    return PersistentTabView(
      tabs: tabs,
      controller: _controller,
      navBarHeight: kBottomNavigationBarHeight + 8,
      navBarOverlap: const NavBarOverlap.none(),
      navBarBuilder: (navBarConfig) => Style7BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: theme.navigationBarTheme.backgroundColor ??
              theme.colorScheme.surfaceContainer,
        ),
      ),
    );
  }
}

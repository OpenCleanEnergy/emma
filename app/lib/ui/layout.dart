import 'package:openems/ui/analytics/analytics_screen.dart';
import 'package:openems/ui/icons/app_icons.dart';
import 'package:openems/ui/devices/devices_screen.dart';
import 'package:openems/ui/home/home_screen.dart';
import 'package:flutter/material.dart';

// from
// - https://dev.to/nicks101/state-persistence-techniques-for-the-flutter-bottom-navigation-bar-3ikc
// - https://blog.canopas.com/how-to-maintain-the-state-of-bottomnavigationbar-across-tabs-528b3699f78b
class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    const pages = [
      DevicesScreen(),
      HomeScreen(),
      AnalyticsScreen(),
    ];

    const destinations = [
      NavigationDestination(
        icon: Icon(AppIcons.device),
        selectedIcon: Icon(AppIcons.device_solid),
        label: "Geräte",
      ),
      NavigationDestination(
        icon: Icon(AppIcons.home),
        selectedIcon: Icon(AppIcons.home_solid),
        label: "Zuhause",
      ),
      NavigationDestination(
        icon: Icon(AppIcons.analytics),
        selectedIcon: Icon(AppIcons.analytics_solid),
        label: "Auswertung",
      ),
    ];

    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: pages,
        ),
        bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: destinations));
  }

  void _onDestinationSelected(int selectedIndex) {
    if (_selectedIndex != selectedIndex) {
      setState(() {
        _selectedIndex = selectedIndex;
      });
    }
  }
}

import 'dart:math';

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
    _controller = PersistentTabController(
      initialIndex: 1,
      historyLength: 1,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // constants, colors and text theme based on
    // https://m3.material.io/components/navigation-bar/specs
    final theme = Theme.of(context);

    final tabs = [
      _buildTabConfig(
        theme: theme,
        title: "Geräte",
        activeIcon: const Icon(AppIcons.device_solid),
        inactiveIcon: const Icon(AppIcons.device),
        screen: const DevicesScreen(),
      ),
      _buildTabConfig(
        theme: theme,
        title: "Zuhause",
        activeIcon: const Icon(AppIcons.home_solid),
        inactiveIcon: const Icon(AppIcons.home),
        screen: const HomeScreen(),
      ),
      _buildTabConfig(
        theme: theme,
        title: "Auswertung",
        activeIcon: const Icon(AppIcons.analytics_solid),
        inactiveIcon: const Icon(AppIcons.analytics),
        screen: const AnalyticsScreen(),
      ),
    ];

    return PersistentTabView(
      controller: _controller,
      tabs: tabs,
      navBarHeight: 80,
      navBarOverlap: const NavBarOverlap.none(),
      navBarBuilder: (navBarConfig) => _ModifiedStyle4BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: theme.colorScheme.surfaceContainer,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  PersistentTabConfig _buildTabConfig({
    required ThemeData theme,
    required String title,
    required Icon activeIcon,
    required Icon inactiveIcon,
    required Widget screen,
  }) {
    assert(theme.textTheme.labelMedium != null);
    assert(theme.iconTheme.size != null);
    return PersistentTabConfig(
      screen: screen,
      item: ItemConfig(
        title: title,
        icon: activeIcon,
        inactiveIcon: inactiveIcon,
        activeForegroundColor: theme.colorScheme.primary,
        inactiveForegroundColor: theme.colorScheme.onSurface,
        textStyle: theme.textTheme.labelMedium!,
        iconSize: theme.iconTheme.size!,
      ),
    );
  }
}

class _ModifiedStyle4BottomNavBar extends StatelessWidget {
  const _ModifiedStyle4BottomNavBar({
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
  });

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

  /// This controls the animation properties of the items of the NavBar.
  final ItemAnimation itemAnimationProperties = const ItemAnimation();

  Widget _buildItem(ItemConfig item, bool isSelected) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(
              size: item.iconSize,
              color: isSelected
                  ? item.activeForegroundColor
                  : item.inactiveForegroundColor,
            ),
            child: isSelected ? item.icon : item.inactiveIcon,
          ),
          if (item.title != null) ...[
            const SizedBox(
              height: 12,
            ),
            FittedBox(
              child: Text(
                item.title!,
                style: item.textStyle.apply(
                  color: isSelected
                      ? item.activeForegroundColor
                      : item.inactiveForegroundColor,
                ),
              ),
            )
          ],
        ],
      );

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (MediaQuery.of(context).size.width -
            navBarDecoration.padding.horizontal) /
        navBarConfig.items.length;
    final indicatorWidth = min(itemWidth, 80.0);
    final paddingLeft =
        itemWidth * (navBarConfig.selectedIndex + 0.5) - (indicatorWidth / 2.0);

    return DecoratedNavBar(
      decoration: navBarDecoration,
      height: navBarConfig.navBarHeight,
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: itemAnimationProperties.duration,
                  curve: itemAnimationProperties.curve,
                  width: paddingLeft,
                  height: 4,
                ),
                AnimatedContainer(
                  duration: itemAnimationProperties.duration,
                  curve: itemAnimationProperties.curve,
                  width: indicatorWidth,
                  height: 4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: navBarConfig.selectedItem.activeForegroundColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...navBarConfig.items.map((item) {
                    final int index = navBarConfig.items.indexOf(item);
                    return Flexible(
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        radius: navBarConfig.navBarHeight / 2 * 1.125,
                        onTap: () {
                          navBarConfig.onItemSelected(index);
                        },
                        child: Center(
                          child: _buildItem(
                            item,
                            navBarConfig.selectedIndex == index,
                          ),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/app/app_state/platform_provider.dart';
import 'package:mvvm_cube_timer/app/navigation/tabs_controller_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/background_color_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/computed_contrast_provider.dart';

/// Platform-aware bottom navigation bar
class AppShellBottomNav extends ConsumerWidget {
  const AppShellBottomNav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCupertino = ref.watch(isCupertinoProvider);

    if (isCupertino) {
      return const _CupertinoBottomNav();
    }

    return const _MaterialBottomNav();
  }
}

/// Material Design bottom navigation bar
class _MaterialBottomNav extends ConsumerWidget {
  const _MaterialBottomNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(tabsControllerProvider);
    final bottomBarColor = ref.watch(bottomBarColorProvider);
    final textColor = ref.watch(computedTextColorProvider);

    return BottomNavigationBar(
      currentIndex: currentTab,
      onTap: (index) => ref.read(tabsControllerProvider.notifier).setTab(index),
      backgroundColor: bottomBarColor,
      selectedItemColor: textColor,
      unselectedItemColor: textColor.withValues(alpha: 0.5),
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.timer_outlined),
          activeIcon: Icon(Icons.timer),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          activeIcon: Icon(Icons.list_alt),
          label: 'Solves',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart_outlined),
          activeIcon: Icon(Icons.show_chart),
          label: 'Statistics',
        ),
      ],
    );
  }
}

/// Cupertino-style bottom navigation (for iOS)
class _CupertinoBottomNav extends ConsumerWidget {
  const _CupertinoBottomNav();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(tabsControllerProvider);
    final bottomBarColor = ref.watch(bottomBarColorProvider);
    final textColor = ref.watch(computedTextColorProvider);

    return CupertinoTabBar(
      currentIndex: currentTab,
      onTap: (index) => ref.read(tabsControllerProvider.notifier).setTab(index),
      backgroundColor: bottomBarColor,
      activeColor: textColor,
      inactiveColor: textColor.withValues(alpha: 0.5),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.timer),
          activeIcon: Icon(CupertinoIcons.timer_fill),
          label: 'Timer',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.list_bullet),
          activeIcon: Icon(CupertinoIcons.list_bullet),
          label: 'Solves',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.chart_bar),
          activeIcon: Icon(CupertinoIcons.chart_bar_fill),
          label: 'Statistics',
        ),
      ],
    );
  }
}

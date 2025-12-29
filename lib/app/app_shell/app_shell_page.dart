import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/app/app_shell/app_shell_appbar.dart';
import 'package:mvvm_cube_timer/app/app_shell/app_shell_bottom_nav.dart';
import 'package:mvvm_cube_timer/app/app_shell/app_shell_drawer.dart';
import 'package:mvvm_cube_timer/app/navigation/tabs_controller_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/background_color_provider.dart';

/// Main app shell page with bottom navigation and PageView
class AppShellPage extends ConsumerStatefulWidget {
  const AppShellPage({super.key});

  @override
  ConsumerState<AppShellPage> createState() => _AppShellPageState();
}

class _AppShellPageState extends ConsumerState<AppShellPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: timerTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundGradient = ref.watch(backgroundGradientProvider);

    // Sync PageController with tab state
    ref.listen<int>(tabsControllerProvider, (previous, next) {
      if (_pageController.hasClients && _pageController.page?.round() != next) {
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      appBar: const AppShellAppBar(),
      drawer: const AppShellDrawer(),
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            ref.read(tabsControllerProvider.notifier).setTab(index);
          },
          children: [
            _buildTimerTab(),
            _buildSolvesTab(),
            _buildStatisticsTab(),
          ],
        ),
      ),
      bottomNavigationBar: const AppShellBottomNav(),
    );
  }

  Widget _buildTimerTab() {
    // Placeholder for Timer Tab
    return const Center(
      child: Text(
        'Timer Tab',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  Widget _buildSolvesTab() {
    // Placeholder for Solves Tab
    return const Center(
      child: Text(
        'Solves Tab',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }

  Widget _buildStatisticsTab() {
    // Placeholder for Statistics Tab
    return const Center(
      child: Text(
        'Statistics Tab',
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tab indices
const int timerTabIndex = 0;
const int solvesTabIndex = 1;
const int statisticsTabIndex = 2;

/// Notifier for tab navigation state
class TabsControllerNotifier extends StateNotifier<int> {
  TabsControllerNotifier() : super(timerTabIndex);

  void setTab(int index) {
    if (index >= 0 && index <= 2) {
      state = index;
    }
  }

  void goToTimer() => state = timerTabIndex;
  void goToSolves() => state = solvesTabIndex;
  void goToStatistics() => state = statisticsTabIndex;

  void nextTab() {
    if (state < 2) {
      state++;
    }
  }

  void previousTab() {
    if (state > 0) {
      state--;
    }
  }
}

/// Provider for current tab index
final tabsControllerProvider =
    StateNotifierProvider<TabsControllerNotifier, int>((ref) {
  return TabsControllerNotifier();
});

/// Provider for checking if on timer tab
final isOnTimerTabProvider = Provider<bool>((ref) {
  return ref.watch(tabsControllerProvider) == timerTabIndex;
});

/// Provider for checking if on solves tab
final isOnSolvesTabProvider = Provider<bool>((ref) {
  return ref.watch(tabsControllerProvider) == solvesTabIndex;
});

/// Provider for checking if on statistics tab
final isOnStatisticsTabProvider = Provider<bool>((ref) {
  return ref.watch(tabsControllerProvider) == statisticsTabIndex;
});

# Task Breakdown: Speedcube Timer App

## Overview
Total Tasks: 13 Task Groups

## Task List

---

### Project Setup

#### Task Group 1: Project Configuration & Dependencies ✅
**Dependencies:** None
**Status:** COMPLETED

- [x] 1.0 Complete project setup
  - [x] 1.1 Update pubspec.yaml with required dependencies
    - Add drift, drift_dev, sqlite3_flutter_libs for database
    - Add flutter_riverpod for state management (manual providers, no generators)
    - Add shared_preferences for theme persistence
    - Add fl_chart for statistics charts
    - Add build_runner for Drift code generation only
  - [x] 1.2 Create folder structure following ideal_structure.md
    - Create lib/app/ with app_shell/, navigation/, app_state/, theme/ subdirectories
    - Create lib/core/ with database/, platform/, utils/ subdirectories
    - Create lib/features/ with timer/, solves/, statistics/, algorithms/, trainer/ subdirectories
  - [x] 1.3 Set up bootstrap.dart for app initialization
    - Initialize Drift database
    - Set up ProviderScope
    - Configure platform detection
  - [x] 1.4 Add Quicksand font to assets
    - Register in pubspec.yaml
    - NOTE: Font files need to be downloaded from Google Fonts

**Acceptance Criteria:**
- ✅ All dependencies resolve with `flutter pub get`
- ✅ Folder structure matches ideal_structure.md
- ✅ App compiles without errors

---

### Core Database Layer

#### Task Group 2: Drift Database & Tables ✅
**Dependencies:** Task Group 1
**Status:** COMPLETED (tests skipped)

- [x] 2.0 Complete database layer
  - [ ] ~~2.1 Write 4-6 focused tests for database functionality~~ (SKIPPED)
  - [x] 2.2 Create core/database/tables/cubes_table.dart
    - Fields: id (autoIncrement), name (text), icon (text nullable)
    - Pre-seed with: 2x2, 3x3, 4x4, 5x5, 6x6, 7x7, Pyraminx, Megaminx, Skewb, Square-1
  - [x] 2.3 Create core/database/tables/categories_table.dart
    - Fields: id, name, cube_id (foreign key to cubes)
    - Default "normal" category per cube type
  - [x] 2.4 Create core/database/tables/sessions_table.dart
    - Fields: id, started_at (DateTime), cube_id, category_id
  - [x] 2.5 Create core/database/tables/solves_table.dart
    - Fields: id, duration (int milliseconds), timestamp, cube_id, category_id, session_id
    - Additional: penalty (enum: none, plus2, dnf), scramble (text), comment (text nullable)
  - [x] 2.6 Create core/database/app_database.dart
    - Include all tables
    - Configure Drift with sqlite3_flutter_libs
    - Add schemaVersion and migrations
  - [ ] ~~2.7 Ensure database tests pass~~ (SKIPPED)

**Acceptance Criteria:**
- ✅ Database creates successfully on app launch
- ✅ Tables have correct schema
- ⏭️ Tests skipped per user request

#### Task Group 3: Data Access Objects (DAOs) ✅
**Dependencies:** Task Group 2
**Status:** COMPLETED (tests skipped)

- [x] 3.0 Complete DAO layer
  - [ ] ~~3.1 Write 4-6 focused tests for DAO operations~~ (SKIPPED)
  - [x] 3.2 Create core/database/daos/cubes_dao.dart
    - getAllCubes() - returns List<Cube>
    - getCubeById(int id)
    - Read-only, no insert/update/delete
  - [x] 3.3 Create core/database/daos/categories_dao.dart
    - watchCategories(int cubeId) - Stream<List<Category>>
    - addCategory(String name, int cubeId)
    - deleteCategory(int id)
    - getDefaultCategory(int cubeId)
  - [x] 3.4 Create core/database/daos/sessions_dao.dart
    - createSession(int cubeId, int categoryId)
    - getMostRecentSession()
    - watchMostRecentSession()
  - [x] 3.5 Create core/database/daos/solves_dao.dart
    - insertSolve(SolvesCompanion)
    - updateSolve(Solve)
    - deleteSolve(int id)
    - watchSolves(int cubeId, int categoryId) - Stream<List<Solve>>
    - watchSessionSolves(int sessionId) - Stream<List<Solve>>
    - getSolvesCount(int cubeId, int categoryId)
  - [ ] ~~3.6 Ensure DAO tests pass~~ (SKIPPED)

**Acceptance Criteria:**
- ✅ All DAOs provide reactive streams
- ✅ Queries filter correctly by cube/category
- ⏭️ Tests skipped per user request

---

### Core Utilities

#### Task Group 4: Calculation Utilities ✅
**Dependencies:** Task Group 2
**Status:** COMPLETED (tests skipped)

- [x] 4.0 Complete core utilities
  - [ ] ~~4.1 Write 5-8 focused tests for utility functions~~ (SKIPPED)
  - [x] 4.2 Create core/utils/time_math.dart
    - formatTime(int milliseconds) → String (e.g., "12.34")
    - parseTime(String) → int milliseconds
    - formatTimeWithMinutes(int ms) → String (e.g., "1:23.45")
  - [x] 4.3 Create core/utils/aox_calculator.dart
    - calculateAoX(List<int> times, int x) → double?
    - Algorithm: sort, remove best and worst, average remaining
    - Return null if times.length < x
  - [x] 4.4 Create core/utils/statistics_helpers.dart
    - calculateMean(List<int> times) → double?
    - calculateDeviation(List<int> times) → double?
    - findBestTime(List<int> times) → int?
    - calculateBestProgression(List<int> times) → List<int>
  - [ ] ~~4.5 Ensure utility tests pass~~ (SKIPPED)

**Acceptance Criteria:**
- ✅ AoX correctly removes best/worst before averaging
- ✅ Edge cases handled (empty lists, insufficient data)
- ⏭️ Tests skipped per user request

#### Task Group 5: Platform Services ✅
**Dependencies:** Task Group 1
**Status:** COMPLETED (tests skipped)

- [x] 5.0 Complete platform services
  - [ ] ~~5.1 Write 2-4 focused tests for platform services~~ (SKIPPED)
  - [x] 5.2 Create core/platform/haptics.dart
    - lightImpact() - for timer ready state
    - mediumImpact() - for timer start/stop
    - selectionClick() - for UI selections
    - Platform-aware: HapticFeedback on iOS, Vibration on Android
  - [x] 5.3 Create core/platform/gestures.dart
    - Timer gesture constants (hold duration thresholds)
    - Platform-specific touch timing adjustments
  - [x] 5.4 Create app/app_state/platform_provider.dart
    - platformProvider - exposes TargetPlatform
    - isCupertinoProvider, isMaterialProvider, isIOSProvider, isAndroidProvider
  - [ ] ~~5.5 Ensure platform tests pass~~ (SKIPPED)

**Acceptance Criteria:**
- ✅ Haptics configured for both iOS and Android
- ✅ Platform detection is accurate
- ⏭️ Tests skipped per user request

---

### Theme System

#### Task Group 6: Theme Models & Data ✅
**Dependencies:** Task Group 1
**Status:** COMPLETED (tests skipped)

- [x] 6.0 Complete theme models
  - [ ] ~~6.1 Write 3-5 focused tests for theme system~~ (SKIPPED)
  - [x] 6.2 Create app/theme/models/app_theme.dart
    - ColorBackgroundPair class (primaryColor, secondaryColor)
    - ColorAppTheme class (bgPatternColor, appBarColor, bottomBarColor, isDarkmode, name)
    - AppTextTheme class (colorText nullable, name)
    - AppTheme class (actualThemeIndex, actualTextThemeIndex, statusBarTextColor, isDarkmode)
  - [x] 6.3 Define appColorTheme constant list (24 themes)
    - All theme definitions from cube_timer_oficial/app_theme.dart
    - Include: Hazy Blues, Spotty Guy, Simply White, etc.
  - [x] 6.4 Define appTextTheme constant list (15 options)
    - Default (null colorText), Pessoa, Lou, Burgess, Bowie, etc.
  - [x] 6.5 Create app/theme/logic/contrast_calculator.dart
    - computeContrastColor(Color background) → Color (white or black)
    - Use luminance calculation for auto-contrast
  - [ ] ~~6.6 Ensure theme model tests pass~~ (SKIPPED)

**Acceptance Criteria:**
- ✅ All 24 color themes defined
- ✅ All 15 text themes defined
- ✅ Contrast calculator works correctly
- ⏭️ Tests skipped per user request

#### Task Group 7: Theme Providers & Platform Themes ✅
**Dependencies:** Task Group 6
**Status:** COMPLETED (tests skipped)

- [x] 7.0 Complete theme providers
  - [ ] ~~7.1 Write 3-5 focused tests for theme providers~~ (SKIPPED)
  - [x] 7.2 Create app/theme/providers/theme_mode_provider.dart
    - themeIndexProvider - StateNotifier with persistence
    - textThemeIndexProvider - StateNotifier with persistence
    - Load/save to shared_preferences
  - [x] 7.3 Create app/theme/providers/background_color_provider.dart
    - Derives ColorBackgroundPair from themeIndexProvider
    - Exposes primaryColor, secondaryColor, appBarColor, bottomBarColor
  - [x] 7.4 Create app/theme/providers/text_color_provider.dart
    - Derives text color from textThemeIndexProvider
    - Falls back to computed contrast if colorText is null
  - [x] 7.5 Create app/theme/providers/computed_contrast_provider.dart
    - Combines background and text color providers
    - Provides final resolved text color
  - [x] 7.6 Add getTheme() method to AppTheme for Material ThemeData
    - Configure brightness based on isDarkmode
    - Set colorScheme, appBarTheme, bottomNavigationBarTheme
    - Use Quicksand font family
  - [x] 7.7 Add getCupertinoTheme() method for CupertinoThemeData
    - Configure brightness, primaryColor, scaffoldBackgroundColor
    - CupertinoTextThemeData with correct colors
  - [ ] ~~7.8 Ensure theme provider tests pass~~ (SKIPPED)

**Acceptance Criteria:**
- ✅ Theme selection persists across app restarts
- ✅ Both Material and Cupertino themes generate correctly
- ✅ Auto-contrast works when text theme is "Default"
- ⏭️ Tests skipped per user request

---

### App Shell

#### Task Group 8: App Shell & Navigation ✅
**Dependencies:** Task Groups 5, 7
**Status:** COMPLETED (tests skipped)

- [x] 8.0 Complete app shell
  - [ ] ~~8.1 Write 3-5 focused tests for app shell~~ (SKIPPED)
  - [x] 8.2 Create app/app_state/selected_cube_provider.dart
    - StateNotifier<Cube?> with initialization
    - Default to 3x3 cube
  - [x] 8.3 Create app/app_state/selected_category_provider.dart
    - StateNotifier<Category?>
    - Updates when cube changes (reset to "normal")
    - Watches categories for selected cube
  - [x] 8.4 Create app/app_state/selected_session_provider.dart
    - Manages current timing session
    - Creates new session on app start or manual reset
  - [x] 8.5 Create app/navigation/tabs_controller_provider.dart
    - StateNotifier<int> for current tab index
    - Methods: goToTimer(), goToSolves(), goToStatistics()
  - [x] 8.6 Create app/app_shell/app_shell_page.dart
    - Scaffold with AppBar, body (PageView), bottom nav
    - Platform-aware: Material or Cupertino styling
    - PageView synced with TabController
  - [x] 8.7 Create app/app_shell/app_shell_appbar.dart
    - Cube type selector button (opens dialog)
    - Category selector button (opens dialog)
    - Drawer toggle IconButton
    - Display current cube name and category
  - [x] 8.8 Create app/app_shell/app_shell_bottom_nav.dart
    - 3 items: Timer, Solves, Statistics
    - Platform-aware: BottomNavigationBar or CupertinoTabBar
    - Sync with tabs_controller
  - [x] 8.9 Create app/app_shell/app_shell_drawer.dart
    - Navigation items: Algorithms, Trainer, Theme Settings
    - Current theme preview
    - Theme selector bottom sheets
  - [ ] ~~8.10 Ensure app shell tests pass~~ (SKIPPED)

**Acceptance Criteria:**
- ✅ Tab navigation works via swipe and bottom nav
- ✅ Cube/category selection updates globally
- ✅ Drawer provides navigation to other pages
- ✅ Platform styling is correct (iOS vs Android)
- ⏭️ Tests skipped per user request

---

### Features

#### Task Group 9: Timer Feature
**Dependencies:** Task Groups 3, 4, 8
**Status:** PENDING

- [ ] 9.0 Complete timer feature
  - [ ] 9.1 Write 4-6 focused tests for timer feature
    - Test timer state transitions (idle → ready → running → stopped)
    - Test solve saves to database on stop
    - Test scramble generates for current cube type
    - Test penalty application (+2, DNF)
  - [ ] 9.2 Create features/timer/providers/timer_state.provider.dart
    - TimerState enum: idle, inspection, ready, running, stopped
    - StateNotifier managing state transitions
    - Stopwatch for timing logic
    - Methods: startHold(), release(), stop(), reset()
  - [ ] 9.3 Create features/timer/providers/scramble.provider.dart
    - Generates scramble for current cube type
    - Refresh method for new scramble
    - Scramble algorithms per cube type (basic random moves)
  - [ ] 9.4 Create features/timer/presentation/gestures/timer_gesture_handler.dart
    - GestureDetector wrapper for full-screen touch
    - onTapDown → start hold timer
    - onTapUp → if held long enough, start timer; else cancel
    - onLongPressEnd → stop timer
    - Haptic feedback integration
  - [ ] 9.5 Create features/timer/presentation/widgets/chronometer.dart
    - Large time display (centered)
    - Animated color changes for states (red while holding, green when ready)
    - Format: seconds.centiseconds (e.g., "12.34")
  - [ ] 9.6 Create features/timer/presentation/widgets/scramble_view.dart
    - Display scramble notation in monospace font
    - Light bulb icon (scramble hints - future)
    - Refresh icon to regenerate scramble
  - [ ] 9.7 Create features/timer/presentation/widgets/aox_summary.dart
    - Right panel: Ao5, Ao12, Ao50, Ao100 values
    - Subscribe to statistics providers
    - Show "--" when insufficient data
  - [ ] 9.8 Create features/timer/presentation/widgets/best_time_view.dart
    - Left panel: Deviation, Mean, Best, Count
    - Subscribe to solves stream and compute
  - [ ] 9.9 Create features/timer/presentation/pages/timer_tab_page.dart
    - Compose all widgets: scramble_view, chronometer, aox_summary, best_time_view
    - Action buttons after solve (delete, +2, DNF, comment)
    - Cube visualization widget placeholder
  - [ ] 9.10 Ensure timer feature tests pass
    - Run only tests from 9.1

**Acceptance Criteria:**
- Timer starts/stops with tap gestures
- Solves save to database with scramble
- Statistics display and update reactively
- Haptic feedback on state changes
- Tests pass (4-6 tests)

#### Task Group 10: Solves List Feature
**Dependencies:** Task Groups 3, 8
**Status:** PENDING

- [ ] 10.0 Complete solves list feature
  - [ ] 10.1 Write 3-5 focused tests for solves list
    - Test solves list displays from stream
    - Test pagination loads more on scroll
    - Test search filters by comment
  - [ ] 10.2 Create features/solves/providers/solves_stream.provider.dart
    - Watches solves for current cube/category
    - Provides Stream<List<Solve>>
  - [ ] 10.3 Create features/solves/providers/solves_pagination.provider.dart
    - Manages pagination state (offset, limit)
    - Load more on scroll threshold
    - Initial load: 30 items, load 20 more on scroll
  - [ ] 10.4 Create features/solves/presentation/widgets/solve_tile.dart
    - Display: date, time, +2/DNF badge, comment icon
    - Tap to expand details
    - Long-press for quick actions (delete, edit penalty)
  - [ ] 10.5 Create features/solves/presentation/widgets/solves_virtual_list.dart
    - ListView.builder with pagination
    - Date grouping headers (sticky headers)
    - Pull-to-refresh
  - [ ] 10.6 Create features/solves/presentation/pages/solves_tab_page.dart
    - Search bar with comment filter
    - Calendar date picker for filtering
    - Settings icon in header
    - Solves virtual list
  - [ ] 10.7 Ensure solves list tests pass
    - Run only tests from 10.1

**Acceptance Criteria:**
- Solves display with correct formatting
- Pagination works smoothly
- Search filters results
- Tests pass (3-5 tests)

#### Task Group 11: Statistics Feature
**Dependencies:** Task Groups 3, 4, 8
**Status:** PENDING

- [ ] 11.0 Complete statistics feature
  - [ ] 11.1 Write 4-6 focused tests for statistics feature
    - Test AoX providers compute correct values
    - Test chart data generates from solves
    - Test global vs session filtering
  - [ ] 11.2 Create features/statistics/providers/ AoX providers
    - ao5.provider.dart - watches solves, computes Ao5
    - ao12.provider.dart - watches solves, computes Ao12
    - ao50.provider.dart - watches solves, computes Ao50
    - ao100.provider.dart - watches solves, computes Ao100
    - mean.provider.dart - simple average of all
  - [ ] 11.3 Create features/statistics/presentation/widgets/performance_chart.dart
    - LineChart using fl_chart
    - White line: all solve times
    - Dotted line: best time progression
    - Red line: Ao5 trend
    - Green line: Ao12 trend
    - X-axis: solve index, Y-axis: time in seconds
  - [ ] 11.4 Create features/statistics/presentation/widgets/aox_lines.dart
    - Calculate AoX values at each point for trend lines
    - Efficient calculation (sliding window)
  - [ ] 11.5 Create features/statistics/presentation/widgets/stats_table.dart
    - Rows: Deviation, Ao12, Ao50, Ao100, Best, Count
    - Columns: Metric name, Global value, Session value
  - [ ] 11.6 Create features/statistics/presentation/widgets/stats_tabs.dart
    - TabBar: Improvement, Average, Other
    - Switch table content based on selected tab
  - [ ] 11.7 Create features/statistics/presentation/pages/statistics_tab_page.dart
    - Performance chart at top
    - Chart legend with toggleable series
    - Stats table with tabs below
  - [ ] 11.8 Ensure statistics feature tests pass
    - Run only tests from 11.1

**Acceptance Criteria:**
- Chart displays all data series correctly
- Statistics update reactively on new solves
- Global and session values differentiated
- Tests pass (4-6 tests)

#### Task Group 12: Algorithms & Trainer Features
**Dependencies:** Task Groups 8, 9
**Status:** PENDING

- [ ] 12.0 Complete algorithms and trainer features
  - [ ] 12.1 Write 3-5 focused tests for algorithms/trainer
    - Test algorithm data loads correctly
    - Test trainer scramble generates OLL/PLL only
    - Test trainer times save under correct category
  - [ ] 12.2 Create features/algorithms/data/algorithms_repository.dart
    - Static data for OLL cases (57 cases)
    - Static data for PLL cases (21 cases)
    - Each case: name, image/diagram, algorithm variations, recognition tips
  - [ ] 12.3 Create features/algorithms/presentation/pages/algorithms_page.dart
    - TabBar: OLL, PLL sections
    - GridView of algorithm case cards
    - Tap to open detail dialog
  - [ ] 12.4 Create features/algorithms/presentation/dialogs/algorithm_detail_dialog.dart
    - Case name and visual representation
    - List of algorithm variations
    - Finger trick hints
  - [ ] 12.5 Create features/trainer/providers/trainer_state.provider.dart
    - Selected OLL/PLL cases to practice
    - Generates case-specific scrambles
    - Tracks trainer session separately
  - [ ] 12.6 Create features/trainer/presentation/widgets/trainer_scramble.dart
    - Scramble generator for OLL-only or PLL-only
    - Shows which case the scramble is for
  - [ ] 12.7 Create features/trainer/presentation/pages/trainer_page.dart
    - Reuse timer components but with trainer_state provider
    - Case selector toggle
    - Only available for 3x3 cube (enforce in UI)
    - Statistics for trainer sessions
  - [ ] 12.8 Ensure algorithms/trainer tests pass
    - Run only tests from 12.1

**Acceptance Criteria:**
- All OLL/PLL cases display with algorithms
- Trainer generates correct scrambles
- Trainer times tracked separately
- Tests pass (3-5 tests)

---

### Integration & Testing

#### Task Group 13: Test Review & Integration
**Dependencies:** Task Groups 1-12
**Status:** PENDING

- [ ] 13.0 Review and fill critical test gaps
  - [ ] 13.1 Review tests from all task groups
    - Database tests (2.1, 3.1): ~8-12 tests
    - Utility tests (4.1, 5.1): ~7-12 tests
    - Theme tests (6.1, 7.1): ~6-10 tests
    - App shell tests (8.1): ~3-5 tests
    - Feature tests (9.1, 10.1, 11.1, 12.1): ~14-22 tests
    - Total existing: approximately 38-61 tests
  - [ ] 13.2 Analyze critical workflow gaps
    - Full timer flow: start → stop → save → display in list
    - Theme change persists and applies
    - Category/cube change updates all views
    - Statistics recalculate on new solve
  - [ ] 13.3 Write up to 10 additional integration tests
    - End-to-end timer workflow test
    - Theme persistence test
    - Category switch updates solves list test
    - AoX updates on new solve test
  - [ ] 13.4 Run all feature-specific tests
    - Run complete test suite for this app
    - Verify all tests pass
    - Fix any failures

**Acceptance Criteria:**
- All tests pass (approximately 48-71 tests total)
- Critical user workflows covered
- No regressions in existing functionality

---

## Execution Order

Recommended implementation sequence:

1. ✅ **Project Setup** (Task Group 1) - COMPLETED
2. ✅ **Core Database** (Task Groups 2-3) - COMPLETED
3. ✅ **Core Utilities** (Task Groups 4-5) - COMPLETED
4. ✅ **Theme System** (Task Groups 6-7) - COMPLETED
5. ✅ **App Shell** (Task Group 8) - COMPLETED
6. ⏳ **Timer Feature** (Task Group 9) - PENDING
7. ⏳ **Solves List Feature** (Task Group 10) - PENDING
8. ⏳ **Statistics Feature** (Task Group 11) - PENDING
9. ⏳ **Algorithms & Trainer** (Task Group 12) - PENDING
10. ⏳ **Integration Testing** (Task Group 13) - PENDING

## Progress Summary

| Task Group | Status | Tests |
|------------|--------|-------|
| 1. Project Setup | ✅ Complete | N/A |
| 2. Database Tables | ✅ Complete | ⏭️ Skipped |
| 3. DAOs | ✅ Complete | ⏭️ Skipped |
| 4. Calculation Utils | ✅ Complete | ⏭️ Skipped |
| 5. Platform Services | ✅ Complete | ⏭️ Skipped |
| 6. Theme Models | ✅ Complete | ⏭️ Skipped |
| 7. Theme Providers | ✅ Complete | ⏭️ Skipped |
| 8. App Shell | ✅ Complete | ⏭️ Skipped |
| 9. Timer Feature | ⏳ Pending | - |
| 10. Solves List | ⏳ Pending | - |
| 11. Statistics | ⏳ Pending | - |
| 12. Algorithms/Trainer | ⏳ Pending | - |
| 13. Integration | ⏳ Pending | - |

## Notes

- Each task group can be worked on by a specialized agent
- Database layer must complete before features
- Theme system should complete before app shell for styling
- Timer feature is the most complex and should be prioritized
- Algorithms data can be worked on in parallel with other features
- **Tests were skipped for Task Groups 1-8 per user request**
- **Quicksand fonts need to be downloaded from Google Fonts**

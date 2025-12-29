# Specification: Speedcube Timer App

## Goal
Build a cross-platform speedcubing timer app with MVVM architecture using Drift for local storage and Riverpod for state management, featuring timer tracking, statistics computation (AoX calculations), customizable themes, and OLL/PLL algorithm training.

## User Stories
- As a speedcuber, I want to time my solves with tap-to-start/stop gestures so that I can track my progress across different cube types and categories
- As a speedcuber, I want to see computed averages (Ao5, Ao12, Ao50, Ao100) and statistics so that I can analyze my improvement over time

## Specific Requirements

**Database Layer with Drift**
- Create three main tables: `solves` (time entries), `cubes` (static cube types), `categories` (user-manageable)
- `solves` table stores: id, duration (milliseconds), timestamp, cube_id, category_id, session_id, penalty (+2, DNF), scramble, comment
- `cubes` table is pre-seeded and read-only: 2x2, 3x3, 4x4, 5x5, 6x6, 7x7, Pyraminx, Megaminx, Skewb, Square-1
- `categories` table: id, name, cube_id (default "normal" category per cube)
- Use Drift DAOs for each table with stream-based queries for reactive UI updates
- AoX values are NEVER stored - always computed from solve streams

**AoX Calculation System**
- Implement `aox_calculator.dart` utility that computes averages by removing best and worst times
- Create Riverpod providers that subscribe to solves stream and emit computed Ao5, Ao12, Ao50, Ao100
- Providers should filter by current category and cube type selection
- Support both "global" (all solves) and "session" (current session only) calculations
- Mean calculation includes all times; AoX removes best/worst before averaging

**Main Page App Shell**
- Bottom navigation bar with 3 tabs: Timer, Solves List, Statistics
- Horizontal swipe gesture to navigate between tabs (PageView with TabController sync)
- AppBar with: cube type selector (dropdown dialog), category selector (dropdown dialog), drawer toggle
- Drawer for settings and navigation to other pages (Algorithms, Trainer, Theme)
- Platform-aware styling: Material on Android, Cupertino-style tabs on iOS

**Timer Tab (First Sub-tab)**
- Full-screen tap gesture detector for timer start/stop
- Timer states: idle, inspection (optional 15s countdown), ready (holding), running, stopped
- Display current time with large typography (centered, prominent)
- Bottom left info panel: Deviation, Mean, Best time, Solve count
- Bottom right info panel: Ao5, Ao12, Ao50, Ao100 values
- Scramble display at top (generated for current cube type)
- After solve: show action buttons (delete X, no penalty, +2 flag, DNF mark, add comment)
- Cube visualization widget showing scramble state
- Haptic feedback on timer state changes (platform-specific)

**Solves List Tab (Second Sub-tab)**
- Virtualized/paginated list of solve entries for performance (load 20-50 at time)
- Each tile shows: date, time in seconds (with +2/DNF indicators), comment icon if present
- Search/filter functionality by comments
- Tap to expand solve details or long-press for quick actions
- Pull-to-refresh pattern
- Calendar date grouping header

**Statistics Tab (Third Sub-tab)**
- Performance chart (line graph) with multiple data series:
  - White line: actual solve times
  - Dotted line: best time progression (when records were broken)
  - Red line: Ao5 trend
  - Green line: Ao12 trend
- Chart legend with toggleable series visibility
- Statistics table below chart with tabs: Improvement, Average, Other
- Table columns: Metric name, Global value, Session value
- Metrics: Deviation, Ao12, Ao50, Ao100, Best, Count

**Platform-Specific Theme Providers**
- Create `MaterialThemeProvider` for Android and other platforms (Windows, Linux, Web)
- Create `CupertinoThemeProvider` for iOS/macOS with Cupertino-specific overrides
- Both providers consume shared theme state but output platform-appropriate ThemeData/CupertinoThemeData
- Use `platform.provider.dart` to detect current platform and select appropriate theme provider
- Theme selection persisted via shared_preferences (actualThemeIndex, actualTextThemeIndex)

**Color Theme System (24 Preset Themes)**
- `ColorBackgroundPair` model: primaryColor + secondaryColor for gradient backgrounds
- `ColorAppTheme` model: bgPatternColor, appBarColor, bottomBarColor, isDarkmode flag, theme name
- Themes include: Hazy Blues (#1959FF/#3b12ff), Spotty Guy (dark #0D0D0D), Simply White, Bluy Gray, Pixie Falls, Wandy Dusk, Quite Purply, Definitely Purple, Pinky Promises, Earthy Teal, Lightly Skyish, Icy Hills, What Green, Simply Black, Notably Yellow, Turtly Sea, Oof Hot, Relaxing Dawn, Even Purplier, Tantalizing, Delicious Brownie, Greeny Gorilla, Cyanic Teal, Greeny Everest
- Each theme defines isDarkmode to control status bar text color and brightness

**Text Theme System (15 Preset Options)**
- `TextTheme` model: optional colorText (null = auto-contrast), name
- Options: Default (auto), Pessoa (#FF1744), Lou (#FF2A9F), Burgess (#FF4500), Bowie (#E86E60), Brie (#FFD4F9), Matsson (#651FFF), Isakov (#2962FF), Adams (#54FFFF), Irwin (#006B21), Tarkovsky (#00E676), Ebert (#82FFB3), Tolkien (#FFFF4C), Asimov (#FFFDB), Kubrick (#BDBDBD)
- "Default" text theme: auto-compute white/black based on background luminance

**Theme State Management**
- `AppTheme` class tracks: actualThemeIndex, actualTextThemeIndex, statusBarTextColor, isDarkmode
- Riverpod providers: `themeIndexProvider`, `textThemeIndexProvider`, `computedThemeProvider`
- `contrast_calculator.dart` utility to derive readable text color from background luminance
- Real-time preview when selecting themes in theme picker UI

**Algorithms Page (OLL/PLL)**
- Tabbed sections for OLL cases and PLL cases
- Grid view of algorithm cases with visual representation
- Tap case to open detail dialog showing:
  - Case name and recognition tips
  - Multiple algorithm variations
  - Finger trick hints
- Static data stored in repository (JSON or hardcoded)

**Trainer Page (OLL/PLL Practice)**
- Same timer interface as main page but restricted to 3x3 only
- Scramble generator produces OLL-only or PLL-only scrambles based on selection
- Toggle to select which specific cases to practice
- Times recorded under dedicated trainer category
- Statistics shown for trainer sessions separately

**Platform-Specific Behaviors**
- iOS/macOS: CupertinoThemeData with CupertinoColors, segmented controls for bottom nav, haptic engine
- Android/Windows/Linux/Web: Material ThemeData, Material bottom navigation bar, vibration feedback
- `platform.provider.dart` exposes `TargetPlatform` for conditional UI and theme selection
- Gesture detection tuned per platform (touch responsiveness)
- Safe area handling for notches and home indicators
- Status bar brightness derived from theme's isDarkmode flag

## Visual Design

**`planning/visuals/main_tabs_screenshot.png`** (provided image)
- Timer tab: Blue background (#2962FF approximate), white text, large centered time "1.20"
- Scramble notation at top in monospace font
- Light bulb icon and refresh icon near scramble
- Bottom stats layout: left column (Deviation, Mean, Best, Count), right column (Ao5, Ao12, Ao50, Ao100)
- 3D cube visualization showing scrambled state
- Action icons below time: X (delete), circle-slash (no penalty), flag (+2), grid (+comment)
- Bottom nav: timer icon, list icon, chart icon

- Solves tab: Card-based list with date headers (01/03, 02/03, etc.)
- Each card shows time prominently, +2/DNF badge in corner
- Search bar with comment filter and calendar picker
- Settings gear icon in header

- Statistics tab: Line chart with white data line, dotted best-time line, red Ao5, green Ao12
- X-axis: solve index, Y-axis: time in seconds
- Legend: Everything (white), Best (green dot), Ao5 (red), Ao12 (green)
- Table with Improvement/Average/Other tabs
- Rows: Deviation, Ao12, Ao50, Ao100, Best, Count with Global and Session columns

## Existing Code to Leverage

**ideal_structure.md Architecture**
- Follow the defined MVVM folder structure exactly: app/, core/, features/
- Implement providers in features/*/providers/ directories
- Keep DAOs in core/database/daos/
- Use core/utils/ for aox_calculator.dart and statistics_helpers.dart
- Platform abstractions in core/platform/

**cube_timer_oficial/lib/shared/theme/app_theme.dart**
- Reuse `ColorBackgroundPair`, `ColorAppTheme`, `TextTheme` model classes
- Copy the 24 `appColorTheme` preset definitions with all color values
- Copy the 15 `appTextTheme` preset definitions
- Adapt `AppTheme.getTheme()` to return platform-specific ThemeData
- Use Quicksand font family as defined

**Flutter Default Project**
- Fresh project with Material design enabled
- SDK ^3.10.1 compatible
- Standard analysis_options.yaml for linting

## Out of Scope
- User authentication/accounts - no cloud sync
- Online leaderboards or social features
- Bluetooth smart cube integration
- WCA (World Cube Association) official timing compliance
- Multi-language/internationalization in initial release
- Push notifications or reminders
- Export to CSV/file (can be added later)
- Backup/restore functionality
- Competition mode with judging workflow
- Custom cube type creation (only preset cube types supported)

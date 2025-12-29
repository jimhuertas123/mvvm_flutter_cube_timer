# Speedcube Timer

A cross-platform speedcubing timer app built with Flutter, featuring MVVM architecture, Drift local storage, and Riverpod state management.

## Goal

Build a professional speedcubing timer that allows cubers to:
- Time solves with tap-to-start/stop gestures
- Track progress across different cube types and categories
- View computed averages (Ao5, Ao12, Ao50, Ao100) and detailed statistics
- Practice OLL/PLL algorithms with dedicated trainer mode
- Customize the app with 24 color themes and 15 text themes

## Features

### Timer
- Full-screen tap gesture for start/stop timing
- Timer states: idle, inspection, ready, running, stopped
- Large centered time display with haptic feedback
- Scramble generation per cube type
- Action buttons: delete, +2 penalty, DNF, comment
- Real-time statistics panels (Ao5, Ao12, Mean, Best)

### Solves List
- Virtualized/paginated list for performance
- Date grouping headers
- Search/filter by comments
- Quick actions on long-press
- Pull-to-refresh

### Statistics
- Performance chart with multiple data series:
  - Solve times (white line)
  - Best time progression (dotted)
  - Ao5 trend (red line)
  - Ao12 trend (green line)
- Statistics table with Global/Session columns
- Metrics: Deviation, Ao12, Ao50, Ao100, Best, Count

### Algorithms (OLL/PLL)
- Grid view of 57 OLL cases and 21 PLL cases
- Algorithm variations and recognition tips
- Finger trick hints

### Trainer
- Practice specific OLL/PLL cases
- Case-specific scramble generation
- Separate trainer statistics

### Theme System
- 24 preset color themes
- 15 text theme options
- Auto-contrast text color calculation
- Platform-specific theme providers (Material/Cupertino)
- Theme persistence via SharedPreferences

## Tech Stack

| Technology | Purpose |
|------------|---------|
| Flutter 3.x | Cross-platform framework |
| Drift | Local SQLite database with type-safe queries |
| Riverpod | State management (manual providers, no code-gen) |
| fl_chart | Statistics charts |
| SharedPreferences | Theme persistence |
| Vibration | Android haptic feedback |

## Architecture

MVVM (Model-View-ViewModel) architecture with clean separation:

- **Model**: Drift tables and DAOs for data persistence
- **View**: Presentation widgets and pages
- **ViewModel**: Riverpod providers managing business logic and state

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── bootstrap.dart               # Initialization (DB, providers, platform)
│
├── app/                         # App-wide concerns
│   ├── app_shell/               # Main scaffold and navigation
│   │   ├── app_shell_page.dart       # Main scaffold with PageView
│   │   ├── app_shell_appbar.dart     # Cube/category selectors
│   │   ├── app_shell_bottom_nav.dart # Platform-aware bottom nav
│   │   └── app_shell_drawer.dart     # Settings and navigation drawer
│   │
│   ├── app_state/               # Global app state
│   │   ├── platform_provider.dart       # Platform detection
│   │   ├── selected_cube_provider.dart  # Current cube selection
│   │   ├── selected_category_provider.dart
│   │   └── selected_session_provider.dart
│   │
│   ├── navigation/              # Navigation state
│   │   └── tabs_controller_provider.dart
│   │
│   └── theme/                   # Theme system
│       ├── models/
│       │   └── app_theme.dart        # Theme models & 24+15 presets
│       ├── logic/
│       │   └── contrast_calculator.dart
│       └── providers/
│           ├── theme_mode_provider.dart
│           ├── background_color_provider.dart
│           ├── text_color_provider.dart
│           └── computed_contrast_provider.dart
│
├── core/                        # Core utilities and services
│   ├── database/
│   │   ├── app_database.dart         # Drift database definition
│   │   ├── tables/
│   │   │   ├── cubes_table.dart      # 10 preset cube types
│   │   │   ├── categories_table.dart # User categories per cube
│   │   │   ├── sessions_table.dart   # Timing sessions
│   │   │   └── solves_table.dart     # Solve times with penalties
│   │   └── daos/
│   │       ├── cubes_dao.dart
│   │       ├── categories_dao.dart
│   │       ├── sessions_dao.dart
│   │       └── solves_dao.dart
│   │
│   ├── platform/                # Platform abstractions
│   │   ├── haptics.dart              # iOS/Android haptic feedback
│   │   └── gestures.dart             # Timer gesture configuration
│   │
│   └── utils/                   # Calculation utilities
│       ├── time_math.dart            # Time formatting/parsing
│       ├── aox_calculator.dart       # AoX computation
│       └── statistics_helpers.dart   # Mean, deviation, etc.
│
└── features/                    # Feature modules (pending)
    ├── timer/
    │   ├── providers/
    │   └── presentation/
    │       ├── pages/
    │       ├── widgets/
    │       └── gestures/
    │
    ├── solves/
    │   ├── providers/
    │   └── presentation/
    │       ├── pages/
    │       └── widgets/
    │
    ├── statistics/
    │   ├── providers/
    │   └── presentation/
    │       ├── pages/
    │       └── widgets/
    │
    ├── algorithms/
    │   ├── data/
    │   └── presentation/
    │       ├── pages/
    │       └── dialogs/
    │
    └── trainer/
        ├── providers/
        └── presentation/
            ├── pages/
            └── widgets/
```

## Database Schema

### cubes (read-only, pre-seeded)
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key, auto-increment |
| name | TEXT | Cube name (e.g., "3x3", "Pyraminx") |
| icon | TEXT? | Optional icon identifier |

**Pre-seeded cubes:** 2x2, 3x3, 4x4, 5x5, 6x6, 7x7, Pyraminx, Megaminx, Skewb, Square-1

### categories
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key, auto-increment |
| name | TEXT | Category name |
| cube_id | INTEGER | Foreign key to cubes |

### sessions
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key, auto-increment |
| started_at | DATETIME | Session start timestamp |
| cube_id | INTEGER | Foreign key to cubes |
| category_id | INTEGER | Foreign key to categories |

### solves
| Column | Type | Description |
|--------|------|-------------|
| id | INTEGER | Primary key, auto-increment |
| duration | INTEGER | Time in milliseconds |
| timestamp | DATETIME | When solve occurred |
| cube_id | INTEGER | Foreign key to cubes |
| category_id | INTEGER | Foreign key to categories |
| session_id | INTEGER | Foreign key to sessions |
| penalty | INTEGER | Enum: none(0), plus2(1), dnf(2) |
| scramble | TEXT | Scramble notation |
| comment | TEXT? | Optional user comment |

## AoX Calculation

Average of X (AoX) is calculated by:
1. Taking the last X solves
2. Removing the best and worst times
3. Averaging the remaining times

```dart
// Example: Ao5 from times [10.5, 11.2, 9.8, 12.1, 10.9]
// Remove best (9.8) and worst (12.1)
// Average of [10.5, 11.2, 10.9] = 10.87
```

**DNF Handling:**
- 1 DNF in set: DNF counts as worst time, only best is removed
- 2+ DNFs in set: Entire average is DNF (null)

## Theme System

### Color Themes (24 presets)
| Theme | Primary Color | Dark Mode |
|-------|---------------|-----------|
| Hazy Blues | #1959FF | No |
| Spotty Guy | #0D0D0D | Yes |
| Simply White | #FFFFFF | No |
| Bluy Gray | #B0BEC5 | No |
| Pixie Falls | #80CBC4 | No |
| Wandy Dusk | #A1887F | No |
| Quite Purply | #9575CD | No |
| Definitely Purple | #4527A0 | Yes |
| Pinky Promises | #F8BBD0 | No |
| Earthy Teal | #004D40 | Yes |
| Lightly Skyish | #03A9F4 | No |
| Icy Hills | #E0F7FA | No |
| What Green | #7CB342 | No |
| Simply Black | #212121 | Yes |
| Notably Yellow | #FFEB3B | No |
| Turtly Sea | #00897B | Yes |
| Oof Hot | #FF7043 | No |
| Relaxing Dawn | #FFE0B2 | No |
| Even Purplier | #7B1FA2 | Yes |
| Tantalizing | #FF6F00 | No |
| Delicious Brownie | #5D4037 | Yes |
| Greeny Gorilla | #2E7D32 | Yes |
| Cyanic Teal | #00BCD4 | No |
| Greeny Everest | #1B5E20 | Yes |

### Text Themes (15 options)
| Theme | Color | Description |
|-------|-------|-------------|
| Default | Auto | Computed from background luminance |
| Pessoa | #FF1744 | Red accent |
| Lou | #FF2A9F | Pink |
| Burgess | #FF4500 | Orange-red |
| Bowie | #E86E60 | Coral |
| Brie | #FFD4F9 | Light pink |
| Matsson | #651FFF | Purple |
| Isakov | #2962FF | Blue |
| Adams | #54FFFF | Cyan |
| Irwin | #006B21 | Dark green |
| Tarkovsky | #00E676 | Green |
| Ebert | #82FFB3 | Mint |
| Tolkien | #FFFF4C | Yellow |
| Asimov | #FFFDB0 | Cream |
| Kubrick | #BDBDBD | Gray |

## Getting Started

### Prerequisites
- Flutter SDK 3.x
- Dart SDK
- Xcode (for iOS)
- Android Studio (for Android)

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd mvvm_cube_timer

# Install dependencies
flutter pub get

# Generate Drift database code
dart run build_runner build --delete-conflicting-outputs

# Run on iOS simulator
flutter run -d ios

# Run on Android emulator
flutter run -d android
```

### iOS Setup

The project includes SQLite warning suppression in `ios/Podfile`. After pulling, run:

```bash
cd ios && pod install && cd ..
```

## Development Progress

### Task Groups Status

| Group | Description | Status |
|-------|-------------|--------|
| 1 | Project Configuration & Dependencies | Completed |
| 2 | Drift Database & Tables | Completed |
| 3 | Data Access Objects (DAOs) | Completed |
| 4 | Calculation Utilities | Completed |
| 5 | Platform Services | Completed |
| 6 | Theme Models & Data | Completed |
| 7 | Theme Providers & Platform Themes | Completed |
| 8 | App Shell & Navigation | Completed |
| 9 | Timer Feature | Pending |
| 10 | Solves List Feature | Pending |
| 11 | Statistics Feature | Pending |
| 12 | Algorithms & Trainer | Pending |
| 13 | Integration & Testing | Pending |

### Completed (Groups 1-8)
- Project setup with all dependencies
- Drift database with 4 tables and DAOs
- AoX calculator and statistics utilities
- Platform-aware haptic feedback
- 24 color themes + 15 text themes
- Material and Cupertino theme providers
- App shell with bottom navigation
- Cube/category selection system
- Drawer with theme selector

### Pending (Groups 9-13)
- Timer feature with gesture handling
- Solves list with pagination
- Statistics charts with fl_chart
- OLL/PLL algorithms page
- Trainer mode
- Integration tests

## Fonts

The app uses [Quicksand](https://fonts.google.com/specimen/Quicksand) font family.

Font files are located in `assets/fonts/`:
- Quicksand-Light.ttf
- Quicksand-Regular.ttf
- Quicksand-Medium.ttf
- Quicksand-SemiBold.ttf
- Quicksand-Bold.ttf

## Out of Scope

- User authentication/cloud sync
- Online leaderboards
- Bluetooth smart cube integration
- WCA official timing compliance
- Multi-language support (initial release)
- Export to CSV/file
- Custom cube type creation

## License

This project is private and not licensed for public distribution.

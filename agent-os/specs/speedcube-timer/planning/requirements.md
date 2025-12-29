# Requirements: Speedcube Timer App

## Original Description

A complex speedcubing timer app using local data storage with Drift and Riverpod, following MVVM architecture. The app features animations, screen touch detectors, and iOS/Android platform-specific behaviors.

## Data Models

### Three Core Entities:
1. **Solves (Timers)** - Records of time spent solving cubes
2. **Cube Types** - Static, never modifiable, stored in DB for reference
3. **Categories** - Each cube type has categories (default: "normal"), user can add more

### AoX Calculations:
- Ao5, Ao12, Ao50, Ao100 = Average of X solves, removing best and worst times
- These should be computed via subscriptions/streams, not stored
- Mean = simple average of all times

## Main Page Features

### App Bar:
- Category selector button (dialog)
- Cube type selector button (dialog)
- Drawer toggle icon button

### Bottom Navigation (3 tabs with horizontal scroll):
1. **Timer Tab**: Chronometer with Ao5/Ao12/Ao50/Ao100, best time, count, mean, deviation, scramble display
2. **Solves Tab**: Paginated list of times with lazy loading on scroll
3. **Statistics Tab**: Performance chart (white=times, dotted=best progression, red=Ao5, green=Ao12), stats table with Improvement/Average/Other tabs showing deviation, Ao12, Ao50, Ao100, best, count for global and session

### Platform Differences:
- iOS: Separated tab styling (Cupertino)
- Android: Material bottom navigation

## Additional Pages

### B. Theme Changer
- Complex color customization for text and background
- Auto-contrast: if text color unchanged, switch between white/black based on background luminance and dark/light theme

### C. Algorithms Page
- OLL/PLL sections
- Dialog showing different algorithms per case

### D. Trainer Page
- Same as main page but scramble only for OLL/PLL selected cases
- Times registered under category/cube type
- Only available for 3x3 cube

## Architecture Reference
Based on ideal_structure.md with MVVM pattern:
- app/ for global UI shell and shared state
- core/ for database, DAOs, utilities
- features/ for timer, solves, statistics, algorithms, trainer

## Visual Reference
Screenshots provided showing the three main tabs with blue theme background.

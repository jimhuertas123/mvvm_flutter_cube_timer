# Ideal Structure (MVVM architecture)

```cmd
lib/
├─ app/
│   ├─ app_shell/
│   │   ├─ app_shell_page.dart
│   │   ├─ app_shell_appbar.dart
│   │   ├─ app_shell_drawer.dart
│   │   ├─ app_shell_bottom_nav.dart
│   │   └─ app_shell_tabs.dart
│   │
│   ├─ navigation/
│   │   └─ tabs_controller.provider.dart
│   │
│   ├─ app_state/
│   │   ├─ selected_category.provider.dart
│   │   ├─ selected_cube.provider.dart
│   │   ├─ selected_session.provider.dart
│   │   └─ platform.provider.dart
│   │
│   └─ theme/
│       ├─ models/
│       │   └─ app_theme.dart
│       │
│       ├─ providers/
│       │   ├─ theme_mode.provider.dart
│       │   ├─ background_color.provider.dart
│       │   ├─ text_color.provider.dart
│       │   └─ computed_contrast.provider.dart
│       │
│       └─ logic/
│           └─ contrast_calculator.dart
│
├─ core/
│   ├─ database/
│   │   ├─ app_database.dart
│   │   ├─ migrations.dart
│   │   ├─ tables/
│   │   │   ├─ solves_table.dart
│   │   │   ├─ cubes_table.dart
│   │   │   ├─ categories_table.dart
│   │   │   └─ sessions_table.dart
│   │   │
│   │   └─ daos/
│   │       ├─ solves_dao.dart
│   │       ├─ cubes_dao.dart
│   │       ├─ categories_dao.dart
│   │       └─ sessions_dao.dart
│   │
│   ├─ platform/
│   │   ├─ haptics.dart
│   │   └─ gestures.dart
│   │
│   └─ utils/
│       ├─ time_math.dart
│       ├─ aox_calculator.dart
│       └─ statistics_helpers.dart
│
├─ features/
│   ├─ timer/
│   │   ├─ presentation/
│   │   │   ├─ pages/
│   │   │   │   └─ timer_tab_page.dart
│   │   │   │
│   │   │   ├─ widgets/
│   │   │   │   ├─ chronometer.dart
│   │   │   │   ├─ scramble_view.dart
│   │   │   │   ├─ best_time_view.dart
│   │   │   │   ├─ deviation_view.dart
│   │   │   │   └─ aox_summary.dart
│   │   │   │
│   │   │   └─ gestures/
│   │   │       └─ timer_gesture_handler.dart
│   │   │
│   │   └─ providers/
│   │       ├─ timer_state.provider.dart
│   │       └─ scramble.provider.dart
│   │
│   ├─ solves/
│   │   ├─ presentation/
│   │   │   ├─ pages/
│   │   │   │   └─ solves_tab_page.dart
│   │   │   │
│   │   │   └─ widgets/
│   │   │       ├─ solve_tile.dart
│   │   │       └─ solves_virtual_list.dart
│   │   │
│   │   └─ providers/
│   │       ├─ solves_stream.provider.dart
│   │       └─ solves_pagination.provider.dart
│   │
│   ├─ statistics/
│   │   ├─ presentation/
│   │   │   ├─ pages/
│   │   │   │   └─ statistics_tab_page.dart
│   │   │   │
│   │   │   └─ widgets/
│   │   │       ├─ performance_chart.dart
│   │   │       ├─ aox_lines.dart
│   │   │       ├─ stats_table.dart
│   │   │       └─ stats_tabs.dart
│   │   │
│   │   └─ providers/
│   │       ├─ mean.provider.dart
│   │       ├─ ao5.provider.dart
│   │       ├─ ao12.provider.dart
│   │       ├─ ao50.provider.dart
│   │       └─ ao100.provider.dart
│   │
│   ├─ algorithms/
│   │   ├─ data/
│   │   │   └─ algorithms_repository.dart
│   │   │
│   │   └─ presentation/
│   │       ├─ pages/
│   │       │   └─ algorithms_page.dart
│   │       │
│   │       └─ dialogs/
│   │           └─ algorithm_detail_dialog.dart
│   │
│   └─ trainer/
│       ├─ presentation/
│       │   ├─ pages/
│       │   │   └─ trainer_page.dart
│       │   │
│       │   └─ widgets/
│       │       ├─ trainer_timer.dart
│       │       └─ trainer_scramble.dart
│       │
│       └─ providers/
│           └─ trainer_state.provider.dart
│
├─ main.dart
└─ bootstrap.dart
```

# MVVM CONTEXT:

## app/

Global UI shell + shared state:

- Navigation
- Theme
- Category / cube / session selection

PS: Nothing here knows about AoX, solves, or statistics logic.

## core/

Low-level, reusable infrastructure:

- Drift database
- DAOs
- Math helpers (AoX, deviation)
- Platform services

No widgets. No Riverpod UI logic.

## features/

Each feature:

- Owns its UI
- Owns its providers
- Reuses shared data from core

Features talk via shared providers, not directly.

## 🔑 KEY ARCHITECTURAL GUARANTEES (AI reasons)

- ✔ AoX is derived, never stored
- ✔ Drift is the single source of truth
- ✔ UI complexity is isolated
- ✔ Riverpod scales without provider spaghetti
- ✔ iOS / Android differences don’t leak
- ✔ You can add authentication later cleanly

## 🚀 Final reassurance

This structure:

- Is not overkill for your app
- Matches real production Flutter apps
- Will not collapse when you add more features
- Keeps your mental load low even with complex UI

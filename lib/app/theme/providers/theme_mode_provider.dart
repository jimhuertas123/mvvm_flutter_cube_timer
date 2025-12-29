import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvvm_cube_timer/app/theme/models/app_theme.dart';

/// Keys for SharedPreferences
const _themeIndexKey = 'theme_index';
const _textThemeIndexKey = 'text_theme_index';

/// Provider for SharedPreferences instance
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});

/// Notifier for theme index state
class ThemeIndexNotifier extends StateNotifier<int> {
  final SharedPreferences? _prefs;

  ThemeIndexNotifier(this._prefs) : super(_prefs?.getInt(_themeIndexKey) ?? 0);

  void setThemeIndex(int index) {
    if (index >= 0 && index < appColorTheme.length) {
      state = index;
      _prefs?.setInt(_themeIndexKey, index);
    }
  }

  void nextTheme() {
    setThemeIndex((state + 1) % appColorTheme.length);
  }

  void previousTheme() {
    setThemeIndex((state - 1 + appColorTheme.length) % appColorTheme.length);
  }
}

/// Provider for theme index
final themeIndexProvider = StateNotifierProvider<ThemeIndexNotifier, int>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeIndexNotifier(prefs);
});

/// Notifier for text theme index state
class TextThemeIndexNotifier extends StateNotifier<int> {
  final SharedPreferences? _prefs;

  TextThemeIndexNotifier(this._prefs)
      : super(_prefs?.getInt(_textThemeIndexKey) ?? 0);

  void setTextThemeIndex(int index) {
    if (index >= 0 && index < appTextTheme.length) {
      state = index;
      _prefs?.setInt(_textThemeIndexKey, index);
    }
  }

  void nextTextTheme() {
    setTextThemeIndex((state + 1) % appTextTheme.length);
  }

  void previousTextTheme() {
    setTextThemeIndex((state - 1 + appTextTheme.length) % appTextTheme.length);
  }
}

/// Provider for text theme index
final textThemeIndexProvider =
    StateNotifierProvider<TextThemeIndexNotifier, int>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TextThemeIndexNotifier(prefs);
});

/// Provider for current ColorAppTheme
final currentColorThemeProvider = Provider<ColorAppTheme>((ref) {
  final index = ref.watch(themeIndexProvider);
  return appColorTheme[index];
});

/// Provider for current AppTextTheme
final currentTextThemeProvider = Provider<AppTextTheme>((ref) {
  final index = ref.watch(textThemeIndexProvider);
  return appTextTheme[index];
});

/// Provider for complete AppTheme
final appThemeProvider = Provider<AppTheme>((ref) {
  final themeIndex = ref.watch(themeIndexProvider);
  final textThemeIndex = ref.watch(textThemeIndexProvider);
  final colorTheme = appColorTheme[themeIndex];

  return AppTheme(
    actualThemeIndex: themeIndex,
    actualTextThemeIndex: textThemeIndex,
    statusBarTextColor:
        colorTheme.isDarkmode ? Brightness.light : Brightness.dark,
    isDarkmode: colorTheme.isDarkmode,
  );
});

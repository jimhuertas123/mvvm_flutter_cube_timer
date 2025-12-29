import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/app/theme/providers/theme_mode_provider.dart';

/// Provider for primary background color
final primaryBackgroundColorProvider = Provider<Color>((ref) {
  final colorTheme = ref.watch(currentColorThemeProvider);
  return colorTheme.bgPatternColor.primaryColor;
});

/// Provider for secondary background color
final secondaryBackgroundColorProvider = Provider<Color>((ref) {
  final colorTheme = ref.watch(currentColorThemeProvider);
  return colorTheme.bgPatternColor.secondaryColor;
});

/// Provider for app bar color
final appBarColorProvider = Provider<Color>((ref) {
  final colorTheme = ref.watch(currentColorThemeProvider);
  return colorTheme.appBarColor;
});

/// Provider for bottom bar color
final bottomBarColorProvider = Provider<Color>((ref) {
  final colorTheme = ref.watch(currentColorThemeProvider);
  return colorTheme.bottomBarColor;
});

/// Provider for background gradient
final backgroundGradientProvider = Provider<LinearGradient>((ref) {
  final primary = ref.watch(primaryBackgroundColorProvider);
  final secondary = ref.watch(secondaryBackgroundColorProvider);

  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primary, secondary],
  );
});

/// Provider for whether current theme is dark mode
final isDarkModeProvider = Provider<bool>((ref) {
  final colorTheme = ref.watch(currentColorThemeProvider);
  return colorTheme.isDarkmode;
});

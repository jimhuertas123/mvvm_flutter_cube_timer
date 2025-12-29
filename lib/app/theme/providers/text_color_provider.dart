import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/app/theme/providers/theme_mode_provider.dart';

/// Provider for the explicitly selected text color (may be null for auto-contrast)
final selectedTextColorProvider = Provider<Color?>((ref) {
  final textTheme = ref.watch(currentTextThemeProvider);
  return textTheme.colorText;
});

/// Provider to check if using auto-contrast mode
final isAutoContrastProvider = Provider<bool>((ref) {
  final selectedColor = ref.watch(selectedTextColorProvider);
  return selectedColor == null;
});

/// Provider for text theme name
final textThemeNameProvider = Provider<String>((ref) {
  final textTheme = ref.watch(currentTextThemeProvider);
  return textTheme.name;
});

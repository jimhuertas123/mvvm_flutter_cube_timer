import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/app/theme/logic/contrast_calculator.dart';
import 'package:mvvm_cube_timer/app/theme/providers/background_color_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/text_color_provider.dart';

/// Provider for computed/resolved text color
/// Returns the selected text color if set, otherwise computes contrast color
final computedTextColorProvider = Provider<Color>((ref) {
  final selectedColor = ref.watch(selectedTextColorProvider);
  final backgroundColor = ref.watch(primaryBackgroundColorProvider);

  return ContrastCalculator.getTextColor(backgroundColor, selectedColor);
});

/// Provider for secondary text color (slightly transparent)
final secondaryTextColorProvider = Provider<Color>((ref) {
  final primaryColor = ref.watch(computedTextColorProvider);
  return primaryColor.withValues(alpha: 0.7);
});

/// Provider for hint text color (more transparent)
final hintTextColorProvider = Provider<Color>((ref) {
  final primaryColor = ref.watch(computedTextColorProvider);
  return primaryColor.withValues(alpha: 0.5);
});

/// Provider for disabled text color
final disabledTextColorProvider = Provider<Color>((ref) {
  final primaryColor = ref.watch(computedTextColorProvider);
  return primaryColor.withValues(alpha: 0.3);
});

/// Provider for icon color (same as text color)
final iconColorProvider = Provider<Color>((ref) {
  return ref.watch(computedTextColorProvider);
});

/// Provider for divider color
final dividerColorProvider = Provider<Color>((ref) {
  final textColor = ref.watch(computedTextColorProvider);
  return textColor.withValues(alpha: 0.12);
});

/// Provider to check if current contrast meets WCAG AA
final meetsContrastAAProvider = Provider<bool>((ref) {
  final textColor = ref.watch(computedTextColorProvider);
  final backgroundColor = ref.watch(primaryBackgroundColorProvider);
  return ContrastCalculator.meetsWcagAA(textColor, backgroundColor);
});

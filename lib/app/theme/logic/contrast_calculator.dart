import 'package:flutter/material.dart';

/// Utility class for calculating contrast colors
class ContrastCalculator {
  /// Calculate the relative luminance of a color
  /// Using the formula from WCAG 2.0
  static double calculateLuminance(Color color) {
    return color.computeLuminance();
  }

  /// Determine if a color is considered "dark"
  /// Returns true if the color is dark (luminance < 0.5)
  static bool isDarkColor(Color color) {
    return calculateLuminance(color) < 0.5;
  }

  /// Compute the contrast color (white or black) for a given background
  /// Returns white for dark backgrounds, black for light backgrounds
  static Color computeContrastColor(Color backgroundColor) {
    return isDarkColor(backgroundColor) ? Colors.white : Colors.black;
  }

  /// Compute contrast color with custom threshold
  static Color computeContrastColorWithThreshold(
    Color backgroundColor, {
    double threshold = 0.5,
  }) {
    return calculateLuminance(backgroundColor) < threshold
        ? Colors.white
        : Colors.black;
  }

  /// Get the text color based on background and optional override
  /// If overrideColor is null, returns computed contrast color
  static Color getTextColor(Color backgroundColor, Color? overrideColor) {
    return overrideColor ?? computeContrastColor(backgroundColor);
  }

  /// Calculate contrast ratio between two colors
  /// Returns a value between 1 and 21
  static double calculateContrastRatio(Color color1, Color color2) {
    final lum1 = calculateLuminance(color1);
    final lum2 = calculateLuminance(color2);

    final lighter = lum1 > lum2 ? lum1 : lum2;
    final darker = lum1 > lum2 ? lum2 : lum1;

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Check if contrast ratio meets WCAG AA standards (4.5:1 for normal text)
  static bool meetsWcagAA(Color foreground, Color background) {
    return calculateContrastRatio(foreground, background) >= 4.5;
  }

  /// Check if contrast ratio meets WCAG AAA standards (7:1 for normal text)
  static bool meetsWcagAAA(Color foreground, Color background) {
    return calculateContrastRatio(foreground, background) >= 7.0;
  }
}

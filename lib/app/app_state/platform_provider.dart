import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for platform detection
final platformProvider = Provider<TargetPlatform>((ref) {
  if (kIsWeb) {
    return TargetPlatform.android; // Default to Material on web
  }

  if (Platform.isIOS) return TargetPlatform.iOS;
  if (Platform.isMacOS) return TargetPlatform.macOS;
  if (Platform.isAndroid) return TargetPlatform.android;
  if (Platform.isWindows) return TargetPlatform.windows;
  if (Platform.isLinux) return TargetPlatform.linux;
  if (Platform.isFuchsia) return TargetPlatform.fuchsia;

  return TargetPlatform.android; // Default fallback
});

/// Provider to check if using Cupertino (iOS/macOS) style
final isCupertinoProvider = Provider<bool>((ref) {
  final platform = ref.watch(platformProvider);
  return platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
});

/// Provider to check if using Material style
final isMaterialProvider = Provider<bool>((ref) {
  return !ref.watch(isCupertinoProvider);
});

/// Provider for iOS-specific checks
final isIOSProvider = Provider<bool>((ref) {
  return ref.watch(platformProvider) == TargetPlatform.iOS;
});

/// Provider for Android-specific checks
final isAndroidProvider = Provider<bool>((ref) {
  return ref.watch(platformProvider) == TargetPlatform.android;
});

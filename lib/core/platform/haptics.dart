import 'dart:io';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

/// Platform-aware haptic feedback service
class HapticsService {
  static final HapticsService _instance = HapticsService._internal();
  factory HapticsService() => _instance;
  HapticsService._internal();

  bool? _hasVibrator;

  /// Initialize and check vibration capability
  Future<void> init() async {
    if (Platform.isAndroid) {
      _hasVibrator = await Vibration.hasVibrator();
    }
  }

  /// Light impact feedback - for timer ready state
  Future<void> lightImpact() async {
    if (Platform.isIOS) {
      await HapticFeedback.lightImpact();
    } else if (Platform.isAndroid && _hasVibrator == true) {
      await Vibration.vibrate(duration: 10, amplitude: 64);
    }
  }

  /// Medium impact feedback - for timer start/stop
  Future<void> mediumImpact() async {
    if (Platform.isIOS) {
      await HapticFeedback.mediumImpact();
    } else if (Platform.isAndroid && _hasVibrator == true) {
      await Vibration.vibrate(duration: 20, amplitude: 128);
    }
  }

  /// Heavy impact feedback - for important actions
  Future<void> heavyImpact() async {
    if (Platform.isIOS) {
      await HapticFeedback.heavyImpact();
    } else if (Platform.isAndroid && _hasVibrator == true) {
      await Vibration.vibrate(duration: 30, amplitude: 255);
    }
  }

  /// Selection click feedback - for UI selections
  Future<void> selectionClick() async {
    if (Platform.isIOS) {
      await HapticFeedback.selectionClick();
    } else if (Platform.isAndroid && _hasVibrator == true) {
      await Vibration.vibrate(duration: 5, amplitude: 32);
    }
  }

  /// Error/warning feedback
  Future<void> error() async {
    if (Platform.isIOS) {
      await HapticFeedback.heavyImpact();
    } else if (Platform.isAndroid && _hasVibrator == true) {
      await Vibration.vibrate(pattern: [0, 50, 50, 50], intensities: [0, 200, 0, 200]);
    }
  }
}

/// Global haptics instance
final haptics = HapticsService();

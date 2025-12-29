import 'dart:io';

/// Timer gesture configuration constants
class TimerGestureConfig {
  /// Duration to hold before timer is ready to start (milliseconds)
  static int get holdDuration {
    if (Platform.isIOS) {
      return 300; // iOS tends to have faster touch response
    }
    return 350; // Android/other platforms
  }

  /// Minimum tap duration to register as a tap vs accidental touch
  static int get minTapDuration => 50;

  /// Maximum duration for a double-tap gesture
  static int get doubleTapWindow => 300;

  /// Debounce duration for rapid taps
  static int get debounceMilliseconds => 100;

  /// Whether to use long press detection
  static bool get useLongPress => true;

  /// Touch feedback delay
  static int get feedbackDelay {
    if (Platform.isIOS) {
      return 0; // iOS haptics are immediate
    }
    return 10; // Small delay for Android
  }
}

/// Gesture state for timer
enum TimerGestureState {
  /// No touch active
  idle,

  /// Touch started, waiting for hold duration
  touching,

  /// Held long enough, ready to start timer
  ready,

  /// Touch released after ready, timer should start
  starting,

  /// Timer is running
  running,
}

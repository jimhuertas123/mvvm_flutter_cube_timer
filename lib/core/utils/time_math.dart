/// Format milliseconds to display string (e.g., "12.34")
String formatTime(int milliseconds) {
  if (milliseconds < 0) return '--';

  final totalSeconds = milliseconds / 1000;
  final seconds = totalSeconds.floor();
  final centiseconds = ((totalSeconds - seconds) * 100).round();

  if (seconds < 60) {
    return '$seconds.${centiseconds.toString().padLeft(2, '0')}';
  }

  return formatTimeWithMinutes(milliseconds);
}

/// Format milliseconds with minutes (e.g., "1:23.45")
String formatTimeWithMinutes(int milliseconds) {
  if (milliseconds < 0) return '--';

  final totalSeconds = milliseconds / 1000;
  final minutes = (totalSeconds / 60).floor();
  final seconds = (totalSeconds % 60).floor();
  final centiseconds = ((totalSeconds - totalSeconds.floor()) * 100).round();

  if (minutes > 0) {
    return '$minutes:${seconds.toString().padLeft(2, '0')}.${centiseconds.toString().padLeft(2, '0')}';
  }

  return '$seconds.${centiseconds.toString().padLeft(2, '0')}';
}

/// Parse time string to milliseconds
/// Supports formats: "12.34", "1:23.45"
int? parseTime(String timeString) {
  try {
    final trimmed = timeString.trim();
    if (trimmed.isEmpty || trimmed == '--') return null;

    if (trimmed.contains(':')) {
      // Format: "M:SS.cc" or "MM:SS.cc"
      final parts = trimmed.split(':');
      final minutes = int.parse(parts[0]);
      final secondsParts = parts[1].split('.');
      final seconds = int.parse(secondsParts[0]);
      final centiseconds = secondsParts.length > 1
          ? int.parse(secondsParts[1].padRight(2, '0').substring(0, 2))
          : 0;

      return (minutes * 60 * 1000) + (seconds * 1000) + (centiseconds * 10);
    } else {
      // Format: "SS.cc"
      final parts = trimmed.split('.');
      final seconds = int.parse(parts[0]);
      final centiseconds = parts.length > 1
          ? int.parse(parts[1].padRight(2, '0').substring(0, 2))
          : 0;

      return (seconds * 1000) + (centiseconds * 10);
    }
  } catch (_) {
    return null;
  }
}

/// Format milliseconds for display with penalty
String formatTimeWithPenalty(int milliseconds, bool isPlusTwo, bool isDnf) {
  if (isDnf) return 'DNF';

  final displayTime = isPlusTwo ? milliseconds + 2000 : milliseconds;
  final formatted = formatTime(displayTime);

  return isPlusTwo ? '$formatted+' : formatted;
}

/// Get effective time considering penalty
int getEffectiveTime(int milliseconds, bool isPlusTwo, bool isDnf) {
  if (isDnf) return -1; // DNF represented as -1
  return isPlusTwo ? milliseconds + 2000 : milliseconds;
}

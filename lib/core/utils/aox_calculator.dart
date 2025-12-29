// Calculator for Average of X (AoX) statistics
//
// AoX calculation: Take the last X solves, remove the best and worst times,
// then calculate the mean of the remaining times.

/// Calculate AoX from a list of times (in milliseconds)
/// Returns null if there are not enough times
///
/// [times] - List of solve times in milliseconds (DNF = -1)
/// [x] - Number of solves to include in average
double? calculateAoX(List<int> times, int x) {
  if (times.length < x) return null;

  // Take the last X times
  final lastX = times.sublist(times.length - x);

  // Count DNFs (-1 values)
  final dnfCount = lastX.where((t) => t < 0).length;

  // If more than 1 DNF, the average is DNF (return null)
  if (dnfCount > 1) return null;

  // Filter out DNFs for sorting, but handle single DNF as worst time
  final validTimes = lastX.where((t) => t >= 0).toList();

  if (validTimes.isEmpty) return null;

  // Sort valid times
  validTimes.sort();

  if (dnfCount == 1) {
    // Single DNF counts as worst time, remove only the best
    // Remove the best time (first after sorting)
    final trimmed = validTimes.sublist(1);
    if (trimmed.isEmpty) return null;
    return trimmed.reduce((a, b) => a + b) / trimmed.length;
  } else {
    // No DNFs - remove best and worst
    if (validTimes.length <= 2) return null;
    final trimmed = validTimes.sublist(1, validTimes.length - 1);
    return trimmed.reduce((a, b) => a + b) / trimmed.length;
  }
}

/// Calculate Ao5
double? calculateAo5(List<int> times) => calculateAoX(times, 5);

/// Calculate Ao12
double? calculateAo12(List<int> times) => calculateAoX(times, 12);

/// Calculate Ao50
double? calculateAo50(List<int> times) => calculateAoX(times, 50);

/// Calculate Ao100
double? calculateAo100(List<int> times) => calculateAoX(times, 100);

/// Calculate AoX at each point for trend line
/// Returns a list of AoX values for each point where enough data exists
List<double?> calculateAoXTrend(List<int> times, int x) {
  final result = <double?>[];

  for (int i = 0; i < times.length; i++) {
    if (i + 1 < x) {
      result.add(null);
    } else {
      final subset = times.sublist(0, i + 1);
      result.add(calculateAoX(subset, x));
    }
  }

  return result;
}

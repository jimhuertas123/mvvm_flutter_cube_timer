import 'dart:math';

/// Helper functions for statistics calculations

/// Calculate the mean (simple average) of times
/// Returns null if list is empty
/// DNF times (negative values) are excluded
double? calculateMean(List<int> times) {
  final validTimes = times.where((t) => t >= 0).toList();
  if (validTimes.isEmpty) return null;

  final sum = validTimes.reduce((a, b) => a + b);
  return sum / validTimes.length;
}

/// Calculate standard deviation of times
/// Returns null if list has less than 2 valid times
double? calculateDeviation(List<int> times) {
  final validTimes = times.where((t) => t >= 0).toList();
  if (validTimes.length < 2) return null;

  final mean = calculateMean(validTimes);
  if (mean == null) return null;

  final squaredDiffs = validTimes.map((t) => pow(t - mean, 2));
  final variance = squaredDiffs.reduce((a, b) => a + b) / validTimes.length;

  return sqrt(variance);
}

/// Find the best (minimum) time, excluding DNFs
int? findBestTime(List<int> times) {
  final validTimes = times.where((t) => t >= 0).toList();
  if (validTimes.isEmpty) return null;

  return validTimes.reduce((a, b) => a < b ? a : b);
}

/// Find the worst (maximum) time, excluding DNFs
int? findWorstTime(List<int> times) {
  final validTimes = times.where((t) => t >= 0).toList();
  if (validTimes.isEmpty) return null;

  return validTimes.reduce((a, b) => a > b ? a : b);
}

/// Calculate best time progression
/// Returns list of indices where a new best time was achieved
List<int> calculateBestProgression(List<int> times) {
  final progression = <int>[];
  int? currentBest;

  for (int i = 0; i < times.length; i++) {
    final time = times[i];
    if (time < 0) continue; // Skip DNF

    if (currentBest == null || time < currentBest) {
      currentBest = time;
      progression.add(i);
    }
  }

  return progression;
}

/// Get best times at each point for chart
/// Returns the best time achieved up to each point
List<int?> getBestTimesAtEachPoint(List<int> times) {
  final result = <int?>[];
  int? currentBest;

  for (int i = 0; i < times.length; i++) {
    final time = times[i];
    if (time >= 0 && (currentBest == null || time < currentBest)) {
      currentBest = time;
    }
    result.add(currentBest);
  }

  return result;
}

/// Count valid solves (excluding DNF)
int countValidSolves(List<int> times) {
  return times.where((t) => t >= 0).length;
}

/// Count DNF solves
int countDnfSolves(List<int> times) {
  return times.where((t) => t < 0).length;
}

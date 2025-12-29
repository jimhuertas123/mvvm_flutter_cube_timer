import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/bootstrap.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';
import 'package:mvvm_cube_timer/app/app_state/selected_cube_provider.dart';
import 'package:mvvm_cube_timer/app/app_state/selected_category_provider.dart';

/// Notifier for current session state
class CurrentSessionNotifier extends StateNotifier<Session?> {
  final AppDatabase _db;
  final int? _cubeId;
  final int? _categoryId;

  CurrentSessionNotifier(this._db, this._cubeId, this._categoryId) : super(null) {
    if (_cubeId != null && _categoryId != null) {
      _initOrCreateSession();
    }
  }

  Future<void> _initOrCreateSession() async {
    final cubeId = _cubeId;
    final categoryId = _categoryId;
    if (cubeId == null || categoryId == null) return;

    // Try to get the most recent session
    var session = await _db.sessionsDao.getMostRecentSession(cubeId, categoryId);

    // If no session exists, create one
    if (session == null) {
      final sessionId = await _db.sessionsDao.createSession(cubeId, categoryId);
      session = await _db.sessionsDao.getSessionById(sessionId);
    }

    state = session;
  }

  /// Create a new session (for manual session reset)
  Future<void> createNewSession() async {
    final cubeId = _cubeId;
    final categoryId = _categoryId;
    if (cubeId == null || categoryId == null) return;

    final sessionId = await _db.sessionsDao.createSession(cubeId, categoryId);
    final session = await _db.sessionsDao.getSessionById(sessionId);
    state = session;
  }
}

/// Provider for current session
/// Automatically updates when cube or category changes
final currentSessionProvider =
    StateNotifierProvider<CurrentSessionNotifier, Session?>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final cube = ref.watch(selectedCubeProvider);
  final category = ref.watch(selectedCategoryProvider);

  return CurrentSessionNotifier(db, cube?.id, category?.id);
});

/// Provider to create a new session
final newSessionProvider = Provider<Future<void> Function()>((ref) {
  final notifier = ref.watch(currentSessionProvider.notifier);
  return notifier.createNewSession;
});

import 'package:drift/drift.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';
import 'package:mvvm_cube_timer/core/database/tables/sessions_table.dart';

part 'sessions_dao.g.dart';

@DriftAccessor(tables: [Sessions])
class SessionsDao extends DatabaseAccessor<AppDatabase> with _$SessionsDaoMixin {
  SessionsDao(super.db);

  /// Create a new session
  Future<int> createSession(int cubeId, int categoryId) {
    return into(sessions).insert(SessionsCompanion.insert(
      cubeId: cubeId,
      categoryId: categoryId,
    ));
  }

  /// Get session by ID
  Future<Session?> getSessionById(int id) {
    return (select(sessions)..where((s) => s.id.equals(id))).getSingleOrNull();
  }

  /// Get the most recent session for a cube/category
  Future<Session?> getMostRecentSession(int cubeId, int categoryId) {
    return (select(sessions)
      ..where((s) => s.cubeId.equals(cubeId) & s.categoryId.equals(categoryId))
      ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
      ..limit(1))
      .getSingleOrNull();
  }

  /// Watch the most recent session
  Stream<Session?> watchMostRecentSession(int cubeId, int categoryId) {
    return (select(sessions)
      ..where((s) => s.cubeId.equals(cubeId) & s.categoryId.equals(categoryId))
      ..orderBy([(s) => OrderingTerm.desc(s.startedAt)])
      ..limit(1))
      .watchSingleOrNull();
  }

  /// Get all sessions for a cube/category
  Future<List<Session>> getSessionsForCubeCategory(int cubeId, int categoryId) {
    return (select(sessions)
      ..where((s) => s.cubeId.equals(cubeId) & s.categoryId.equals(categoryId))
      ..orderBy([(s) => OrderingTerm.desc(s.startedAt)]))
      .get();
  }
}

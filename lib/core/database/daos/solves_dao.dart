import 'package:drift/drift.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';
import 'package:mvvm_cube_timer/core/database/tables/solves_table.dart';

part 'solves_dao.g.dart';

@DriftAccessor(tables: [Solves])
class SolvesDao extends DatabaseAccessor<AppDatabase> with _$SolvesDaoMixin {
  SolvesDao(super.db);

  /// Insert a new solve
  Future<int> insertSolve({
    required int duration,
    required int cubeId,
    required int categoryId,
    required String scramble,
    int? sessionId,
    SolvePenalty penalty = SolvePenalty.none,
    String? comment,
  }) {
    return into(solves).insert(SolvesCompanion.insert(
      duration: duration,
      cubeId: cubeId,
      categoryId: categoryId,
      scramble: scramble,
      sessionId: Value(sessionId),
      penalty: Value(penalty),
      comment: Value(comment),
    ));
  }

  /// Update an existing solve
  Future<bool> updateSolve(Solve solve) {
    return update(solves).replace(solve);
  }

  /// Update solve penalty
  Future<int> updatePenalty(int solveId, SolvePenalty penalty) {
    return (update(solves)..where((s) => s.id.equals(solveId)))
        .write(SolvesCompanion(penalty: Value(penalty)));
  }

  /// Update solve comment
  Future<int> updateComment(int solveId, String? comment) {
    return (update(solves)..where((s) => s.id.equals(solveId)))
        .write(SolvesCompanion(comment: Value(comment)));
  }

  /// Delete a solve
  Future<int> deleteSolve(int id) {
    return (delete(solves)..where((s) => s.id.equals(id))).go();
  }

  /// Watch solves for a cube/category (ordered by timestamp desc)
  Stream<List<Solve>> watchSolves(int cubeId, int categoryId) {
    return (select(solves)
      ..where((s) => s.cubeId.equals(cubeId) & s.categoryId.equals(categoryId))
      ..orderBy([(s) => OrderingTerm.desc(s.timestamp)]))
      .watch();
  }

  /// Watch solves for a specific session
  Stream<List<Solve>> watchSessionSolves(int sessionId) {
    return (select(solves)
      ..where((s) => s.sessionId.equals(sessionId))
      ..orderBy([(s) => OrderingTerm.desc(s.timestamp)]))
      .watch();
  }

  /// Get solves count for a cube/category
  Future<int> getSolvesCount(int cubeId, int categoryId) async {
    final count = countAll();
    final query = selectOnly(solves)
      ..addColumns([count])
      ..where(solves.cubeId.equals(cubeId) & solves.categoryId.equals(categoryId));
    final result = await query.getSingle();
    return result.read(count) ?? 0;
  }

  /// Get paginated solves
  Future<List<Solve>> getSolvesPaginated(
    int cubeId,
    int categoryId, {
    required int limit,
    required int offset,
  }) {
    return (select(solves)
      ..where((s) => s.cubeId.equals(cubeId) & s.categoryId.equals(categoryId))
      ..orderBy([(s) => OrderingTerm.desc(s.timestamp)])
      ..limit(limit, offset: offset))
      .get();
  }

  /// Get all solves for a cube/category (for statistics)
  Future<List<Solve>> getAllSolves(int cubeId, int categoryId) {
    return (select(solves)
      ..where((s) => s.cubeId.equals(cubeId) & s.categoryId.equals(categoryId))
      ..orderBy([(s) => OrderingTerm.asc(s.timestamp)]))
      .get();
  }

  /// Get the best solve (excluding DNF)
  Future<Solve?> getBestSolve(int cubeId, int categoryId) {
    return (select(solves)
      ..where((s) =>
          s.cubeId.equals(cubeId) &
          s.categoryId.equals(categoryId) &
          s.penalty.equals(SolvePenalty.dnf.index).not())
      ..orderBy([(s) => OrderingTerm.asc(s.duration)])
      ..limit(1))
      .getSingleOrNull();
  }

  /// Search solves by comment
  Stream<List<Solve>> searchByComment(int cubeId, int categoryId, String query) {
    return (select(solves)
      ..where((s) =>
          s.cubeId.equals(cubeId) &
          s.categoryId.equals(categoryId) &
          s.comment.like('%$query%'))
      ..orderBy([(s) => OrderingTerm.desc(s.timestamp)]))
      .watch();
  }
}

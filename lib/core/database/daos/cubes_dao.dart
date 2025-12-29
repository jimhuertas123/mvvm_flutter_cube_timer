import 'package:drift/drift.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';
import 'package:mvvm_cube_timer/core/database/tables/cubes_table.dart';

part 'cubes_dao.g.dart';

@DriftAccessor(tables: [Cubes])
class CubesDao extends DatabaseAccessor<AppDatabase> with _$CubesDaoMixin {
  CubesDao(super.db);

  /// Get all cubes (read-only, pre-seeded data)
  Future<List<Cube>> getAllCubes() => select(cubes).get();

  /// Watch all cubes as a stream
  Stream<List<Cube>> watchAllCubes() => select(cubes).watch();

  /// Get a single cube by ID
  Future<Cube?> getCubeById(int id) {
    return (select(cubes)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Get cube by name
  Future<Cube?> getCubeByName(String name) {
    return (select(cubes)..where((c) => c.name.equals(name))).getSingleOrNull();
  }
}

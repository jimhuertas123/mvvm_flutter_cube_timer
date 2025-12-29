import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/bootstrap.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';

/// Notifier for selected cube state
class SelectedCubeNotifier extends StateNotifier<Cube?> {
  final AppDatabase _db;

  SelectedCubeNotifier(this._db) : super(null) {
    _initDefaultCube();
  }

  Future<void> _initDefaultCube() async {
    // Default to 3x3 cube
    final cube = await _db.cubesDao.getCubeByName('3x3');
    if (cube != null && state == null) {
      state = cube;
    }
  }

  void selectCube(Cube cube) {
    state = cube;
  }

  Future<void> selectCubeById(int id) async {
    final cube = await _db.cubesDao.getCubeById(id);
    if (cube != null) {
      state = cube;
    }
  }
}

/// Provider for selected cube
final selectedCubeProvider =
    StateNotifierProvider<SelectedCubeNotifier, Cube?>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SelectedCubeNotifier(db);
});

/// Provider for all available cubes
final allCubesProvider = FutureProvider<List<Cube>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.cubesDao.getAllCubes();
});

/// Stream provider for all cubes (reactive)
final cubesStreamProvider = StreamProvider<List<Cube>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.cubesDao.watchAllCubes();
});

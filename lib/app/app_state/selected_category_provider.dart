import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/bootstrap.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';
import 'package:mvvm_cube_timer/app/app_state/selected_cube_provider.dart';

/// Notifier for selected category state
class SelectedCategoryNotifier extends StateNotifier<Category?> {
  final AppDatabase _db;
  final int? _cubeId;

  SelectedCategoryNotifier(this._db, this._cubeId) : super(null) {
    if (_cubeId != null) {
      _initDefaultCategory();
    }
  }

  Future<void> _initDefaultCategory() async {
    if (_cubeId == null) return;

    final category = await _db.categoriesDao.getDefaultCategory(_cubeId);
    if (category != null && state == null) {
      state = category;
    }
  }

  void selectCategory(Category category) {
    state = category;
  }

  Future<void> selectCategoryById(int id) async {
    final category = await _db.categoriesDao.getCategoryById(id);
    if (category != null) {
      state = category;
    }
  }

  Future<void> resetToDefault() async {
    if (_cubeId == null) return;
    final category = await _db.categoriesDao.getDefaultCategory(_cubeId);
    state = category;
  }
}

/// Provider for selected category
/// Automatically resets when cube changes
final selectedCategoryProvider =
    StateNotifierProvider<SelectedCategoryNotifier, Category?>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final cube = ref.watch(selectedCubeProvider);

  return SelectedCategoryNotifier(db, cube?.id);
});

/// Provider for categories of the selected cube
final categoriesForSelectedCubeProvider = StreamProvider<List<Category>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final cube = ref.watch(selectedCubeProvider);

  if (cube == null) {
    return Stream.value([]);
  }

  return db.categoriesDao.watchCategories(cube.id);
});

/// Provider for adding a new category
final addCategoryProvider = Provider<Future<void> Function(String name)>((ref) {
  final db = ref.watch(appDatabaseProvider);
  final cube = ref.watch(selectedCubeProvider);

  return (String name) async {
    if (cube == null) return;
    await db.categoriesDao.addCategory(name, cube.id);
  };
});

import 'package:drift/drift.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';
import 'package:mvvm_cube_timer/core/database/tables/categories_table.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase> with _$CategoriesDaoMixin {
  CategoriesDao(super.db);

  /// Watch categories for a specific cube
  Stream<List<Category>> watchCategories(int cubeId) {
    return (select(categories)..where((c) => c.cubeId.equals(cubeId))).watch();
  }

  /// Get all categories for a cube
  Future<List<Category>> getCategoriesForCube(int cubeId) {
    return (select(categories)..where((c) => c.cubeId.equals(cubeId))).get();
  }

  /// Get the default category for a cube
  Future<Category?> getDefaultCategory(int cubeId) {
    return (select(categories)
      ..where((c) => c.cubeId.equals(cubeId) & c.name.equals(defaultCategoryName)))
      .getSingleOrNull();
  }

  /// Add a new category
  Future<int> addCategory(String name, int cubeId) {
    return into(categories).insert(CategoriesCompanion.insert(
      name: name,
      cubeId: cubeId,
    ));
  }

  /// Delete a category by ID
  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((c) => c.id.equals(id))).go();
  }

  /// Get category by ID
  Future<Category?> getCategoryById(int id) {
    return (select(categories)..where((c) => c.id.equals(id))).getSingleOrNull();
  }
}

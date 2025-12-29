import 'package:drift/drift.dart';
import 'package:mvvm_cube_timer/core/database/tables/cubes_table.dart';

/// Table for solve categories per cube type
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get cubeId => integer().references(Cubes, #id)();
}

/// Default category name
const String defaultCategoryName = 'normal';

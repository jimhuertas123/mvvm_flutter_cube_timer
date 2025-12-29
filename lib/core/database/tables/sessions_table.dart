import 'package:drift/drift.dart';
import 'package:mvvm_cube_timer/core/database/tables/cubes_table.dart';
import 'package:mvvm_cube_timer/core/database/tables/categories_table.dart';

/// Table for timing sessions
class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get startedAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get cubeId => integer().references(Cubes, #id)();
  IntColumn get categoryId => integer().references(Categories, #id)();
}

import 'package:drift/drift.dart';
import 'package:mvvm_cube_timer/core/database/tables/cubes_table.dart';
import 'package:mvvm_cube_timer/core/database/tables/categories_table.dart';
import 'package:mvvm_cube_timer/core/database/tables/sessions_table.dart';

/// Penalty types for solves
enum SolvePenalty {
  none,
  plus2,
  dnf,
}

/// Table for solve times
class Solves extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// Duration in milliseconds
  IntColumn get duration => integer()();

  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();

  IntColumn get cubeId => integer().references(Cubes, #id)();
  IntColumn get categoryId => integer().references(Categories, #id)();
  IntColumn get sessionId => integer().references(Sessions, #id).nullable()();

  /// Penalty type: 0 = none, 1 = +2, 2 = DNF
  IntColumn get penalty => intEnum<SolvePenalty>().withDefault(Constant(SolvePenalty.none.index))();

  TextColumn get scramble => text()();
  TextColumn get comment => text().nullable()();
}

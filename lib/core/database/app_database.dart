import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'package:mvvm_cube_timer/core/database/tables/cubes_table.dart';
import 'package:mvvm_cube_timer/core/database/tables/categories_table.dart';
import 'package:mvvm_cube_timer/core/database/tables/sessions_table.dart';
import 'package:mvvm_cube_timer/core/database/tables/solves_table.dart';

import 'package:mvvm_cube_timer/core/database/daos/cubes_dao.dart';
import 'package:mvvm_cube_timer/core/database/daos/categories_dao.dart';
import 'package:mvvm_cube_timer/core/database/daos/sessions_dao.dart';
import 'package:mvvm_cube_timer/core/database/daos/solves_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Cubes, Categories, Sessions, Solves],
  daos: [CubesDao, CategoriesDao, SessionsDao, SolvesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle future migrations here
      },
    );
  }

  /// Seeds initial data (cube types and default categories)
  Future<void> seedInitialData() async {
    // Check if cubes already exist
    final existingCubes = await cubesDao.getAllCubes();
    if (existingCubes.isNotEmpty) return;

    // Seed cube types
    await batch((batch) {
      batch.insertAll(
        cubes,
        seedCubes.map((c) => CubesCompanion.insert(
          name: c['name'] as String,
          icon: Value(c['icon'] as String?),
        )).toList(),
      );
    });

    // Seed default categories for each cube
    final allCubes = await cubesDao.getAllCubes();
    await batch((batch) {
      batch.insertAll(
        categories,
        allCubes.map((cube) => CategoriesCompanion.insert(
          name: defaultCategoryName,
          cubeId: cube.id,
        )).toList(),
      );
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'speedcube_timer.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

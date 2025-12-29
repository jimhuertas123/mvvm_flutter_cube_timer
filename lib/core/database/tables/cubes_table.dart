import 'package:drift/drift.dart';

/// Table for cube types (static, pre-seeded data)
class Cubes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get icon => text().nullable()();
}

/// Pre-defined cube types
const List<Map<String, dynamic>> seedCubes = [
  {'id': 1, 'name': '2x2', 'icon': null},
  {'id': 2, 'name': '3x3', 'icon': null},
  {'id': 3, 'name': '4x4', 'icon': null},
  {'id': 4, 'name': '5x5', 'icon': null},
  {'id': 5, 'name': '6x6', 'icon': null},
  {'id': 6, 'name': '7x7', 'icon': null},
  {'id': 7, 'name': 'Pyraminx', 'icon': null},
  {'id': 8, 'name': 'Megaminx', 'icon': null},
  {'id': 9, 'name': 'Skewb', 'icon': null},
  {'id': 10, 'name': 'Square-1', 'icon': null},
];

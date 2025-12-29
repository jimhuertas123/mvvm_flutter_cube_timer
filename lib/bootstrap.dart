import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';
import 'package:mvvm_cube_timer/core/platform/haptics.dart';
import 'package:mvvm_cube_timer/app/theme/providers/theme_mode_provider.dart';

/// Initializes the app and returns the ProviderContainer with overrides
Future<ProviderContainer> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize haptics
  await haptics.init();

  // Initialize SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Initialize database
  final database = AppDatabase();

  // Seed initial data if needed
  await database.seedInitialData();

  final container = ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );

  return container;
}

/// Provider for the app database
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Database must be overridden in bootstrap');
});

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/bootstrap.dart';
import 'package:mvvm_cube_timer/app/app_shell/app_shell_page.dart';
import 'package:mvvm_cube_timer/app/theme/providers/theme_mode_provider.dart';

void main() async {
  final container = await bootstrap();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SpeedcubeTimerApp(),
    ),
  );
}

class SpeedcubeTimerApp extends ConsumerWidget {
  const SpeedcubeTimerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(appThemeProvider);

    return MaterialApp(
      title: 'Speedcube Timer',
      debugShowCheckedModeBanner: false,
      theme: appTheme.getTheme(),
      home: const AppShellPage(),
    );
  }
}

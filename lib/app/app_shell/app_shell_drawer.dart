import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/app/theme/providers/theme_mode_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/background_color_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/computed_contrast_provider.dart';
import 'package:mvvm_cube_timer/app/theme/models/app_theme.dart';

/// App drawer with navigation and settings
class AppShellDrawer extends ConsumerWidget {
  const AppShellDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = ref.watch(primaryBackgroundColorProvider);
    final textColor = ref.watch(computedTextColorProvider);

    return Drawer(
      backgroundColor: primaryColor,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Speedcube Timer',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Track your progress',
                    style: TextStyle(
                      color: textColor.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: 1),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _DrawerItem(
                    icon: Icons.school_outlined,
                    label: 'Algorithms',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: Navigate to Algorithms page
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.fitness_center_outlined,
                    label: 'Trainer',
                    onTap: () {
                      Navigator.of(context).pop();
                      // TODO: Navigate to Trainer page
                    },
                  ),
                  const Divider(),
                  _DrawerItem(
                    icon: Icons.palette_outlined,
                    label: 'Theme',
                    onTap: () {
                      Navigator.of(context).pop();
                      _showThemeSelector(context, ref);
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.text_fields_outlined,
                    label: 'Text Color',
                    onTap: () {
                      Navigator.of(context).pop();
                      _showTextThemeSelector(context, ref);
                    },
                  ),
                ],
              ),
            ),

            // Theme preview at bottom
            const Divider(height: 1),
            _ThemePreview(),
          ],
        ),
      ),
    );
  }

  void _showThemeSelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _ThemeSelectorSheet(),
    );
  }

  void _showTextThemeSelector(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _TextThemeSelectorSheet(),
    );
  }
}

/// Single drawer item
class _DrawerItem extends ConsumerWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textColor = ref.watch(computedTextColorProvider);

    return ListTile(
      leading: Icon(icon, color: textColor),
      title: Text(
        label,
        style: TextStyle(color: textColor),
      ),
      onTap: onTap,
    );
  }
}

/// Theme preview widget
class _ThemePreview extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorTheme = ref.watch(currentColorThemeProvider);
    final textTheme = ref.watch(currentTextThemeProvider);
    final textColor = ref.watch(computedTextColorProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Color theme preview
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorTheme.bgPatternColor.primaryColor,
                  colorTheme.bgPatternColor.secondaryColor,
                ],
              ),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: textColor.withValues(alpha: 0.3)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  colorTheme.name.replaceAll('\n', ' '),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Text: ${textTheme.name}',
                  style: TextStyle(
                    color: textColor.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Theme selector bottom sheet
class _ThemeSelectorSheet extends ConsumerWidget {
  const _ThemeSelectorSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(themeIndexProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Theme',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: appColorTheme.length,
              itemBuilder: (context, index) {
                final theme = appColorTheme[index];
                final isSelected = index == currentIndex;

                return GestureDetector(
                  onTap: () {
                    ref.read(themeIndexProvider.notifier).setThemeIndex(index);
                    Navigator.of(context).pop();
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              theme.bgPatternColor.primaryColor,
                              theme.bgPatternColor.secondaryColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.blue : Colors.grey[300]!,
                            width: isSelected ? 3 : 1,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.white)
                            : null,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        theme.name.replaceAll('\n', ' '),
                        style: const TextStyle(fontSize: 10),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Text theme selector bottom sheet
class _TextThemeSelectorSheet extends ConsumerWidget {
  const _TextThemeSelectorSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(textThemeIndexProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Select Text Color',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: appTextTheme.length,
              itemBuilder: (context, index) {
                final textTheme = appTextTheme[index];
                final isSelected = index == currentIndex;

                return ListTile(
                  leading: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: textTheme.colorText ?? Colors.grey[300],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[400]!),
                    ),
                    child: textTheme.colorText == null
                        ? const Icon(Icons.auto_awesome, size: 16)
                        : null,
                  ),
                  title: Text(textTheme.name),
                  subtitle: textTheme.colorText == null
                      ? const Text('Auto contrast')
                      : null,
                  trailing: isSelected
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () {
                    ref
                        .read(textThemeIndexProvider.notifier)
                        .setTextThemeIndex(index);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

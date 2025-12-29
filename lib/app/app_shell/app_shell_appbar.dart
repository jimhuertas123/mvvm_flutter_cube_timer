import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_cube_timer/app/app_state/selected_cube_provider.dart';
import 'package:mvvm_cube_timer/app/app_state/selected_category_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/background_color_provider.dart';
import 'package:mvvm_cube_timer/app/theme/providers/computed_contrast_provider.dart';
import 'package:mvvm_cube_timer/core/database/app_database.dart';

/// App bar with cube/category selectors and drawer toggle
class AppShellAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppShellAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appBarColor = ref.watch(appBarColorProvider);
    final textColor = ref.watch(computedTextColorProvider);
    final selectedCube = ref.watch(selectedCubeProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return AppBar(
      backgroundColor: appBarColor,
      leading: IconButton(
        icon: Icon(Icons.settings, color: textColor),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      title: GestureDetector(
        onTap: () => _showCubeSelector(context, ref),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  selectedCube?.name ?? 'Select Cube',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.arrow_drop_down, color: textColor),
              ],
            ),
            GestureDetector(
              onTap: () => _showCategorySelector(context, ref),
              child: Text(
                selectedCategory?.name ?? 'normal',
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.category_outlined, color: textColor),
          onPressed: () => _showCategorySelector(context, ref),
        ),
      ],
    );
  }

  void _showCubeSelector(BuildContext context, WidgetRef ref) {
    final cubesAsync = ref.read(allCubesProvider);

    cubesAsync.whenData((cubes) {
      showDialog(
        context: context,
        builder: (context) => _CubeSelectorDialog(cubes: cubes),
      );
    });
  }

  void _showCategorySelector(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.read(categoriesForSelectedCubeProvider);

    categoriesAsync.whenData((categories) {
      showDialog(
        context: context,
        builder: (context) => _CategorySelectorDialog(categories: categories),
      );
    });
  }
}

/// Dialog for selecting cube type
class _CubeSelectorDialog extends ConsumerWidget {
  final List<Cube> cubes;

  const _CubeSelectorDialog({required this.cubes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCube = ref.watch(selectedCubeProvider);

    return AlertDialog(
      title: const Text('Select Cube'),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: cubes.length,
          itemBuilder: (context, index) {
            final cube = cubes[index];
            final isSelected = cube.id == selectedCube?.id;

            return ListTile(
              title: Text(cube.name),
              selected: isSelected,
              leading: isSelected
                  ? const Icon(Icons.check, color: Colors.blue)
                  : const SizedBox(width: 24),
              onTap: () {
                ref.read(selectedCubeProvider.notifier).selectCube(cube);
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}

/// Dialog for selecting category
class _CategorySelectorDialog extends ConsumerWidget {
  final List<Category> categories;

  const _CategorySelectorDialog({required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return AlertDialog(
      title: const Text('Select Category'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category.id == selectedCategory?.id;

                return ListTile(
                  title: Text(category.name),
                  selected: isSelected,
                  leading: isSelected
                      ? const Icon(Icons.check, color: Colors.blue)
                      : const SizedBox(width: 24),
                  onTap: () {
                    ref
                        .read(selectedCategoryProvider.notifier)
                        .selectCategory(category);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Category'),
              onTap: () {
                Navigator.of(context).pop();
                _showAddCategoryDialog(context, ref);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  void _showAddCategoryDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final addCategory = ref.read(addCategoryProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Category'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Category Name',
            hintText: 'Enter category name',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                addCategory(name);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

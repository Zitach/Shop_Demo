import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class CategoryStrip extends StatelessWidget {
  final List<Category> categories;
  final int? selectedId;
  final ValueChanged<Category>? onSelected;

  const CategoryStrip({
    super.key,
    required this.categories,
    this.selectedId,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat.id == selectedId;
          return _CategoryItem(
            category: cat,
            isSelected: isSelected,
            onTap: () => onSelected?.call(cat),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback? onTap;

  const _CategoryItem({
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                _iconForCategory(category.name),
                size: 28,
                color: isSelected ? AppColors.ink : AppColors.muted,
              ),
              if (category.isNew)
                Positioned(
                  top: -6,
                  right: -12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.canvas,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.categoryNew,
                      style: AppTypography.uppercaseTag.copyWith(
                        color: AppColors.ink,
                        fontSize: 7,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            category.name,
            style: AppTypography.buttonSm.copyWith(
              color: isSelected ? AppColors.ink : AppColors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            height: 2,
            width: isSelected ? 24 : 0,
            color: isSelected ? AppColors.ink : Colors.transparent,
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String name) {
    return switch (name.toLowerCase()) {
      'rooms' => Icons.hotel,
      'mansions' => Icons.villa,
      'countryside' => Icons.landscape,
      'beach' => Icons.beach_access,
      'cabins' => Icons.cabin,
      'pools' => Icons.pool,
      'lakefront' => Icons.water,
      'tiny homes' => Icons.home,
      'treehouses' => Icons.park,
      'experiences' => Icons.confirmation_num,
      _ => Icons.category,
    };
  }
}

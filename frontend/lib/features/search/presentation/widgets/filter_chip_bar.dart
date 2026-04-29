import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/search/domain/search_filter.dart';

class FilterChipBar extends StatelessWidget {
  final SortBy currentSort;
  final ValueChanged<SortBy> onSortChanged;
  final VoidCallback? onFilterTap;

  const FilterChipBar({
    super.key,
    required this.currentSort,
    required this.onSortChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        children: [
          _FilterChip(
            label: 'Filters',
            icon: Icons.tune,
            isActive: false,
            onTap: onFilterTap,
          ),
          const SizedBox(width: AppSpacing.sm),
          ...SortBy.values.map((sort) => Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: _FilterChip(
                  label: _labelFor(sort),
                  isActive: currentSort == sort,
                  onTap: () => onSortChanged(sort),
                ),
              )),
        ],
      ),
    );
  }

  static String _labelFor(SortBy sort) {
    switch (sort) {
      case SortBy.relevance:
        return 'Relevance';
      case SortBy.priceLow:
        return 'Price ↑';
      case SortBy.priceHigh:
        return 'Price ↓';
      case SortBy.rating:
        return 'Rating';
      case SortBy.newest:
        return 'Newest';
    }
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isActive;
  final VoidCallback? onTap;

  const _FilterChip({
    required this.label,
    this.icon,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.ink : AppColors.canvas,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isActive ? AppColors.ink : AppColors.hairline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isActive ? AppColors.onDark : AppColors.ink,
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            Text(
              label,
              style: AppTypography.bodySm.copyWith(
                color: isActive ? AppColors.onDark : AppColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

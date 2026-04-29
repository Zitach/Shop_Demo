import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/extensions.dart';
import 'package:shop_demo/features/search/domain/search_filter.dart';
import 'package:shop_demo/features/search/presentation/providers/search_provider.dart';
import 'package:shop_demo/features/search/presentation/widgets/date_range_picker.dart'
    as custom;
import 'package:shop_demo/features/search/presentation/widgets/guest_counter.dart';

class SearchOverlay extends ConsumerStatefulWidget {
  final VoidCallback? onSearch;

  const SearchOverlay({super.key, this.onSearch});

  @override
  ConsumerState<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends ConsumerState<SearchOverlay> {
  final _whereController = TextEditingController();
  int _activeTab = 0; // 0: Where, 1: When, 2: Who

  @override
  void dispose() {
    _whereController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(searchFilterProvider);
    final isMobile = context.isMobile;

    if (isMobile) {
      return _buildMobile(context, filter);
    }
    return _buildDesktop(context, filter);
  }

  Widget _buildMobile(BuildContext context, SearchFilter filter) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.base,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, size: 24),
                ),
                const Spacer(),
                Text(
                  'Search',
                  style: AppTypography.titleMd.copyWith(color: AppColors.ink),
                ),
                const Spacer(),
                const SizedBox(width: 24),
              ],
            ),
          ),
          const Divider(color: AppColors.hairlineSoft, height: 1),

          // Tab bar
          Row(
            children: [
              _TabButton(
                label: 'Where',
                isActive: _activeTab == 0,
                value: filter.query,
                onTap: () => setState(() => _activeTab = 0),
              ),
              _TabButton(
                label: 'When',
                isActive: _activeTab == 1,
                value: filter.dateRange != null
                    ? 'Add dates'
                    : null,
                onTap: () => setState(() => _activeTab = 1),
              ),
              _TabButton(
                label: 'Who',
                isActive: _activeTab == 2,
                value: filter.totalGuests > 1
                    ? '${filter.totalGuests} guests'
                    : null,
                onTap: () => setState(() => _activeTab = 2),
              ),
            ],
          ),
          const Divider(color: AppColors.hairlineSoft, height: 1),

          // Content
          Expanded(
            child: _buildTabContent(filter),
          ),

          // Bottom actions
          Padding(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(searchFilterProvider.notifier).clear();
                    _whereController.clear();
                  },
                  child: Text(
                    'Clear all',
                    style: AppTypography.bodyMd.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onSearch?.call();
                  },
                  icon: const Icon(Icons.search, size: 18),
                  label: const Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    textStyle: AppTypography.buttonMd,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop(BuildContext context, SearchFilter filter) {
    return Container(
      width: 420,
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: _buildTabContent(filter),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref.read(searchFilterProvider.notifier).clear();
                    _whereController.clear();
                  },
                  child: Text(
                    'Clear',
                    style: AppTypography.bodyMd.copyWith(
                      decoration: TextDecoration.underline,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onSearch?.call();
                  },
                  icon: const Icon(Icons.search, size: 18),
                  label: const Text('Search'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    textStyle: AppTypography.buttonMd,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(SearchFilter filter) {
    switch (_activeTab) {
      case 0:
        return _WhereTab(controller: _whereController);
      case 1:
        return _WhenTab(
          dateRange: filter.dateRange,
          onRangeSelected: (range) {
            ref.read(searchFilterProvider.notifier).updateDateRange(range);
          },
        );
      case 2:
        return _WhoTab(
          adults: filter.adults,
          children: filter.children,
          infants: filter.infants,
          onChanged: ({int? adults, int? children, int? infants}) {
            ref.read(searchFilterProvider.notifier).updateGuests(
                  adults: adults,
                  children: children,
                  infants: infants,
                );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final String? value;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isActive,
    this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            border: isActive
                ? const Border(
                    bottom: BorderSide(color: AppColors.ink, width: 2),
                  )
                : null,
          ),
          child: Column(
            children: [
              Text(
                label,
                style: (isActive
                        ? AppTypography.caption
                        : AppTypography.caption)
                    .copyWith(
                  color: isActive ? AppColors.ink : AppColors.muted,
                ),
              ),
              if (value != null)
                Text(
                  value!,
                  style: AppTypography.captionSm.copyWith(
                    color: AppColors.muted,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhereTab extends ConsumerWidget {
  final TextEditingController controller;

  const _WhereTab({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Where to?',
            style: AppTypography.displaySm.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: AppSpacing.base),
          Material(
            color: Colors.transparent,
            child: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search destinations',
              hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.muted),
              prefixIcon: const Icon(Icons.search, color: AppColors.ink),
              filled: true,
              fillColor: AppColors.surfaceSoft,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.base,
                vertical: AppSpacing.md,
              ),
            ),
            style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
            onChanged: (value) {
              ref.read(searchFilterProvider.notifier).updateQuery(value.isEmpty ? null : value);
            },
          ),
          ),
        ],
      ),
    );
  }
}

class _WhenTab extends StatelessWidget {
  final DateTimeRange? dateRange;
  final ValueChanged<DateTimeRange> onRangeSelected;

  const _WhenTab({this.dateRange, required this.onRangeSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'When\'s your trip?',
            style: AppTypography.displaySm.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: AppSpacing.base),
          custom.SearchDateRangePicker(
            selectedRange: dateRange,
            onRangeSelected: onRangeSelected,
          ),
        ],
      ),
    );
  }
}

class _WhoTab extends StatelessWidget {
  final int adults;
  final int children;
  final int infants;
  final void Function({int? adults, int? children, int? infants}) onChanged;

  const _WhoTab({
    required this.adults,
    required this.children,
    required this.infants,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.base),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who\'s coming?',
            style: AppTypography.displaySm.copyWith(color: AppColors.ink),
          ),
          const SizedBox(height: AppSpacing.lg),
          GuestCounter(
            label: 'Adults',
            subtitle: 'Ages 13 or above',
            count: adults,
            min: 1,
            onIncrement: () => onChanged(adults: adults + 1),
            onDecrement: () => onChanged(adults: adults - 1),
          ),
          const Divider(color: AppColors.hairlineSoft, height: 1),
          GuestCounter(
            label: 'Children',
            subtitle: 'Ages 2–12',
            count: children,
            onIncrement: () => onChanged(children: children + 1),
            onDecrement: () => onChanged(children: children - 1),
          ),
          const Divider(color: AppColors.hairlineSoft, height: 1),
          GuestCounter(
            label: 'Infants',
            subtitle: 'Under 2',
            count: infants,
            onIncrement: () => onChanged(infants: infants + 1),
            onDecrement: () => onChanged(infants: infants - 1),
          ),
        ],
      ),
    );
  }
}

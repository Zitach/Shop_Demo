import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/home/presentation/widgets/listing_card.dart';
import 'package:shop_demo/features/search/presentation/providers/search_provider.dart';
import 'package:shop_demo/features/search/presentation/widgets/filter_chip_bar.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';
import 'package:shop_demo/shared/widgets/skeleton_loader.dart';

class SearchResultsPage extends ConsumerWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final results = ref.watch(searchResultsProvider);
    final filter = ref.watch(searchFilterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.canvas,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.ink),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Search results',
          style: AppTypography.titleMd.copyWith(color: AppColors.ink),
        ),
      ),
      body: Column(
        children: [
          // Filter chips
          FilterChipBar(
            currentSort: filter.sortBy,
            onSortChanged: (sort) {
              ref.read(searchFilterProvider.notifier).updateSortBy(sort);
            },
            onFilterTap: () {
              context.push('/search');
            },
          ),
          const Divider(color: AppColors.hairlineSoft, height: 1),

          // Results
          Expanded(
            child: results.when(
              data: (listings) {
                if (listings.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.muted,
                        ),
                        const SizedBox(height: AppSpacing.base),
                        Text(
                          'No results found',
                          style: AppTypography.displaySm.copyWith(
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          'Try different filters',
                          style: AppTypography.bodyMd.copyWith(
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = switch (constraints.maxWidth) {
                      < 744 => 1,
                      < 1128 => 2,
                      < 1440 => 3,
                      _ => 4,
                    };

                    if (crossAxisCount == 1) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.base,
                          vertical: AppSpacing.base,
                        ),
                        itemCount: listings.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppSpacing.lg,
                          ),
                          child: ListingCardWidget(
                            listing: listings[index],
                            onTap: () => context.push(
                              '/listing/${listings[index].id}',
                            ),
                          ),
                        ),
                      );
                    }

                    return GridView.builder(
                      padding: const EdgeInsets.all(AppSpacing.base),
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: AppSpacing.base,
                        mainAxisSpacing: AppSpacing.lg,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: listings.length,
                      itemBuilder: (context, index) => ListingCardWidget(
                        listing: listings[index],
                        onTap: () => context.push(
                          '/listing/${listings[index].id}',
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const ListingGridSkeleton(),
              error: (e, _) => ErrorDisplay(
                message: 'Something went wrong',
                onRetry: () => ref.invalidate(searchResultsProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/home/presentation/widgets/listing_card.dart';
import 'package:shop_demo/features/profile/presentation/providers/profile_provider.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritesAsync = ref.watch(favoriteListingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoritesAsync.when(
        data: (listings) {
          if (listings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: 64, color: AppColors.mutedSoft),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'No favorites yet',
                    style: AppTypography.displaySm
                        .copyWith(color: AppColors.ink),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Tap the heart icon to save listings you love.',
                    style: AppTypography.bodyMd
                        .copyWith(color: AppColors.muted),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(favoriteListingsProvider.notifier).refresh(),
            child: GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.base),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: 0.78,
                crossAxisSpacing: AppSpacing.base,
                mainAxisSpacing: AppSpacing.lg,
              ),
              itemCount: listings.length,
              itemBuilder: (context, index) {
                final listing = listings[index];
                return ListingCardWidget(
                  listing: listing,
                  onTap: () => context.push('/listing/${listing.id}'),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => ErrorDisplay(
          message: 'Failed to load favorites',
          onRetry: () => ref.invalidate(favoriteListingsProvider),
        ),
      ),
    );
  }
}

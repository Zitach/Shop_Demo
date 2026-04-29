import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';
import 'package:shop_demo/features/profile/presentation/providers/profile_provider.dart';
import 'package:shop_demo/shared/widgets/photo_carousel.dart';
import 'guest_favorite_badge.dart';

class ListingCardWidget extends ConsumerStatefulWidget {
  final ListingCard listing;
  final VoidCallback? onTap;

  const ListingCardWidget({
    super.key,
    required this.listing,
    this.onTap,
  });

  @override
  ConsumerState<ListingCardWidget> createState() => _ListingCardWidgetState();
}

class _ListingCardWidgetState extends ConsumerState<ListingCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0.6,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    ref.read(favoriteIdsProvider.notifier).toggle(widget.listing.id);
    _heartController.forward().then((_) => _heartController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.listing;
    final favoriteIds = ref.watch(favoriteIdsProvider);
    final isFavorited =
        favoriteIds.valueOrNull?.contains(l.id) ?? false;

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PhotoCarousel(
            imageUrls: l.imageUrls,
            aspectRatio: 1.0,
            overlays: [
              if (l.isGuestFavorite)
                const Positioned(
                  top: AppSpacing.sm,
                  left: AppSpacing.sm,
                  child: GuestFavoriteBadge(),
                ),
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: ScaleTransition(
                    scale: _heartController,
                    child: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color:
                          isFavorited ? AppColors.primary : Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: Text(
                  l.title,
                  style:
                      AppTypography.titleMd.copyWith(color: AppColors.ink),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (l.rating != null) ...[
                const Icon(Icons.star, size: 14, color: AppColors.ink),
                const SizedBox(width: 2),
                Text(
                  l.rating!.toStringAsFixed(2),
                  style:
                      AppTypography.bodySm.copyWith(color: AppColors.ink),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            l.location,
            style: AppTypography.bodySm.copyWith(color: AppColors.muted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (l.dateRange != null) ...[
            const SizedBox(height: 2),
            Text(
              l.dateRange!,
              style: AppTypography.bodySm.copyWith(color: AppColors.muted),
            ),
          ],
          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: PriceFormatter.perNight(l.pricePerNight),
                  style: AppTypography.titleMd
                      .copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

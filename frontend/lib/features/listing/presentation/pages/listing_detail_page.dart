import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/listing/presentation/providers/listing_provider.dart';
import 'package:shop_demo/features/listing/presentation/widgets/amenity_list.dart';
import 'package:shop_demo/features/listing/presentation/widgets/host_card.dart';
import 'package:shop_demo/features/listing/presentation/widgets/photo_banner.dart';
import 'package:shop_demo/features/listing/presentation/widgets/rating_display_card.dart';
import 'package:shop_demo/features/listing/presentation/widgets/reservation_card.dart';
import 'package:shop_demo/features/listing/presentation/widgets/reviews_section.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';
import 'package:shop_demo/shared/widgets/responsive_builder.dart';
import 'package:shop_demo/shared/widgets/skeleton_loader.dart';

class ListingDetailPage extends ConsumerWidget {
  final String listingId;

  const ListingDetailPage({super.key, required this.listingId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingAsync = ref.watch(listingDetailProvider(listingId));

    return Scaffold(
      body: listingAsync.when(
        data: (listing) {
          if (listing == null) {
            return ErrorDisplay(
              message: 'Listing not found',
              onRetry: () => ref.invalidate(listingDetailProvider(listingId)),
            );
          }
          return _ListingContent(listing: listing);
        },
        loading: () => const _ListingDetailSkeleton(),
        error: (e, _) => ErrorDisplay(
          message: 'Something went wrong',
          onRetry: () => ref.invalidate(listingDetailProvider(listingId)),
        ),
      ),
    );
  }
}

class _ListingContent extends StatelessWidget {
  final dynamic listing;

  const _ListingContent({required this.listing});

  @override
  Widget build(BuildContext context) {
    final bp = ResponsiveBuilder.breakpointFor(
      MediaQuery.sizeOf(context).width,
    );

    return Stack(
      children: [
        // Main scroll area
        CustomScrollView(
          slivers: [
            // Photo banner
            SliverToBoxAdapter(
              child: PhotoBanner(
                listingId: listing.id,
                imageUrls: listing.imageUrls,
              ),
            ),

            // Content — switches layout based on breakpoint
            SliverToBoxAdapter(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: bp == ScreenBreakpoint.mobile
                        ? AppSpacing.base
                        : AppSpacing.xl,
                  ),
                  child: switch (bp) {
                    ScreenBreakpoint.mobile =>
                      _MobileLayout(listing: listing),
                    ScreenBreakpoint.tablet =>
                      _TabletLayout(listing: listing),
                    ScreenBreakpoint.desktop =>
                      _DesktopLayout(listing: listing),
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.section),
            ),
          ],
        ),

        // Fixed bottom reservation bar on mobile
        if (bp == ScreenBreakpoint.mobile)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _MobileBottomBar(listing: listing),
          ),
      ],
    );
  }
}

// ── Mobile layout: single column, fixed bottom bar ───────────────────

class _MobileLayout extends StatelessWidget {
  final dynamic listing;

  const _MobileLayout({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        _TitleSection(listing: listing),
        const SizedBox(height: AppSpacing.lg),
        if (listing.isGuestFavorite || listing.reviewCount > 0)
          RatingDisplayCard(
            rating: listing.rating,
            reviewCount: listing.reviewCount,
            isGuestFavorite: listing.isGuestFavorite,
          ),
        const SizedBox(height: AppSpacing.lg),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.lg),
        HostCard(host: listing.host),
        const SizedBox(height: AppSpacing.lg),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.lg),
        _DescriptionSection(listing: listing),
        const SizedBox(height: AppSpacing.xl),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.xl),
        _AmenitiesSection(listing: listing),
        const SizedBox(height: AppSpacing.xl),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.xl),
        ReviewsSection(
          reviews: listing.reviews,
          rating: listing.rating,
          reviewCount: listing.reviewCount,
        ),
        // Extra bottom padding for mobile bottom bar
        const SizedBox(height: 100),
      ],
    );
  }
}

// ── Tablet layout: single column, reservation card inline ────────────

class _TabletLayout extends StatelessWidget {
  final dynamic listing;

  const _TabletLayout({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        _TitleSection(listing: listing),
        const SizedBox(height: AppSpacing.lg),
        if (listing.isGuestFavorite || listing.reviewCount > 0)
          RatingDisplayCard(
            rating: listing.rating,
            reviewCount: listing.reviewCount,
            isGuestFavorite: listing.isGuestFavorite,
          ),
        const SizedBox(height: AppSpacing.lg),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.lg),

        // Two-column: content + reservation card (not sticky on tablet)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HostCard(host: listing.host),
                  const SizedBox(height: AppSpacing.xl),
                  const Divider(color: AppColors.hairlineSoft, height: 1),
                  const SizedBox(height: AppSpacing.xl),
                  _DescriptionSection(listing: listing),
                  const SizedBox(height: AppSpacing.xl),
                  const Divider(color: AppColors.hairlineSoft, height: 1),
                  const SizedBox(height: AppSpacing.xl),
                  _AmenitiesSection(listing: listing),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.xl),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: AppSpacing.lg),
                child: ReservationCard(
                  pricePerNight: listing.pricePerNight,
                  maxGuests: listing.maxGuests,
                  listingId: listing.id,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: AppSpacing.xl),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.xl),
        ReviewsSection(
          reviews: listing.reviews,
          rating: listing.rating,
          reviewCount: listing.reviewCount,
        ),
        const SizedBox(height: AppSpacing.section),
      ],
    );
  }
}

// ── Desktop layout: content left, sticky reservation sidebar right ───

class _DesktopLayout extends StatelessWidget {
  final dynamic listing;

  const _DesktopLayout({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.lg),
        _TitleSection(listing: listing),
        const SizedBox(height: AppSpacing.lg),
        if (listing.isGuestFavorite || listing.reviewCount > 0)
          RatingDisplayCard(
            rating: listing.rating,
            reviewCount: listing.reviewCount,
            isGuestFavorite: listing.isGuestFavorite,
          ),
        const SizedBox(height: AppSpacing.lg),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.lg),

        // Two-column layout: content + sticky sidebar
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: main content
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HostCard(host: listing.host),
                    const SizedBox(height: AppSpacing.xl),
                    const Divider(color: AppColors.hairlineSoft, height: 1),
                    const SizedBox(height: AppSpacing.xl),
                    _DescriptionSection(listing: listing),
                    const SizedBox(height: AppSpacing.xl),
                    const Divider(color: AppColors.hairlineSoft, height: 1),
                    const SizedBox(height: AppSpacing.xl),
                    _AmenitiesSection(listing: listing),
                    const SizedBox(height: AppSpacing.xl),
                    const Divider(color: AppColors.hairlineSoft, height: 1),
                    const SizedBox(height: AppSpacing.xl),
                    ReviewsSection(
                      reviews: listing.reviews,
                      rating: listing.rating,
                      reviewCount: listing.reviewCount,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppSpacing.xl),

              // Right: sticky reservation card
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.lg),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      color: Colors.transparent,
                      child: ReservationCard(
                        pricePerNight: listing.pricePerNight,
                        maxGuests: listing.maxGuests,
                        listingId: listing.id,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.section),
      ],
    );
  }
}

// ── Shared sub-widgets ───────────────────────────────────────────────

class _TitleSection extends StatelessWidget {
  final dynamic listing;

  const _TitleSection({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          listing.title,
          style: AppTypography.displayXl.copyWith(color: AppColors.ink),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          listing.location,
          style: AppTypography.bodyMd.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }
}

class _DescriptionSection extends StatelessWidget {
  final dynamic listing;

  const _DescriptionSection({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Text(
      listing.description,
      style: AppTypography.bodyMd.copyWith(color: AppColors.body),
    );
  }
}

class _AmenitiesSection extends StatelessWidget {
  final dynamic listing;

  const _AmenitiesSection({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What this place offers',
          style: AppTypography.displaySm.copyWith(color: AppColors.ink),
        ),
        const SizedBox(height: AppSpacing.base),
        AmenityList(amenities: listing.amenities),
      ],
    );
  }
}

class _MobileBottomBar extends StatelessWidget {
  final dynamic listing;

  const _MobileBottomBar({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        border: const Border(
          top: BorderSide(color: AppColors.hairline),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${listing.pricePerNight.toStringAsFixed(0)} night',
                  style: AppTypography.titleMd.copyWith(color: AppColors.ink),
                ),
                if (listing.reviewCount > 0)
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: AppColors.ink),
                      const SizedBox(width: 2),
                      Text(
                        '${listing.rating.toStringAsFixed(2)} · ${listing.reviewCount} reviews',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.muted,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.canvas,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (ctx) => DraggableScrollableSheet(
                      initialChildSize: 0.7,
                      minChildSize: 0.5,
                      maxChildSize: 0.95,
                      expand: false,
                      builder: (ctx, scrollController) => SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: ReservationCard(
                          pricePerNight: listing.pricePerNight,
                          maxGuests: listing.maxGuests,
                          listingId: listing.id,
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: AppTypography.buttonMd,
                ),
                child: const Text('Reserve'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListingDetailSkeleton extends StatelessWidget {
  const _ListingDetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonLoader(
            width: double.infinity,
            height: 300,
            borderRadius: BorderRadius.zero,
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SkeletonLoader(width: 280, height: 28),
                const SizedBox(height: AppSpacing.sm),
                const SkeletonLoader(width: 180, height: 16),
                const SizedBox(height: AppSpacing.lg),
                const SkeletonLoader(width: double.infinity, height: 80),
                const SizedBox(height: AppSpacing.lg),
                const SkeletonLoader(width: double.infinity, height: 120),
                const SizedBox(height: AppSpacing.lg),
                const SkeletonLoader(width: double.infinity, height: 200),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

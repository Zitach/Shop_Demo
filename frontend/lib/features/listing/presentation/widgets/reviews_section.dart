import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/features/listing/domain/review.dart';

class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;
  final double rating;
  final int reviewCount;

  const ReviewsSection({
    super.key,
    required this.reviews,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.star, size: 24, color: AppColors.ink),
            const SizedBox(width: AppSpacing.sm),
            Text(
              '${rating.toStringAsFixed(2)} · $reviewCount reviews',
              style: AppTypography.displaySm.copyWith(color: AppColors.ink),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        _ReviewGrid(reviews: reviews),
      ],
    );
  }
}

class _ReviewGrid extends StatelessWidget {
  final List<Review> reviews;

  const _ReviewGrid({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;

        if (crossAxisCount == 1) {
          return Column(
            children: reviews
                .map((r) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                      child: _ReviewCard(review: r),
                    ))
                .toList(),
          );
        }

        return Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: reviews
              .map((r) => SizedBox(
                    width: (constraints.maxWidth - AppSpacing.lg) / 2,
                    child: _ReviewCard(review: r),
                  ))
              .toList(),
        );
      },
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.surfaceSoft,
              backgroundImage: CachedNetworkImageProvider(review.userAvatarUrl),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.userName,
                    style: AppTypography.titleSm.copyWith(color: AppColors.ink),
                  ),
                  Text(
                    DateFmt.monthDayYear(review.date),
                    style: AppTypography.captionSm.copyWith(color: AppColors.muted),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: List.generate(
            5,
            (i) => Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(
                i < review.rating ? Icons.star : Icons.star_border,
                size: 14,
                color: AppColors.ink,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          review.comment,
          style: AppTypography.bodySm.copyWith(color: AppColors.body),
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

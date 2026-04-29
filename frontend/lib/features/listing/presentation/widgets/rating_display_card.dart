import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';

class RatingDisplayCard extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final bool isGuestFavorite;

  const RatingDisplayCard({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.isGuestFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.base,
      ),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.hairline),
      ),
      child: Row(
        children: [
          if (isGuestFavorite) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Guest favorite',
                  style: AppTypography.titleMd.copyWith(color: AppColors.ink),
                ),
                const SizedBox(height: 2),
                Text(
                  'One of the most loved homes on Airbnb',
                  style: AppTypography.bodySm.copyWith(color: AppColors.muted),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 1,
              height: 40,
              color: AppColors.hairline,
              margin: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
            ),
          ],
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rating.toStringAsFixed(2),
                    style: AppTypography.ratingDisplay.copyWith(
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Icon(
                      Icons.star,
                      size: 28,
                      color: AppColors.ink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                '$reviewCount reviews',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.muted,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

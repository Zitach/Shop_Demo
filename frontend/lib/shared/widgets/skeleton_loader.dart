import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceSoft,
      highlightColor: AppColors.canvas,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surfaceSoft,
          borderRadius: borderRadius ??
              BorderRadius.circular(AppRadius.sm),
        ),
      ),
    );
  }
}

class CategoryStripSkeleton extends StatelessWidget {
  const CategoryStripSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        itemCount: 6,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (_, __) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeletonLoader(
              width: 28,
              height: 28,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            const SizedBox(height: AppSpacing.xs),
            const SkeletonLoader(width: 48, height: 10),
          ],
        ),
      ),
    );
  }
}

class BookingListSkeleton extends StatelessWidget {
  const BookingListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.base),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.base),
      itemBuilder: (_, __) => Container(
        padding: const EdgeInsets.all(AppSpacing.base),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.hairlineSoft),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SkeletonLoader(
                  width: 60,
                  height: 60,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                const SizedBox(width: AppSpacing.base),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SkeletonLoader(width: 180, height: 16),
                      const SizedBox(height: AppSpacing.xs),
                      const SkeletonLoader(width: 120, height: 14),
                    ],
                  ),
                ),
                const SkeletonLoader(width: 72, height: 24),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const Divider(color: AppColors.hairlineSoft, height: 1),
            const SizedBox(height: AppSpacing.sm),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SkeletonLoader(width: 100, height: 14),
                SkeletonLoader(width: 80, height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListingGridSkeleton extends StatelessWidget {
  const ListingGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Column(
        children: List.generate(
          3,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: double.infinity,
                  height: 300,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                const SizedBox(height: AppSpacing.sm),
                const SkeletonLoader(width: 200, height: 16),
                const SizedBox(height: 4),
                const SkeletonLoader(width: 150, height: 14),
                const SizedBox(height: 4),
                const SkeletonLoader(width: 100, height: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

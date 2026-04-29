import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/features/booking/domain/entities/booking.dart';
import 'package:shop_demo/features/booking/presentation/providers/booking_provider.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';

class MyBookingsPage extends ConsumerWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(myBookingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: bookingsAsync.when(
        data: (bookings) {
          if (bookings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today_outlined,
                      size: 64, color: AppColors.mutedSoft),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'No bookings yet',
                    style: AppTypography.displaySm
                        .copyWith(color: AppColors.ink),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Your upcoming trips will appear here.',
                    style: AppTypography.bodyMd
                        .copyWith(color: AppColors.muted),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () =>
                ref.read(myBookingsProvider.notifier).refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.base),
              itemCount: bookings.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: AppSpacing.base),
              itemBuilder: (context, index) {
                return _BookingCard(booking: bookings[index]);
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => ErrorDisplay(
          message: 'Failed to load bookings',
          onRetry: () => ref.invalidate(myBookingsProvider),
        ),
      ),
    );
  }
}

class _BookingCard extends StatelessWidget {
  final Booking booking;

  const _BookingCard({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hairline),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Listing image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: booking.listingImageUrl != null
                    ? Image.network(
                        booking.listingImageUrl!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 60,
                          height: 60,
                          color: AppColors.surfaceSoft,
                          child: const Icon(Icons.image,
                              color: AppColors.muted),
                        ),
                      )
                    : Container(
                        width: 60,
                        height: 60,
                        color: AppColors.surfaceSoft,
                        child: const Icon(Icons.image,
                            color: AppColors.muted),
                      ),
              ),
              const SizedBox(width: AppSpacing.base),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      booking.listingTitle,
                      style: AppTypography.titleMd
                          .copyWith(color: AppColors.ink),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${DateFmt.monthDay(booking.checkIn)} – ${DateFmt.monthDay(booking.checkOut)}',
                      style: AppTypography.bodySm
                          .copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              // Status badge
              _StatusBadge(status: booking.status),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.hairlineSoft, height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${booking.nights} night${booking.nights > 1 ? 's' : ''} · ${booking.guests} guest${booking.guests > 1 ? 's' : ''}',
                style:
                    AppTypography.bodySm.copyWith(color: AppColors.muted),
              ),
              Text(
                PriceFormatter.formatDecimal(booking.totalAmount),
                style: AppTypography.titleSm
                    .copyWith(color: AppColors.ink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final BookingStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, label) = switch (status) {
      BookingStatus.pending => (const Color(0xFFFFA726), 'Pending'),
      BookingStatus.confirmed => (const Color(0xFF4CAF50), 'Confirmed'),
      BookingStatus.cancelled => (const Color(0xFFEF5350), 'Cancelled'),
      BookingStatus.completed => (const Color(0xFF42A5F5), 'Completed'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        label,
        style: AppTypography.badge.copyWith(color: color),
      ),
    );
  }
}

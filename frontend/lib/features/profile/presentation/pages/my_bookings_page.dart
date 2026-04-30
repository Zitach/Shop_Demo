import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/features/booking/domain/entities/booking.dart';
import 'package:shop_demo/features/booking/presentation/providers/booking_provider.dart';
import 'package:shop_demo/l10n/app_localizations.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';
import 'package:shop_demo/shared/widgets/skeleton_loader.dart';

class MyBookingsPage extends ConsumerWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingsAsync = ref.watch(myBookingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myBookings),
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
        loading: () => const BookingListSkeleton(),
        error: (_, __) => ErrorDisplay(
          message: 'Failed to load bookings',
          onRetry: () => ref.invalidate(myBookingsProvider),
        ),
      ),
    );
  }
}

class _BookingCard extends StatefulWidget {
  final Booking booking;

  const _BookingCard({required this.booking});

  @override
  State<_BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<_BookingCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(AppSpacing.base),
        decoration: BoxDecoration(
          border: Border.all(
            color: _isHovered ? AppColors.ink : AppColors.hairline,
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Listing image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: widget.booking.listingImageUrl != null
                    ? Image.network(
                        widget.booking.listingImageUrl!,
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
                      widget.booking.listingTitle,
                      style: AppTypography.titleMd
                          .copyWith(color: AppColors.ink),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '${DateFmt.monthDay(widget.booking.checkIn)} – ${DateFmt.monthDay(widget.booking.checkOut)}',
                      style: AppTypography.bodySm
                          .copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              // Status badge
              _StatusBadge(status: widget.booking.status),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.hairlineSoft, height: 1),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.booking.nights} night${widget.booking.nights > 1 ? 's' : ''} · ${widget.booking.guests} guest${widget.booking.guests > 1 ? 's' : ''}',
                style:
                    AppTypography.bodySm.copyWith(color: AppColors.muted),
              ),
              Text(
                PriceFormatter.formatDecimal(widget.booking.totalAmount),
                style: AppTypography.titleSm
                    .copyWith(color: AppColors.ink),
              ),
            ],
          ),
        ],
      ),
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

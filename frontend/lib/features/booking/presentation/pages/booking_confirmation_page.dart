import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/features/booking/domain/entities/booking.dart';
import 'package:shop_demo/shared/widgets/app_button.dart';

class BookingConfirmationPage extends StatelessWidget {
  final Booking booking;

  const BookingConfirmationPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.xxl),

              // Success icon
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE8F5E9),
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 48,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Title
              Text(
                'Booking confirmed!',
                style:
                    AppTypography.displayXl.copyWith(color: AppColors.ink),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Your reservation has been confirmed. We\'ve sent a confirmation email with all the details.',
                style:
                    AppTypography.bodyMd.copyWith(color: AppColors.muted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Booking details card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.hairline),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Booking details',
                      style: AppTypography.titleMd
                          .copyWith(color: AppColors.ink),
                    ),
                    const SizedBox(height: AppSpacing.base),

                    // Listing title
                    Text(
                      booking.listingTitle,
                      style: AppTypography.bodyMd
                          .copyWith(color: AppColors.ink),
                    ),
                    const SizedBox(height: AppSpacing.base),

                    const Divider(color: AppColors.hairlineSoft, height: 1),
                    const SizedBox(height: AppSpacing.base),

                    // Dates
                    _DetailRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Dates',
                      value:
                          '${DateFmt.monthDay(booking.checkIn)} – ${DateFmt.monthDay(booking.checkOut)}',
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Nights
                    _DetailRow(
                      icon: Icons.nightlight_outlined,
                      label: 'Duration',
                      value:
                          '${booking.nights} night${booking.nights > 1 ? 's' : ''}',
                    ),
                    const SizedBox(height: AppSpacing.sm),

                    // Guests
                    _DetailRow(
                      icon: Icons.person_outline,
                      label: 'Guests',
                      value:
                          '${booking.guests} guest${booking.guests > 1 ? 's' : ''}',
                    ),
                    const SizedBox(height: AppSpacing.base),

                    const Divider(color: AppColors.hairlineSoft, height: 1),
                    const SizedBox(height: AppSpacing.base),

                    // Total
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total paid',
                          style: AppTypography.titleMd
                              .copyWith(color: AppColors.ink),
                        ),
                        Text(
                          PriceFormatter.formatDecimal(booking.totalAmount),
                          style: AppTypography.titleMd
                              .copyWith(color: AppColors.ink),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // View my bookings button
              AppButton.primary(
                label: 'View my bookings',
                onTap: () => context.go('/my-bookings'),
              ),
              const SizedBox(height: AppSpacing.sm),

              // Back to home
              AppButton.tertiary(
                label: 'Back to home',
                onTap: () => context.go('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.muted),
        const SizedBox(width: AppSpacing.sm),
        Text(
          label,
          style: AppTypography.bodySm.copyWith(color: AppColors.muted),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
        ),
      ],
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/features/auth/presentation/providers/auth_provider.dart';
import 'package:shop_demo/features/booking/presentation/providers/booking_provider.dart';
import 'package:shop_demo/features/booking/presentation/widgets/fee_breakdown.dart';
import 'package:shop_demo/features/listing/presentation/providers/listing_provider.dart';
import 'package:shop_demo/shared/widgets/app_button.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';
import 'package:shop_demo/shared/widgets/skeleton_loader.dart';

class BookingPage extends ConsumerStatefulWidget {
  final String listingId;

  const BookingPage({super.key, required this.listingId});

  @override
  ConsumerState<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  DateTimeRange? _dateRange;
  int _guests = 1;

  int get _nights => _dateRange != null
      ? DateFmt.nightsBetween(_dateRange!.start, _dateRange!.end)
      : 0;

  Future<void> _pickDates(double pricePerNight, int maxGuests) async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      initialDateRange: _dateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: AppColors.primary,
                ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dateRange = picked);
    }
  }

  Future<void> _handleConfirm(double pricePerNight) async {
    final authState = ref.read(authProvider);
    if (!authState.hasValue || authState.value == null) {
      // Not logged in - redirect to login
      context.push('/login');
      return;
    }

    if (_dateRange == null || _nights == 0) return;

    const cleaningFee = 75.0;
    final serviceFee = (pricePerNight * _nights) * 0.14;
    final total = (pricePerNight * _nights) + cleaningFee + serviceFee;

    final booking = await ref.read(createBookingProvider.notifier).create(
          listingId: widget.listingId,
          checkIn: _dateRange!.start,
          checkOut: _dateRange!.end,
          guests: _guests,
          nightlyRate: pricePerNight,
          cleaningFee: cleaningFee,
          serviceFee: serviceFee,
          totalAmount: total,
        );

    if (booking != null && mounted) {
      context.push('/booking/confirmation', extra: booking);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingAsync = ref.watch(listingDetailProvider(widget.listingId));
    final createState = ref.watch(createBookingProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm and pay'),
      ),
      body: listingAsync.when(
        data: (listing) {
          if (listing == null) {
            return const ErrorDisplay(message: 'Listing not found');
          }

          final cleaningFee = _nights > 0 ? 75.0 : 0.0;
          final serviceFee =
              _nights > 0 ? (listing.pricePerNight * _nights) * 0.14 : 0.0;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.base),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Listing summary
                Container(
                  padding: const EdgeInsets.all(AppSpacing.base),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.hairline),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        child: CachedNetworkImage(
                          imageUrl: listing.imageUrls.isNotEmpty
                              ? listing.imageUrls.first
                              : '',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => const SkeletonLoader(
                            width: 80,
                            height: 80,
                          ),
                          errorWidget: (_, __, ___) => Container(
                            width: 80,
                            height: 80,
                            color: AppColors.surfaceSoft,
                            child: const Icon(Icons.image, color: AppColors.muted),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.base),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              listing.title,
                              style: AppTypography.titleMd
                                  .copyWith(color: AppColors.ink),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              listing.location,
                              style: AppTypography.bodySm
                                  .copyWith(color: AppColors.muted),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              PriceFormatter.perNight(listing.pricePerNight),
                              style: AppTypography.titleSm
                                  .copyWith(color: AppColors.ink),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),

                // Date range picker
                Text(
                  'Your trip',
                  style:
                      AppTypography.displaySm.copyWith(color: AppColors.ink),
                ),
                const SizedBox(height: AppSpacing.base),

                // Date picker row
                Row(
                  children: [
                    Expanded(
                      child: _PickerField(
                        label: 'CHECK-IN',
                        value: _dateRange != null
                            ? DateFmt.monthDay(_dateRange!.start)
                            : 'Add dates',
                        onTap: () => _pickDates(
                            listing.pricePerNight, listing.maxGuests),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: _PickerField(
                        label: 'CHECKOUT',
                        value: _dateRange != null
                            ? DateFmt.monthDay(_dateRange!.end)
                            : 'Add dates',
                        onTap: () => _pickDates(
                            listing.pricePerNight, listing.maxGuests),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),

                // Guest counter
                _GuestPicker(
                  guests: _guests,
                  maxGuests: listing.maxGuests,
                  onChanged: (v) => setState(() => _guests = v),
                ),

                if (_nights > 0) ...[
                  const SizedBox(height: AppSpacing.xl),

                  // Fee breakdown
                  Text(
                    'Price details',
                    style: AppTypography.displaySm
                        .copyWith(color: AppColors.ink),
                  ),
                  const SizedBox(height: AppSpacing.base),
                  FeeBreakdown(
                    nightlyRate: listing.pricePerNight,
                    nights: _nights,
                    cleaningFee: cleaningFee,
                    serviceFee: serviceFee,
                  ),
                ],

                const SizedBox(height: AppSpacing.xl),

                // Confirm button
                AppButton.primary(
                  label: _nights > 0
                      ? 'Confirm and pay ${PriceFormatter.formatDecimal(listing.pricePerNight * _nights + cleaningFee + serviceFee)}'
                      : 'Select dates to continue',
                  onTap: _nights > 0 && !createState.isLoading
                      ? () => _handleConfirm(listing.pricePerNight)
                      : null,
                  enabled: _nights > 0 && !createState.isLoading,
                ),

                if (_nights > 0) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Center(
                    child: Text(
                      "You won't be charged yet",
                      style: AppTypography.bodySm
                          .copyWith(color: AppColors.muted),
                    ),
                  ),
                ],

                // Error
                if (createState.hasError) ...[
                  const SizedBox(height: AppSpacing.base),
                  Text(
                    'Booking failed. Please try again.',
                    style: AppTypography.bodySm
                        .copyWith(color: AppColors.errorText),
                    textAlign: TextAlign.center,
                  ),
                ],

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const ErrorDisplay(message: 'Something went wrong'),
      ),
    );
  }
}

class _PickerField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _PickerField({
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.hairline),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppTypography.uppercaseTag.copyWith(color: AppColors.ink),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
            ),
          ],
        ),
      ),
    );
  }
}

class _GuestPicker extends StatelessWidget {
  final int guests;
  final int maxGuests;
  final ValueChanged<int> onChanged;

  const _GuestPicker({
    required this.guests,
    required this.maxGuests,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.hairline),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'GUESTS',
                  style:
                      AppTypography.uppercaseTag.copyWith(color: AppColors.ink),
                ),
                const SizedBox(height: 2),
                Text(
                  '$guests guest${guests > 1 ? 's' : ''}',
                  style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
          _StepperButton(
            icon: Icons.remove,
            enabled: guests > 1,
            onTap: () => onChanged(guests - 1),
          ),
          const SizedBox(width: AppSpacing.sm),
          _StepperButton(
            icon: Icons.add,
            enabled: guests < maxGuests,
            onTap: () => onChanged(guests + 1),
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback? onTap;

  const _StepperButton({
    required this.icon,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? AppColors.ink : AppColors.hairline,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? AppColors.ink : AppColors.mutedSoft,
        ),
      ),
    );
  }
}

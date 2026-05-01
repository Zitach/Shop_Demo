import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/l10n/app_localizations.dart';
import 'package:shop_demo/shared/widgets/app_button.dart';

class ReservationCard extends StatefulWidget {
  final double pricePerNight;
  final int maxGuests;
  final String listingId;

  const ReservationCard({
    super.key,
    required this.pricePerNight,
    required this.maxGuests,
    required this.listingId,
  });

  @override
  State<ReservationCard> createState() => _ReservationCardState();
}

class _ReservationCardState extends State<ReservationCard> {
  DateTimeRange? _dateRange;
  int _guests = 1;

  int get _nights =>
      _dateRange != null
          ? DateFmt.nightsBetween(_dateRange!.start, _dateRange!.end)
          : 0;

  double get _subtotal => widget.pricePerNight * _nights;
  double get _cleaningFee => _nights > 0 ? 75 : 0;
  double get _serviceFee => _subtotal * 0.14;
  double get _total => _subtotal + _cleaningFee + _serviceFee;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.hairline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Price header
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                PriceFormatter.perNight(widget.pricePerNight),
                style: AppTypography.displaySm.copyWith(color: AppColors.ink),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.base),

          // Date picker
          _PickerField(
            label: l10n.checkIn.toUpperCase(),
            value: _dateRange != null
                ? DateFmt.monthDay(_dateRange!.start)
                : l10n.addDates,
            onTap: _pickDates,
          ),
          const SizedBox(height: 0),
          _PickerField(
            label: l10n.checkOut.toUpperCase(),
            value: _dateRange != null
                ? DateFmt.monthDay(_dateRange!.end)
                : l10n.addDates,
            onTap: _pickDates,
          ),
          const SizedBox(height: 0),
          _GuestPicker(
            guests: _guests,
            maxGuests: widget.maxGuests,
            onChanged: (v) => setState(() => _guests = v),
          ),

          const SizedBox(height: AppSpacing.base),
          AppButton.primary(
            label: l10n.reserve,
            onTap: _nights > 0
                ? () => context.push('/booking/${widget.listingId}')
                : null,
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: _nights > 0
                ? Column(
                    children: [
                      const SizedBox(height: AppSpacing.sm),
                      Center(
                        child: Text(
                          l10n.noChargeYet,
                          style: AppTypography.bodySm.copyWith(color: AppColors.muted),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.base),
                      const Divider(color: AppColors.hairlineSoft, height: 1),
                      const SizedBox(height: AppSpacing.base),
                      _FeeRow(
                        label:
                            '${PriceFormatter.format(widget.pricePerNight)} x $_nights nights',
                        value: PriceFormatter.formatDecimal(_subtotal),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _FeeRow(
                        label: l10n.cleaningFee,
                        value: PriceFormatter.formatDecimal(_cleaningFee),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _FeeRow(
                        label: l10n.serviceFee,
                        value: PriceFormatter.formatDecimal(_serviceFee),
                      ),
                      const SizedBox(height: AppSpacing.base),
                      const Divider(color: AppColors.hairlineSoft, height: 1),
                      const SizedBox(height: AppSpacing.base),
                      _FeeRow(
                        label: l10n.total,
                        value: PriceFormatter.formatDecimal(_total),
                        bold: true,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDates() async {
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
    final l10n = AppLocalizations.of(context)!;
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
                  l10n.guests.toUpperCase(),
                  style: AppTypography.uppercaseTag.copyWith(color: AppColors.ink),
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

class _FeeRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;

  const _FeeRow({
    required this.label,
    required this.value,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = bold
        ? AppTypography.titleSm.copyWith(color: AppColors.ink)
        : AppTypography.bodyMd.copyWith(color: AppColors.ink);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: style,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(value, style: style),
      ],
    );
  }
}

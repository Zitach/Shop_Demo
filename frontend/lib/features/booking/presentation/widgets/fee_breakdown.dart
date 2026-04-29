import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';

class FeeBreakdown extends StatelessWidget {
  final double nightlyRate;
  final int nights;
  final double cleaningFee;
  final double serviceFee;

  const FeeBreakdown({
    super.key,
    required this.nightlyRate,
    required this.nights,
    required this.cleaningFee,
    required this.serviceFee,
  });

  double get subtotal => nightlyRate * nights;
  double get total => subtotal + cleaningFee + serviceFee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.base),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          _FeeRow(
            label: '${PriceFormatter.format(nightlyRate)} x $nights nights',
            value: PriceFormatter.formatDecimal(subtotal),
          ),
          const SizedBox(height: AppSpacing.sm),
          _FeeRow(
            label: 'Cleaning fee',
            value: PriceFormatter.formatDecimal(cleaningFee),
          ),
          const SizedBox(height: AppSpacing.sm),
          _FeeRow(
            label: 'Service fee',
            value: PriceFormatter.formatDecimal(serviceFee),
          ),
          const SizedBox(height: AppSpacing.base),
          const Divider(color: AppColors.hairlineSoft, height: 1),
          const SizedBox(height: AppSpacing.base),
          _FeeRow(
            label: 'Total',
            value: PriceFormatter.formatDecimal(total),
            bold: true,
          ),
        ],
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

import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';

class GuestCounter extends StatelessWidget {
  final String label;
  final String subtitle;
  final int count;
  final int min;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const GuestCounter({
    super.key,
    required this.label,
    required this.subtitle,
    required this.count,
    this.min = 0,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final canDecrement = count > min;
    const maxCount = 16;
    final canIncrement = count < maxCount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.titleSm.copyWith(color: AppColors.ink),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySm.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
          _StepperButton(
            icon: Icons.remove,
            enabled: canDecrement,
            onTap: onDecrement,
          ),
          SizedBox(
            width: 40,
            child: Center(
              child: Text(
                '$count',
                style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
              ),
            ),
          ),
          _StepperButton(
            icon: Icons.add,
            enabled: canIncrement,
            onTap: onIncrement,
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

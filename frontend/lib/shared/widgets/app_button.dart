import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_typography.dart';

enum _AppButtonType { primary, secondary, tertiary }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final _AppButtonType _type;
  final bool enabled;
  final IconData? icon;

  const AppButton.primary({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.icon,
  }) : _type = _AppButtonType.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.icon,
  }) : _type = _AppButtonType.secondary;

  const AppButton.tertiary({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.icon,
  }) : _type = _AppButtonType.tertiary;

  @override
  Widget build(BuildContext context) {
    final effectiveOnTap = enabled ? onTap : null;

    return switch (_type) {
      _AppButtonType.primary => SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: effectiveOnTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: enabled ? AppColors.primary : AppColors.primaryDisabled,
              foregroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              textStyle: AppTypography.buttonMd,
            ),
            child: _buildChild(AppColors.onPrimary),
          ),
        ),
      _AppButtonType.secondary => SizedBox(
          height: 48,
          child: OutlinedButton(
            onPressed: effectiveOnTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.ink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              side: const BorderSide(color: AppColors.ink),
              textStyle: AppTypography.buttonMd,
            ),
            child: _buildChild(AppColors.ink),
          ),
        ),
      _AppButtonType.tertiary => TextButton(
          onPressed: effectiveOnTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.ink,
            textStyle: AppTypography.buttonMd,
          ),
          child: _buildChild(AppColors.ink),
        ),
    };
  }

  Widget _buildChild(Color iconColor) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(label),
        ],
      );
    }
    return Text(label);
  }
}

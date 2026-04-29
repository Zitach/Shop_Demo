import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class SearchBarPill extends StatelessWidget {
  final VoidCallback? onTap;
  final String? whereText;
  final String? whenText;
  final String? whoText;

  const SearchBarPill({
    super.key,
    this.onTap,
    this.whereText,
    this.whenText,
    this.whoText,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.circular(AppRadius.full),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSpacing.lg),
            const Icon(Icons.search, color: AppColors.ink, size: 24),
            const SizedBox(width: AppSpacing.md),
            _Segment(
              label: l10n.searchWhere,
              value: whereText ?? l10n.searchAnywhere,
            ),
            _divider(),
            _Segment(
              label: l10n.searchWhen,
              value: whenText ?? l10n.searchAnyWeek,
            ),
            _divider(),
            _Segment(
              label: l10n.searchWho,
              value: whoText ?? l10n.searchAddGuests,
            ),
            const Spacer(),
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search, color: AppColors.onPrimary, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 24,
      color: AppColors.hairline,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final String value;

  const _Segment({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.caption.copyWith(color: AppColors.ink)),
        const SizedBox(height: 2),
        Text(value, style: AppTypography.bodySm.copyWith(color: AppColors.muted)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class GuestFavoriteBadge extends StatelessWidget {
  const GuestFavoriteBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        AppLocalizations.of(context)!.guestFavorite,
        style: AppTypography.badge.copyWith(color: AppColors.ink),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorDisplay({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.muted),
            const SizedBox(height: AppSpacing.base),
            Text(message, style: AppTypography.bodySm.copyWith(color: AppColors.muted), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.base),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

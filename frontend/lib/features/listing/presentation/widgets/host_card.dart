import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';
import 'package:shop_demo/l10n/app_localizations.dart';
import 'package:shop_demo/shared/widgets/app_button.dart';

class HostCard extends StatelessWidget {
  final HostInfo host;

  const HostCard({super.key, required this.host});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.surfaceSoft,
              backgroundImage: CachedNetworkImageProvider(host.avatarUrl),
            ),
            const SizedBox(width: AppSpacing.base),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.listingHosted(host.name),
                    style: AppTypography.displaySm.copyWith(color: AppColors.ink),
                  ),
                  if (host.isSuperhost) ...[
                    const SizedBox(height: 2),
                    Text(
                      '${host.hostingYears} years hosting',
                      style: AppTypography.bodySm.copyWith(color: AppColors.muted),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        if (host.isSuperhost) ...[
          const SizedBox(height: AppSpacing.base),
          Row(
            children: [
              const Icon(Icons.verified, size: 18, color: AppColors.ink),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.superhost,
                style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${host.responseRate.toInt()}% response rate',
            style: AppTypography.bodySm.copyWith(color: AppColors.muted),
          ),
        ],
        if (host.bio != null) ...[
          const SizedBox(height: AppSpacing.base),
          Text(
            host.bio!,
            style: AppTypography.bodyMd.copyWith(color: AppColors.body),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: AppSpacing.base),
        Opacity(
          opacity: 0.5,
          child: AppButton.secondary(
            label: l10n.contactHost,
            icon: Icons.message_outlined,
            onTap: null,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/listing/domain/amenity.dart';

class AmenityList extends StatelessWidget {
  final List<Amenity> amenities;

  const AmenityList({super.key, required this.amenities});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < amenities.length; i++) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Row(
              children: [
                Icon(
                  _iconFor(amenities[i].iconKey),
                  size: 24,
                  color: AppColors.ink,
                ),
                const SizedBox(width: AppSpacing.base),
                Text(
                  amenities[i].name,
                  style: AppTypography.bodyMd.copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
          if (i < amenities.length - 1)
            const Divider(
              color: AppColors.hairlineSoft,
              height: 1,
              thickness: 1,
            ),
        ],
      ],
    );
  }

  static IconData _iconFor(String key) {
    switch (key) {
      case 'wifi':
        return Icons.wifi;
      case 'hot_tub':
        return Icons.hot_tub;
      case 'kitchen':
        return Icons.kitchen;
      case 'parking':
        return Icons.local_parking;
      case 'heating':
        return Icons.thermostat;
      case 'fireplace':
        return Icons.fireplace;
      case 'washer':
        return Icons.local_laundry_service;
      case 'dryer':
        return Icons.dry_cleaning;
      case 'ac':
        return Icons.ac_unit;
      case 'tv':
        return Icons.tv;
      case 'workspace':
        return Icons.laptop_mac;
      case 'pool':
        return Icons.pool;
      case 'beach':
        return Icons.beach_access;
      case 'grill':
        return Icons.outdoor_grill;
      case 'gym':
        return Icons.fitness_center;
      case 'ocean':
        return Icons.water;
      default:
        return Icons.check_circle_outline;
    }
  }
}

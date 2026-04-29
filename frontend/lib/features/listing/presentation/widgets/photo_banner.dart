import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/shared/widgets/photo_carousel.dart';

class PhotoBanner extends StatelessWidget {
  final String listingId;
  final List<String> imageUrls;

  const PhotoBanner({
    super.key,
    required this.listingId,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'listing_photo_$listingId',
      child: PhotoCarousel(
        imageUrls: imageUrls,
        aspectRatio: 16 / 9,
        borderRadius: BorderRadius.zero,
        overlays: [
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: _CircleIconButton(
              icon: Icons.arrow_back,
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }
}

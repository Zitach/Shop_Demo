import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';

class PhotoCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double aspectRatio;
  final BorderRadius? borderRadius;
  final List<Widget>? overlays;

  const PhotoCarousel({
    super.key,
    required this.imageUrls,
    this.aspectRatio = 1.0,
    this.borderRadius,
    this.overlays,
  });

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int _current = 0;
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ??
        BorderRadius.circular(AppRadius.md);

    return ClipRRect(
      borderRadius: radius,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.imageUrls.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.imageUrls[index],
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: AppColors.surfaceSoft),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.surfaceSoft,
                    child: const Icon(Icons.broken_image, color: AppColors.muted),
                  ),
                );
              },
            ),
            if (widget.imageUrls.length > 1)
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.imageUrls.length,
                    (i) => Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _current
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ),
            if (widget.overlays != null) ...widget.overlays!,
          ],
        ),
      ),
    );
  }
}

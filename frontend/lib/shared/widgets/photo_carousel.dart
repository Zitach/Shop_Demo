import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/shared/widgets/responsive_builder.dart';

class PhotoCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double aspectRatio;
  final BorderRadius? borderRadius;
  final List<Widget>? overlays;
  final String? heroTag;

  const PhotoCarousel({
    super.key,
    required this.imageUrls,
    this.aspectRatio = 1.0,
    this.borderRadius,
    this.overlays,
    this.heroTag,
  });

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int _current = 0;
  bool _isHovered = false;
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    if (_current > 0) {
      _controller.animateToPage(
        _current - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _next() {
    if (_current < widget.imageUrls.length - 1) {
      _controller.animateToPage(
        _current + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  Widget _buildImage(int index) {
    if (kIsWeb) {
      return Image.network(
        widget.imageUrls[index],
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Shimmer.fromColors(
            baseColor: AppColors.surfaceSoft,
            highlightColor: AppColors.canvas,
            child: Container(
              color: AppColors.surfaceSoft,
              alignment: Alignment.center,
              child: const Icon(Icons.image_outlined,
                  color: AppColors.mutedSoft, size: 32),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => Container(
          color: AppColors.surfaceSoft,
          child: const Icon(Icons.broken_image, color: AppColors.muted),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: widget.imageUrls[index],
      fit: BoxFit.cover,
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: AppColors.surfaceSoft,
        highlightColor: AppColors.canvas,
        child: Container(
          color: AppColors.surfaceSoft,
          alignment: Alignment.center,
          child: const Icon(Icons.image_outlined,
              color: AppColors.mutedSoft, size: 32),
        ),
      ),
      errorWidget: (_, __, ___) => Container(
        color: AppColors.surfaceSoft,
        child: const Icon(Icons.broken_image, color: AppColors.muted),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius =
        widget.borderRadius ?? BorderRadius.circular(AppRadius.md);
    final isDesktop = ResponsiveBuilder.isDesktop(context);

    return ClipRRect(
      borderRadius: radius,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: widget.imageUrls.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (context, index) {
                  final image = _buildImage(index);
                  // Hero wraps only the first image
                  if (widget.heroTag != null && index == 0) {
                    return Hero(
                      tag: widget.heroTag!,
                      child: image,
                    );
                  }
                  return image;
                },
              ),

              // Desktop arrow navigation
              if (isDesktop && widget.imageUrls.length > 1) ...[
                // Left arrow
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: _isHovered && _current > 0 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: Center(
                      child: _CircleIconButton(
                        icon: Icons.arrow_back_ios_new,
                        onTap: _prev,
                      ),
                    ),
                  ),
                ),
                // Right arrow
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: AnimatedOpacity(
                    opacity: _isHovered && _current < widget.imageUrls.length - 1
                        ? 1.0
                        : 0.0,
                    duration: const Duration(milliseconds: 150),
                    child: Center(
                      child: _CircleIconButton(
                        icon: Icons.arrow_forward_ios,
                        onTap: _next,
                      ),
                    ),
                  ),
                ),
              ],

              // Dot indicators
              if (widget.imageUrls.length > 1)
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.imageUrls.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: i == _current ? 8 : 6,
                        height: i == _current ? 8 : 6,
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
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(icon, size: 14, color: AppColors.ink),
      ),
    );
  }
}

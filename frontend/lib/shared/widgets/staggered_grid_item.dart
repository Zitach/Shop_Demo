import 'package:flutter/material.dart';

/// Wraps a grid item with a staggered fade + slide-up entry animation.
/// Each item gets its own AnimationController with a delay based on [index].
class StaggeredGridItem extends StatefulWidget {
  final int index;
  final Widget child;
  final Duration delayPerItem;
  final Duration animationDuration;
  final Curve curve;

  const StaggeredGridItem({
    super.key,
    required this.index,
    required this.child,
    this.delayPerItem = const Duration(milliseconds: 60),
    this.animationDuration = const Duration(milliseconds: 350),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<StaggeredGridItem> createState() => _StaggeredGridItemState();
}

class _StaggeredGridItemState extends State<StaggeredGridItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    final delay = widget.delayPerItem * widget.index;
    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = widget.curve.transform(_controller.value);
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - t)),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

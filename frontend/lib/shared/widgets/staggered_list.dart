import 'package:flutter/material.dart';

class StaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration delayPerItem;
  final Duration animationDuration;
  final Curve curve;

  const StaggeredList({
    super.key,
    required this.children,
    this.delayPerItem = const Duration(milliseconds: 60),
    this.animationDuration = const Duration(milliseconds: 350),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<StaggeredList> createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration +
          widget.delayPerItem * (widget.children.length - 1),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (i) {
        final start = (i * widget.delayPerItem.inMilliseconds) /
            _controller.duration!.inMilliseconds;
        final end = start + 0.5;
        if (end > 1.0) {
          return FadeTransition(
            opacity: _controller,
            child: widget.children[i],
          );
        }
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final anim = Interval(start, end, curve: widget.curve)
                .transform(_controller.value);
            return Opacity(
              opacity: anim,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - anim)),
                child: child,
              ),
            );
          },
          child: widget.children[i],
        );
      }),
    );
  }
}

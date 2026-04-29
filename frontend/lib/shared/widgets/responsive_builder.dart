import 'package:flutter/material.dart';

/// Breakpoint definitions following Airbnb's responsive grid:
/// - Mobile:  < 744px
/// - Tablet:  744px – 1127px
/// - Desktop: >= 1128px
enum ScreenBreakpoint { mobile, tablet, desktop }

/// Provides breakpoint info and responsive layout helpers.
///
/// Usage:
/// ```dart
/// ResponsiveBuilder(
///   builder: (context, breakpoint, child) {
///     switch (breakpoint) {
///       case ScreenBreakpoint.mobile:
///         return _buildMobile();
///       case ScreenBreakpoint.tablet:
///         return _buildTablet();
///       case ScreenBreakpoint.desktop:
///         return _buildDesktop();
///     }
///   },
/// )
/// ```
class ResponsiveBuilder extends StatelessWidget {
  static const double mobileBreakpoint = 744;
  static const double desktopBreakpoint = 1128;

  final Widget Function(
    BuildContext context,
    ScreenBreakpoint breakpoint,
    Widget? child,
  ) builder;

  /// Optional child widget that doesn't depend on breakpoint —
  /// avoids rebuilding it every time.
  final Widget? child;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.child,
  });

  static ScreenBreakpoint breakpointFor(double width) {
    if (width < mobileBreakpoint) return ScreenBreakpoint.mobile;
    if (width < desktopBreakpoint) return ScreenBreakpoint.tablet;
    return ScreenBreakpoint.desktop;
  }

  static bool isMobile(BuildContext context) =>
      breakpointFor(MediaQuery.sizeOf(context).width) ==
      ScreenBreakpoint.mobile;

  static bool isTablet(BuildContext context) =>
      breakpointFor(MediaQuery.sizeOf(context).width) ==
      ScreenBreakpoint.tablet;

  static bool isDesktop(BuildContext context) =>
      breakpointFor(MediaQuery.sizeOf(context).width) ==
      ScreenBreakpoint.desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bp = breakpointFor(constraints.maxWidth);
        return builder(context, bp, child);
      },
    );
  }
}

/// A convenience widget that switches between mobile and desktop builders.
class MobileDesktopSwitch extends StatelessWidget {
  final WidgetBuilder mobile;
  final WidgetBuilder desktop;
  final WidgetBuilder? tablet;

  const MobileDesktopSwitch({
    super.key,
    required this.mobile,
    required this.desktop,
    this.tablet,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, bp, _) {
        switch (bp) {
          case ScreenBreakpoint.mobile:
            return mobile(context);
          case ScreenBreakpoint.tablet:
            return (tablet ?? mobile)(context);
          case ScreenBreakpoint.desktop:
            return desktop(context);
        }
      },
    );
  }
}

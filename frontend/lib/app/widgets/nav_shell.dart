import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/widgets/bottom_nav_shell.dart';
import 'package:shop_demo/app/widgets/top_nav_bar.dart';
import 'package:shop_demo/shared/widgets/responsive_builder.dart';

/// Responsive navigation shell that shows:
/// - Bottom navigation bar on mobile/tablet (< 1128px)
/// - Top navigation bar on desktop (>= 1128px)
class NavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, breakpoint, _) {
        if (breakpoint == ScreenBreakpoint.desktop) {
          return _DesktopNavShell(navigationShell: navigationShell);
        }
        return BottomNavShell(navigationShell: navigationShell);
      },
    );
  }
}

class _DesktopNavShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const _DesktopNavShell({required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavBar(
        currentIndex: navigationShell.currentIndex,
        onNavigate: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
      body: navigationShell,
    );
  }
}

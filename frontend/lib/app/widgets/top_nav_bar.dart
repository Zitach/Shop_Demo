import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/auth/presentation/providers/auth_provider.dart';

/// Desktop top navigation bar shown on screens >= 1128px.
/// Contains logo (left), search bar (center), nav links (right),
/// and user avatar dropdown (far right).
class TopNavBar extends ConsumerWidget implements PreferredSizeWidget {
  final int currentIndex;
  final ValueChanged<int> onNavigate;

  const TopNavBar({
    super.key,
    required this.currentIndex,
    required this.onNavigate,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.valueOrNull;

    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.canvas,
        border: Border(bottom: BorderSide(color: AppColors.hairlineSoft)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Row(
        children: [
          // Logo
          GestureDetector(
            onTap: () => onNavigate(0),
            child: Text(
              'Shop Demo',
              style: AppTypography.titleMd.copyWith(color: AppColors.primary),
            ),
          ),

          const SizedBox(width: AppSpacing.xl),

          // Search bar (center)
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: GestureDetector(
                  onTap: () => context.push('/search'),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceSoft,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      border: Border.all(color: AppColors.hairline),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: AppSpacing.base),
                        const Icon(Icons.search, size: 18, color: AppColors.muted),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Search destinations',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.xl),

          // Nav links
          _NavLink(
            label: 'Home',
            isActive: currentIndex == 0,
            onTap: () => onNavigate(0),
          ),
          const SizedBox(width: AppSpacing.sm),
          _NavLink(
            label: 'Search',
            isActive: currentIndex == 1,
            onTap: () => onNavigate(1),
          ),
          const SizedBox(width: AppSpacing.sm),
          _NavLink(
            label: 'Favorites',
            isActive: currentIndex == 2,
            onTap: () => onNavigate(2),
          ),
          const SizedBox(width: AppSpacing.sm),
          _NavLink(
            label: 'Profile',
            isActive: currentIndex == 3,
            onTap: () => onNavigate(3),
          ),

          const SizedBox(width: AppSpacing.lg),

          // User avatar dropdown
          _UserAvatarDropdown(user: user),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Text(
          label,
          style: (isActive ? AppTypography.navLink : AppTypography.bodySm)
              .copyWith(
            color: isActive ? AppColors.ink : AppColors.muted,
            decoration: isActive ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}

class _UserAvatarDropdown extends ConsumerStatefulWidget {
  final dynamic user;

  const _UserAvatarDropdown({required this.user});

  @override
  ConsumerState<_UserAvatarDropdown> createState() =>
      _UserAvatarDropdownState();
}

class _UserAvatarDropdownState extends ConsumerState<_UserAvatarDropdown> {
  final _menuKey = GlobalKey();

  void _showMenu() {
    final renderBox =
        _menuKey.currentContext!.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final position = RelativeRect.fromRect(
      renderBox.localToGlobal(Offset.zero, ancestor: overlay) &
          renderBox.size,
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: context,
      position: position,
      color: AppColors.canvas,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side: const BorderSide(color: AppColors.hairline),
      ),
      items: [
        if (widget.user != null) ...[
          const PopupMenuItem(
            value: 'profile',
            child: Text('My Profile'),
          ),
          const PopupMenuItem(
            value: 'bookings',
            child: Text('My Bookings'),
          ),
          const PopupMenuItem(
            value: 'favorites',
            child: Text('Favorites'),
          ),
          const PopupMenuDivider(),
          const PopupMenuItem(
            value: 'logout',
            child: Text('Log out', style: TextStyle(color: AppColors.errorText)),
          ),
        ] else ...[
          const PopupMenuItem(
            value: 'login',
            child: Text('Log in'),
          ),
          const PopupMenuItem(
            value: 'register',
            child: Text('Sign up'),
          ),
        ],
      ],
    ).then((value) {
      if (value == null || !mounted) return;
      switch (value) {
        case 'profile':
          context.push('/profile');
        case 'bookings':
          context.push('/my-bookings');
        case 'favorites':
          context.push('/favorites');
        case 'login':
          context.push('/login');
        case 'register':
          context.push('/register');
        case 'logout':
          ref.read(authProvider.notifier).logout();
          context.go('/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _menuKey,
      onTap: _showMenu,
      child: Container(
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: AppColors.hairline),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.menu, size: 16, color: AppColors.ink),
            const SizedBox(width: AppSpacing.sm),
            CircleAvatar(
              radius: 14,
              backgroundColor: AppColors.surfaceStrong,
              child: widget.user != null && widget.user.avatarUrl != null
                  ? ClipOval(
                      child: Image.network(
                        widget.user.avatarUrl!,
                        width: 28,
                        height: 28,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          size: 16,
                          color: AppColors.muted,
                        ),
                      ),
                    )
                  : const Icon(Icons.person, size: 16, color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

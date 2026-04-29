import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: user == null
          ? _buildLoggedOut(context)
          : _buildLoggedIn(context, ref, user),
    );
  }

  Widget _buildLoggedOut(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surfaceSoft,
                border: Border.all(color: AppColors.hairline, width: 2),
              ),
              child:
                  const Icon(Icons.person, size: 40, color: AppColors.muted),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Welcome',
              style:
                  AppTypography.displayXl.copyWith(color: AppColors.ink),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Log in to view your profile, bookings, and favorites.',
              style:
                  AppTypography.bodyMd.copyWith(color: AppColors.muted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            SizedBox(
              width: 200,
              height: 48,
              child: ElevatedButton(
                onPressed: () => context.push('/login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  textStyle: AppTypography.buttonMd,
                ),
                child: const Text('Log in'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoggedIn(
      BuildContext context, WidgetRef ref, dynamic user) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      children: [
        // User info header
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: AppColors.surfaceSoft,
                backgroundImage: user.avatarUrl != null
                    ? NetworkImage(user.avatarUrl!)
                    : null,
                child: user.avatarUrl == null
                    ? Text(
                        user.name.isNotEmpty
                            ? user.name[0].toUpperCase()
                            : '?',
                        style: AppTypography.displayMd
                            .copyWith(color: AppColors.muted),
                      )
                    : null,
              ),
              const SizedBox(width: AppSpacing.base),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: AppTypography.titleMd
                          .copyWith(color: AppColors.ink),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      user.email,
                      style: AppTypography.bodySm
                          .copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.sm),

        // Menu items
        _ProfileMenuItem(
          icon: Icons.calendar_today_outlined,
          label: 'My Bookings',
          onTap: () => context.push('/my-bookings'),
        ),
        _ProfileMenuItem(
          icon: Icons.favorite_border,
          label: 'Favorites',
          onTap: () => context.push('/favorites'),
        ),
        _ProfileMenuItem(
          icon: Icons.settings_outlined,
          label: 'Settings',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Settings coming soon')),
            );
          },
        ),
        _ProfileMenuItem(
          icon: Icons.language_outlined,
          label: 'Language',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Language settings coming soon')),
            );
          },
        ),
        const SizedBox(height: AppSpacing.base),
        const Divider(color: AppColors.hairlineSoft, height: 1),
        const SizedBox(height: AppSpacing.sm),

        // Logout
        _ProfileMenuItem(
          icon: Icons.logout,
          label: 'Log out',
          iconColor: AppColors.errorText,
          onTap: () async {
            await ref.read(authProvider.notifier).logout();
            if (context.mounted) {
              context.go('/');
            }
          },
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Color? iconColor;

  const _ProfileMenuItem({
    required this.icon,
    required this.label,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? AppColors.ink),
      title: Text(
        label,
        style: AppTypography.bodyMd.copyWith(
          color: iconColor ?? AppColors.ink,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.muted,
      ),
      onTap: onTap,
    );
  }
}

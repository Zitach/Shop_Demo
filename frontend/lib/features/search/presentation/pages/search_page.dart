import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/extensions.dart';
import 'package:shop_demo/features/search/presentation/providers/search_provider.dart';
import 'package:shop_demo/features/search/presentation/widgets/search_overlay.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOverlay();
    });
  }

  void _showOverlay() {
    final isMobile = context.isMobile;
    if (isMobile) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (ctx) => SearchOverlay(
          onSearch: () {
            context.push('/search/results');
          },
        ),
      ).then((_) {
        // If dismissed without searching, pop back
        if (mounted && context.canPop()) {
          context.pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final filter = ref.watch(searchFilterProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.canvas,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.ink),
          onPressed: () => context.pop(),
        ),
        title: Container(
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(AppRadius.full),
          ),
          child: Row(
            children: [
              const SizedBox(width: AppSpacing.base),
              const Icon(Icons.search, color: AppColors.ink, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  filter.query ?? 'Search destinations',
                  style: AppTypography.bodyMd.copyWith(
                    color:
                        filter.query != null ? AppColors.ink : AppColors.muted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (filter.query != null)
                GestureDetector(
                  onTap: () {
                    ref.read(searchFilterProvider.notifier).updateQuery(null);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(right: AppSpacing.sm),
                    child: Icon(Icons.close, color: AppColors.ink, size: 18),
                  ),
                ),
            ],
          ),
        ),
        actions: [
          if (!isMobile)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _showDesktopOverlay(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.hairline),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.tune, size: 16, color: AppColors.ink),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          'Filters',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.ink,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: isMobile
          ? const SizedBox.shrink() // Overlay handles content on mobile
          : _DesktopSearchContent(
              onSearch: () => context.push('/search/results'),
            ),
    );
  }

  void _showDesktopOverlay(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Search filters',
      barrierColor: Colors.black.withValues(alpha: 0.3),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, _, __) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: SearchOverlay(
              onSearch: () {
                context.push('/search/results');
              },
            ),
          ),
        );
      },
    );
  }
}

class _DesktopSearchContent extends ConsumerWidget {
  final VoidCallback? onSearch;

  const _DesktopSearchContent({this.onSearch});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 64,
                color: AppColors.muted.withValues(alpha: 0.4),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Start your search',
                style: AppTypography.displayMd.copyWith(color: AppColors.ink),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Use the search bar above or filters to find your perfect stay',
                style: AppTypography.bodyMd.copyWith(color: AppColors.muted),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              ElevatedButton(
                onPressed: onSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.base,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  textStyle: AppTypography.buttonMd,
                ),
                child: const Text('Show all listings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/home/presentation/providers/home_provider.dart';
import 'package:shop_demo/features/home/presentation/widgets/category_strip.dart';
import 'package:shop_demo/features/home/presentation/widgets/listing_card.dart';
import 'package:shop_demo/features/home/presentation/widgets/search_bar_pill.dart';
import 'package:shop_demo/l10n/app_localizations.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';
import 'package:shop_demo/shared/widgets/skeleton_loader.dart';
import 'package:shop_demo/shared/widgets/staggered_grid_item.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final show = _scrollController.offset > 500;
    if (show != _showScrollToTop) {
      setState(() => _showScrollToTop = show);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = ref.watch(categoriesProvider);
    final listings = ref.watch(featuredListingsProvider);
    final selectedCategoryId = ref.watch(selectedCategoryIdProvider);

    return Scaffold(
      floatingActionButton: _showScrollToTop
          ? FloatingActionButton.small(
              onPressed: () => _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
              ),
              backgroundColor: AppColors.canvas,
              foregroundColor: AppColors.ink,
              elevation: 2,
              child: const Icon(Icons.keyboard_arrow_up),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(categoriesProvider);
          ref.invalidate(featuredListingsProvider);
          await Future.wait([
            ref.read(categoriesProvider.future),
            ref.read(featuredListingsProvider.future),
          ]);
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.base, AppSpacing.md, AppSpacing.base, AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.appName,
                      style: AppTypography.titleMd.copyWith(color: AppColors.primary),
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.surfaceStrong,
                      child: Icon(Icons.person, size: 18, color: AppColors.ink),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.sm,
                ),
                child: SearchBarPill(
                  onTap: () => context.push('/search'),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: categories.when(
                data: (cats) => CategoryStrip(
                  categories: cats,
                  selectedId: selectedCategoryId,
                  onSelected: (category) {
                    final current = ref.read(selectedCategoryIdProvider);
                    if (current == category.id) {
                      ref.read(selectedCategoryIdProvider.notifier).state = null;
                    } else {
                      ref.read(selectedCategoryIdProvider.notifier).state = category.id;
                    }
                  },
                ),
                loading: () => const CategoryStripSkeleton(),
                error: (e, _) => SizedBox(
                  height: 72,
                  child: Center(child: Text(l10n.error)),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(color: AppColors.hairlineSoft, height: 1),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.base, AppSpacing.lg, AppSpacing.base, AppSpacing.base,
                ),
                child: Text(
                  l10n.homeTitle,
                  style: AppTypography.displayXl.copyWith(color: AppColors.ink),
                ),
              ),
            ),
            listings.when(
              data: (items) => SliverLayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = switch (constraints.crossAxisExtent) {
                    < 744 => 1,
                    < 1128 => 2,
                    < 1440 => 3,
                    _ => 4,
                  };

                  if (crossAxisCount == 1) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(
                            left: AppSpacing.base,
                            right: AppSpacing.base,
                            bottom: AppSpacing.lg,
                          ),
                          child: StaggeredGridItem(
                            index: index,
                            child: ListingCardWidget(
                              listing: items[index],
                              onTap: () => context.push('/listing/${items[index].id}'),
                            ),
                          ),
                        ),
                        childCount: items.length,
                      ),
                    );
                  }

                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: AppSpacing.base,
                      mainAxisSpacing: AppSpacing.lg,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => StaggeredGridItem(
                        index: index,
                        child: ListingCardWidget(
                          listing: items[index],
                          onTap: () => context.push('/listing/${items[index].id}'),
                        ),
                      ),
                      childCount: items.length,
                    ),
                  );
                },
              ),
              loading: () => const SliverToBoxAdapter(
                child: ListingGridSkeleton(),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: ErrorDisplay(
                  message: l10n.error,
                  onRetry: () => ref.invalidate(featuredListingsProvider),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.section),
            ),
          ],
        ),
      ),
    );
  }
}

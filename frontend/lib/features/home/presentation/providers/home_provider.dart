import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/core/providers/core_providers.dart';
import 'package:shop_demo/features/home/data/home_repository.dart';
import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(ref.read(apiClientProvider));
});

final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) {
  return ref.watch(homeRepositoryProvider).getCategories();
});

final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);

final featuredListingsProvider =
    FutureProvider.autoDispose<List<ListingCard>>((ref) {
  final categoryId = ref.watch(selectedCategoryIdProvider);
  return ref.watch(homeRepositoryProvider).getFeaturedListings(
        category: categoryId,
      );
});

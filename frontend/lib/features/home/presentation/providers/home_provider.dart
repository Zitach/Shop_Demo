import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/features/home/data/home_repository.dart';
import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) {
  return ref.watch(homeRepositoryProvider).getCategories();
});

final featuredListingsProvider =
    FutureProvider.autoDispose<List<ListingCard>>((ref) {
  return ref.watch(homeRepositoryProvider).getFeaturedListings();
});

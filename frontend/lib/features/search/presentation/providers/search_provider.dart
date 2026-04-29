import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';
import 'package:shop_demo/features/search/data/search_repository.dart';
import 'package:shop_demo/features/search/domain/search_filter.dart';

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepository();
});

class SearchFilterNotifier extends StateNotifier<SearchFilter> {
  SearchFilterNotifier() : super(const SearchFilter());

  void updateQuery(String? query) {
    state = state.copyWith(query: query);
  }

  void updateCategory(String? category) {
    state = state.copyWith(category: category);
  }

  void updateDateRange(DateTimeRange? dateRange) {
    state = state.copyWith(dateRange: dateRange);
  }

  void updateGuests({int? adults, int? children, int? infants}) {
    state = state.copyWith(
      adults: adults ?? state.adults,
      children: children ?? state.children,
      infants: infants ?? state.infants,
    );
  }

  void updatePriceRange({double? minPrice, double? maxPrice}) {
    state = state.copyWith(
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  void updateSortBy(SortBy sortBy) {
    state = state.copyWith(sortBy: sortBy);
  }

  void clear() {
    state = const SearchFilter();
  }
}

final searchFilterProvider =
    StateNotifierProvider.autoDispose<SearchFilterNotifier, SearchFilter>(
  (ref) => SearchFilterNotifier(),
);

final searchResultsProvider = FutureProvider.autoDispose<List<ListingCard>>(
  (ref) async {
    final filter = ref.watch(searchFilterProvider);
    final repo = ref.watch(searchRepositoryProvider);
    return repo.search(filter);
  },
);

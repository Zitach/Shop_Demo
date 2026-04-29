import 'package:shop_demo/features/home/data/home_mock_data.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';
import 'package:shop_demo/features/search/domain/search_filter.dart';

class SearchRepository {
  Future<List<ListingCard>> search(SearchFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 400));
    var results = [...HomeMockData.listings];

    if (filter.query != null && filter.query!.isNotEmpty) {
      final q = filter.query!.toLowerCase();
      results = results.where((l) =>
        l.title.toLowerCase().contains(q) ||
        l.location.toLowerCase().contains(q)).toList();
    }

    if (filter.minPrice != null) {
      results = results.where((l) => l.pricePerNight >= filter.minPrice!).toList();
    }
    if (filter.maxPrice != null) {
      results = results.where((l) => l.pricePerNight <= filter.maxPrice!).toList();
    }

    switch (filter.sortBy) {
      case SortBy.priceLow:
        results.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
      case SortBy.priceHigh:
        results.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
      case SortBy.rating:
        results.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
      case SortBy.newest:
        break;
      case SortBy.relevance:
        break;
    }

    return results;
  }
}

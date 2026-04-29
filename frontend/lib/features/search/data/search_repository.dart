import 'package:shop_demo/features/home/data/home_mock_data.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';
import 'package:shop_demo/features/search/domain/search_filter.dart';

class SearchRepository {
  Future<List<ListingCard>> search(SearchFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var results = List<ListingCard>.from(HomeMockData.listings);

    // Filter by query (title or location)
    if (filter.query != null && filter.query!.isNotEmpty) {
      final q = filter.query!.toLowerCase();
      results = results
          .where((l) =>
              l.title.toLowerCase().contains(q) ||
              l.location.toLowerCase().contains(q))
          .toList();
    }

    // Filter by category
    if (filter.category != null && filter.category!.isNotEmpty) {
      // Category matching is title-based for mock data
      final cat = filter.category!.toLowerCase();
      results = results
          .where((l) => l.title.toLowerCase().contains(cat))
          .toList();
    }

    // Filter by price range
    if (filter.minPrice != null) {
      results =
          results.where((l) => l.pricePerNight >= filter.minPrice!).toList();
    }
    if (filter.maxPrice != null) {
      results =
          results.where((l) => l.pricePerNight <= filter.maxPrice!).toList();
    }

    // Sort
    switch (filter.sortBy) {
      case SortBy.priceLow:
        results.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
      case SortBy.priceHigh:
        results.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
      case SortBy.rating:
        results.sort((a, b) {
          final aR = a.rating ?? 0;
          final bR = b.rating ?? 0;
          return bR.compareTo(aR);
        });
      case SortBy.newest:
        // Mock data has no date field; keep original order
        break;
      case SortBy.relevance:
        break;
    }

    return results;
  }
}

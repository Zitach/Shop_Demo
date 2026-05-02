import 'package:shop_demo/core/constants/app_constants.dart';
import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/features/home/data/home_mock_data.dart';
import 'package:shop_demo/features/home/data/models/listing_card_model.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';
import 'package:shop_demo/features/search/domain/search_filter.dart';

class SearchRepository {
  final ApiClient _apiClient;

  SearchRepository(this._apiClient);

  Future<List<ListingCard>> search(SearchFilter filter) async {
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 400));
      var results = [...HomeMockData.listings];

      if (filter.query != null && filter.query!.isNotEmpty) {
        final q = filter.query!.toLowerCase();
        results = results
            .where((l) =>
                l.title.toLowerCase().contains(q) ||
                l.location.toLowerCase().contains(q))
            .toList();
      }
      if (filter.minPrice != null) {
        results =
            results.where((l) => l.pricePerNight >= filter.minPrice!).toList();
      }
      if (filter.maxPrice != null) {
        results =
            results.where((l) => l.pricePerNight <= filter.maxPrice!).toList();
      }
      if (filter.category != null && filter.category!.isNotEmpty) {
        final c = filter.category!.toLowerCase();
        results =
            results.where((l) => l.location.toLowerCase().contains(c)).toList();
      }

      switch (filter.sortBy) {
        case SortBy.priceLow:
          results.sort((a, b) => a.pricePerNight.compareTo(b.pricePerNight));
        case SortBy.priceHigh:
          results.sort((a, b) => b.pricePerNight.compareTo(a.pricePerNight));
        case SortBy.rating:
          results
              .sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
        case SortBy.newest:
        case SortBy.relevance:
          break;
      }
      return results;
    }

    final queryParams = <String, dynamic>{};

    if (filter.query != null && filter.query!.isNotEmpty) {
      queryParams['q'] = filter.query;
    }
    if (filter.category != null && filter.category!.isNotEmpty) {
      queryParams['category'] = filter.category;
    }
    if (filter.minPrice != null) {
      queryParams['minPrice'] = filter.minPrice.toString();
    }
    if (filter.maxPrice != null) {
      queryParams['maxPrice'] = filter.maxPrice.toString();
    }
    if (filter.totalGuests > 0) {
      queryParams['guests'] = filter.totalGuests.toString();
    }
    if (filter.sortBy != SortBy.relevance) {
      queryParams['sortBy'] = _sortByToString(filter.sortBy);
    }

    final response = await _apiClient.dio.get(
      '/api/listings/search',
      queryParameters: queryParams,
    );

    final data = response.data;
    if (data is List) {
      return ListingCardModel.listFromJson(data);
    }
    if (data is Map<String, dynamic> && data['data'] is List) {
      return ListingCardModel.listFromJson(data['data'] as List);
    }
    if (data is Map<String, dynamic> && data['listings'] is List) {
      return ListingCardModel.listFromJson(data['listings'] as List);
    }
    return [];
  }

  String _sortByToString(SortBy sortBy) {
    return switch (sortBy) {
      SortBy.priceLow => 'price_asc',
      SortBy.priceHigh => 'price_desc',
      SortBy.rating => 'rating',
      SortBy.newest => 'newest',
      SortBy.relevance => 'relevance',
    };
  }
}

import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/features/home/data/models/listing_card_model.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';
import 'package:shop_demo/features/search/domain/search_filter.dart';

class SearchRepository {
  final ApiClient _apiClient;

  SearchRepository(this._apiClient);

  Future<List<ListingCard>> search(SearchFilter filter) async {
    final queryParams = <String, dynamic>{};

    if (filter.query != null && filter.query!.isNotEmpty) {
      queryParams['q'] = filter.query;
    }
    if (filter.category != null && filter.category!.isNotEmpty) {
      queryParams['category'] = filter.category;
    }
    if (filter.minPrice != null) {
      queryParams['minPrice'] = filter.minPrice;
    }
    if (filter.maxPrice != null) {
      queryParams['maxPrice'] = filter.maxPrice;
    }
    if (filter.dateRange != null) {
      queryParams['checkIn'] = filter.dateRange!.start.toIso8601String();
      queryParams['checkOut'] = filter.dateRange!.end.toIso8601String();
    }
    queryParams['adults'] = filter.adults;
    if (filter.children > 0) {
      queryParams['children'] = filter.children;
    }
    if (filter.infants > 0) {
      queryParams['infants'] = filter.infants;
    }

    // Map sort
    switch (filter.sortBy) {
      case SortBy.priceLow:
        queryParams['sort'] = 'price_asc';
      case SortBy.priceHigh:
        queryParams['sort'] = 'price_desc';
      case SortBy.rating:
        queryParams['sort'] = 'rating';
      case SortBy.newest:
        queryParams['sort'] = 'newest';
      case SortBy.relevance:
        break;
    }

    final response =
        await _apiClient.dio.get('/api/listings', queryParameters: queryParams);
    final data = response.data;
    if (data is List) {
      return ListingCardModel.listFromJson(data);
    }
    if (data is Map<String, dynamic> && data['data'] is List) {
      return ListingCardModel.listFromJson(data['data'] as List);
    }
    return [];
  }
}

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

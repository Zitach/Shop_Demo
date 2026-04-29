import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/features/home/data/models/category_model.dart';
import 'package:shop_demo/features/home/data/models/listing_card_model.dart';
import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

class HomeRepository {
  final ApiClient _apiClient;

  HomeRepository(this._apiClient);

  Future<List<Category>> getCategories() async {
    final response = await _apiClient.dio.get('/api/categories');
    final data = response.data;
    if (data is List) {
      return CategoryModel.listFromJson(data);
    }
    if (data is Map<String, dynamic> && data['data'] is List) {
      return CategoryModel.listFromJson(data['data'] as List);
    }
    return [];
  }

  Future<List<ListingCard>> getFeaturedListings() async {
    final response = await _apiClient.dio.get('/api/listings', queryParameters: {
      'featured': true,
      'limit': 20,
    });
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

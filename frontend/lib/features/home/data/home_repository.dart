import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/features/home/data/models/category_model.dart';
import 'package:shop_demo/features/home/data/models/listing_card_model.dart';
import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

abstract class HomeRepository {
  Future<List<Category>> getCategories();
  Future<List<ListingCard>> getFeaturedListings({String? category});
}

class HomeRepositoryImpl implements HomeRepository {
  final ApiClient _apiClient;

  HomeRepositoryImpl(this._apiClient);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await _apiClient.dio.get('/api/categories');
      final data = response.data;
      if (data is List) {
        return CategoryModel.listFromJson(data);
      }
      if (data is Map<String, dynamic> && data['data'] is List) {
        return CategoryModel.listFromJson(data['data'] as List);
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  @override
  Future<List<ListingCard>> getFeaturedListings({String? category}) async {
    try {
      final response = await _apiClient.dio.get(
        '/api/listings',
        queryParameters: category != null ? {'category': category} : null,
      );
      final data = response.data;
      if (data is List) {
        return ListingCardModel.listFromJson(data);
      }
      if (data is Map<String, dynamic> && data['data'] is List) {
        return ListingCardModel.listFromJson(data['data'] as List);
      }
      return [];
    } catch (_) {
      return [];
    }
  }
}

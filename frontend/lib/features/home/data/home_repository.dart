import 'package:shop_demo/features/home/data/home_mock_data.dart';
import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

class HomeRepository {
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return HomeMockData.categories;
  }

  Future<List<ListingCard>> getFeaturedListings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return HomeMockData.listings;
  }
}

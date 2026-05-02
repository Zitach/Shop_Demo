import 'package:shop_demo/core/constants/app_constants.dart';
import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/features/listing/data/listing_mock_data.dart';
import 'package:shop_demo/features/listing/data/models/listing_detail_model.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';

class ListingRepository {
  final ApiClient _apiClient;

  ListingRepository(this._apiClient);

  Future<ListingDetail?> getById(String id) async {
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 400));
      return ListingMockData.listings[id];
    }
    final response = await _apiClient.dio.get('/api/listings/$id');
    final data = response.data as Map<String, dynamic>;
    final listingData =
        data.containsKey('data') ? data['data'] as Map<String, dynamic> : data;
    return ListingDetailModel.fromJson(listingData);
  }
}

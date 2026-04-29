import 'package:shop_demo/features/listing/data/listing_mock_data.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';

class ListingRepository {
  Future<ListingDetail?> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return ListingMockData.listings[id];
  }
}

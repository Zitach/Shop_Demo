import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/core/providers/core_providers.dart';
import 'package:shop_demo/features/listing/data/listing_repository.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';

final listingRepositoryProvider = Provider<ListingRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ListingRepository(apiClient);
});

final listingDetailProvider = FutureProvider.autoDispose
    .family<ListingDetail?, String>((ref, id) async {
  final repo = ref.watch(listingRepositoryProvider);
  return repo.getById(id);
});

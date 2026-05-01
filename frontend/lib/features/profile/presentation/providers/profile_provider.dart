import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/core/providers/core_providers.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';
import 'package:shop_demo/features/profile/data/repositories/profile_repository_impl.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localStorage = ref.watch(localStorageProvider);
  return ProfileRepositoryImpl(apiClient, localStorage);
});

/// Provider for the set of favorite listing IDs.
final favoriteIdsProvider =
    AsyncNotifierProvider<FavoriteIdsNotifier, Set<String>>(
        FavoriteIdsNotifier.new);

class FavoriteIdsNotifier extends AsyncNotifier<Set<String>> {
  @override
  Future<Set<String>> build() async {
    final repo = ref.watch(profileRepositoryProvider);
    return repo.getFavoriteIds();
  }

  Future<void> toggle(String listingId) async {
    final repo = ref.read(profileRepositoryProvider);
    await repo.toggleFavorite(listingId);
    ref.invalidateSelf();
  }

  bool isFavorite(String listingId) {
    final ids = state.valueOrNull ?? {};
    return ids.contains(listingId);
  }
}

/// Provider for favorite listings (full data).
final favoriteListingsProvider =
    AsyncNotifierProvider<FavoriteListingsNotifier, List<ListingCard>>(
        FavoriteListingsNotifier.new);

class FavoriteListingsNotifier extends AsyncNotifier<List<ListingCard>> {
  @override
  Future<List<ListingCard>> build() async {
    final repo = ref.watch(profileRepositoryProvider);
    return repo.getFavorites();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

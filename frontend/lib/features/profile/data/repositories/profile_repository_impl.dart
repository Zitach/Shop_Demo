import 'package:shop_demo/core/storage/local_storage.dart';
import 'package:shop_demo/features/home/data/models/listing_card_model.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

abstract class ProfileRepository {
  Future<List<ListingCard>> getFavorites();
  Future<void> toggleFavorite(String listingId);
  Future<bool> isFavorite(String listingId);
  Future<Set<String>> getFavoriteIds();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final LocalStorage _localStorage;

  static const _favoritesKey = 'favorite_listing_ids';

  ProfileRepositoryImpl(this._localStorage);

  @override
  Future<List<ListingCard>> getFavorites() async {
    final ids = await getFavoriteIds();
    if (ids.isEmpty) return [];

    // Load cached listing data for favorites
    final cachedListings = _localStorage.get<List>('cached_listings');
    if (cachedListings != null) {
      final allListings = cachedListings
          .map((e) =>
              ListingCardModel.fromJson((e as Map).cast<String, dynamic>()))
          .toList();
      return allListings.where((l) => ids.contains(l.id)).toList();
    }

    // If no cached listings, return empty (favorites data stored as IDs only)
    return [];
  }

  @override
  Future<void> toggleFavorite(String listingId) async {
    final ids = await getFavoriteIds();
    if (ids.contains(listingId)) {
      ids.remove(listingId);
    } else {
      ids.add(listingId);
    }
    await _localStorage.set(_favoritesKey, ids.toList());
  }

  @override
  Future<bool> isFavorite(String listingId) async {
    final ids = await getFavoriteIds();
    return ids.contains(listingId);
  }

  @override
  Future<Set<String>> getFavoriteIds() async {
    final raw = _localStorage.get<List>(_favoritesKey);
    if (raw == null) return {};
    return raw.map((e) => e.toString()).toSet();
  }
}

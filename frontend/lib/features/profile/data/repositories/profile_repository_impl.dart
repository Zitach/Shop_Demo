import 'package:shop_demo/core/constants/app_constants.dart';
import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/core/storage/local_storage.dart';
import 'package:shop_demo/features/home/data/home_mock_data.dart';
import 'package:shop_demo/features/home/data/models/listing_card_model.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

abstract class ProfileRepository {
  Future<List<ListingCard>> getFavorites();
  Future<void> toggleFavorite(String listingId);
  Future<bool> isFavorite(String listingId);
  Future<Set<String>> getFavoriteIds();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  static const _favoritesKey = 'favorite_listing_ids';

  ProfileRepositoryImpl(this._apiClient, this._localStorage);

  bool get _isLoggedIn => _localStorage.isLoggedIn;

  static const _mockFavoriteIds = {
    'd0000000-0000-0000-0000-000000000001',
    'd0000000-0000-0000-0000-000000000002',
    'd0000000-0000-0000-0000-000000000003',
  };

  Set<String> _getStoredFavoriteIds() {
    final raw = _localStorage.get<List>(_favoritesKey);
    if (raw == null) return {};
    return raw.map((e) => e.toString()).toSet();
  }

  @override
  Future<List<ListingCard>> getFavorites() async {
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      final ids = _getStoredFavoriteIds();
      final allIds = ids.isEmpty ? _mockFavoriteIds : ids;
      return HomeMockData.listings
          .where((l) => allIds.contains(l.id))
          .toList();
    }

    if (_isLoggedIn) {
      try {
        final response = await _apiClient.dio.get('/api/user/favorites');
        final data = response.data as Map<String, dynamic>;
        final list =
            (data.containsKey('data') ? data['data'] : data) as List<dynamic>;
        return list
            .map((e) => ListingCardModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        return [];
      }
    }

    final ids = await getFavoriteIds();
    if (ids.isEmpty) return [];

    final cachedListings = _localStorage.get<List>('cached_listings');
    if (cachedListings != null) {
      final allListings = cachedListings
          .map((e) =>
              ListingCardModel.fromJson((e as Map).cast<String, dynamic>()))
          .toList();
      return allListings.where((l) => ids.contains(l.id)).toList();
    }

    return [];
  }

  @override
  Future<void> toggleFavorite(String listingId) async {
    if (AppConstants.useMockData) {
      final ids = _getStoredFavoriteIds();
      if (ids.contains(listingId)) {
        ids.remove(listingId);
      } else {
        ids.add(listingId);
      }
      await _localStorage.set(_favoritesKey, ids.toList());
      return;
    }

    if (_isLoggedIn) {
      await _apiClient.dio.post(
        '/api/user/favorites',
        data: {'listingId': listingId},
      );
      return;
    }

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
    if (AppConstants.useMockData) {
      final ids = _getStoredFavoriteIds();
      final checkIds = ids.isEmpty ? _mockFavoriteIds : ids;
      return checkIds.contains(listingId);
    }

    if (_isLoggedIn) {
      try {
        final response = await _apiClient.dio.get('/api/user/favorites');
        final data = response.data as Map<String, dynamic>;
        final list =
            (data.containsKey('data') ? data['data'] : data) as List<dynamic>;
        final ids = list
            .map((e) => (e as Map<String, dynamic>)['id']?.toString())
            .whereType<String>()
            .toSet();
        return ids.contains(listingId);
      } catch (_) {
        return false;
      }
    }

    final ids = await getFavoriteIds();
    return ids.contains(listingId);
  }

  @override
  Future<Set<String>> getFavoriteIds() async {
    if (AppConstants.useMockData) {
      final ids = _getStoredFavoriteIds();
      return ids.isEmpty ? _mockFavoriteIds : ids;
    }

    if (_isLoggedIn) {
      try {
        final response = await _apiClient.dio.get('/api/user/favorites');
        final data = response.data as Map<String, dynamic>;
        final list =
            (data.containsKey('data') ? data['data'] : data) as List<dynamic>;
        return list
            .map((e) => (e as Map<String, dynamic>)['id']?.toString())
            .whereType<String>()
            .toSet();
      } catch (_) {
        return {};
      }
    }

    final raw = _localStorage.get<List>(_favoritesKey);
    if (raw == null) return {};
    return raw.map((e) => e.toString()).toSet();
  }

  Future<void> removeFavorite(String listingId) async {
    if (AppConstants.useMockData) {
      final ids = _getStoredFavoriteIds();
      ids.remove(listingId);
      await _localStorage.set(_favoritesKey, ids.toList());
      return;
    }

    if (_isLoggedIn) {
      await _apiClient.dio.delete('/api/user/favorites/$listingId');
      return;
    }

    final ids = await getFavoriteIds();
    ids.remove(listingId);
    await _localStorage.set(_favoritesKey, ids.toList());
  }

  Future<void> syncLocalFavoritesToBackend() async {
    if (!_isLoggedIn) return;

    final localIds = _localStorage.get<List>(_favoritesKey);
    if (localIds == null || localIds.isEmpty) return;

    for (final id in localIds) {
      try {
        await _apiClient.dio.post(
          '/api/user/favorites',
          data: {'listingId': id.toString()},
        );
      } catch (_) {
        // Ignore individual sync failures
      }
    }

    await _localStorage.remove(_favoritesKey);
  }
}

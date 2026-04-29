import 'package:drift/drift.dart';

import '../database_context.dart';
import '../tables/tables.dart';

part 'listing_dao.g.dart';

/// Data Access Object for Listings
@DriftAccessor(tables: [Listings, Images, Amenities, ListingAmenities, Favorites])
class ListingDao extends DatabaseAccessor<AppDatabase> with _$ListingDaoMixin {
  ListingDao(AppDatabase db) : super(db);

  /// Get all active listings
  Future<List<Listing>> getActiveListings() =>
      (select(listings)..where((l) => l.isActive.equals(true))).get();

  /// Get featured listings
  Future<List<Listing>> getFeaturedListings() =>
      (select(listings)
            ..where((l) => l.isFeatured.equals(true) & l.isActive.equals(true))
            ..orderBy([(l) => OrderingTerm.desc(l.createdAt)]))
          .get();

  /// Get listings by category
  Future<List<Listing>> getListingsByCategory(String categoryId) =>
      (select(listings)
            ..where((l) =>
                l.categoryId.equals(categoryId) & l.isActive.equals(true))
            ..orderBy([(l) => OrderingTerm.desc(l.createdAt)]))
          .get();

  /// Get listings by host
  Future<List<Listing>> getListingsByHost(String hostId) =>
      (select(listings)
            ..where((l) => l.hostId.equals(hostId))
            ..orderBy([(l) => OrderingTerm.desc(l.createdAt)]))
          .get();

  /// Get listing by ID
  Future<Listing?> getListingById(String id) =>
      (select(listings)..where((l) => l.id.equals(id))).getSingleOrNull();

  /// Search listings with filters
  Future<List<Listing>> searchListings({
    String? query,
    String? city,
    String? country,
    double? minPrice,
    double? maxPrice,
    int? minGuests,
    String? categoryId,
    List<String>? amenityIds,
    String sortBy = 'created_at',
    bool ascending = false,
    int limit = 20,
    int offset = 0,
  }) async {
    final queryBuilder = select(listings)
      ..where((l) => l.isActive.equals(true));

    if (query != null && query.isNotEmpty) {
      final searchPattern = '%\$query%';
      queryBuilder.where(
          (l) => l.title.like(searchPattern) | l.description.like(searchPattern));
    }

    if (city != null) {
      queryBuilder.where((l) => l.city.equals(city));
    }

    if (country != null) {
      queryBuilder.where((l) => l.country.equals(country));
    }

    if (minPrice != null) {
      queryBuilder.where((l) => l.pricePerUnit.isBiggerOrEqualValue(minPrice));
    }

    if (maxPrice != null) {
      queryBuilder.where((l) => l.pricePerUnit.isSmallerOrEqualValue(maxPrice));
    }

    if (minGuests != null) {
      queryBuilder.where((l) => l.maxGuests.isBiggerOrEqualValue(minGuests));
    }

    if (categoryId != null) {
      queryBuilder.where((l) => l.categoryId.equals(categoryId));
    }

    // Sort
    queryBuilder.orderBy([
      (l) {
        switch (sortBy) {
          case 'price':
            return ascending
                ? OrderingTerm.asc(l.pricePerUnit)
                : OrderingTerm.desc(l.pricePerUnit);
          case 'rating':
            return ascending
                ? OrderingTerm.asc(l.avgRating)
                : OrderingTerm.desc(l.avgRating);
          default:
            return ascending
                ? OrderingTerm.asc(l.createdAt)
                : OrderingTerm.desc(l.createdAt);
        }
      },
    ]);

    queryBuilder.limit(limit, offset: offset);

    return queryBuilder.get();
  }

  /// Create a new listing
  Future<int> createListing(ListingsCompanion listing) =>
      into(listings).insert(listing);

  /// Update listing
  Future<bool> updateListing(String id, ListingsCompanion listing) async {
    final updated =
        await (update(listings)..where((l) => l.id.equals(id))).write(
            listing.copyWith(updatedAt: Value(DateTime.now())));
    return updated > 0;
  }

  /// Update listing rating
  Future<bool> updateListingRating({
    required String id,
    required double avgRating,
    required int reviewCount,
  }) async {
    final updated =
        await (update(listings)..where((l) => l.id.equals(id))).write(
            ListingsCompanion(
      avgRating: Value(avgRating),
      reviewCount: Value(reviewCount),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// Deactivate listing
  Future<bool> deactivateListing(String id) async {
    final updated =
        await (update(listings)..where((l) => l.id.equals(id))).write(
            ListingsCompanion(
      isActive: const Value(false),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// Delete listing
  Future<int> deleteListing(String id) =>
      (delete(listings)..where((l) => l.id.equals(id))).go();

  /// Get images for a listing
  Future<List<Image>> getListingImages(String listingId) =>
      (select(images)
            ..where((i) => i.listingId.equals(listingId))
            ..orderBy([(i) => OrderingTerm.asc(i.sortOrder)]))
          .get();

  /// Get amenities for a listing
  Future<List<Amenity>> getListingAmenities(String listingId) async {
    final query = select(amenities).join([
      innerJoin(
        listingAmenities,
        listingAmenities.amenityId.equalsExp(amenities.id),
      ),
    ])
      ..where(listingAmenities.listingId.equals(listingId));

    final results = await query.get();
    return results.map((row) => row.readTable(amenities)).toList();
  }

  /// Add image to listing
  Future<int> addImage(ImagesCompanion image) => into(images).insert(image);

  /// Add amenity to listing
  Future<void> addAmenityToListing(String listingId, String amenityId) =>
      into(listingAmenities).insert(ListingAmenitiesCompanion(
        listingId: Value(listingId),
        amenityId: Value(amenityId),
      ));

  /// Remove amenity from listing
  Future<int> removeAmenityFromListing(String listingId, String amenityId) =>
      (delete(listingAmenities)
            ..where((la) =>
                la.listingId.equals(listingId) &
                la.amenityId.equals(amenityId)))
          .go();

  /// Check if listing is favorited by user
  Future<bool> isFavorited(String userId, String listingId) async {
    final favorite = await (select(favorites)
          ..where((f) =>
              f.userId.equals(userId) & f.listingId.equals(listingId)))
        .getSingleOrNull();
    return favorite != null;
  }

  /// Toggle favorite
  Future<bool> toggleFavorite(String userId, String listingId) async {
    final existing = await isFavorited(userId, listingId);
    if (existing) {
      await (delete(favorites)
            ..where((f) =>
                f.userId.equals(userId) & f.listingId.equals(listingId)))
          .go();
      return false;
    } else {
      await into(favorites).insert(FavoritesCompanion(
        userId: Value(userId),
        listingId: Value(listingId),
      ));
      return true;
    }
  }

  /// Get user's favorite listings
  Future<List<Listing>> getFavoriteListings(String userId) async {
    final query = select(listings).join([
      innerJoin(
        favorites,
        favorites.listingId.equalsExp(listings.id),
      ),
    ])
      ..where(favorites.userId.equals(userId))
      ..orderBy([OrderingTerm.desc(favorites.createdAt)]);

    final results = await query.get();
    return results.map((row) => row.readTable(listings)).toList();
  }
}

import '../database/daos/daos.dart';
import '../database/database_context.dart';

/// Response wrapper for paginated listing results
class PaginatedListings {
  PaginatedListings({
    required this.listings,
    required this.total,
    required this.page,
    required this.limit,
  });

  final List<Listing> listings;
  final int total;
  final int page;
  final int limit;

  bool get hasMore => page * limit < total;

  Map<String, dynamic> toJson() => {
        'listings': listings.map(_listingToJson).toList(),
        'pagination': {
          'total': total,
          'page': page,
          'limit': limit,
          'hasMore': hasMore,
        },
      };
}

/// Detailed listing with related data
class ListingDetail {
  ListingDetail({
    required this.listing,
    required this.images,
    required this.amenities,
    required this.host,
  });

  final Listing listing;
  final List<Image> images;
  final List<Amenity> amenities;
  final User? host;

  Map<String, dynamic> toJson() => {
        ..._listingToJson(listing),
        'images': images.map(_imageToJson).toList(),
        'amenities': amenities.map(_amenityToJson).toList(),
        'host': host != null ? _hostToJson(host!) : null,
      };
}

/// Service for listing-related business logic
class ListingService {
  ListingService({
    required ListingDao listingDao,
    required UserDao userDao,
  })  : _listingDao = listingDao,
        _userDao = userDao;

  final ListingDao _listingDao;
  final UserDao _userDao;

  /// Get paginated featured/active listings
  Future<PaginatedListings> getFeatured(int page, int limit) async {
    final offset = (page - 1) * limit;
    final allListings = await _listingDao.getFeaturedListings();
    final total = allListings.length;
    final paginatedListings = allListings.skip(offset).take(limit).toList();

    return PaginatedListings(
      listings: paginatedListings,
      total: total,
      page: page,
      limit: limit,
    );
  }

  /// Get paginated active listings
  Future<PaginatedListings> getActive(int page, int limit) async {
    final offset = (page - 1) * limit;
    final allListings = await _listingDao.getActiveListings();
    final total = allListings.length;
    final paginatedListings = allListings.skip(offset).take(limit).toList();

    return PaginatedListings(
      listings: paginatedListings,
      total: total,
      page: page,
      limit: limit,
    );
  }

  /// Get listing detail by ID with images, amenities, and host info
  Future<ListingDetail?> getById(String id) async {
    final listing = await _listingDao.getListingById(id);
    if (listing == null) return null;

    final images = await _listingDao.getListingImages(id);
    final amenities = await _listingDao.getListingAmenities(id);
    final host = await _userDao.getUserById(listing.hostId);

    return ListingDetail(
      listing: listing,
      images: images,
      amenities: amenities,
      host: host,
    );
  }
}

/// Helper: Convert a Listing row to JSON
Map<String, dynamic> _listingToJson(Listing l) => {
      'id': l.id,
      'hostId': l.hostId,
      'categoryId': l.categoryId,
      'title': l.title,
      'description': l.description,
      'pricePerUnit': l.pricePerUnit,
      'currency': l.currency,
      'unitType': l.unitType,
      'maxGuests': l.maxGuests,
      'bedrooms': l.bedrooms,
      'bathrooms': l.bathrooms,
      'address': l.address,
      'city': l.city,
      'state': l.state,
      'country': l.country,
      'postalCode': l.postalCode,
      'latitude': l.latitude,
      'longitude': l.longitude,
      'isActive': l.isActive,
      'isFeatured': l.isFeatured,
      'avgRating': l.avgRating,
      'reviewCount': l.reviewCount,
      'minNights': l.minNights,
      'maxNights': l.maxNights,
      'checkInTime': l.checkInTime,
      'checkOutTime': l.checkOutTime,
      'cancellationPolicy': l.cancellationPolicy,
      'createdAt': l.createdAt.toIso8601String(),
      'updatedAt': l.updatedAt.toIso8601String(),
    };

/// Helper: Convert an Image row to JSON
Map<String, dynamic> _imageToJson(Image i) => {
      'id': i.id,
      'listingId': i.listingId,
      'url': i.url,
      'altText': i.altText,
      'width': i.width,
      'height': i.height,
      'sortOrder': i.sortOrder,
      'isPrimary': i.isPrimary,
    };

/// Helper: Convert an Amenity row to JSON
Map<String, dynamic> _amenityToJson(Amenity a) => {
      'id': a.id,
      'name': a.name,
      'slug': a.slug,
      'iconUrl': a.iconUrl,
      'category': a.category,
    };

/// Helper: Convert host User to safe JSON (no password hash)
Map<String, dynamic> _hostToJson(User u) => {
      'id': u.id,
      'displayName': u.displayName,
      'avatarUrl': u.avatarUrl,
      'bio': u.bio,
      'isHost': u.isHost,
      'isVerified': u.isVerified,
    };

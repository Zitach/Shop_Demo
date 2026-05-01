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

/// Holds a review together with its author for serialization
class _ReviewWithAuthor {
  _ReviewWithAuthor({required this.review, required this.author});
  final Review review;
  final User author;
}

/// Detailed listing with related data
class ListingDetail {
  ListingDetail({
    required this.listing,
    required this.images,
    required this.amenities,
    required this.host,
    required this.reviewsWithAuthors,
  });

  final Listing listing;
  final List<Image> images;
  final List<Amenity> amenities;
  final User? host;
  final List<_ReviewWithAuthor> reviewsWithAuthors;

  Map<String, dynamic> toJson() => {
        ..._listingToJson(listing),
        'imageUrls': images.map((i) => i.url).toList(),
        'amenities': amenities.map(_amenityToJson).toList(),
        'host': host != null ? _hostToJson(host!) : null,
        'reviews': reviewsWithAuthors.map(_reviewWithAuthorToJson).toList(),
      };
}

/// Service for listing-related business logic
class ListingService {
  ListingService({
    required ListingDao listingDao,
    required UserDao userDao,
    required ReviewDao reviewDao,
  })  : _listingDao = listingDao,
        _userDao = userDao,
        _reviewDao = reviewDao;

  final ListingDao _listingDao;
  final UserDao _userDao;
  final ReviewDao _reviewDao;

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

  /// Get listing detail by ID with images, amenities, host info, and reviews
  Future<ListingDetail?> getById(String id) async {
    final listing = await _listingDao.getListingById(id);
    if (listing == null) return null;

    final images = await _listingDao.getListingImages(id);
    final amenities = await _listingDao.getListingAmenities(id);
    final host = await _userDao.getUserById(listing.hostId);

    // Fetch reviews with author info
    final reviews = await _reviewDao.getReviewsByListing(id);
    final reviewsWithAuthors = <_ReviewWithAuthor>[];
    for (final review in reviews) {
      final author = await _userDao.getUserById(review.authorId);
      if (author != null) {
        reviewsWithAuthors
            .add(_ReviewWithAuthor(review: review, author: author));
      }
    }

    return ListingDetail(
      listing: listing,
      images: images,
      amenities: amenities,
      host: host,
      reviewsWithAuthors: reviewsWithAuthors,
    );
  }
}

/// Helper: Convert a Listing row to JSON aligned with frontend ListingCard / ListingDetailModel
Map<String, dynamic> _listingToJson(Listing l) => {
      'id': l.id,
      'hostId': l.hostId,
      'categoryId': l.categoryId,
      'title': l.title,
      'description': l.description,
      'pricePerNight': l.pricePerUnit,
      'currency': l.currency,
      'maxGuests': l.maxGuests,
      'bedrooms': l.bedrooms,
      'bathrooms': l.bathrooms,
      'location': [l.city, l.country]
          .where((s) => s != null && s.isNotEmpty)
          .join(', '),
      'latitude': l.latitude,
      'longitude': l.longitude,
      'isActive': l.isActive,
      'isGuestFavorite': l.isFeatured,
      'rating': l.avgRating,
      'reviewCount': l.reviewCount,
      'imageUrls': <String>[],
      'minNights': l.minNights,
      'maxNights': l.maxNights,
      'checkInTime': l.checkInTime,
      'checkOutTime': l.checkOutTime,
      'cancellationPolicy': l.cancellationPolicy,
      'createdAt': l.createdAt.toIso8601String(),
      'updatedAt': l.updatedAt.toIso8601String(),
    };

/// Helper: Convert an Amenity row to JSON aligned with frontend Amenity model
Map<String, dynamic> _amenityToJson(Amenity a) => {
      'id': a.id,
      'name': a.name,
      'iconKey': a.slug,
    };

/// Helper: Convert host User to JSON aligned with frontend HostInfo model
Map<String, dynamic> _hostToJson(User u) => {
      'id': u.id,
      'name': u.displayName,
      'avatarUrl': u.avatarUrl,
      'bio': u.bio,
      'isSuperhost': true,
      'hostingYears': 3,
      'responseRate': 95,
    };

/// Helper: Convert a review with author to JSON aligned with frontend Review model
Map<String, dynamic> _reviewWithAuthorToJson(_ReviewWithAuthor r) => {
      'id': r.review.id,
      'userName': r.author.displayName,
      'userAvatarUrl': r.author.avatarUrl ?? '',
      'rating': r.review.rating,
      'comment': r.review.comment ?? '',
      'date': r.review.createdAt.toIso8601String(),
    };

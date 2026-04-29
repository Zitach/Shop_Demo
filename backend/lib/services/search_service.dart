import '../database/daos/listing_dao.dart';
import '../database/database_context.dart';

/// Search result with pagination metadata
class SearchResult {
  SearchResult({
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

/// Service for search and filter operations
class SearchService {
  SearchService({required ListingDao listingDao}) : _listingDao = listingDao;

  final ListingDao _listingDao;

  /// Search listings with filters
  Future<SearchResult> search({
    String? query,
    String? category,
    double? minPrice,
    double? maxPrice,
    int? guests,
    String? sortBy,
    bool ascending = false,
    int page = 1,
    int limit = 20,
  }) async {
    final offset = (page - 1) * limit;

    // Map frontend sort values to backend sort fields
    String sortField;
    switch (sortBy) {
      case 'price_low':
        sortField = 'price';
        ascending = true;
        break;
      case 'price_high':
        sortField = 'price';
        ascending = false;
        break;
      case 'rating':
        sortField = 'rating';
        break;
      case 'newest':
        sortField = 'created_at';
        break;
      default:
        sortField = 'created_at';
    }

    final listings = await _listingDao.searchListings(
      query: query,
      categoryId: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minGuests: guests,
      sortBy: sortField,
      ascending: ascending,
      limit: limit,
      offset: offset,
    );

    // For total count, we run the same query without limit/offset
    // In production, you'd use a separate COUNT query for efficiency
    final allResults = await _listingDao.searchListings(
      query: query,
      categoryId: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minGuests: guests,
      sortBy: sortField,
      ascending: ascending,
      limit: 10000,
      offset: 0,
    );

    return SearchResult(
      listings: listings,
      total: allResults.length,
      page: page,
      limit: limit,
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
      'city': l.city,
      'state': l.state,
      'country': l.country,
      'latitude': l.latitude,
      'longitude': l.longitude,
      'isFeatured': l.isFeatured,
      'avgRating': l.avgRating,
      'reviewCount': l.reviewCount,
      'createdAt': l.createdAt.toIso8601String(),
    };

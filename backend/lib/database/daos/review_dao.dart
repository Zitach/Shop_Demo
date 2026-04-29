import 'package:drift/drift.dart';

import '../database_context.dart';
import '../tables/tables.dart';

part 'review_dao.g.dart';

/// Data Access Object for Reviews
@DriftAccessor(tables: [Reviews, Listings])
class ReviewDao extends DatabaseAccessor<AppDatabase> with _$ReviewDaoMixin {
  ReviewDao(AppDatabase db) : super(db);

  /// Get review by ID
  Future<Review?> getReviewById(String id) =>
      (select(reviews)..where((r) => r.id.equals(id))).getSingleOrNull();

  /// Get reviews for a listing
  Future<List<Review>> getReviewsByListing(String listingId) =>
      (select(reviews)
            ..where((r) =>
                r.listingId.equals(listingId) & r.isVisible.equals(true))
            ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
          .get();

  /// Get reviews by a user
  Future<List<Review>> getReviewsByUser(String authorId) =>
      (select(reviews)
            ..where((r) => r.authorId.equals(authorId))
            ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
          .get();

  /// Get review for a booking
  Future<Review?> getReviewByBooking(String bookingId) =>
      (select(reviews)..where((r) => r.bookingId.equals(bookingId)))
          .getSingleOrNull();

  /// Create a new review
  Future<int> createReview(ReviewsCompanion review) async {
    final id = await into(reviews).insert(review);

    // Update listing rating
    await _updateListingRating(review.listingId.value);

    return id;
  }

  /// Update review
  Future<bool> updateReview(String id, ReviewsCompanion review) async {
    final updated =
        await (update(reviews)..where((r) => r.id.equals(id))).write(
            review.copyWith(updatedAt: Value(DateTime.now())));
    return updated > 0;
  }

  /// Add host response to review
  Future<bool> addResponse(String reviewId, String response) async {
    final updated =
        await (update(reviews)..where((r) => r.id.equals(reviewId))).write(
            ReviewsCompanion(
      response: Value(response),
      responseAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// Hide review (soft delete)
  Future<bool> hideReview(String id) async {
    final updated =
        await (update(reviews)..where((r) => r.id.equals(id))).write(
            ReviewsCompanion(
      isVisible: const Value(false),
      updatedAt: Value(DateTime.now()),
    ));

    if (updated > 0) {
      final review = await getReviewById(id);
      if (review != null) {
        await _updateListingRating(review.listingId);
      }
    }

    return updated > 0;
  }

  /// Delete review
  Future<int> deleteReview(String id) async {
    final review = await getReviewById(id);
    final deleted =
        await (delete(reviews)..where((r) => r.id.equals(id))).go();

    if (deleted > 0 && review != null) {
      await _updateListingRating(review.listingId);
    }

    return deleted;
  }

  /// Get average rating for a listing
  Future<double> getAverageRating(String listingId) async {
    final result = await customSelect(
      'SELECT AVG(rating) as avg_rating FROM reviews WHERE listing_id = ? AND is_visible = true',
      variables: [Variable.withString(listingId)],
    ).getSingleOrNull();

    if (result != null) {
      return result.read<double?>('avg_rating') ?? 0.0;
    }
    return 0.0;
  }

  /// Get review count for a listing
  Future<int> getReviewCount(String listingId) async {
    final result = await customSelect(
      'SELECT COUNT(*) as count FROM reviews WHERE listing_id = ? AND is_visible = true',
      variables: [Variable.withString(listingId)],
    ).getSingleOrNull();

    if (result != null) {
      return result.read<int>('count');
    }
    return 0;
  }

  /// Update listing rating and review count
  Future<void> _updateListingRating(String listingId) async {
    final avgRating = await getAverageRating(listingId);
    final reviewCount = await getReviewCount(listingId);

    await (update(listings)..where((l) => l.id.equals(listingId))).write(
        ListingsCompanion(
      avgRating: Value(avgRating),
      reviewCount: Value(reviewCount),
      updatedAt: Value(DateTime.now()),
    ));
  }

  /// Check if user can review (has completed booking)
  Future<bool> canUserReview({
    required String userId,
    required String listingId,
  }) async {
    final existingReview = await (select(reviews)
          ..where((r) =>
              r.authorId.equals(userId) & r.listingId.equals(listingId)))
        .getSingleOrNull();

    if (existingReview != null) {
      return false; // Already reviewed
    }

    // Check for completed booking
    final completedBooking = await customSelect(
      "SELECT id FROM bookings WHERE guest_id = ? AND listing_id = ? AND status = 'completed'",
      variables: [Variable.withString(userId), Variable.withString(listingId)],
    ).getSingleOrNull();

    return completedBooking != null;
  }
}

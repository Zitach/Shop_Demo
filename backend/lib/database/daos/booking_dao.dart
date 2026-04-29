import 'package:drift/drift.dart';

import '../database_context.dart';
import '../tables/tables.dart';

part 'booking_dao.g.dart';

/// Data Access Object for Bookings
@DriftAccessor(tables: [Bookings])
class BookingDao extends DatabaseAccessor<AppDatabase> with _$BookingDaoMixin {
  BookingDao(AppDatabase db) : super(db);

  /// Get booking by ID
  Future<Booking?> getBookingById(String id) =>
      (select(bookings)..where((b) => b.id.equals(id))).getSingleOrNull();

  /// Get bookings for a guest
  Future<List<Booking>> getBookingsByGuest(String guestId) =>
      (select(bookings)
            ..where((b) => b.guestId.equals(guestId))
            ..orderBy([(b) => OrderingTerm.desc(b.createdAt)]))
          .get();

  /// Get bookings for a host
  Future<List<Booking>> getBookingsByHost(String hostId) =>
      (select(bookings)
            ..where((b) => b.hostId.equals(hostId))
            ..orderBy([(b) => OrderingTerm.desc(b.createdAt)]))
          .get();

  /// Get bookings for a listing
  Future<List<Booking>> getBookingsByListing(String listingId) =>
      (select(bookings)
            ..where((b) => b.listingId.equals(listingId))
            ..orderBy([(b) => OrderingTerm.desc(b.createdAt)]))
          .get();

  /// Get active bookings for a listing (for availability check)
  Future<List<Booking>> getActiveBookingsForListing(
    String listingId,
    DateTime startDate,
    DateTime endDate,
  ) =>
      (select(bookings)
            ..where((b) =>
                b.listingId.equals(listingId) &
                b.status.equals('confirmed') &
                b.startDate.isSmallerOrEqualValue(endDate) &
                b.endDate.isBiggerOrEqualValue(startDate)))
          .get();

  /// Create a new booking
  Future<int> createBooking(BookingsCompanion booking) =>
      into(bookings).insert(booking);

  /// Update booking status
  Future<bool> updateBookingStatus(String id, String status) async {
    final updated =
        await (update(bookings)..where((b) => b.id.equals(id))).write(
            BookingsCompanion(
      status: Value(status),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// Confirm booking
  Future<bool> confirmBooking(String id) =>
      updateBookingStatus(id, 'confirmed');

  /// Cancel booking
  Future<bool> cancelBooking(String id, String reason) async {
    final updated =
        await (update(bookings)..where((b) => b.id.equals(id))).write(
            BookingsCompanion(
      status: const Value('cancelled'),
      cancelledAt: Value(DateTime.now()),
      cancellationReason: Value(reason),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// Complete booking
  Future<bool> completeBooking(String id) =>
      updateBookingStatus(id, 'completed');

  /// Check availability for dates
  Future<bool> checkAvailability({
    required String listingId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final conflicting = await getActiveBookingsForListing(
      listingId,
      startDate,
      endDate,
    );
    return conflicting.isEmpty;
  }

  /// Get upcoming bookings for a guest
  Future<List<Booking>> getUpcomingBookings(String guestId) =>
      (select(bookings)
            ..where((b) =>
                b.guestId.equals(guestId) &
                b.status.equals('confirmed') &
                b.startDate.isBiggerOrEqualValue(DateTime.now()))
            ..orderBy([(b) => OrderingTerm.asc(b.startDate)]))
          .get();

  /// Get past bookings for a guest
  Future<List<Booking>> getPastBookings(String guestId) =>
      (select(bookings)
            ..where((b) =>
                b.guestId.equals(guestId) &
                b.endDate.isSmallerThanValue(DateTime.now()))
            ..orderBy([(b) => OrderingTerm.desc(b.endDate)]))
          .get();

  /// Get pending bookings for a host
  Future<List<Booking>> getPendingBookings(String hostId) =>
      (select(bookings)
            ..where((b) =>
                b.hostId.equals(hostId) & b.status.equals('pending'))
            ..orderBy([(b) => OrderingTerm.asc(b.createdAt)]))
          .get();

  /// Delete booking
  Future<int> deleteBooking(String id) =>
      (delete(bookings)..where((b) => b.id.equals(id))).go();
}

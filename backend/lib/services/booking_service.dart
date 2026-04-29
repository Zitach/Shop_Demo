import 'package:drift/drift.dart';

import '../database/database.dart';
import '../middleware/error_handler.dart';

/// Service for booking-related business logic
class BookingService {
  BookingService({
    required BookingDao bookingDao,
    required ListingDao listingDao,
  })  : _bookingDao = bookingDao,
        _listingDao = listingDao;

  final BookingDao _bookingDao;
  final ListingDao _listingDao;

  /// Create a new booking
  Future<Booking> create({
    required String listingId,
    required String userId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required double totalPrice,
    String? specialRequests,
  }) async {
    // Validate listing exists
    final listing = await _listingDao.getListingById(listingId);
    if (listing == null) {
      throw AppHttpException('Listing not found', statusCode: 404);
    }

    if (!listing.isActive) {
      throw AppHttpException('Listing is not available', statusCode: 400);
    }

    // Validate guest count
    if (guests > listing.maxGuests) {
      throw AppHttpException(
        'Guest count exceeds maximum (${listing.maxGuests})',
        statusCode: 400,
      );
    }

    // Validate dates
    if (checkIn.isBefore(DateTime.now())) {
      throw AppHttpException('Check-in date must be in the future', statusCode: 400);
    }

    if (!checkOut.isAfter(checkIn)) {
      throw AppHttpException('Check-out must be after check-in', statusCode: 400);
    }

    final nights = checkOut.difference(checkIn).inDays;
    if (nights < listing.minNights) {
      throw AppHttpException(
        'Minimum stay is ${listing.minNights} nights',
        statusCode: 400,
      );
    }
    if (nights > listing.maxNights) {
      throw AppHttpException(
        'Maximum stay is ${listing.maxNights} nights',
        statusCode: 400,
      );
    }

    // Check availability
    final available = await _bookingDao.checkAvailability(
      listingId: listingId,
      startDate: checkIn,
      endDate: checkOut,
    );
    if (!available) {
      throw AppHttpException('Selected dates are not available', statusCode: 409);
    }

    // Generate booking ID
    final bookingId = _generateId();

    // Create booking
    await _bookingDao.createBooking(BookingsCompanion(
      id: Value(bookingId),
      listingId: Value(listingId),
      guestId: Value(userId),
      hostId: Value(listing.hostId),
      startDate: Value(checkIn),
      endDate: Value(checkOut),
      numGuests: Value(guests),
      totalPrice: Value(totalPrice),
      currency: Value(listing.currency),
      status: const Value('pending'),
      specialRequests: Value(specialRequests),
    ));

    final booking = await _bookingDao.getBookingById(bookingId);
    return booking!;
  }

  /// Get bookings for a user
  Future<List<Booking>> getByUser(String userId) {
    return _bookingDao.getBookingsByGuest(userId);
  }

  /// Get booking by ID
  Future<Booking?> getById(String id) {
    return _bookingDao.getBookingById(id);
  }

  /// Cancel a booking
  Future<Booking> cancel(String bookingId, String userId, {String? reason}) async {
    final booking = await _bookingDao.getBookingById(bookingId);
    if (booking == null) {
      throw AppHttpException('Booking not found', statusCode: 404);
    }

    if (booking.guestId != userId) {
      throw AppHttpException('Not authorized to cancel this booking', statusCode: 403);
    }

    if (booking.status == 'cancelled') {
      throw AppHttpException('Booking is already cancelled', statusCode: 400);
    }

    if (booking.status == 'completed') {
      throw AppHttpException('Cannot cancel a completed booking', statusCode: 400);
    }

    await _bookingDao.cancelBooking(bookingId, reason ?? 'Cancelled by guest');

    final updated = await _bookingDao.getBookingById(bookingId);
    return updated!;
  }

  /// Generate a UUID-like ID
  String _generateId() {
    final random = List<int>.generate(16, (_) => DateTime.now().microsecondsSinceEpoch % 256);
    random[6] = (random[6] & 0x0f) | 0x40; // version 4
    random[8] = (random[8] & 0x3f) | 0x80; // variant 1
    final hex = random.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/core/providers/core_providers.dart';
import 'package:shop_demo/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:shop_demo/features/booking/domain/entities/booking.dart';

final bookingRepositoryProvider = Provider<BookingRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return BookingRepositoryImpl(apiClient);
});

/// Provider for the list of user's bookings.
final myBookingsProvider =
    AsyncNotifierProvider<MyBookingsNotifier, List<Booking>>(
        MyBookingsNotifier.new);

class MyBookingsNotifier extends AsyncNotifier<List<Booking>> {
  @override
  Future<List<Booking>> build() async {
    final repo = ref.watch(bookingRepositoryProvider);
    return repo.getMyBookings();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => build());
  }
}

/// Notifier for creating a booking.
final createBookingProvider =
    AsyncNotifierProvider<CreateBookingNotifier, Booking?>(
        CreateBookingNotifier.new);

class CreateBookingNotifier extends AsyncNotifier<Booking?> {
  @override
  Booking? build() => null;

  Future<Booking?> create({
    required String listingId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required double nightlyRate,
    required double cleaningFee,
    required double serviceFee,
    required double totalAmount,
  }) async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final repo = ref.read(bookingRepositoryProvider);
      return repo.createBooking(
        listingId: listingId,
        checkIn: checkIn,
        checkOut: checkOut,
        guests: guests,
        nightlyRate: nightlyRate,
        cleaningFee: cleaningFee,
        serviceFee: serviceFee,
        totalAmount: totalAmount,
      );
    });
    state = result;
    return result.valueOrNull;
  }
}

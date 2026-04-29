import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/features/booking/data/models/booking_model.dart';
import 'package:shop_demo/features/booking/domain/entities/booking.dart';

abstract class BookingRepository {
  Future<Booking> createBooking({
    required String listingId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required double nightlyRate,
    required double cleaningFee,
    required double serviceFee,
    required double totalAmount,
  });
  Future<List<Booking>> getMyBookings();
  Future<Booking?> getBookingById(String id);
}

class BookingRepositoryImpl implements BookingRepository {
  final ApiClient _apiClient;

  BookingRepositoryImpl(this._apiClient);

  @override
  Future<Booking> createBooking({
    required String listingId,
    required DateTime checkIn,
    required DateTime checkOut,
    required int guests,
    required double nightlyRate,
    required double cleaningFee,
    required double serviceFee,
    required double totalAmount,
  }) async {
    final response = await _apiClient.dio.post(
      '/api/bookings',
      data: {
        'listingId': listingId,
        'checkIn': checkIn.toIso8601String(),
        'checkOut': checkOut.toIso8601String(),
        'guests': guests,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final bookingData =
        data.containsKey('data') ? data['data'] as Map<String, dynamic> : data;
    return BookingModel.fromJson(bookingData);
  }

  @override
  Future<List<Booking>> getMyBookings() async {
    final response = await _apiClient.dio.get('/api/bookings');
    final data = response.data;
    if (data is List) {
      return BookingModel.listFromJson(data);
    }
    if (data is Map<String, dynamic> && data['data'] is List) {
      return BookingModel.listFromJson(data['data'] as List);
    }
    return [];
  }

  @override
  Future<Booking?> getBookingById(String id) async {
    final response = await _apiClient.dio.get('/api/bookings/$id');
    final data = response.data as Map<String, dynamic>;
    final bookingData =
        data.containsKey('data') ? data['data'] as Map<String, dynamic> : data;
    return BookingModel.fromJson(bookingData);
  }
}

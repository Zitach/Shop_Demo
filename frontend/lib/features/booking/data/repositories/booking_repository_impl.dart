import 'package:shop_demo/core/constants/app_constants.dart';
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

  static final _mockBookings = [
    BookingModel(
      id: 'f0000000-0000-0000-0000-000000000001',
      listingId: 'd0000000-0000-0000-0000-000000000001',
      listingTitle: 'Modern Downtown Apartment',
      listingImageUrl:
          'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=400&q=80',
      checkIn: DateTime(2026, 5, 10),
      checkOut: DateTime(2026, 5, 15),
      guests: 2,
      nightlyRate: 150.0,
      cleaningFee: 50.0,
      serviceFee: 75.0,
      totalAmount: 875.0,
      status: BookingStatus.confirmed,
      createdAt: DateTime(2026, 4, 28),
    ),
  ];

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
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 600));
      final booking = BookingModel(
        id: 'mock-booking-${DateTime.now().millisecondsSinceEpoch}',
        listingId: listingId,
        listingTitle: 'Mock Listing',
        checkIn: checkIn,
        checkOut: checkOut,
        guests: guests,
        nightlyRate: nightlyRate,
        cleaningFee: cleaningFee,
        serviceFee: serviceFee,
        totalAmount: totalAmount,
        status: BookingStatus.confirmed,
        createdAt: DateTime.now(),
      );
      return booking;
    }

    final response = await _apiClient.dio.post(
      '/api/bookings',
      data: {
        'listingId': listingId,
        'checkIn': checkIn.toIso8601String(),
        'checkOut': checkOut.toIso8601String(),
        'guests': guests,
        'totalPrice': totalAmount,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final bookingData =
        data.containsKey('data') ? data['data'] as Map<String, dynamic> : data;
    return BookingModel.fromJson(bookingData);
  }

  @override
  Future<List<Booking>> getMyBookings() async {
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 400));
      return _mockBookings;
    }

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
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _mockBookings.where((b) => b.id == id).firstOrNull;
    }

    final response = await _apiClient.dio.get('/api/bookings/$id');
    final data = response.data as Map<String, dynamic>;
    final bookingData =
        data.containsKey('data') ? data['data'] as Map<String, dynamic> : data;
    return BookingModel.fromJson(bookingData);
  }
}

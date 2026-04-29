import 'package:shop_demo/features/booking/domain/entities/booking.dart';

class BookingModel extends Booking {
  const BookingModel({
    required super.id,
    required super.listingId,
    required super.listingTitle,
    super.listingImageUrl,
    required super.checkIn,
    required super.checkOut,
    required super.guests,
    required super.nightlyRate,
    required super.cleaningFee,
    required super.serviceFee,
    required super.totalAmount,
    required super.status,
    required super.createdAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'].toString(),
      listingId: (json['listingId'] ?? json['listing_id']).toString(),
      listingTitle:
          (json['listingTitle'] ?? json['listing_title'] ?? '') as String,
      listingImageUrl:
          (json['listingImageUrl'] ?? json['listing_image_url']) as String?,
      checkIn: DateTime.parse(
          (json['checkIn'] ?? json['check_in']) as String),
      checkOut: DateTime.parse(
          (json['checkOut'] ?? json['check_out']) as String),
      guests: (json['guests'] ?? 1) as int,
      nightlyRate:
          _parseDouble(json['nightlyRate'] ?? json['nightly_rate']),
      cleaningFee:
          _parseDouble(json['cleaningFee'] ?? json['cleaning_fee']),
      serviceFee:
          _parseDouble(json['serviceFee'] ?? json['service_fee']),
      totalAmount:
          _parseDouble(json['totalAmount'] ?? json['total_amount']),
      status: _parseStatus(json['status'] as String?),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : json['created_at'] != null
              ? DateTime.parse(json['created_at'] as String)
              : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listingId': listingId,
      'listingTitle': listingTitle,
      'listingImageUrl': listingImageUrl,
      'checkIn': checkIn.toIso8601String(),
      'checkOut': checkOut.toIso8601String(),
      'guests': guests,
      'nightlyRate': nightlyRate,
      'cleaningFee': cleaningFee,
      'serviceFee': serviceFee,
      'totalAmount': totalAmount,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static List<BookingModel> listFromJson(List<dynamic> json) {
    return json
        .map((e) => BookingModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  static BookingStatus _parseStatus(String? status) {
    switch (status) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'completed':
        return BookingStatus.completed;
      default:
        return BookingStatus.confirmed;
    }
  }
}

import 'package:equatable/equatable.dart';

enum BookingStatus { pending, confirmed, cancelled, completed }

class Booking extends Equatable {
  final String id;
  final String listingId;
  final String listingTitle;
  final String? listingImageUrl;
  final DateTime checkIn;
  final DateTime checkOut;
  final int guests;
  final double nightlyRate;
  final double cleaningFee;
  final double serviceFee;
  final double totalAmount;
  final BookingStatus status;
  final DateTime createdAt;

  const Booking({
    required this.id,
    required this.listingId,
    required this.listingTitle,
    this.listingImageUrl,
    required this.checkIn,
    required this.checkOut,
    required this.guests,
    required this.nightlyRate,
    required this.cleaningFee,
    required this.serviceFee,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  int get nights => checkOut.difference(checkIn).inDays;

  @override
  List<Object?> get props => [id, listingId, checkIn, checkOut, status];
}

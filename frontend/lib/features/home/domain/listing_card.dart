import 'package:equatable/equatable.dart';

class ListingCard extends Equatable {
  final String id;
  final List<String> imageUrls;
  final String title;
  final String location;
  final String? dateRange;
  final double pricePerNight;
  final double? rating;
  final int reviewCount;
  final bool isGuestFavorite;

  const ListingCard({
    required this.id,
    required this.imageUrls,
    required this.title,
    required this.location,
    this.dateRange,
    required this.pricePerNight,
    this.rating,
    this.reviewCount = 0,
    this.isGuestFavorite = false,
  });

  @override
  List<Object?> get props => [id, title, location, pricePerNight, rating, reviewCount, isGuestFavorite];
}

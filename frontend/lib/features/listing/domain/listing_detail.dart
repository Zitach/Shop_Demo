import 'package:equatable/equatable.dart';
import 'amenity.dart';
import 'review.dart';

class ListingDetail extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final String location;
  final double pricePerNight;
  final double rating;
  final int reviewCount;
  final bool isGuestFavorite;
  final int maxGuests;
  final int bedrooms;
  final int beds;
  final int bathrooms;
  final List<Amenity> amenities;
  final List<Review> reviews;
  final HostInfo host;

  const ListingDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrls,
    required this.location,
    required this.pricePerNight,
    required this.rating,
    this.reviewCount = 0,
    this.isGuestFavorite = false,
    this.maxGuests = 1,
    this.bedrooms = 1,
    this.beds = 1,
    this.bathrooms = 1,
    this.amenities = const [],
    this.reviews = const [],
    required this.host,
  });

  @override
  List<Object?> get props =>
      [id, title, pricePerNight, rating, reviewCount, isGuestFavorite];
}

class HostInfo extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isSuperhost;
  final int hostingYears;
  final double responseRate;
  final String? bio;

  const HostInfo({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.isSuperhost = false,
    this.hostingYears = 0,
    this.responseRate = 0,
    this.bio,
  });

  @override
  List<Object?> get props => [id, name, isSuperhost];
}

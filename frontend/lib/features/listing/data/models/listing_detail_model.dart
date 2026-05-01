import 'package:shop_demo/features/listing/domain/amenity.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';
import 'package:shop_demo/features/listing/domain/review.dart';

class ListingDetailModel extends ListingDetail {
  const ListingDetailModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrls,
    required super.location,
    required super.pricePerNight,
    required super.rating,
    super.reviewCount,
    super.isGuestFavorite,
    super.maxGuests,
    super.bedrooms,
    super.beds,
    super.bathrooms,
    super.amenities,
    super.reviews,
    required super.host,
  });

  factory ListingDetailModel.fromJson(Map<String, dynamic> json) {
    return ListingDetailModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrls: _parseStringList(json['imageUrls'] ?? json['image_urls']),
      location: json['location'] as String,
      pricePerNight: _parseDouble(json['pricePerNight'] ?? json['price_per_night']),
      rating: _parseDouble(json['rating']),
      reviewCount: (json['reviewCount'] ?? json['review_count'] ?? 0) as int,
      isGuestFavorite:
          (json['isGuestFavorite'] ?? json['is_guest_favorite'] ?? false) as bool,
      maxGuests: (json['maxGuests'] ?? json['max_guests'] ?? 1) as int,
      bedrooms: (json['bedrooms'] ?? 1) as int,
      beds: (json['beds'] ?? 1) as int,
      bathrooms: (json['bathrooms'] ?? 1) as int,
      amenities: _parseAmenities(json['amenities']),
      reviews: _parseReviews(json['reviews']),
      host: _parseHost(json['host']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrls': imageUrls,
      'location': location,
      'pricePerNight': pricePerNight,
      'rating': rating,
      'reviewCount': reviewCount,
      'isGuestFavorite': isGuestFavorite,
      'maxGuests': maxGuests,
      'bedrooms': bedrooms,
      'beds': beds,
      'bathrooms': bathrooms,
      'amenities': amenities
          .map((a) => {'id': a.id, 'name': a.name, 'iconKey': a.iconKey})
          .toList(),
      'reviews': reviews
          .map((r) => {
                'id': r.id,
                'userName': r.userName,
                'userAvatarUrl': r.userAvatarUrl,
                'rating': r.rating,
                'comment': r.comment,
                'date': r.date.toIso8601String(),
              })
          .toList(),
      'host': {
        'id': host.id,
        'name': host.name,
        'avatarUrl': host.avatarUrl,
        'isSuperhost': host.isSuperhost,
        'hostingYears': host.hostingYears,
        'responseRate': host.responseRate,
        'bio': host.bio,
      },
    };
  }

  static List<String> _parseStringList(dynamic raw) {
    if (raw is List) return raw.map((e) => e.toString()).toList();
    return [];
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  static List<Amenity> _parseAmenities(dynamic raw) {
    if (raw is! List) return [];
    return raw.map((e) {
      final m = e as Map<String, dynamic>;
      return Amenity(
        id: (m['id'] ?? '').toString(),
        name: (m['name'] ?? '') as String,
        iconKey: (m['iconKey'] ?? m['icon_key'] ?? '') as String,
      );
    }).toList();
  }

  static List<Review> _parseReviews(dynamic raw) {
    if (raw is! List) return [];
    return raw.map((e) {
      final m = e as Map<String, dynamic>;
      return Review(
        id: (m['id'] ?? '').toString(),
        userName: (m['userName'] ?? m['user_name'] ?? '') as String,
        userAvatarUrl:
            (m['userAvatarUrl'] ?? m['user_avatar_url'] ?? '') as String,
        rating: (m['rating'] ?? 0) as int,
        comment: (m['comment'] ?? '') as String,
        date: m['date'] != null
            ? DateTime.parse(m['date'] as String)
            : DateTime.now(),
      );
    }).toList();
  }

  static HostInfo _parseHost(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return const HostInfo(id: '', name: '', avatarUrl: '');
    }
    final m = raw;
    return HostInfo(
      id: (m['id'] ?? '').toString(),
      name: (m['name'] ?? '') as String,
      avatarUrl: (m['avatarUrl'] ?? m['avatar_url'] ?? '') as String,
      isSuperhost: (m['isSuperhost'] ?? m['is_superhost'] ?? false) as bool,
      hostingYears: (m['hostingYears'] ?? m['hosting_years'] ?? 0) as int,
      responseRate: _parseDouble(m['responseRate'] ?? m['response_rate']),
      bio: m['bio'] as String?,
    );
  }
}

import 'package:shop_demo/features/home/domain/listing_card.dart';

class ListingCardModel extends ListingCard {
  const ListingCardModel({
    required super.id,
    required super.imageUrls,
    required super.title,
    required super.location,
    super.dateRange,
    required super.pricePerNight,
    super.rating,
    super.reviewCount,
    super.isGuestFavorite,
  });

  factory ListingCardModel.fromJson(Map<String, dynamic> json) {
    return ListingCardModel(
      id: json['id'].toString(),
      imageUrls: _parseImageUrls(json),
      title: json['title'] as String,
      location: json['location'] as String,
      dateRange: json['dateRange'] as String? ?? json['date_range'] as String?,
      pricePerNight: _parseDouble(json['pricePerNight'] ?? json['price_per_night']),
      rating: json['rating'] != null ? _parseDouble(json['rating']) : null,
      reviewCount: (json['reviewCount'] ?? json['review_count'] ?? 0) as int,
      isGuestFavorite:
          (json['isGuestFavorite'] ?? json['is_guest_favorite'] ?? false) as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrls': imageUrls,
      'title': title,
      'location': location,
      'dateRange': dateRange,
      'pricePerNight': pricePerNight,
      'rating': rating,
      'reviewCount': reviewCount,
      'isGuestFavorite': isGuestFavorite,
    };
  }

  static List<ListingCardModel> listFromJson(List<dynamic> json) {
    return json
        .map((e) => ListingCardModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static List<String> _parseImageUrls(Map<String, dynamic> json) {
    final raw = json['imageUrls'] ?? json['image_urls'];
    if (raw is List) {
      return raw.map((e) => e.toString()).toList();
    }
    return [];
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}

import 'package:shop_demo/features/home/data/models/category_model.dart';
import 'package:shop_demo/features/home/data/models/listing_card_model.dart';

class HomeMockData {
  static const categories = [
    CategoryModel(
      id: 'b0000000-0000-0000-0000-000000000001',
      name: 'Entire Homes',
      iconUrl: '🏠',
      isNew: false,
    ),
    CategoryModel(
      id: 'b0000000-0000-0000-0000-000000000002',
      name: 'Private Rooms',
      iconUrl: '🚪',
      isNew: false,
    ),
    CategoryModel(
      id: 'b0000000-0000-0000-0000-000000000003',
      name: 'Shared Spaces',
      iconUrl: '🤝',
      isNew: false,
    ),
    CategoryModel(
      id: 'b0000000-0000-0000-0000-000000000004',
      name: 'Unique Stays',
      iconUrl: '✨',
      isNew: true,
    ),
    CategoryModel(
      id: 'b0000000-0000-0000-0000-000000000005',
      name: 'Experiences',
      iconUrl: '🎯',
      isNew: false,
    ),
  ];

  static const listings = [
    ListingCardModel(
      id: 'd0000000-0000-0000-0000-000000000001',
      imageUrls: [
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&q=80',
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&q=80',
        'https://images.unsplash.com/photo-1484154218962-a1c002085d2f?w=800&q=80',
      ],
      title: 'Modern Downtown Apartment',
      location: 'New York, United States',
      dateRange: 'May 10 - 15',
      pricePerNight: 150.0,
      rating: 4.75,
      reviewCount: 12,
      isGuestFavorite: true,
    ),
    ListingCardModel(
      id: 'd0000000-0000-0000-0000-000000000002',
      imageUrls: [
        'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8?w=800&q=80',
        'https://images.unsplash.com/photo-1510798831971-661eb04b3739?w=800&q=80',
        'https://images.unsplash.com/photo-1542718610-a1d656d1884c?w=800&q=80',
      ],
      title: 'Cozy Mountain Cabin',
      location: 'Aspen, United States',
      dateRange: 'Jun 2 - 7',
      pricePerNight: 200.0,
      rating: 4.90,
      reviewCount: 8,
      isGuestFavorite: true,
    ),
    ListingCardModel(
      id: 'd0000000-0000-0000-0000-000000000003',
      imageUrls: [
        'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?w=800&q=80',
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80',
        'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800&q=80',
      ],
      title: 'Beachfront Villa',
      location: 'Miami, United States',
      dateRange: 'Jul 20 - 25',
      pricePerNight: 350.0,
      rating: 4.95,
      reviewCount: 15,
      isGuestFavorite: true,
    ),
    ListingCardModel(
      id: 'd0000000-0000-0000-0000-000000000004',
      imageUrls: [
        'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800&q=80',
        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=800&q=80',
      ],
      title: 'Historic Brownstone',
      location: 'Boston, United States',
      dateRange: 'May 18 - 22',
      pricePerNight: 175.0,
      rating: 4.60,
      reviewCount: 6,
      isGuestFavorite: false,
    ),
    ListingCardModel(
      id: 'd0000000-0000-0000-0000-000000000005',
      imageUrls: [
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80',
        'https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=800&q=80',
        'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=800&q=80',
      ],
      title: 'Loft in Arts District',
      location: 'Los Angeles, United States',
      dateRange: 'Jun 15 - 20',
      pricePerNight: 125.0,
      rating: 4.80,
      reviewCount: 10,
      isGuestFavorite: false,
    ),
  ];
}

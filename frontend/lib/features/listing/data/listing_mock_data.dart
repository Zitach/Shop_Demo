import 'package:shop_demo/features/listing/data/models/listing_detail_model.dart';
import 'package:shop_demo/features/listing/domain/amenity.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';
import 'package:shop_demo/features/listing/domain/review.dart';

class ListingMockData {
  static final listings = <String, ListingDetail>{
    'd0000000-0000-0000-0000-000000000001': ListingDetailModel(
      id: 'd0000000-0000-0000-0000-000000000001',
      title: 'Modern Downtown Apartment',
      description:
          'Stunning 2-bedroom apartment in the heart of New York City with panoramic skyline views. '
          'Walking distance to world-class restaurants, boutique shops, and major attractions. '
          'The apartment features floor-to-ceiling windows, a fully equipped kitchen, '
          'and a dedicated workspace for remote work. Perfect for both business travelers '
          'and vacationers looking to experience the best of NYC.',
      imageUrls: [
        'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800&q=80',
        'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800&q=80',
        'https://images.unsplash.com/photo-1484154218962-a1c002085d2f?w=800&q=80',
      ],
      location: 'New York, United States',
      pricePerNight: 150.0,
      rating: 4.75,
      reviewCount: 12,
      isGuestFavorite: true,
      maxGuests: 4,
      bedrooms: 2,
      beds: 3,
      bathrooms: 1,
      amenities: const [
        Amenity(id: '1', name: 'WiFi', iconKey: 'wifi'),
        Amenity(id: '2', name: 'Kitchen', iconKey: 'kitchen'),
        Amenity(id: '3', name: 'Air Conditioning', iconKey: 'ac'),
        Amenity(id: '10', name: 'TV', iconKey: 'tv'),
        Amenity(id: '12', name: 'Workspace', iconKey: 'workspace'),
      ],
      reviews: [
        Review(
          id: 'e0000000-0000-0000-0000-000000000001',
          userName: 'John Guest',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80',
          rating: 5,
          comment:
              'The apartment was exactly as pictured. Great location and very clean. '
              'Walking distance to everything! Highly recommend for anyone visiting NYC.',
          date: DateTime.fromMillisecondsSinceEpoch(1744070400000),
        ),
        Review(
          id: 'rev-002',
          userName: 'Emily Traveler',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100&q=80',
          rating: 4,
          comment:
              'Beautiful apartment with amazing views. The only minor issue was street noise '
              'at night, but that is to be expected in Manhattan. Would stay again!',
          date: DateTime.fromMillisecondsSinceEpoch(1742774400000),
        ),
      ],
      host: const HostInfo(
        id: 'a0000000-0000-0000-0000-000000000002',
        name: 'Sarah Host',
        avatarUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
        isSuperhost: true,
        hostingYears: 5,
        responseRate: 98.0,
        bio: 'Experienced host with multiple properties across the US. '
            'I love creating memorable stays for my guests.',
      ),
    ),

    'd0000000-0000-0000-0000-000000000002': ListingDetailModel(
      id: 'd0000000-0000-0000-0000-000000000002',
      title: 'Cozy Mountain Cabin',
      description:
          'Escape to this charming cabin nestled in the Rocky Mountains near Aspen. '
          'Surrounded by pine forests with breathtaking mountain views from every window. '
          'Features a stone fireplace, outdoor hot tub, and wrap-around deck. '
          'Perfect for a romantic getaway or family retreat. '
          'Minutes from hiking trails, ski slopes, and downtown Aspen.',
      imageUrls: [
        'https://images.unsplash.com/photo-1449158743715-0a90ebb6d2d8?w=800&q=80',
        'https://images.unsplash.com/photo-1510798831971-661eb04b3739?w=800&q=80',
        'https://images.unsplash.com/photo-1542718610-a1d656d1884c?w=800&q=80',
      ],
      location: 'Aspen, United States',
      pricePerNight: 200.0,
      rating: 4.90,
      reviewCount: 8,
      isGuestFavorite: true,
      maxGuests: 6,
      bedrooms: 3,
      beds: 4,
      bathrooms: 2,
      amenities: const [
        Amenity(id: '1', name: 'WiFi', iconKey: 'wifi'),
        Amenity(id: '2', name: 'Kitchen', iconKey: 'kitchen'),
        Amenity(id: '4', name: 'Heating', iconKey: 'heating'),
        Amenity(id: '9', name: 'Hot Tub', iconKey: 'hot_tub'),
        Amenity(id: '7', name: 'Free Parking', iconKey: 'parking'),
      ],
      reviews: [
        Review(
          id: 'e0000000-0000-0000-0000-000000000002',
          userName: 'John Guest',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80',
          rating: 5,
          comment:
              'The cabin was cozy and the views were breathtaking. We spent hours '
              'relaxing in the hot tub watching the sunset over the mountains. Highly recommend!',
          date: DateTime.fromMillisecondsSinceEpoch(1740950400000),
        ),
        Review(
          id: 'rev-004',
          userName: 'Mike Outdoors',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&q=80',
          rating: 5,
          comment:
              'Perfect location for our ski trip. Just 10 minutes to the slopes and the '
              'fireplace made evenings so cozy. Sarah was an amazing host!',
          date: DateTime.fromMillisecondsSinceEpoch(1739145600000),
        ),
      ],
      host: const HostInfo(
        id: 'a0000000-0000-0000-0000-000000000002',
        name: 'Sarah Host',
        avatarUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
        isSuperhost: true,
        hostingYears: 5,
        responseRate: 98.0,
        bio: 'Experienced host with multiple properties across the US. '
            'I love creating memorable stays for my guests.',
      ),
    ),

    'd0000000-0000-0000-0000-000000000003': ListingDetailModel(
      id: 'd0000000-0000-0000-0000-000000000003',
      title: 'Beachfront Villa',
      description:
          'Luxurious 4-bedroom beachfront villa in Miami with a private pool '
          'and direct beach access. Wake up to the sound of waves and enjoy '
          'breathtaking ocean sunsets from your private terrace. '
          'Features a gourmet kitchen, outdoor BBQ area, lush tropical garden, '
          'and resort-style amenities. The ultimate beach vacation experience.',
      imageUrls: [
        'https://images.unsplash.com/photo-1499793983690-e29da59ef1c2?w=800&q=80',
        'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800&q=80',
        'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800&q=80',
      ],
      location: 'Miami, United States',
      pricePerNight: 350.0,
      rating: 4.95,
      reviewCount: 15,
      isGuestFavorite: true,
      maxGuests: 8,
      bedrooms: 4,
      beds: 5,
      bathrooms: 3,
      amenities: const [
        Amenity(id: '1', name: 'WiFi', iconKey: 'wifi'),
        Amenity(id: '2', name: 'Kitchen', iconKey: 'kitchen'),
        Amenity(id: '3', name: 'Air Conditioning', iconKey: 'ac'),
        Amenity(id: '8', name: 'Pool', iconKey: 'pool'),
        Amenity(id: '7', name: 'Free Parking', iconKey: 'parking'),
        Amenity(id: '16', name: 'Garden', iconKey: 'garden'),
      ],
      reviews: [
        Review(
          id: 'e0000000-0000-0000-0000-000000000003',
          userName: 'John Guest',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&q=80',
          rating: 5,
          comment:
              'The villa exceeded all expectations. Private pool and beach access were '
              'incredible. We never wanted to leave! Perfect for our family vacation.',
          date: DateTime.fromMillisecondsSinceEpoch(1736438400000),
        ),
        Review(
          id: 'rev-006',
          userName: 'Lisa BeachLover',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&q=80',
          rating: 5,
          comment:
              'Absolute paradise! The villa is even more beautiful in person. '
              'Morning coffee on the terrace watching the ocean was the highlight of our trip.',
          date: DateTime.fromMillisecondsSinceEpoch(1733673600000),
        ),
      ],
      host: const HostInfo(
        id: 'a0000000-0000-0000-0000-000000000002',
        name: 'Sarah Host',
        avatarUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
        isSuperhost: true,
        hostingYears: 5,
        responseRate: 98.0,
        bio: 'Experienced host with multiple properties across the US. '
            'I love creating memorable stays for my guests.',
      ),
    ),

    'd0000000-0000-0000-0000-000000000004': ListingDetailModel(
      id: 'd0000000-0000-0000-0000-000000000004',
      title: 'Historic Brownstone',
      description:
          'Beautifully restored 19th-century brownstone in a quiet, tree-lined '
          'Boston neighborhood. Original hardwood floors, exposed brick walls, '
          'and modern amenities blend historic charm with contemporary comfort. '
          'Features a chef''s kitchen, cozy reading nook, and private backyard garden. '
          'Walking distance to the T, Harvard Square, and the Charles River.',
      imageUrls: [
        'https://images.unsplash.com/photo-1460317442991-0ec209397118?w=800&q=80',
        'https://images.unsplash.com/photo-1505691938895-1758d7feb511?w=800&q=80',
      ],
      location: 'Boston, United States',
      pricePerNight: 175.0,
      rating: 4.60,
      reviewCount: 6,
      isGuestFavorite: false,
      maxGuests: 5,
      bedrooms: 3,
      beds: 3,
      bathrooms: 2,
      amenities: const [
        Amenity(id: '1', name: 'WiFi', iconKey: 'wifi'),
        Amenity(id: '2', name: 'Kitchen', iconKey: 'kitchen'),
        Amenity(id: '4', name: 'Heating', iconKey: 'heating'),
        Amenity(id: '5', name: 'Washer', iconKey: 'washer'),
      ],
      reviews: [
        Review(
          id: 'rev-007',
          userName: 'David Historian',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100&q=80',
          rating: 5,
          comment:
              'What a gem! The brownstone is full of character and beautifully maintained. '
              'The neighborhood is peaceful yet close to everything. A true Boston experience.',
          date: DateTime.fromMillisecondsSinceEpoch(1730128000000),
        ),
        Review(
          id: 'rev-008',
          userName: 'Anna Scholar',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1487412720507-e7ab37603b4a?w=100&q=80',
          rating: 4,
          comment:
              'Lovely historic home with modern updates. Great kitchen for cooking. '
              'The stairs are a bit steep (old house charm!) but overall a wonderful stay.',
          date: DateTime.fromMillisecondsSinceEpoch(1727344000000),
        ),
      ],
      host: const HostInfo(
        id: 'a0000000-0000-0000-0000-000000000002',
        name: 'Sarah Host',
        avatarUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
        isSuperhost: true,
        hostingYears: 5,
        responseRate: 98.0,
        bio: 'Experienced host with multiple properties across the US. '
            'I love creating memorable stays for my guests.',
      ),
    ),

    'd0000000-0000-0000-0000-000000000005': ListingDetailModel(
      id: 'd0000000-0000-0000-0000-000000000005',
      title: 'Loft in Arts District',
      description:
          'Industrial-chic loft in the vibrant Arts District of Downtown Los Angeles. '
          'High ceilings, exposed brick, polished concrete floors, and walls of windows '
          'flood the space with natural light. Features an open-plan living area, '
          'a fully equipped kitchen, and a private balcony overlooking the city. '
          'Steps away from galleries, coffee shops, and the best nightlife in LA.',
      imageUrls: [
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800&q=80',
        'https://images.unsplash.com/photo-1536376072261-38c75010e6c9?w=800&q=80',
        'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=800&q=80',
      ],
      location: 'Los Angeles, United States',
      pricePerNight: 125.0,
      rating: 4.80,
      reviewCount: 10,
      isGuestFavorite: false,
      maxGuests: 2,
      bedrooms: 1,
      beds: 1,
      bathrooms: 1,
      amenities: const [
        Amenity(id: '1', name: 'WiFi', iconKey: 'wifi'),
        Amenity(id: '3', name: 'Air Conditioning', iconKey: 'ac'),
        Amenity(id: '10', name: 'TV', iconKey: 'tv'),
        Amenity(id: '15', name: 'Balcony', iconKey: 'balcony'),
      ],
      reviews: [
        Review(
          id: 'rev-009',
          userName: 'Chris Creative',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=100&q=80',
          rating: 5,
          comment:
              'The perfect LA stay! The loft is stylish and inspiring. Loved the balcony '
              'for morning coffee. The Arts District neighborhood is amazing for exploring.',
          date: DateTime.fromMillisecondsSinceEpoch(1724560000000),
        ),
        Review(
          id: 'rev-010',
          userName: 'Jessica Design',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100&q=80',
          rating: 4,
          comment:
              'Gorgeous loft with incredible natural light. Perfect for photos! '
              'Parking was a bit tricky in the area but the loft itself is fantastic.',
          date: DateTime.fromMillisecondsSinceEpoch(1721376000000),
        ),
      ],
      host: const HostInfo(
        id: 'a0000000-0000-0000-0000-000000000002',
        name: 'Sarah Host',
        avatarUrl:
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80',
        isSuperhost: true,
        hostingYears: 5,
        responseRate: 98.0,
        bio: 'Experienced host with multiple properties across the US. '
            'I love creating memorable stays for my guests.',
      ),
    ),
  };
}

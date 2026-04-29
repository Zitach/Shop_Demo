import 'package:shop_demo/features/listing/domain/amenity.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';
import 'package:shop_demo/features/listing/domain/review.dart';

abstract final class ListingMockData {
  static final Map<String, ListingDetail> listings = {
    '1': ListingDetail(
      id: '1',
      title: 'Secluded Treehouse Getaway',
      description:
          'Escape to this magical treehouse nestled in the Blue Ridge Mountains. '
          'Wake up to birdsong and panoramic forest views. The treehouse features '
          'handcrafted wooden interiors, a wraparound deck with a hot tub, and a '
          'fully equipped kitchenette. Perfect for couples seeking a unique retreat '
          'with all the comforts of home surrounded by nature.',
      imageUrls: [
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
      ],
      location: 'Asheville, North Carolina',
      pricePerNight: 185,
      rating: 4.92,
      reviewCount: 128,
      isGuestFavorite: true,
      maxGuests: 2,
      bedrooms: 1,
      beds: 1,
      bathrooms: 1,
      amenities: const [
        Amenity(id: 1, name: 'Wifi', iconKey: 'wifi'),
        Amenity(id: 2, name: 'Hot tub', iconKey: 'hot_tub'),
        Amenity(id: 3, name: 'Kitchen', iconKey: 'kitchen'),
        Amenity(id: 4, name: 'Free parking', iconKey: 'parking'),
        Amenity(id: 5, name: 'Heating', iconKey: 'heating'),
        Amenity(id: 6, name: 'Fireplace', iconKey: 'fireplace'),
      ],
      reviews: [
        Review(
          id: 'r1',
          userName: 'Sarah',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
          rating: 5,
          comment:
              'Absolutely magical experience! The treehouse exceeded all our '
              'expectations. Waking up surrounded by nature was incredible.',
          date: DateTime(2025, 10, 15),
        ),
        Review(
          id: 'r2',
          userName: 'James',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
          rating: 5,
          comment:
              'Perfect romantic getaway. The hot tub under the stars was the '
              'highlight of our trip.',
          date: DateTime(2025, 9, 22),
        ),
        Review(
          id: 'r3',
          userName: 'Maria',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
          rating: 4,
          comment:
              'Beautiful place with amazing views. The drive up was a bit '
              'challenging but worth it!',
          date: DateTime(2025, 8, 5),
        ),
        Review(
          id: 'r4',
          userName: 'David',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
          rating: 5,
          comment:
              'Host was incredibly responsive. The treehouse is even more '
              'beautiful in person.',
          date: DateTime(2025, 7, 18),
        ),
      ],
      host: const HostInfo(
        id: 'h1',
        name: 'Emily',
        avatarUrl:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
        isSuperhost: true,
        hostingYears: 5,
        responseRate: 98,
        bio: 'Nature lover and treehouse builder. I love sharing this magical '
            'space with travelers from around the world.',
      ),
    ),
    '2': ListingDetail(
      id: '2',
      title: 'Modern Loft in Downtown',
      description:
          'Stylish industrial loft in the heart of Portland\'s Pearl District. '
          'Soaring 14-foot ceilings, exposed brick walls, and floor-to-ceiling '
          'windows flood the space with natural light. Walking distance to '
          'Powell\'s Books, craft breweries, and the best food carts in the city.',
      imageUrls: [
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
        'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800',
      ],
      location: 'Portland, Oregon',
      pricePerNight: 120,
      rating: 4.78,
      reviewCount: 95,
      isGuestFavorite: false,
      maxGuests: 4,
      bedrooms: 1,
      beds: 2,
      bathrooms: 1,
      amenities: const [
        Amenity(id: 1, name: 'Wifi', iconKey: 'wifi'),
        Amenity(id: 7, name: 'Washer', iconKey: 'washer'),
        Amenity(id: 8, name: 'Dryer', iconKey: 'dryer'),
        Amenity(id: 3, name: 'Kitchen', iconKey: 'kitchen'),
        Amenity(id: 9, name: 'Air conditioning', iconKey: 'ac'),
        Amenity(id: 10, name: 'TV', iconKey: 'tv'),
        Amenity(id: 11, name: 'Workspace', iconKey: 'workspace'),
      ],
      reviews: [
        Review(
          id: 'r5',
          userName: 'Alex',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
          rating: 5,
          comment:
              'The location is unbeatable! Walked everywhere and the loft itself '
              'is beautifully designed.',
          date: DateTime(2025, 11, 3),
        ),
        Review(
          id: 'r6',
          userName: 'Kim',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
          rating: 4,
          comment:
              'Great space for a city getaway. The loft has everything you need '
              'and the neighborhood is vibrant.',
          date: DateTime(2025, 10, 20),
        ),
        Review(
          id: 'r7',
          userName: 'Tom',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
          rating: 5,
          comment:
              'Stylish and comfortable. Would definitely book again on our next '
              'Portland trip.',
          date: DateTime(2025, 9, 14),
        ),
      ],
      host: const HostInfo(
        id: 'h2',
        name: 'Marcus',
        avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
        isSuperhost: true,
        hostingYears: 3,
        responseRate: 95,
        bio: 'Architect and Portland local. Happy to share tips about the best '
            'spots in the city.',
      ),
    ),
    '3': ListingDetail(
      id: '3',
      title: 'Oceanfront Villa with Pool',
      description:
          'Luxury oceanfront villa with stunning Pacific Ocean views. This '
          '5-bedroom retreat features an infinity pool, private beach access, '
          'and a chef\'s kitchen. The open floor plan seamlessly blends indoor '
          'and outdoor living. Watch dolphins play from the expansive terrace '
          'or take a short walk to some of California\'s best beaches.',
      imageUrls: [
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
        'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800',
        'https://images.unsplash.com/photo-1600573472592-401b489a3cdc?w=800',
        'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=800',
      ],
      location: 'Malibu, California',
      pricePerNight: 450,
      rating: 4.96,
      reviewCount: 210,
      isGuestFavorite: true,
      maxGuests: 10,
      bedrooms: 5,
      beds: 6,
      bathrooms: 4,
      amenities: const [
        Amenity(id: 1, name: 'Wifi', iconKey: 'wifi'),
        Amenity(id: 12, name: 'Pool', iconKey: 'pool'),
        Amenity(id: 3, name: 'Kitchen', iconKey: 'kitchen'),
        Amenity(id: 13, name: 'Beach access', iconKey: 'beach'),
        Amenity(id: 4, name: 'Free parking', iconKey: 'parking'),
        Amenity(id: 9, name: 'Air conditioning', iconKey: 'ac'),
        Amenity(id: 10, name: 'TV', iconKey: 'tv'),
        Amenity(id: 14, name: 'BBQ grill', iconKey: 'grill'),
        Amenity(id: 7, name: 'Washer', iconKey: 'washer'),
        Amenity(id: 8, name: 'Dryer', iconKey: 'dryer'),
        Amenity(id: 15, name: 'Gym', iconKey: 'gym'),
        Amenity(id: 16, name: 'Ocean view', iconKey: 'ocean'),
      ],
      reviews: [
        Review(
          id: 'r8',
          userName: 'Jennifer',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
          rating: 5,
          comment:
              'This villa is absolutely stunning. The infinity pool overlooking '
              'the ocean was a dream. Best vacation rental we\'ve ever had!',
          date: DateTime(2025, 11, 10),
        ),
        Review(
          id: 'r9',
          userName: 'Michael',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
          rating: 5,
          comment:
              'Hosted our family reunion here. Everyone was blown away by the '
              'views and amenities. Truly a five-star property.',
          date: DateTime(2025, 10, 5),
        ),
        Review(
          id: 'r10',
          userName: 'Priya',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
          rating: 5,
          comment:
              'Worth every penny. The sunsets from the terrace are '
              'unforgettable. We didn\'t want to leave!',
          date: DateTime(2025, 9, 18),
        ),
        Review(
          id: 'r11',
          userName: 'Chris',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
          rating: 5,
          comment:
              'Perfect for a group trip. The kitchen is fully stocked, pool is '
              'heated, and the location is incredible.',
          date: DateTime(2025, 8, 22),
        ),
        Review(
          id: 'r12',
          userName: 'Laura',
          userAvatarUrl:
              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
          rating: 4,
          comment:
              'Beautiful property! Only minor issue was the wifi was a bit '
              'slow, but who needs wifi with these views?',
          date: DateTime(2025, 7, 30),
        ),
      ],
      host: const HostInfo(
        id: 'h3',
        name: 'Sophia',
        avatarUrl:
            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200',
        isSuperhost: true,
        hostingYears: 8,
        responseRate: 99,
        bio: 'Luxury property manager with a passion for hospitality. I ensure '
            'every guest has an unforgettable Malibu experience.',
      ),
    ),
  };
}

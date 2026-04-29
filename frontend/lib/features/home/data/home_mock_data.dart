import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

abstract final class HomeMockData {
  static const categories = [
    Category(id: 1, name: 'Rooms', iconUrl: 'https://img.icons8.com/ios/32/bedroom.png'),
    Category(id: 2, name: 'Mansions', iconUrl: 'https://img.icons8.com/ios/32/castle.png'),
    Category(id: 3, name: 'Countryside', iconUrl: 'https://img.icons8.com/ios/32/farm.png'),
    Category(id: 4, name: 'Beach', iconUrl: 'https://img.icons8.com/ios/32/beach.png'),
    Category(id: 5, name: 'Cabins', iconUrl: 'https://img.icons8.com/ios/32/cabin.png'),
    Category(id: 6, name: 'Pools', iconUrl: 'https://img.icons8.com/ios/32/swimming.png'),
    Category(id: 7, name: 'Lakefront', iconUrl: 'https://img.icons8.com/ios/32/lake.png'),
    Category(id: 8, name: 'Tiny homes', iconUrl: 'https://img.icons8.com/ios/32/home.png'),
    Category(id: 9, name: 'Treehouses', iconUrl: 'https://img.icons8.com/ios/32/treehouse.png', isNew: true),
    Category(id: 10, name: 'Experiences', iconUrl: 'https://img.icons8.com/ios/32/ticket.png', isNew: true),
  ];

  static const listings = [
    ListingCard(
      id: '1',
      imageUrls: [
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
      ],
      title: 'Secluded Treehouse Getaway',
      location: 'Asheville, North Carolina',
      dateRange: 'Nov 12 – 17',
      pricePerNight: 185,
      rating: 4.92,
      reviewCount: 128,
      isGuestFavorite: true,
    ),
    ListingCard(
      id: '2',
      imageUrls: [
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
        'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800',
      ],
      title: 'Modern Loft in Downtown',
      location: 'Portland, Oregon',
      dateRange: 'Dec 1 – 6',
      pricePerNight: 120,
      rating: 4.78,
      reviewCount: 95,
    ),
    ListingCard(
      id: '3',
      imageUrls: [
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
        'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800',
        'https://images.unsplash.com/photo-1600573472592-401b489a3cdc?w=800',
        'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=800',
      ],
      title: 'Oceanfront Villa with Pool',
      location: 'Malibu, California',
      pricePerNight: 450,
      rating: 4.96,
      reviewCount: 210,
      isGuestFavorite: true,
    ),
    ListingCard(
      id: '4',
      imageUrls: [
        'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?w=800',
        'https://images.unsplash.com/photo-1600210492493-0946911123ea?w=800',
      ],
      title: 'Cozy Mountain Cabin',
      location: 'Gatlinburg, Tennessee',
      dateRange: 'Jan 5 – 10',
      pricePerNight: 95,
      rating: 4.85,
      reviewCount: 342,
    ),
    ListingCard(
      id: '5',
      imageUrls: [
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
      ],
      title: 'Designer Apartment near Eiffel Tower',
      location: 'Paris, France',
      pricePerNight: 275,
      rating: 4.88,
      reviewCount: 156,
    ),
    ListingCard(
      id: '6',
      imageUrls: [
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
      ],
      title: 'Rustic Farmhouse Retreat',
      location: 'Tuscany, Italy',
      dateRange: 'Mar 15 – 22',
      pricePerNight: 160,
      rating: 4.72,
      reviewCount: 87,
    ),
  ];
}

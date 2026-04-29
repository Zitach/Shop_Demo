import 'package:go_router/go_router.dart';
import 'package:shop_demo/features/auth/presentation/pages/login_page.dart';
import 'package:shop_demo/features/auth/presentation/pages/register_page.dart';
import 'package:shop_demo/features/booking/domain/entities/booking.dart';
import 'package:shop_demo/features/booking/presentation/pages/booking_confirmation_page.dart';
import 'package:shop_demo/features/booking/presentation/pages/booking_page.dart';
import 'package:shop_demo/features/home/presentation/pages/home_page.dart';
import 'package:shop_demo/features/listing/presentation/pages/listing_detail_page.dart';
import 'package:shop_demo/features/profile/presentation/pages/favorites_page.dart';
import 'package:shop_demo/features/profile/presentation/pages/my_bookings_page.dart';
import 'package:shop_demo/features/profile/presentation/pages/profile_page.dart';
import 'package:shop_demo/features/search/presentation/pages/search_page.dart';
import 'package:shop_demo/features/search/presentation/pages/search_results_page.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      path: '/search/results',
      name: 'searchResults',
      builder: (context, state) => const SearchResultsPage(),
    ),
    GoRoute(
      path: '/listing/:id',
      name: 'listing',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ListingDetailPage(listingId: id);
      },
    ),
    GoRoute(
      path: '/booking/:listingId',
      name: 'booking',
      builder: (context, state) {
        final id = state.pathParameters['listingId']!;
        return BookingPage(listingId: id);
      },
    ),
    GoRoute(
      path: '/booking/confirmation',
      name: 'bookingConfirmation',
      builder: (context, state) {
        final booking = state.extra as Booking;
        return BookingConfirmationPage(booking: booking);
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/my-bookings',
      name: 'myBookings',
      builder: (context, state) => const MyBookingsPage(),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesPage(),
    ),
  ],
);

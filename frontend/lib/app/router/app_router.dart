import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/features/home/presentation/pages/home_page.dart';

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: Theme.of(context).textTheme.displayMedium)),
    );
  }
}

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
      builder: (context, state) => const _PlaceholderPage('Search'),
    ),
    GoRoute(
      path: '/listing/:id',
      name: 'listing',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return _PlaceholderPage('Listing $id');
      },
    ),
    GoRoute(
      path: '/booking/:listingId',
      name: 'booking',
      builder: (context, state) {
        final id = state.pathParameters['listingId']!;
        return _PlaceholderPage('Booking $id');
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const _PlaceholderPage('Login'),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const _PlaceholderPage('Register'),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const _PlaceholderPage('Profile'),
    ),
    GoRoute(
      path: '/my-bookings',
      name: 'myBookings',
      builder: (context, state) => const _PlaceholderPage('My Bookings'),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const _PlaceholderPage('Favorites'),
    ),
  ],
);

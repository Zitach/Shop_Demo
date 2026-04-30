import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/widgets/nav_shell.dart';
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

// Shared transition durations
const _kPageTransitionDuration = Duration(milliseconds: 300);
const _kPageReverseDuration = Duration(milliseconds: 250);

// Fade + slight upward slide transition (for detail pages)
CustomTransitionPage<void> _fadeSlideTransition(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: _kPageTransitionDuration,
    reverseTransitionDuration: _kPageReverseDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.03),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

// Slide from right transition (for push pages like booking, login)
CustomTransitionPage<void> _slideRightTransition(
  GoRouterState state,
  Widget child,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: _kPageTransitionDuration,
    reverseTransitionDuration: _kPageReverseDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(curved),
        child: FadeTransition(
          opacity: curved,
          child: child,
        ),
      );
    },
  );
}

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // Shell routes with bottom/top navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return NavShell(navigationShell: navigationShell);
      },
      branches: [
        // Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),

        // Search
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              name: 'search',
              builder: (context, state) => const SearchPage(),
              routes: [
                GoRoute(
                  path: 'results',
                  name: 'searchResults',
                  builder: (context, state) => const SearchResultsPage(),
                ),
              ],
            ),
          ],
        ),

        // Favorites
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/favorites',
              name: 'favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
          ],
        ),

        // Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),

    // Top-level routes (outside navigation shell)
    GoRoute(
      path: '/listing/:id',
      name: 'listing',
      pageBuilder: (context, state) {
        final id = state.pathParameters['id']!;
        return _fadeSlideTransition(state, ListingDetailPage(listingId: id));
      },
    ),
    GoRoute(
      path: '/booking/:listingId',
      name: 'booking',
      pageBuilder: (context, state) {
        final id = state.pathParameters['listingId']!;
        return _slideRightTransition(state, BookingPage(listingId: id));
      },
    ),
    GoRoute(
      path: '/booking/confirmation',
      name: 'bookingConfirmation',
      pageBuilder: (context, state) {
        final booking = state.extra as Booking;
        return _slideRightTransition(
            state, BookingConfirmationPage(booking: booking));
      },
    ),
    GoRoute(
      path: '/my-bookings',
      name: 'myBookings',
      pageBuilder: (context, state) =>
          _slideRightTransition(state, const MyBookingsPage()),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      pageBuilder: (context, state) =>
          _slideRightTransition(state, const LoginPage()),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      pageBuilder: (context, state) =>
          _slideRightTransition(state, const RegisterPage()),
    ),
  ],
);

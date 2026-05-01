import 'package:dart_frog/dart_frog.dart';

import '../lib/database/database.dart';
import '../lib/middleware/cors_middleware.dart';
import '../lib/middleware/error_handler.dart';
import '../lib/services/auth_service.dart';
import '../lib/services/booking_service.dart';
import '../lib/services/listing_service.dart';
import '../lib/services/search_service.dart';

// Singleton database instance
final _database = AppDatabase();

// Singleton service instances
final _authService = AuthService();
final _userDao = UserDao(_database);
final _listingDao = ListingDao(_database);
final _bookingDao = BookingDao(_database);
final _reviewDao = ReviewDao(_database);
final _listingService = ListingService(listingDao: _listingDao, userDao: _userDao, reviewDao: _reviewDao);
final _searchService = SearchService(listingDao: _listingDao);
final _bookingService = BookingService(bookingDao: _bookingDao, listingDao: _listingDao);

/// Root middleware that applies global middleware and provides shared dependencies
Handler middleware(Handler handler) {
  return handler
      .use(errorHandler())
      .use(corsMiddleware())
      .use(provider<AppDatabase>((_) => _database))
      .use(provider<UserDao>((_) => _userDao))
      .use(provider<ListingDao>((_) => _listingDao))
      .use(provider<BookingDao>((_) => _bookingDao))
      .use(provider<ReviewDao>((_) => _reviewDao))
      .use(provider<AuthService>((_) => _authService))
      .use(provider<ListingService>((_) => _listingService))
      .use(provider<SearchService>((_) => _searchService))
      .use(provider<BookingService>((_) => _bookingService));
}

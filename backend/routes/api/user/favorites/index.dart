import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../../lib/database/database.dart';
import '../../../../lib/services/auth_service.dart';

/// Extract and verify userId from Authorization header
String? _getUserId(RequestContext context) {
  final authHeader = context.request.headers['Authorization'];
  if (authHeader == null || !authHeader.startsWith('Bearer ')) return null;
  final token = authHeader.substring(7);
  return context.read<AuthService>().verifyToken(token);
}

/// GET /api/user/favorites - Get user's favorites
/// POST /api/user/favorites - Toggle favorite (add/remove)
/// DELETE /api/user/favorites/:listingId - Remove favorite
Future<Response> onRequest(RequestContext context) async {
  final userId = _getUserId(context);
  if (userId == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': {
          'code': HttpStatus.unauthorized,
          'message': 'Authentication required',
        }
      },
    );
  }

  final listingDao = context.read<ListingDao>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getFavorites(listingDao, userId);
    case HttpMethod.post:
      return _toggleFavorite(context, listingDao, userId);
    default:
      return Response.json(
        statusCode: HttpStatus.methodNotAllowed,
        body: {'error': {'code': 405, 'message': 'Method not allowed'}},
      );
  }
}

Future<Response> _getFavorites(ListingDao listingDao, String userId) async {
  final favorites = await listingDao.getFavoriteListings(userId);

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'favorites': favorites
          .map((Listing l) => {
                'id': l.id,
                'hostId': l.hostId,
                'categoryId': l.categoryId,
                'title': l.title,
                'description': l.description,
                'pricePerUnit': l.pricePerUnit,
                'currency': l.currency,
                'city': l.city,
                'country': l.country,
                'avgRating': l.avgRating,
                'reviewCount': l.reviewCount,
              })
          .toList(),
      'total': favorites.length,
    },
  );
}

Future<Response> _toggleFavorite(
  RequestContext context,
  ListingDao listingDao,
  String userId,
) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final listingId = body['listingId'] as String?;

  if (listingId == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'listingId is required',
        }
      },
    );
  }

  final isFavorited = await listingDao.toggleFavorite(userId, listingId);

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'listingId': listingId,
      'isFavorited': isFavorited,
    },
  );
}

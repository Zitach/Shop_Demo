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

/// DELETE /api/user/favorites/:listingId
/// Remove a listing from user's favorites (auth required)
Future<Response> onRequest(RequestContext context, String listingId) async {
  if (context.request.method != HttpMethod.delete) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

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

  // Check if favorited
  final isFavorited = await listingDao.isFavorited(userId, listingId);
  if (!isFavorited) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: {
        'error': {
          'code': HttpStatus.notFound,
          'message': 'Favorite not found',
        }
      },
    );
  }

  // Toggle will remove it since it's already favorited
  await listingDao.toggleFavorite(userId, listingId);

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'listingId': listingId,
      'isFavorited': false,
    },
  );
}

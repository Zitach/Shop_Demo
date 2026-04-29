import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/database/database.dart';

/// GET /api/reviews/:listingId
/// Get reviews for a listing (public endpoint)
Future<Response> onRequest(RequestContext context, String listingId) async {
  if (context.request.method != HttpMethod.get) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

  final reviewDao = context.read<ReviewDao>();
  final userDao = context.read<UserDao>();

  final reviews = await reviewDao.getReviewsByListing(listingId);

  // Enrich reviews with author info
  final enrichedReviews = <Map<String, dynamic>>[];
  for (final review in reviews) {
    final author = await userDao.getUserById(review.authorId);
    enrichedReviews.add({
      'id': review.id,
      'listingId': review.listingId,
      'authorId': review.authorId,
      'author': author != null
          ? {
              'id': author.id,
              'displayName': author.displayName,
              'avatarUrl': author.avatarUrl,
            }
          : null,
      'rating': review.rating,
      'title': review.title,
      'comment': review.comment,
      'response': review.response,
      'responseAt': review.responseAt?.toIso8601String(),
      'createdAt': review.createdAt.toIso8601String(),
    });
  }

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'reviews': enrichedReviews,
      'total': reviews.length,
    },
  );
}

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/services/listing_service.dart';

/// GET /api/listings/:id
/// Get listing detail by ID with images, amenities, and host info
Future<Response> onRequest(RequestContext context, String id) async {
  if (context.request.method != HttpMethod.get) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

  final listingService = context.read<ListingService>();
  final detail = await listingService.getById(id);

  if (detail == null) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: {
        'error': {
          'code': HttpStatus.notFound,
          'message': 'Listing not found',
        }
      },
    );
  }

  return Response.json(
    statusCode: HttpStatus.ok,
    body: detail.toJson(),
  );
}

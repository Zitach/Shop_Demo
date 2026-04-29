import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/services/listing_service.dart';

/// GET /api/listings
/// Get paginated listings (featured by default, or all active)
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

  final listingService = context.read<ListingService>();
  final queryParams = context.request.uri.queryParameters;

  final page = int.tryParse(queryParams['page'] ?? '1') ?? 1;
  final limit = int.tryParse(queryParams['limit'] ?? '20') ?? 20;
  final featured = queryParams['featured'] == 'true';

  // Clamp limit to reasonable range
  final clampedLimit = limit.clamp(1, 100);
  final clampedPage = page.clamp(1, 10000);

  final result = featured
      ? await listingService.getFeatured(clampedPage, clampedLimit)
      : await listingService.getActive(clampedPage, clampedLimit);

  return Response.json(
    statusCode: HttpStatus.ok,
    body: result.toJson(),
  );
}

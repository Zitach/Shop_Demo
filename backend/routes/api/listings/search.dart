import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/services/search_service.dart';

/// GET /api/listings/search
/// Search listings with filters: q, category, minPrice, maxPrice, guests, sortBy, page, limit
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

  final searchService = context.read<SearchService>();
  final queryParams = context.request.uri.queryParameters;

  final query = queryParams['q'];
  final category = queryParams['category'];
  final minPrice = double.tryParse(queryParams['minPrice'] ?? '');
  final maxPrice = double.tryParse(queryParams['maxPrice'] ?? '');
  final guests = int.tryParse(queryParams['guests'] ?? '');
  final sortBy = queryParams['sortBy'];
  final page = int.tryParse(queryParams['page'] ?? '1') ?? 1;
  final limit = int.tryParse(queryParams['limit'] ?? '20') ?? 20;

  final clampedLimit = limit.clamp(1, 100);
  final clampedPage = page.clamp(1, 10000);

  final result = await searchService.search(
    query: query,
    category: category,
    minPrice: minPrice,
    maxPrice: maxPrice,
    guests: guests,
    sortBy: sortBy,
    page: clampedPage,
    limit: clampedLimit,
  );

  return Response.json(
    statusCode: HttpStatus.ok,
    body: result.toJson(),
  );
}

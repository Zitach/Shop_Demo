import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:drift/drift.dart';

import '../../../lib/database/database.dart';

/// GET /api/categories
/// Get all active categories
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.get) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

  final db = context.read<AppDatabase>();

  final categories = await (db.select(db.categories)
        ..where((c) => c.isActive.equals(true))
        ..orderBy([(c) => OrderingTerm.asc(c.sortOrder)]))
      .get();

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'categories': categories
          .map((c) => {
                'id': c.id,
                'name': c.name,
                'iconUrl': c.iconUrl,
                'isNew': false,
              })
          .toList(),
    },
  );
}

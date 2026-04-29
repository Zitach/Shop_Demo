import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// Health check endpoint
Response onRequest(RequestContext context) {
  return Response.json(
    body: {
      'status': 'healthy',
      'service': 'shop_demo_api',
      'version': '1.0.0',
      'timestamp': DateTime.now().toIso8601String(),
      'environment': Platform.environment['DART_FROG_ENV'] ?? 'development',
    },
  );
}

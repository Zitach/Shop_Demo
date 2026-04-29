import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../services/auth_service.dart';

/// Auth middleware that extracts and verifies JWT Bearer tokens.
/// Injects the authenticated userId into the request context.
Middleware authMiddleware() {
  return (handler) {
    return (context) async {
      final authHeader = context.request.headers['Authorization'];

      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.json(
          statusCode: HttpStatus.unauthorized,
          body: {
            'error': {
              'code': HttpStatus.unauthorized,
              'message': 'Missing or invalid Authorization header',
            }
          },
        );
      }

      final token = authHeader.substring(7); // Remove 'Bearer ' prefix
      final authService = context.read<AuthService>();
      final userId = authService.verifyToken(token);

      if (userId == null) {
        return Response.json(
          statusCode: HttpStatus.unauthorized,
          body: {
            'error': {
              'code': HttpStatus.unauthorized,
              'message': 'Invalid or expired token',
            }
          },
        );
      }

      // Inject userId into context for downstream handlers
      return handler(context.provide<String>(() => userId));
    };
  };
}

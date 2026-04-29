import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/database/database.dart';
import '../../../lib/services/auth_service.dart';

/// POST /api/auth/refresh
/// Refresh an expired access token using a refresh token
Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response.json(
      statusCode: HttpStatus.methodNotAllowed,
      body: {'error': {'code': 405, 'message': 'Method not allowed'}},
    );
  }

  final authService = context.read<AuthService>();
  final userDao = context.read<UserDao>();

  final body = await context.request.json() as Map<String, dynamic>;
  final refreshToken = body['refreshToken'] as String?;

  if (refreshToken == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'Refresh token is required',
        }
      },
    );
  }

  // Verify refresh token
  final userId = authService.verifyRefreshToken(refreshToken);
  if (userId == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': {
          'code': HttpStatus.unauthorized,
          'message': 'Invalid or expired refresh token',
        }
      },
    );
  }

  // Verify user still exists
  final user = await userDao.getUserById(userId);
  if (user == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': {
          'code': HttpStatus.unauthorized,
          'message': 'User not found',
        }
      },
    );
  }

  // Generate new access token
  final newToken = authService.generateToken(userId);

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'token': newToken,
    },
  );
}

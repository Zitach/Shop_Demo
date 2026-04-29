import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/database/database.dart';
import '../../../lib/services/auth_service.dart';

/// POST /api/auth/login
/// Authenticate user with email and password, returns JWT token
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
  final email = body['email'] as String?;
  final password = body['password'] as String?;

  if (email == null || password == null) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'Email and password are required',
        }
      },
    );
  }

  // Find user by email
  final user = await userDao.getUserByEmail(email);
  if (user == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': {
          'code': HttpStatus.unauthorized,
          'message': 'Invalid email or password',
        }
      },
    );
  }

  // Verify password
  if (!authService.verifyPassword(password, user.passwordHash)) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': {
          'code': HttpStatus.unauthorized,
          'message': 'Invalid email or password',
        }
      },
    );
  }

  // Generate tokens
  final token = authService.generateToken(user.id);
  final refreshToken = authService.generateRefreshToken(user.id);

  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'user': {
        'id': user.id,
        'email': user.email,
        'displayName': user.displayName,
        'avatarUrl': user.avatarUrl,
        'phone': user.phone,
        'bio': user.bio,
        'isHost': user.isHost,
        'isVerified': user.isVerified,
      },
      'token': token,
      'refreshToken': refreshToken,
    },
  );
}

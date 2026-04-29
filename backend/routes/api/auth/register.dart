import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:drift/drift.dart';

import '../../../lib/database/database.dart';
import '../../../lib/services/auth_service.dart';

/// Generate a UUID v4 ID
String _generateId() {
  final random = List<int>.generate(16, (_) => DateTime.now().microsecondsSinceEpoch % 256);
  random[6] = (random[6] & 0x0f) | 0x40;
  random[8] = (random[8] & 0x3f) | 0x80;
  final hex = random.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20, 32)}';
}

/// POST /api/auth/register
/// Register a new user account
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
  final name = body['name'] as String?;
  final email = body['email'] as String?;
  final password = body['password'] as String?;

  // Validate required fields
  if (name == null || name.trim().isEmpty) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'Name is required',
        }
      },
    );
  }

  if (email == null || email.trim().isEmpty) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'Email is required',
        }
      },
    );
  }

  if (password == null || password.length < 8) {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {
        'error': {
          'code': HttpStatus.badRequest,
          'message': 'Password must be at least 8 characters',
        }
      },
    );
  }

  // Check if email already exists
  final existingUser = await userDao.getUserByEmail(email.trim());
  if (existingUser != null) {
    return Response.json(
      statusCode: HttpStatus.conflict,
      body: {
        'error': {
          'code': HttpStatus.conflict,
          'message': 'An account with this email already exists',
        }
      },
    );
  }

  // Hash password and create user
  final passwordHash = authService.hashPassword(password);
  final userId = _generateId();

  await userDao.createUser(UsersCompanion(
    id: Value(userId),
    email: Value(email.trim()),
    passwordHash: Value(passwordHash),
    displayName: Value(name.trim()),
  ));

  // Fetch the created user
  final user = await userDao.getUserById(userId);

  // Generate tokens
  final token = authService.generateToken(userId);
  final refreshToken = authService.generateRefreshToken(userId);

  return Response.json(
    statusCode: HttpStatus.created,
    body: {
      'user': {
        'id': user!.id,
        'email': user.email,
        'displayName': user.displayName,
        'avatarUrl': user.avatarUrl,
        'isHost': user.isHost,
        'isVerified': user.isVerified,
      },
      'token': token,
      'refreshToken': refreshToken,
    },
  );
}

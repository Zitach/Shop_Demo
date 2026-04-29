import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

import '../../../lib/database/database.dart';
import '../../../lib/services/auth_service.dart';

/// Extract and verify userId from Authorization header
String? _getUserId(RequestContext context) {
  final authHeader = context.request.headers['Authorization'];
  if (authHeader == null || !authHeader.startsWith('Bearer ')) return null;
  final token = authHeader.substring(7);
  return context.read<AuthService>().verifyToken(token);
}

/// GET /api/user/profile - Get current user's profile
/// PUT /api/user/profile - Update current user's profile
Future<Response> onRequest(RequestContext context) async {
  final userId = _getUserId(context);
  if (userId == null) {
    return Response.json(
      statusCode: HttpStatus.unauthorized,
      body: {
        'error': {
          'code': HttpStatus.unauthorized,
          'message': 'Authentication required',
        }
      },
    );
  }

  final userDao = context.read<UserDao>();

  switch (context.request.method) {
    case HttpMethod.get:
      return _getProfile(userDao, userId);
    case HttpMethod.put:
      return _updateProfile(context, userDao, userId);
    default:
      return Response.json(
        statusCode: HttpStatus.methodNotAllowed,
        body: {'error': {'code': 405, 'message': 'Method not allowed'}},
      );
  }
}

Future<Response> _getProfile(UserDao userDao, String userId) async {
  final user = await userDao.getUserById(userId);
  if (user == null) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: {
        'error': {
          'code': HttpStatus.notFound,
          'message': 'User not found',
        }
      },
    );
  }

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
        'createdAt': user.createdAt.toIso8601String(),
        'updatedAt': user.updatedAt.toIso8601String(),
      },
    },
  );
}

Future<Response> _updateProfile(
  RequestContext context,
  UserDao userDao,
  String userId,
) async {
  final body = await context.request.json() as Map<String, dynamic>;

  final displayName = body['displayName'] as String?;
  final avatarUrl = body['avatarUrl'] as String?;
  final phone = body['phone'] as String?;
  final bio = body['bio'] as String?;

  final updated = await userDao.updateProfile(
    id: userId,
    displayName: displayName,
    avatarUrl: avatarUrl,
    phone: phone,
    bio: bio,
  );

  if (!updated) {
    return Response.json(
      statusCode: HttpStatus.notFound,
      body: {
        'error': {
          'code': HttpStatus.notFound,
          'message': 'User not found',
        }
      },
    );
  }

  // Return updated profile
  final user = await userDao.getUserById(userId);
  return Response.json(
    statusCode: HttpStatus.ok,
    body: {
      'user': {
        'id': user!.id,
        'email': user.email,
        'displayName': user.displayName,
        'avatarUrl': user.avatarUrl,
        'phone': user.phone,
        'bio': user.bio,
        'isHost': user.isHost,
        'isVerified': user.isVerified,
        'createdAt': user.createdAt.toIso8601String(),
        'updatedAt': user.updatedAt.toIso8601String(),
      },
    },
  );
}

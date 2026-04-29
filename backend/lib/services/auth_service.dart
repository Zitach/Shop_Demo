import 'dart:io';

import 'package:bcrypt/bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

/// Service for handling authentication, password hashing, and JWT tokens
class AuthService {
  AuthService({
    String? jwtSecret,
    this.tokenExpiration = const Duration(hours: 24),
    this.refreshExpiration = const Duration(days: 30),
  }) : _jwtSecret = jwtSecret ?? Platform.environment['JWT_SECRET'] ?? 'dev-secret-change-in-production';

  final String _jwtSecret;
  final Duration tokenExpiration;
  final Duration refreshExpiration;

  /// Hash a plaintext password using bcrypt
  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  /// Verify a plaintext password against a bcrypt hash
  bool verifyPassword(String password, String hash) {
    return BCrypt.checkpw(password, hash);
  }

  /// Generate a JWT access token for the given userId
  String generateToken(String userId) {
    final jwt = JWT(
      {
        'userId': userId,
        'type': 'access',
      },
      issuer: 'shop_demo_api',
    );
    return jwt.sign(
      SecretKey(_jwtSecret),
      expiresIn: tokenExpiration,
    );
  }

  /// Generate a JWT refresh token for the given userId
  String generateRefreshToken(String userId) {
    final jwt = JWT(
      {
        'userId': userId,
        'type': 'refresh',
      },
      issuer: 'shop_demo_api',
    );
    return jwt.sign(
      SecretKey(_jwtSecret),
      expiresIn: refreshExpiration,
    );
  }

  /// Verify a JWT token and return the userId, or null if invalid
  String? verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_jwtSecret));
      final payload = jwt.payload as Map<String, dynamic>;
      return payload['userId'] as String?;
    } on JWTException {
      return null;
    }
  }

  /// Verify a refresh token specifically (checks type field)
  String? verifyRefreshToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_jwtSecret));
      final payload = jwt.payload as Map<String, dynamic>;
      if (payload['type'] != 'refresh') return null;
      return payload['userId'] as String?;
    } on JWTException {
      return null;
    }
  }
}

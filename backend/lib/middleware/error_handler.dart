import 'dart:developer' as developer;
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// Custom HTTP exception with status code support
class AppHttpException implements Exception {
  AppHttpException(this.message, {this.statusCode = 500});

  final String message;
  final int statusCode;

  @override
  String toString() => 'AppHttpException($statusCode): $message';
}

/// Global error handler middleware that catches unhandled exceptions
/// and returns structured JSON error responses
Middleware errorHandler() {
  return (handler) {
    return (context) async {
      try {
        return await handler(context);
      } on AppHttpException catch (e) {
        developer.log('HTTP Exception: ${e.message}', name: 'ErrorHandler');
        return Response.json(
          statusCode: e.statusCode,
          body: {
            'error': {
              'code': e.statusCode,
              'message': e.message,
            }
          },
        );
      } on FormatException catch (e) {
        developer.log('Format Exception: ${e.message}', name: 'ErrorHandler');
        return Response.json(
          statusCode: HttpStatus.badRequest,
          body: {
            'error': {
              'code': HttpStatus.badRequest,
              'message': 'Invalid request format: ${e.message}',
            }
          },
        );
      } catch (e, stackTrace) {
        developer.log(
          'Unhandled Exception: $e',
          name: 'ErrorHandler',
          error: e,
          stackTrace: stackTrace,
        );
        return Response.json(
          statusCode: HttpStatus.internalServerError,
          body: {
            'error': {
              'code': HttpStatus.internalServerError,
              'message': 'Internal server error',
            }
          },
        );
      }
    };
  };
}

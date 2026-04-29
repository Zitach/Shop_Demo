import 'package:dart_frog/dart_frog.dart';

/// CORS middleware for handling cross-origin requests
Middleware corsMiddleware() {
  return (handler) {
    return (context) async {
      // Handle preflight OPTIONS requests
      if (context.request.method == HttpMethod.options) {
        return Response(
          statusCode: 204,
          headers: _corsHeaders(),
        );
      }

      // Process the request and add CORS headers to the response
      final response = await handler(context);
      return response.copyWith(
        headers: {
          ...response.headers,
          ..._corsHeaders(),
        },
      );
    };
  };
}

Map<String, String> _corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Requested-With',
    'Access-Control-Max-Age': '86400',
  };
}

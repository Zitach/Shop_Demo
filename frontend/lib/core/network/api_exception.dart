sealed class ApiException implements Exception {
  final String message;
  final int? statusCode;
  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class NetworkException extends ApiException {
  const NetworkException(super.message) : super(statusCode: null);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException([super.message = 'Unauthorized'])
      : super(statusCode: 401);
}

class ForbiddenException extends ApiException {
  const ForbiddenException([super.message = 'Forbidden'])
      : super(statusCode: 403);
}

class NotFoundException extends ApiException {
  const NotFoundException([super.message = 'Not found'])
      : super(statusCode: 404);
}

class ValidationException extends ApiException {
  final Map<String, List<String>>? errors;
  const ValidationException(super.message, {this.errors})
      : super(statusCode: 422);
}

class ServerException extends ApiException {
  const ServerException([super.message = 'Server error'])
      : super(statusCode: 500);
}

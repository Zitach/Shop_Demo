import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'api_exception.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({String? baseUrl, String? Function()? getToken}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.addAll([
      if (getToken != null) _AuthInterceptor(getToken),
      _ErrorInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  Dio get dio => _dio;

  void setToken(String? token) {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
}

class _AuthInterceptor extends Interceptor {
  final String? Function() _getToken;

  _AuthInterceptor(this._getToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final message = _extractMessage(err);

    final ApiException exception = switch (statusCode) {
      401 => UnauthorizedException(message),
      403 => ForbiddenException(message),
      404 => NotFoundException(message),
      422 => ValidationException(message),
      500 => ServerException(message),
      _ => err.type == DioExceptionType.connectionTimeout ||
              err.type == DioExceptionType.connectionError
          ? NetworkException('No internet connection')
          : ServerException(message),
    };

    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: exception,
      type: err.type,
      response: err.response,
    ));
  }

  String _extractMessage(DioException err) {
    try {
      final data = err.response?.data;
      if (data is Map<String, dynamic>) {
        return data['message']?.toString() ?? 'Unknown error';
      }
      if (data is String) return data;
    } catch (_) {}
    return err.message ?? 'Unknown error';
  }
}

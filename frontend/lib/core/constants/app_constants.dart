abstract final class AppConstants {
  static const String appName = 'Shop Demo';
  static const String apiBaseUrl = '/api';
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'cached_user';
  static const int defaultPageSize = 20;

  /// Set to true to use embedded mock data instead of making API calls.
  /// Required for GitHub Pages / standalone frontend deployment.
  static const bool useMockData = true;
}

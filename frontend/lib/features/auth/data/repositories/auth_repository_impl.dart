import 'package:shop_demo/core/constants/app_constants.dart';
import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/core/network/api_exception.dart';
import 'package:shop_demo/core/storage/local_storage.dart';
import 'package:shop_demo/features/auth/data/models/auth_response.dart';
import 'package:shop_demo/features/auth/data/models/user_model.dart';
import 'package:shop_demo/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<AuthResponse> login({required String email, required String password});
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
  });
  Future<User?> getCurrentUser();
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;
  final LocalStorage _localStorage;

  AuthRepositoryImpl(this._apiClient, this._localStorage);

  static const _mockUser = UserModel(
    id: 'a0000000-0000-0000-0000-000000000003',
    name: 'John Guest',
    email: 'guest@shopdemo.com',
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&q=80',
  );

  static const _mockAuthResponse = AuthResponse(
    token: 'mock-jwt-token',
    refreshToken: 'mock-refresh-token',
    user: _mockUser,
  );

  @override
  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      _localStorage.token = _mockAuthResponse.token;
      _localStorage.refreshToken = _mockAuthResponse.refreshToken;
      await _localStorage.set('user', _mockAuthResponse.user.toJson());
      return _mockAuthResponse;
    }

    final response = await _apiClient.dio.post(
      '/api/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final authResponse = AuthResponse.fromJson(
      data.containsKey('data') ? data['data'] as Map<String, dynamic> : data,
    );

    _localStorage.token = authResponse.token;
    _localStorage.refreshToken = authResponse.refreshToken;
    await _localStorage.set('user', authResponse.user.toJson());

    return authResponse;
  }

  @override
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (AppConstants.useMockData) {
      await Future.delayed(const Duration(milliseconds: 500));
      _localStorage.token = _mockAuthResponse.token;
      _localStorage.refreshToken = _mockAuthResponse.refreshToken;
      await _localStorage.set('user', _mockAuthResponse.user.toJson());
      return _mockAuthResponse;
    }

    final response = await _apiClient.dio.post(
      '/api/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final authResponse = AuthResponse.fromJson(
      data.containsKey('data') ? data['data'] as Map<String, dynamic> : data,
    );

    _localStorage.token = authResponse.token;
    _localStorage.refreshToken = authResponse.refreshToken;
    await _localStorage.set('user', authResponse.user.toJson());

    return authResponse;
  }

  @override
  Future<User?> getCurrentUser() async {
    if (AppConstants.useMockData) {
      return _mockUser;
    }

    final cached = _localStorage.get<Map>('user');
    if (cached != null && _localStorage.isLoggedIn) {
      return UserModel.fromJson(cached.cast<String, dynamic>());
    }

    if (_localStorage.isLoggedIn) {
      try {
        final response = await _apiClient.dio.get('/api/auth/me');
        final data = response.data as Map<String, dynamic>;
        final userData =
            data.containsKey('data') ? data['data'] as Map<String, dynamic> : data;
        final user = UserModel.fromJson(userData);
        await _localStorage.set('user', user.toJson());
        return user;
      } on UnauthorizedException {
        _localStorage.token = null;
        _localStorage.refreshToken = null;
        return null;
      }
    }

    return null;
  }

  @override
  Future<void> logout() async {
    _localStorage.token = null;
    _localStorage.refreshToken = null;
    await _localStorage.remove('user');
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/core/providers/core_providers.dart';
import 'package:shop_demo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shop_demo/features/auth/domain/entities/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localStorage = ref.watch(localStorageProvider);
  return AuthRepositoryImpl(apiClient, localStorage);
});

/// Holds the current auth state. On app start, attempts to restore session.
final authProvider =
    AsyncNotifierProvider<AuthNotifier, User?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    final repo = ref.watch(authRepositoryProvider);
    return repo.getCurrentUser();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final authResponse = await repo.login(
        email: email,
        password: password,
      );
      return authResponse.user;
    });
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final authResponse = await repo.register(
        name: name,
        email: email,
        password: password,
      );
      return authResponse.user;
    });
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    await repo.logout();
    state = const AsyncValue.data(null);
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/core/network/api_client.dart';
import 'package:shop_demo/core/storage/local_storage.dart';

/// Global LocalStorage instance.
final localStorageProvider = Provider<LocalStorage>((ref) {
  final storage = LocalStorage();
  // Note: init() must be called before use. The app bootstrap handles this.
  return storage;
});

/// Global ApiClient wired to the auth token from LocalStorage.
final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = ref.watch(localStorageProvider);
  return ApiClient(
    getToken: () => storage.token,
  );
});

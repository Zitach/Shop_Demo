import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const _boxName = 'shop_demo';

  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  String? get token => _box.get('token');
  set token(String? value) {
    if (value == null) {
      _box.delete('token');
    } else {
      _box.put('token', value);
    }
  }

  String? get refreshToken => _box.get('refreshToken');
  set refreshToken(String? value) {
    if (value == null) {
      _box.delete('refreshToken');
    } else {
      _box.put('refreshToken', value);
    }
  }

  T? get<T>(String key) => _box.get(key) as T?;
  Future<void> set<T>(String key, T value) => _box.put(key, value);
  Future<void> remove(String key) => _box.delete(key);
  Future<void> clear() => _box.clear();

  bool get isLoggedIn => token != null;
}

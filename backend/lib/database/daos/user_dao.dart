import 'package:drift/drift.dart';

import '../database_context.dart';
import '../tables/tables.dart';

part 'user_dao.g.dart';

/// Data Access Object for Users
@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(AppDatabase db) : super(db);

  /// Get all users
  Future<List<User>> getAllUsers() => select(users).get();

  /// Get user by ID
  Future<User?> getUserById(String id) =>
      (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();

  /// Get user by email
  Future<User?> getUserByEmail(String email) =>
      (select(users)..where((u) => u.email.equals(email))).getSingleOrNull();

  /// Get all hosts
  Future<List<User>> getHosts() =>
      (select(users)..where((u) => u.isHost.equals(true))).get();

  /// Create a new user
  Future<int> createUser(UsersCompanion user) => into(users).insert(user);

  /// Update user
  Future<bool> updateUser(String id, UsersCompanion user) async {
    final updated = await (update(users)..where((u) => u.id.equals(id)))
        .write(user.copyWith(updatedAt: Value(DateTime.now())));
    return updated > 0;
  }

  /// Update user profile
  Future<bool> updateProfile({
    required String id,
    String? displayName,
    String? avatarUrl,
    String? phone,
    String? bio,
  }) async {
    final companion = UsersCompanion(
      displayName: displayName != null ? Value(displayName) : const Value.absent(),
      avatarUrl: avatarUrl != null ? Value(avatarUrl) : const Value.absent(),
      phone: phone != null ? Value(phone) : const Value.absent(),
      bio: bio != null ? Value(bio) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
    );
    final updated = await (update(users)..where((u) => u.id.equals(id)))
        .write(companion);
    return updated > 0;
  }

  /// Mark user as host
  Future<bool> markAsHost(String id) async {
    final updated = await (update(users)..where((u) => u.id.equals(id)))
        .write(UsersCompanion(
      isHost: const Value(true),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// Mark user as verified
  Future<bool> markAsVerified(String id) async {
    final updated = await (update(users)..where((u) => u.id.equals(id)))
        .write(UsersCompanion(
      isVerified: const Value(true),
      updatedAt: Value(DateTime.now()),
    ));
    return updated > 0;
  }

  /// Delete user
  Future<int> deleteUser(String id) =>
      (delete(users)..where((u) => u.id.equals(id))).go();

  /// Search users by name or email
  Future<List<User>> searchUsers(String query) {
    final searchPattern = '%\$query%';
    return (select(users)
          ..where((u) =>
              u.displayName.like(searchPattern) |
              u.email.like(searchPattern)))
        .get();
  }

  /// Check if email exists
  Future<bool> emailExists(String email) async {
    final user = await getUserByEmail(email);
    return user != null;
  }
}

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart';

import 'tables/tables.dart';

part 'database_context.g.dart';

/// Database context that combines all table definitions
@DriftDatabase(tables: [
  Users,
  Categories,
  Listings,
  Images,
  Amenities,
  ListingAmenities,
  Bookings,
  Reviews,
  Favorites,
])
class AppDatabase extends _$AppDatabase {
  /// Create database with PostgreSQL connection
  AppDatabase() : super(_openConnection());

  /// Create database with custom executor (for testing)
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Handle future migrations here
        },
      );
}

/// Open PostgreSQL connection
DatabaseConnection _openConnection() {
  final host = Platform.environment['DB_HOST'] ?? 'localhost';
  final port = int.parse(Platform.environment['DB_PORT'] ?? '5432');
  final database = Platform.environment['DB_NAME'] ?? 'shop_demo';
  final username = Platform.environment['DB_USER'] ?? 'shop_user';
  final password = Platform.environment['DB_PASSWORD'] ?? 'shop_password';

  return DatabaseConnection(PgDatabase(
    endpoint: Endpoint(
      host: host,
      port: port,
      database: database,
      username: username,
      password: password,
      isUnixSocket: false,
    ),
  ));
}

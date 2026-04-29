import 'package:drift/drift.dart';

/// Favorites junction table
class Favorites extends Table {
  TextColumn get userId => text().withLength(min: 36, max: 36)();
  TextColumn get listingId => text().withLength(min: 36, max: 36)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {userId, listingId};
}

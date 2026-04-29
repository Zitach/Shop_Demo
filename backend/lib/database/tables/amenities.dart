import 'package:drift/drift.dart';

/// Amenities table definition
class Amenities extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get slug => text().withLength(min: 1, max: 100).unique()();
  TextColumn get iconUrl => text().nullable()();
  TextColumn get category => text().withLength(max: 50).nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Listing amenities junction table
class ListingAmenities extends Table {
  TextColumn get listingId => text().withLength(min: 36, max: 36)();
  TextColumn get amenityId => text().withLength(min: 36, max: 36)();

  @override
  Set<Column> get primaryKey => {listingId, amenityId};
}

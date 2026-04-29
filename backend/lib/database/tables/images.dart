import 'package:drift/drift.dart';

/// Images table definition
class Images extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get listingId => text().withLength(min: 36, max: 36)();
  TextColumn get url => text()();
  TextColumn get altText => text().withLength(max: 255).nullable()();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

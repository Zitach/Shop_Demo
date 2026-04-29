import 'package:drift/drift.dart';

/// Reviews table definition
class Reviews extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get listingId => text().withLength(min: 36, max: 36)();
  TextColumn get authorId => text().withLength(min: 36, max: 36)();
  TextColumn get bookingId => text().withLength(max: 36).nullable()();
  IntColumn get rating => integer()();
  TextColumn get title => text().withLength(max: 200).nullable()();
  TextColumn get comment => text().nullable()();
  TextColumn get response => text().nullable()();
  DateTimeColumn get responseAt => dateTime().nullable()();
  BoolColumn get isVisible => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

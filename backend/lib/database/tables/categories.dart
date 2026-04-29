import 'package:drift/drift.dart';

/// Categories table definition
class Categories extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get slug => text().withLength(min: 1, max: 100).unique()();
  TextColumn get iconUrl => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get parentId => text().withLength(max: 36).nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

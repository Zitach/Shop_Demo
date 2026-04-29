import 'package:drift/drift.dart';

/// Users table definition
class Users extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get email => text().withLength(min: 1, max: 255).unique()();
  TextColumn get passwordHash => text().withLength(min: 1, max: 255)();
  TextColumn get displayName => text().withLength(min: 1, max: 100)();
  TextColumn get avatarUrl => text().nullable()();
  TextColumn get phone => text().withLength(max: 20).nullable()();
  TextColumn get bio => text().nullable()();
  BoolColumn get isHost => boolean().withDefault(const Constant(false))();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column>> get uniqueKeys => [
    {email},
  ];
}

import 'package:drift/drift.dart';

/// Bookings table definition
class Bookings extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get listingId => text().withLength(min: 36, max: 36)();
  TextColumn get guestId => text().withLength(min: 36, max: 36)();
  TextColumn get hostId => text().withLength(min: 36, max: 36)();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get numGuests => integer().withDefault(const Constant(1))();
  RealColumn get totalPrice => real()();
  TextColumn get currency => text().withLength(min: 3, max: 3).withDefault(const Constant('USD'))();
  TextColumn get status => text().withLength(max: 20).withDefault(const Constant('pending'))();
  TextColumn get specialRequests => text().nullable()();
  DateTimeColumn get cancelledAt => dateTime().nullable()();
  TextColumn get cancellationReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

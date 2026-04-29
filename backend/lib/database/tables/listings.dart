import 'package:drift/drift.dart';

/// Listings table definition
class Listings extends Table {
  TextColumn get id => text().withLength(min: 36, max: 36)();
  TextColumn get hostId => text().withLength(min: 36, max: 36)();
  TextColumn get categoryId => text().withLength(min: 36, max: 36)();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get description => text().nullable()();
  RealColumn get pricePerUnit => real()();
  TextColumn get currency => text().withLength(min: 3, max: 3).withDefault(const Constant('USD'))();
  TextColumn get unitType => text().withLength(max: 20).withDefault(const Constant('night'))();
  IntColumn get maxGuests => integer().withDefault(const Constant(1))();
  IntColumn get bedrooms => integer().nullable()();
  IntColumn get bathrooms => integer().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get city => text().withLength(max: 100).nullable()();
  TextColumn get state => text().withLength(max: 100).nullable()();
  TextColumn get country => text().withLength(max: 100).nullable()();
  TextColumn get postalCode => text().withLength(max: 20).nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  BoolColumn get isFeatured => boolean().withDefault(const Constant(false))();
  RealColumn get avgRating => real().withDefault(const Constant(0.0))();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  IntColumn get minNights => integer().withDefault(const Constant(1))();
  IntColumn get maxNights => integer().withDefault(const Constant(365))();
  TextColumn get checkInTime => text().withLength(max: 10).withDefault(const Constant('15:00'))();
  TextColumn get checkOutTime => text().withLength(max: 10).withDefault(const Constant('11:00'))();
  TextColumn get cancellationPolicy => text().withLength(max: 20).withDefault(const Constant('moderate'))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

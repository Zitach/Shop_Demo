// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_dao.dart';

// ignore_for_file: type=lint
mixin _$ListingDaoMixin on DatabaseAccessor<AppDatabase> {
  $ListingsTable get listings => attachedDatabase.listings;
  $ImagesTable get images => attachedDatabase.images;
  $AmenitiesTable get amenities => attachedDatabase.amenities;
  $ListingAmenitiesTable get listingAmenities =>
      attachedDatabase.listingAmenities;
  $FavoritesTable get favorites => attachedDatabase.favorites;
  ListingDaoManager get managers => ListingDaoManager(this);
}

class ListingDaoManager {
  final _$ListingDaoMixin _db;
  ListingDaoManager(this._db);
  $$ListingsTableTableManager get listings =>
      $$ListingsTableTableManager(_db.attachedDatabase, _db.listings);
  $$ImagesTableTableManager get images =>
      $$ImagesTableTableManager(_db.attachedDatabase, _db.images);
  $$AmenitiesTableTableManager get amenities =>
      $$AmenitiesTableTableManager(_db.attachedDatabase, _db.amenities);
  $$ListingAmenitiesTableTableManager get listingAmenities =>
      $$ListingAmenitiesTableTableManager(
        _db.attachedDatabase,
        _db.listingAmenities,
      );
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db.attachedDatabase, _db.favorites);
}

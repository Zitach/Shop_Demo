// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_dao.dart';

// ignore_for_file: type=lint
mixin _$ReviewDaoMixin on DatabaseAccessor<AppDatabase> {
  $ReviewsTable get reviews => attachedDatabase.reviews;
  $ListingsTable get listings => attachedDatabase.listings;
  ReviewDaoManager get managers => ReviewDaoManager(this);
}

class ReviewDaoManager {
  final _$ReviewDaoMixin _db;
  ReviewDaoManager(this._db);
  $$ReviewsTableTableManager get reviews =>
      $$ReviewsTableTableManager(_db.attachedDatabase, _db.reviews);
  $$ListingsTableTableManager get listings =>
      $$ListingsTableTableManager(_db.attachedDatabase, _db.listings);
}

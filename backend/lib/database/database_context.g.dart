// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_context.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bioMeta = const VerificationMeta('bio');
  @override
  late final GeneratedColumn<String> bio = GeneratedColumn<String>(
    'bio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isHostMeta = const VerificationMeta('isHost');
  @override
  late final GeneratedColumn<bool> isHost = GeneratedColumn<bool>(
    'is_host',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_host" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    passwordHash,
    displayName,
    avatarUrl,
    phone,
    bio,
    isHost,
    isVerified,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('bio')) {
      context.handle(
        _bioMeta,
        bio.isAcceptableOrUnknown(data['bio']!, _bioMeta),
      );
    }
    if (data.containsKey('is_host')) {
      context.handle(
        _isHostMeta,
        isHost.isAcceptableOrUnknown(data['is_host']!, _isHostMeta),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {email},
  ];
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      bio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bio'],
      ),
      isHost: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_host'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String email;
  final String passwordHash;
  final String displayName;
  final String? avatarUrl;
  final String? phone;
  final String? bio;
  final bool isHost;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.email,
    required this.passwordHash,
    required this.displayName,
    this.avatarUrl,
    this.phone,
    this.bio,
    required this.isHost,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['password_hash'] = Variable<String>(passwordHash);
    map['display_name'] = Variable<String>(displayName);
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || bio != null) {
      map['bio'] = Variable<String>(bio);
    }
    map['is_host'] = Variable<bool>(isHost);
    map['is_verified'] = Variable<bool>(isVerified);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      passwordHash: Value(passwordHash),
      displayName: Value(displayName),
      avatarUrl: avatarUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarUrl),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      bio: bio == null && nullToAbsent ? const Value.absent() : Value(bio),
      isHost: Value(isHost),
      isVerified: Value(isVerified),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      displayName: serializer.fromJson<String>(json['displayName']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      phone: serializer.fromJson<String?>(json['phone']),
      bio: serializer.fromJson<String?>(json['bio']),
      isHost: serializer.fromJson<bool>(json['isHost']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'displayName': serializer.toJson<String>(displayName),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'phone': serializer.toJson<String?>(phone),
      'bio': serializer.toJson<String?>(bio),
      'isHost': serializer.toJson<bool>(isHost),
      'isVerified': serializer.toJson<bool>(isVerified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? passwordHash,
    String? displayName,
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> bio = const Value.absent(),
    bool? isHost,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    email: email ?? this.email,
    passwordHash: passwordHash ?? this.passwordHash,
    displayName: displayName ?? this.displayName,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    phone: phone.present ? phone.value : this.phone,
    bio: bio.present ? bio.value : this.bio,
    isHost: isHost ?? this.isHost,
    isVerified: isVerified ?? this.isVerified,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      phone: data.phone.present ? data.phone.value : this.phone,
      bio: data.bio.present ? data.bio.value : this.bio,
      isHost: data.isHost.present ? data.isHost.value : this.isHost,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('phone: $phone, ')
          ..write('bio: $bio, ')
          ..write('isHost: $isHost, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    email,
    passwordHash,
    displayName,
    avatarUrl,
    phone,
    bio,
    isHost,
    isVerified,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.displayName == this.displayName &&
          other.avatarUrl == this.avatarUrl &&
          other.phone == this.phone &&
          other.bio == this.bio &&
          other.isHost == this.isHost &&
          other.isVerified == this.isVerified &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> passwordHash;
  final Value<String> displayName;
  final Value<String?> avatarUrl;
  final Value<String?> phone;
  final Value<String?> bio;
  final Value<bool> isHost;
  final Value<bool> isVerified;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.displayName = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.phone = const Value.absent(),
    this.bio = const Value.absent(),
    this.isHost = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String email,
    required String passwordHash,
    required String displayName,
    this.avatarUrl = const Value.absent(),
    this.phone = const Value.absent(),
    this.bio = const Value.absent(),
    this.isHost = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       passwordHash = Value(passwordHash),
       displayName = Value(displayName);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? displayName,
    Expression<String>? avatarUrl,
    Expression<String>? phone,
    Expression<String>? bio,
    Expression<bool>? isHost,
    Expression<bool>? isVerified,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (displayName != null) 'display_name': displayName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (phone != null) 'phone': phone,
      if (bio != null) 'bio': bio,
      if (isHost != null) 'is_host': isHost,
      if (isVerified != null) 'is_verified': isVerified,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String>? passwordHash,
    Value<String>? displayName,
    Value<String?>? avatarUrl,
    Value<String?>? phone,
    Value<String?>? bio,
    Value<bool>? isHost,
    Value<bool>? isVerified,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      isHost: isHost ?? this.isHost,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (bio.present) {
      map['bio'] = Variable<String>(bio.value);
    }
    if (isHost.present) {
      map['is_host'] = Variable<bool>(isHost.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('displayName: $displayName, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('phone: $phone, ')
          ..write('bio: $bio, ')
          ..write('isHost: $isHost, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconUrlMeta = const VerificationMeta(
    'iconUrl',
  );
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
    'icon_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    slug,
    iconUrl,
    description,
    parentId,
    sortOrder,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('icon_url')) {
      context.handle(
        _iconUrlMeta,
        iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      iconUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_url'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String id;
  final String name;
  final String slug;
  final String? iconUrl;
  final String? description;
  final String? parentId;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  const Category({
    required this.id,
    required this.name,
    required this.slug,
    this.iconUrl,
    this.description,
    this.parentId,
    required this.sortOrder,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || iconUrl != null) {
      map['icon_url'] = Variable<String>(iconUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      iconUrl: iconUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(iconUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      iconUrl: serializer.fromJson<String?>(json['iconUrl']),
      description: serializer.fromJson<String?>(json['description']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'iconUrl': serializer.toJson<String?>(iconUrl),
      'description': serializer.toJson<String?>(description),
      'parentId': serializer.toJson<String?>(parentId),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? slug,
    Value<String?> iconUrl = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> parentId = const Value.absent(),
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    iconUrl: iconUrl.present ? iconUrl.value : this.iconUrl,
    description: description.present ? description.value : this.description,
    parentId: parentId.present ? parentId.value : this.parentId,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      description: data.description.present
          ? data.description.value
          : this.description,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    slug,
    iconUrl,
    description,
    parentId,
    sortOrder,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.iconUrl == this.iconUrl &&
          other.description == this.description &&
          other.parentId == this.parentId &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String?> iconUrl;
  final Value<String?> description;
  final Value<String?> parentId;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.parentId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String id,
    required String name,
    required String slug,
    this.iconUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.parentId = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       slug = Value(slug);
  static Insertable<Category> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? iconUrl,
    Expression<String>? description,
    Expression<String>? parentId,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (description != null) 'description': description,
      if (parentId != null) 'parent_id': parentId,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? slug,
    Value<String?>? iconUrl,
    Value<String?>? description,
    Value<String?>? parentId,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      iconUrl: iconUrl ?? this.iconUrl,
      description: description ?? this.description,
      parentId: parentId ?? this.parentId,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('description: $description, ')
          ..write('parentId: $parentId, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ListingsTable extends Listings with TableInfo<$ListingsTable, Listing> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hostIdMeta = const VerificationMeta('hostId');
  @override
  late final GeneratedColumn<String> hostId = GeneratedColumn<String>(
    'host_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pricePerUnitMeta = const VerificationMeta(
    'pricePerUnit',
  );
  @override
  late final GeneratedColumn<double> pricePerUnit = GeneratedColumn<double>(
    'price_per_unit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _unitTypeMeta = const VerificationMeta(
    'unitType',
  );
  @override
  late final GeneratedColumn<String> unitType = GeneratedColumn<String>(
    'unit_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('night'),
  );
  static const VerificationMeta _maxGuestsMeta = const VerificationMeta(
    'maxGuests',
  );
  @override
  late final GeneratedColumn<int> maxGuests = GeneratedColumn<int>(
    'max_guests',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _bedroomsMeta = const VerificationMeta(
    'bedrooms',
  );
  @override
  late final GeneratedColumn<int> bedrooms = GeneratedColumn<int>(
    'bedrooms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bathroomsMeta = const VerificationMeta(
    'bathrooms',
  );
  @override
  late final GeneratedColumn<int> bathrooms = GeneratedColumn<int>(
    'bathrooms',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postalCodeMeta = const VerificationMeta(
    'postalCode',
  );
  @override
  late final GeneratedColumn<String> postalCode = GeneratedColumn<String>(
    'postal_code',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isFeaturedMeta = const VerificationMeta(
    'isFeatured',
  );
  @override
  late final GeneratedColumn<bool> isFeatured = GeneratedColumn<bool>(
    'is_featured',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_featured" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _avgRatingMeta = const VerificationMeta(
    'avgRating',
  );
  @override
  late final GeneratedColumn<double> avgRating = GeneratedColumn<double>(
    'avg_rating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _reviewCountMeta = const VerificationMeta(
    'reviewCount',
  );
  @override
  late final GeneratedColumn<int> reviewCount = GeneratedColumn<int>(
    'review_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _minNightsMeta = const VerificationMeta(
    'minNights',
  );
  @override
  late final GeneratedColumn<int> minNights = GeneratedColumn<int>(
    'min_nights',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _maxNightsMeta = const VerificationMeta(
    'maxNights',
  );
  @override
  late final GeneratedColumn<int> maxNights = GeneratedColumn<int>(
    'max_nights',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(365),
  );
  static const VerificationMeta _checkInTimeMeta = const VerificationMeta(
    'checkInTime',
  );
  @override
  late final GeneratedColumn<String> checkInTime = GeneratedColumn<String>(
    'check_in_time',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('15:00'),
  );
  static const VerificationMeta _checkOutTimeMeta = const VerificationMeta(
    'checkOutTime',
  );
  @override
  late final GeneratedColumn<String> checkOutTime = GeneratedColumn<String>(
    'check_out_time',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('11:00'),
  );
  static const VerificationMeta _cancellationPolicyMeta =
      const VerificationMeta('cancellationPolicy');
  @override
  late final GeneratedColumn<String> cancellationPolicy =
      GeneratedColumn<String>(
        'cancellation_policy',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('moderate'),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    hostId,
    categoryId,
    title,
    description,
    pricePerUnit,
    currency,
    unitType,
    maxGuests,
    bedrooms,
    bathrooms,
    address,
    city,
    state,
    country,
    postalCode,
    latitude,
    longitude,
    isActive,
    isFeatured,
    avgRating,
    reviewCount,
    minNights,
    maxNights,
    checkInTime,
    checkOutTime,
    cancellationPolicy,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Listing> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('host_id')) {
      context.handle(
        _hostIdMeta,
        hostId.isAcceptableOrUnknown(data['host_id']!, _hostIdMeta),
      );
    } else if (isInserting) {
      context.missing(_hostIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('price_per_unit')) {
      context.handle(
        _pricePerUnitMeta,
        pricePerUnit.isAcceptableOrUnknown(
          data['price_per_unit']!,
          _pricePerUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pricePerUnitMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('unit_type')) {
      context.handle(
        _unitTypeMeta,
        unitType.isAcceptableOrUnknown(data['unit_type']!, _unitTypeMeta),
      );
    }
    if (data.containsKey('max_guests')) {
      context.handle(
        _maxGuestsMeta,
        maxGuests.isAcceptableOrUnknown(data['max_guests']!, _maxGuestsMeta),
      );
    }
    if (data.containsKey('bedrooms')) {
      context.handle(
        _bedroomsMeta,
        bedrooms.isAcceptableOrUnknown(data['bedrooms']!, _bedroomsMeta),
      );
    }
    if (data.containsKey('bathrooms')) {
      context.handle(
        _bathroomsMeta,
        bathrooms.isAcceptableOrUnknown(data['bathrooms']!, _bathroomsMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('postal_code')) {
      context.handle(
        _postalCodeMeta,
        postalCode.isAcceptableOrUnknown(data['postal_code']!, _postalCodeMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_featured')) {
      context.handle(
        _isFeaturedMeta,
        isFeatured.isAcceptableOrUnknown(data['is_featured']!, _isFeaturedMeta),
      );
    }
    if (data.containsKey('avg_rating')) {
      context.handle(
        _avgRatingMeta,
        avgRating.isAcceptableOrUnknown(data['avg_rating']!, _avgRatingMeta),
      );
    }
    if (data.containsKey('review_count')) {
      context.handle(
        _reviewCountMeta,
        reviewCount.isAcceptableOrUnknown(
          data['review_count']!,
          _reviewCountMeta,
        ),
      );
    }
    if (data.containsKey('min_nights')) {
      context.handle(
        _minNightsMeta,
        minNights.isAcceptableOrUnknown(data['min_nights']!, _minNightsMeta),
      );
    }
    if (data.containsKey('max_nights')) {
      context.handle(
        _maxNightsMeta,
        maxNights.isAcceptableOrUnknown(data['max_nights']!, _maxNightsMeta),
      );
    }
    if (data.containsKey('check_in_time')) {
      context.handle(
        _checkInTimeMeta,
        checkInTime.isAcceptableOrUnknown(
          data['check_in_time']!,
          _checkInTimeMeta,
        ),
      );
    }
    if (data.containsKey('check_out_time')) {
      context.handle(
        _checkOutTimeMeta,
        checkOutTime.isAcceptableOrUnknown(
          data['check_out_time']!,
          _checkOutTimeMeta,
        ),
      );
    }
    if (data.containsKey('cancellation_policy')) {
      context.handle(
        _cancellationPolicyMeta,
        cancellationPolicy.isAcceptableOrUnknown(
          data['cancellation_policy']!,
          _cancellationPolicyMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Listing map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Listing(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      hostId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}host_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      pricePerUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price_per_unit'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      unitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_type'],
      )!,
      maxGuests: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_guests'],
      )!,
      bedrooms: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bedrooms'],
      ),
      bathrooms: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bathrooms'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      ),
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      postalCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_code'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isFeatured: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_featured'],
      )!,
      avgRating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_rating'],
      )!,
      reviewCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}review_count'],
      )!,
      minNights: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_nights'],
      )!,
      maxNights: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_nights'],
      )!,
      checkInTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_in_time'],
      )!,
      checkOutTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_out_time'],
      )!,
      cancellationPolicy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cancellation_policy'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ListingsTable createAlias(String alias) {
    return $ListingsTable(attachedDatabase, alias);
  }
}

class Listing extends DataClass implements Insertable<Listing> {
  final String id;
  final String hostId;
  final String categoryId;
  final String title;
  final String? description;
  final double pricePerUnit;
  final String currency;
  final String unitType;
  final int maxGuests;
  final int? bedrooms;
  final int? bathrooms;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final bool isActive;
  final bool isFeatured;
  final double avgRating;
  final int reviewCount;
  final int minNights;
  final int maxNights;
  final String checkInTime;
  final String checkOutTime;
  final String cancellationPolicy;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Listing({
    required this.id,
    required this.hostId,
    required this.categoryId,
    required this.title,
    this.description,
    required this.pricePerUnit,
    required this.currency,
    required this.unitType,
    required this.maxGuests,
    this.bedrooms,
    this.bathrooms,
    this.address,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.latitude,
    this.longitude,
    required this.isActive,
    required this.isFeatured,
    required this.avgRating,
    required this.reviewCount,
    required this.minNights,
    required this.maxNights,
    required this.checkInTime,
    required this.checkOutTime,
    required this.cancellationPolicy,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['host_id'] = Variable<String>(hostId);
    map['category_id'] = Variable<String>(categoryId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['price_per_unit'] = Variable<double>(pricePerUnit);
    map['currency'] = Variable<String>(currency);
    map['unit_type'] = Variable<String>(unitType);
    map['max_guests'] = Variable<int>(maxGuests);
    if (!nullToAbsent || bedrooms != null) {
      map['bedrooms'] = Variable<int>(bedrooms);
    }
    if (!nullToAbsent || bathrooms != null) {
      map['bathrooms'] = Variable<int>(bathrooms);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || state != null) {
      map['state'] = Variable<String>(state);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || postalCode != null) {
      map['postal_code'] = Variable<String>(postalCode);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_featured'] = Variable<bool>(isFeatured);
    map['avg_rating'] = Variable<double>(avgRating);
    map['review_count'] = Variable<int>(reviewCount);
    map['min_nights'] = Variable<int>(minNights);
    map['max_nights'] = Variable<int>(maxNights);
    map['check_in_time'] = Variable<String>(checkInTime);
    map['check_out_time'] = Variable<String>(checkOutTime);
    map['cancellation_policy'] = Variable<String>(cancellationPolicy);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ListingsCompanion toCompanion(bool nullToAbsent) {
    return ListingsCompanion(
      id: Value(id),
      hostId: Value(hostId),
      categoryId: Value(categoryId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      pricePerUnit: Value(pricePerUnit),
      currency: Value(currency),
      unitType: Value(unitType),
      maxGuests: Value(maxGuests),
      bedrooms: bedrooms == null && nullToAbsent
          ? const Value.absent()
          : Value(bedrooms),
      bathrooms: bathrooms == null && nullToAbsent
          ? const Value.absent()
          : Value(bathrooms),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      state: state == null && nullToAbsent
          ? const Value.absent()
          : Value(state),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      postalCode: postalCode == null && nullToAbsent
          ? const Value.absent()
          : Value(postalCode),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      isActive: Value(isActive),
      isFeatured: Value(isFeatured),
      avgRating: Value(avgRating),
      reviewCount: Value(reviewCount),
      minNights: Value(minNights),
      maxNights: Value(maxNights),
      checkInTime: Value(checkInTime),
      checkOutTime: Value(checkOutTime),
      cancellationPolicy: Value(cancellationPolicy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Listing.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Listing(
      id: serializer.fromJson<String>(json['id']),
      hostId: serializer.fromJson<String>(json['hostId']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      pricePerUnit: serializer.fromJson<double>(json['pricePerUnit']),
      currency: serializer.fromJson<String>(json['currency']),
      unitType: serializer.fromJson<String>(json['unitType']),
      maxGuests: serializer.fromJson<int>(json['maxGuests']),
      bedrooms: serializer.fromJson<int?>(json['bedrooms']),
      bathrooms: serializer.fromJson<int?>(json['bathrooms']),
      address: serializer.fromJson<String?>(json['address']),
      city: serializer.fromJson<String?>(json['city']),
      state: serializer.fromJson<String?>(json['state']),
      country: serializer.fromJson<String?>(json['country']),
      postalCode: serializer.fromJson<String?>(json['postalCode']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isFeatured: serializer.fromJson<bool>(json['isFeatured']),
      avgRating: serializer.fromJson<double>(json['avgRating']),
      reviewCount: serializer.fromJson<int>(json['reviewCount']),
      minNights: serializer.fromJson<int>(json['minNights']),
      maxNights: serializer.fromJson<int>(json['maxNights']),
      checkInTime: serializer.fromJson<String>(json['checkInTime']),
      checkOutTime: serializer.fromJson<String>(json['checkOutTime']),
      cancellationPolicy: serializer.fromJson<String>(
        json['cancellationPolicy'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'hostId': serializer.toJson<String>(hostId),
      'categoryId': serializer.toJson<String>(categoryId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'pricePerUnit': serializer.toJson<double>(pricePerUnit),
      'currency': serializer.toJson<String>(currency),
      'unitType': serializer.toJson<String>(unitType),
      'maxGuests': serializer.toJson<int>(maxGuests),
      'bedrooms': serializer.toJson<int?>(bedrooms),
      'bathrooms': serializer.toJson<int?>(bathrooms),
      'address': serializer.toJson<String?>(address),
      'city': serializer.toJson<String?>(city),
      'state': serializer.toJson<String?>(state),
      'country': serializer.toJson<String?>(country),
      'postalCode': serializer.toJson<String?>(postalCode),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'isActive': serializer.toJson<bool>(isActive),
      'isFeatured': serializer.toJson<bool>(isFeatured),
      'avgRating': serializer.toJson<double>(avgRating),
      'reviewCount': serializer.toJson<int>(reviewCount),
      'minNights': serializer.toJson<int>(minNights),
      'maxNights': serializer.toJson<int>(maxNights),
      'checkInTime': serializer.toJson<String>(checkInTime),
      'checkOutTime': serializer.toJson<String>(checkOutTime),
      'cancellationPolicy': serializer.toJson<String>(cancellationPolicy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Listing copyWith({
    String? id,
    String? hostId,
    String? categoryId,
    String? title,
    Value<String?> description = const Value.absent(),
    double? pricePerUnit,
    String? currency,
    String? unitType,
    int? maxGuests,
    Value<int?> bedrooms = const Value.absent(),
    Value<int?> bathrooms = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> city = const Value.absent(),
    Value<String?> state = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> postalCode = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    bool? isActive,
    bool? isFeatured,
    double? avgRating,
    int? reviewCount,
    int? minNights,
    int? maxNights,
    String? checkInTime,
    String? checkOutTime,
    String? cancellationPolicy,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Listing(
    id: id ?? this.id,
    hostId: hostId ?? this.hostId,
    categoryId: categoryId ?? this.categoryId,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    pricePerUnit: pricePerUnit ?? this.pricePerUnit,
    currency: currency ?? this.currency,
    unitType: unitType ?? this.unitType,
    maxGuests: maxGuests ?? this.maxGuests,
    bedrooms: bedrooms.present ? bedrooms.value : this.bedrooms,
    bathrooms: bathrooms.present ? bathrooms.value : this.bathrooms,
    address: address.present ? address.value : this.address,
    city: city.present ? city.value : this.city,
    state: state.present ? state.value : this.state,
    country: country.present ? country.value : this.country,
    postalCode: postalCode.present ? postalCode.value : this.postalCode,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    isActive: isActive ?? this.isActive,
    isFeatured: isFeatured ?? this.isFeatured,
    avgRating: avgRating ?? this.avgRating,
    reviewCount: reviewCount ?? this.reviewCount,
    minNights: minNights ?? this.minNights,
    maxNights: maxNights ?? this.maxNights,
    checkInTime: checkInTime ?? this.checkInTime,
    checkOutTime: checkOutTime ?? this.checkOutTime,
    cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Listing copyWithCompanion(ListingsCompanion data) {
    return Listing(
      id: data.id.present ? data.id.value : this.id,
      hostId: data.hostId.present ? data.hostId.value : this.hostId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      pricePerUnit: data.pricePerUnit.present
          ? data.pricePerUnit.value
          : this.pricePerUnit,
      currency: data.currency.present ? data.currency.value : this.currency,
      unitType: data.unitType.present ? data.unitType.value : this.unitType,
      maxGuests: data.maxGuests.present ? data.maxGuests.value : this.maxGuests,
      bedrooms: data.bedrooms.present ? data.bedrooms.value : this.bedrooms,
      bathrooms: data.bathrooms.present ? data.bathrooms.value : this.bathrooms,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      country: data.country.present ? data.country.value : this.country,
      postalCode: data.postalCode.present
          ? data.postalCode.value
          : this.postalCode,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isFeatured: data.isFeatured.present
          ? data.isFeatured.value
          : this.isFeatured,
      avgRating: data.avgRating.present ? data.avgRating.value : this.avgRating,
      reviewCount: data.reviewCount.present
          ? data.reviewCount.value
          : this.reviewCount,
      minNights: data.minNights.present ? data.minNights.value : this.minNights,
      maxNights: data.maxNights.present ? data.maxNights.value : this.maxNights,
      checkInTime: data.checkInTime.present
          ? data.checkInTime.value
          : this.checkInTime,
      checkOutTime: data.checkOutTime.present
          ? data.checkOutTime.value
          : this.checkOutTime,
      cancellationPolicy: data.cancellationPolicy.present
          ? data.cancellationPolicy.value
          : this.cancellationPolicy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Listing(')
          ..write('id: $id, ')
          ..write('hostId: $hostId, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('pricePerUnit: $pricePerUnit, ')
          ..write('currency: $currency, ')
          ..write('unitType: $unitType, ')
          ..write('maxGuests: $maxGuests, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('postalCode: $postalCode, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isActive: $isActive, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('avgRating: $avgRating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('minNights: $minNights, ')
          ..write('maxNights: $maxNights, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('checkOutTime: $checkOutTime, ')
          ..write('cancellationPolicy: $cancellationPolicy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    hostId,
    categoryId,
    title,
    description,
    pricePerUnit,
    currency,
    unitType,
    maxGuests,
    bedrooms,
    bathrooms,
    address,
    city,
    state,
    country,
    postalCode,
    latitude,
    longitude,
    isActive,
    isFeatured,
    avgRating,
    reviewCount,
    minNights,
    maxNights,
    checkInTime,
    checkOutTime,
    cancellationPolicy,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Listing &&
          other.id == this.id &&
          other.hostId == this.hostId &&
          other.categoryId == this.categoryId &&
          other.title == this.title &&
          other.description == this.description &&
          other.pricePerUnit == this.pricePerUnit &&
          other.currency == this.currency &&
          other.unitType == this.unitType &&
          other.maxGuests == this.maxGuests &&
          other.bedrooms == this.bedrooms &&
          other.bathrooms == this.bathrooms &&
          other.address == this.address &&
          other.city == this.city &&
          other.state == this.state &&
          other.country == this.country &&
          other.postalCode == this.postalCode &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.isActive == this.isActive &&
          other.isFeatured == this.isFeatured &&
          other.avgRating == this.avgRating &&
          other.reviewCount == this.reviewCount &&
          other.minNights == this.minNights &&
          other.maxNights == this.maxNights &&
          other.checkInTime == this.checkInTime &&
          other.checkOutTime == this.checkOutTime &&
          other.cancellationPolicy == this.cancellationPolicy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ListingsCompanion extends UpdateCompanion<Listing> {
  final Value<String> id;
  final Value<String> hostId;
  final Value<String> categoryId;
  final Value<String> title;
  final Value<String?> description;
  final Value<double> pricePerUnit;
  final Value<String> currency;
  final Value<String> unitType;
  final Value<int> maxGuests;
  final Value<int?> bedrooms;
  final Value<int?> bathrooms;
  final Value<String?> address;
  final Value<String?> city;
  final Value<String?> state;
  final Value<String?> country;
  final Value<String?> postalCode;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<bool> isActive;
  final Value<bool> isFeatured;
  final Value<double> avgRating;
  final Value<int> reviewCount;
  final Value<int> minNights;
  final Value<int> maxNights;
  final Value<String> checkInTime;
  final Value<String> checkOutTime;
  final Value<String> cancellationPolicy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ListingsCompanion({
    this.id = const Value.absent(),
    this.hostId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.pricePerUnit = const Value.absent(),
    this.currency = const Value.absent(),
    this.unitType = const Value.absent(),
    this.maxGuests = const Value.absent(),
    this.bedrooms = const Value.absent(),
    this.bathrooms = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.avgRating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.minNights = const Value.absent(),
    this.maxNights = const Value.absent(),
    this.checkInTime = const Value.absent(),
    this.checkOutTime = const Value.absent(),
    this.cancellationPolicy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ListingsCompanion.insert({
    required String id,
    required String hostId,
    required String categoryId,
    required String title,
    this.description = const Value.absent(),
    required double pricePerUnit,
    this.currency = const Value.absent(),
    this.unitType = const Value.absent(),
    this.maxGuests = const Value.absent(),
    this.bedrooms = const Value.absent(),
    this.bathrooms = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.postalCode = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isFeatured = const Value.absent(),
    this.avgRating = const Value.absent(),
    this.reviewCount = const Value.absent(),
    this.minNights = const Value.absent(),
    this.maxNights = const Value.absent(),
    this.checkInTime = const Value.absent(),
    this.checkOutTime = const Value.absent(),
    this.cancellationPolicy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       hostId = Value(hostId),
       categoryId = Value(categoryId),
       title = Value(title),
       pricePerUnit = Value(pricePerUnit);
  static Insertable<Listing> custom({
    Expression<String>? id,
    Expression<String>? hostId,
    Expression<String>? categoryId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<double>? pricePerUnit,
    Expression<String>? currency,
    Expression<String>? unitType,
    Expression<int>? maxGuests,
    Expression<int>? bedrooms,
    Expression<int>? bathrooms,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? country,
    Expression<String>? postalCode,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<bool>? isActive,
    Expression<bool>? isFeatured,
    Expression<double>? avgRating,
    Expression<int>? reviewCount,
    Expression<int>? minNights,
    Expression<int>? maxNights,
    Expression<String>? checkInTime,
    Expression<String>? checkOutTime,
    Expression<String>? cancellationPolicy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hostId != null) 'host_id': hostId,
      if (categoryId != null) 'category_id': categoryId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (pricePerUnit != null) 'price_per_unit': pricePerUnit,
      if (currency != null) 'currency': currency,
      if (unitType != null) 'unit_type': unitType,
      if (maxGuests != null) 'max_guests': maxGuests,
      if (bedrooms != null) 'bedrooms': bedrooms,
      if (bathrooms != null) 'bathrooms': bathrooms,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (postalCode != null) 'postal_code': postalCode,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (isActive != null) 'is_active': isActive,
      if (isFeatured != null) 'is_featured': isFeatured,
      if (avgRating != null) 'avg_rating': avgRating,
      if (reviewCount != null) 'review_count': reviewCount,
      if (minNights != null) 'min_nights': minNights,
      if (maxNights != null) 'max_nights': maxNights,
      if (checkInTime != null) 'check_in_time': checkInTime,
      if (checkOutTime != null) 'check_out_time': checkOutTime,
      if (cancellationPolicy != null) 'cancellation_policy': cancellationPolicy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ListingsCompanion copyWith({
    Value<String>? id,
    Value<String>? hostId,
    Value<String>? categoryId,
    Value<String>? title,
    Value<String?>? description,
    Value<double>? pricePerUnit,
    Value<String>? currency,
    Value<String>? unitType,
    Value<int>? maxGuests,
    Value<int?>? bedrooms,
    Value<int?>? bathrooms,
    Value<String?>? address,
    Value<String?>? city,
    Value<String?>? state,
    Value<String?>? country,
    Value<String?>? postalCode,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<bool>? isActive,
    Value<bool>? isFeatured,
    Value<double>? avgRating,
    Value<int>? reviewCount,
    Value<int>? minNights,
    Value<int>? maxNights,
    Value<String>? checkInTime,
    Value<String>? checkOutTime,
    Value<String>? cancellationPolicy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ListingsCompanion(
      id: id ?? this.id,
      hostId: hostId ?? this.hostId,
      categoryId: categoryId ?? this.categoryId,
      title: title ?? this.title,
      description: description ?? this.description,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      currency: currency ?? this.currency,
      unitType: unitType ?? this.unitType,
      maxGuests: maxGuests ?? this.maxGuests,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      avgRating: avgRating ?? this.avgRating,
      reviewCount: reviewCount ?? this.reviewCount,
      minNights: minNights ?? this.minNights,
      maxNights: maxNights ?? this.maxNights,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (hostId.present) {
      map['host_id'] = Variable<String>(hostId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pricePerUnit.present) {
      map['price_per_unit'] = Variable<double>(pricePerUnit.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (unitType.present) {
      map['unit_type'] = Variable<String>(unitType.value);
    }
    if (maxGuests.present) {
      map['max_guests'] = Variable<int>(maxGuests.value);
    }
    if (bedrooms.present) {
      map['bedrooms'] = Variable<int>(bedrooms.value);
    }
    if (bathrooms.present) {
      map['bathrooms'] = Variable<int>(bathrooms.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (postalCode.present) {
      map['postal_code'] = Variable<String>(postalCode.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isFeatured.present) {
      map['is_featured'] = Variable<bool>(isFeatured.value);
    }
    if (avgRating.present) {
      map['avg_rating'] = Variable<double>(avgRating.value);
    }
    if (reviewCount.present) {
      map['review_count'] = Variable<int>(reviewCount.value);
    }
    if (minNights.present) {
      map['min_nights'] = Variable<int>(minNights.value);
    }
    if (maxNights.present) {
      map['max_nights'] = Variable<int>(maxNights.value);
    }
    if (checkInTime.present) {
      map['check_in_time'] = Variable<String>(checkInTime.value);
    }
    if (checkOutTime.present) {
      map['check_out_time'] = Variable<String>(checkOutTime.value);
    }
    if (cancellationPolicy.present) {
      map['cancellation_policy'] = Variable<String>(cancellationPolicy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListingsCompanion(')
          ..write('id: $id, ')
          ..write('hostId: $hostId, ')
          ..write('categoryId: $categoryId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('pricePerUnit: $pricePerUnit, ')
          ..write('currency: $currency, ')
          ..write('unitType: $unitType, ')
          ..write('maxGuests: $maxGuests, ')
          ..write('bedrooms: $bedrooms, ')
          ..write('bathrooms: $bathrooms, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('postalCode: $postalCode, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('isActive: $isActive, ')
          ..write('isFeatured: $isFeatured, ')
          ..write('avgRating: $avgRating, ')
          ..write('reviewCount: $reviewCount, ')
          ..write('minNights: $minNights, ')
          ..write('maxNights: $maxNights, ')
          ..write('checkInTime: $checkInTime, ')
          ..write('checkOutTime: $checkOutTime, ')
          ..write('cancellationPolicy: $cancellationPolicy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImagesTable extends Images with TableInfo<$ImagesTable, Image> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _listingIdMeta = const VerificationMeta(
    'listingId',
  );
  @override
  late final GeneratedColumn<String> listingId = GeneratedColumn<String>(
    'listing_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altTextMeta = const VerificationMeta(
    'altText',
  );
  @override
  late final GeneratedColumn<String> altText = GeneratedColumn<String>(
    'alt_text',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<int> width = GeneratedColumn<int>(
    'width',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<int> height = GeneratedColumn<int>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listingId,
    url,
    altText,
    width,
    height,
    sortOrder,
    isPrimary,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'images';
  @override
  VerificationContext validateIntegrity(
    Insertable<Image> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('listing_id')) {
      context.handle(
        _listingIdMeta,
        listingId.isAcceptableOrUnknown(data['listing_id']!, _listingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listingIdMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('alt_text')) {
      context.handle(
        _altTextMeta,
        altText.isAcceptableOrUnknown(data['alt_text']!, _altTextMeta),
      );
    }
    if (data.containsKey('width')) {
      context.handle(
        _widthMeta,
        width.isAcceptableOrUnknown(data['width']!, _widthMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Image map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Image(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      listingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listing_id'],
      )!,
      url: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url'],
      )!,
      altText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alt_text'],
      ),
      width: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ImagesTable createAlias(String alias) {
    return $ImagesTable(attachedDatabase, alias);
  }
}

class Image extends DataClass implements Insertable<Image> {
  final String id;
  final String listingId;
  final String url;
  final String? altText;
  final int? width;
  final int? height;
  final int sortOrder;
  final bool isPrimary;
  final DateTime createdAt;
  const Image({
    required this.id,
    required this.listingId,
    required this.url,
    this.altText,
    this.width,
    this.height,
    required this.sortOrder,
    required this.isPrimary,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['listing_id'] = Variable<String>(listingId);
    map['url'] = Variable<String>(url);
    if (!nullToAbsent || altText != null) {
      map['alt_text'] = Variable<String>(altText);
    }
    if (!nullToAbsent || width != null) {
      map['width'] = Variable<int>(width);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<int>(height);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_primary'] = Variable<bool>(isPrimary);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ImagesCompanion toCompanion(bool nullToAbsent) {
    return ImagesCompanion(
      id: Value(id),
      listingId: Value(listingId),
      url: Value(url),
      altText: altText == null && nullToAbsent
          ? const Value.absent()
          : Value(altText),
      width: width == null && nullToAbsent
          ? const Value.absent()
          : Value(width),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      sortOrder: Value(sortOrder),
      isPrimary: Value(isPrimary),
      createdAt: Value(createdAt),
    );
  }

  factory Image.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Image(
      id: serializer.fromJson<String>(json['id']),
      listingId: serializer.fromJson<String>(json['listingId']),
      url: serializer.fromJson<String>(json['url']),
      altText: serializer.fromJson<String?>(json['altText']),
      width: serializer.fromJson<int?>(json['width']),
      height: serializer.fromJson<int?>(json['height']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'listingId': serializer.toJson<String>(listingId),
      'url': serializer.toJson<String>(url),
      'altText': serializer.toJson<String?>(altText),
      'width': serializer.toJson<int?>(width),
      'height': serializer.toJson<int?>(height),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Image copyWith({
    String? id,
    String? listingId,
    String? url,
    Value<String?> altText = const Value.absent(),
    Value<int?> width = const Value.absent(),
    Value<int?> height = const Value.absent(),
    int? sortOrder,
    bool? isPrimary,
    DateTime? createdAt,
  }) => Image(
    id: id ?? this.id,
    listingId: listingId ?? this.listingId,
    url: url ?? this.url,
    altText: altText.present ? altText.value : this.altText,
    width: width.present ? width.value : this.width,
    height: height.present ? height.value : this.height,
    sortOrder: sortOrder ?? this.sortOrder,
    isPrimary: isPrimary ?? this.isPrimary,
    createdAt: createdAt ?? this.createdAt,
  );
  Image copyWithCompanion(ImagesCompanion data) {
    return Image(
      id: data.id.present ? data.id.value : this.id,
      listingId: data.listingId.present ? data.listingId.value : this.listingId,
      url: data.url.present ? data.url.value : this.url,
      altText: data.altText.present ? data.altText.value : this.altText,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Image(')
          ..write('id: $id, ')
          ..write('listingId: $listingId, ')
          ..write('url: $url, ')
          ..write('altText: $altText, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    listingId,
    url,
    altText,
    width,
    height,
    sortOrder,
    isPrimary,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Image &&
          other.id == this.id &&
          other.listingId == this.listingId &&
          other.url == this.url &&
          other.altText == this.altText &&
          other.width == this.width &&
          other.height == this.height &&
          other.sortOrder == this.sortOrder &&
          other.isPrimary == this.isPrimary &&
          other.createdAt == this.createdAt);
}

class ImagesCompanion extends UpdateCompanion<Image> {
  final Value<String> id;
  final Value<String> listingId;
  final Value<String> url;
  final Value<String?> altText;
  final Value<int?> width;
  final Value<int?> height;
  final Value<int> sortOrder;
  final Value<bool> isPrimary;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ImagesCompanion({
    this.id = const Value.absent(),
    this.listingId = const Value.absent(),
    this.url = const Value.absent(),
    this.altText = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImagesCompanion.insert({
    required String id,
    required String listingId,
    required String url,
    this.altText = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       listingId = Value(listingId),
       url = Value(url);
  static Insertable<Image> custom({
    Expression<String>? id,
    Expression<String>? listingId,
    Expression<String>? url,
    Expression<String>? altText,
    Expression<int>? width,
    Expression<int>? height,
    Expression<int>? sortOrder,
    Expression<bool>? isPrimary,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listingId != null) 'listing_id': listingId,
      if (url != null) 'url': url,
      if (altText != null) 'alt_text': altText,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImagesCompanion copyWith({
    Value<String>? id,
    Value<String>? listingId,
    Value<String>? url,
    Value<String?>? altText,
    Value<int?>? width,
    Value<int?>? height,
    Value<int>? sortOrder,
    Value<bool>? isPrimary,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ImagesCompanion(
      id: id ?? this.id,
      listingId: listingId ?? this.listingId,
      url: url ?? this.url,
      altText: altText ?? this.altText,
      width: width ?? this.width,
      height: height ?? this.height,
      sortOrder: sortOrder ?? this.sortOrder,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (listingId.present) {
      map['listing_id'] = Variable<String>(listingId.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (altText.present) {
      map['alt_text'] = Variable<String>(altText.value);
    }
    if (width.present) {
      map['width'] = Variable<int>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<int>(height.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImagesCompanion(')
          ..write('id: $id, ')
          ..write('listingId: $listingId, ')
          ..write('url: $url, ')
          ..write('altText: $altText, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AmenitiesTable extends Amenities
    with TableInfo<$AmenitiesTable, Amenity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AmenitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _iconUrlMeta = const VerificationMeta(
    'iconUrl',
  );
  @override
  late final GeneratedColumn<String> iconUrl = GeneratedColumn<String>(
    'icon_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    slug,
    iconUrl,
    category,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'amenities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Amenity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('icon_url')) {
      context.handle(
        _iconUrlMeta,
        iconUrl.isAcceptableOrUnknown(data['icon_url']!, _iconUrlMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Amenity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Amenity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      iconUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_url'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AmenitiesTable createAlias(String alias) {
    return $AmenitiesTable(attachedDatabase, alias);
  }
}

class Amenity extends DataClass implements Insertable<Amenity> {
  final String id;
  final String name;
  final String slug;
  final String? iconUrl;
  final String? category;
  final DateTime createdAt;
  const Amenity({
    required this.id,
    required this.name,
    required this.slug,
    this.iconUrl,
    this.category,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['slug'] = Variable<String>(slug);
    if (!nullToAbsent || iconUrl != null) {
      map['icon_url'] = Variable<String>(iconUrl);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AmenitiesCompanion toCompanion(bool nullToAbsent) {
    return AmenitiesCompanion(
      id: Value(id),
      name: Value(name),
      slug: Value(slug),
      iconUrl: iconUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(iconUrl),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      createdAt: Value(createdAt),
    );
  }

  factory Amenity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Amenity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      slug: serializer.fromJson<String>(json['slug']),
      iconUrl: serializer.fromJson<String?>(json['iconUrl']),
      category: serializer.fromJson<String?>(json['category']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'slug': serializer.toJson<String>(slug),
      'iconUrl': serializer.toJson<String?>(iconUrl),
      'category': serializer.toJson<String?>(category),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Amenity copyWith({
    String? id,
    String? name,
    String? slug,
    Value<String?> iconUrl = const Value.absent(),
    Value<String?> category = const Value.absent(),
    DateTime? createdAt,
  }) => Amenity(
    id: id ?? this.id,
    name: name ?? this.name,
    slug: slug ?? this.slug,
    iconUrl: iconUrl.present ? iconUrl.value : this.iconUrl,
    category: category.present ? category.value : this.category,
    createdAt: createdAt ?? this.createdAt,
  );
  Amenity copyWithCompanion(AmenitiesCompanion data) {
    return Amenity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      slug: data.slug.present ? data.slug.value : this.slug,
      iconUrl: data.iconUrl.present ? data.iconUrl.value : this.iconUrl,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Amenity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, slug, iconUrl, category, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Amenity &&
          other.id == this.id &&
          other.name == this.name &&
          other.slug == this.slug &&
          other.iconUrl == this.iconUrl &&
          other.category == this.category &&
          other.createdAt == this.createdAt);
}

class AmenitiesCompanion extends UpdateCompanion<Amenity> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> slug;
  final Value<String?> iconUrl;
  final Value<String?> category;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AmenitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.slug = const Value.absent(),
    this.iconUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AmenitiesCompanion.insert({
    required String id,
    required String name,
    required String slug,
    this.iconUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       slug = Value(slug);
  static Insertable<Amenity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? slug,
    Expression<String>? iconUrl,
    Expression<String>? category,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (slug != null) 'slug': slug,
      if (iconUrl != null) 'icon_url': iconUrl,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AmenitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? slug,
    Value<String?>? iconUrl,
    Value<String?>? category,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AmenitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      iconUrl: iconUrl ?? this.iconUrl,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (iconUrl.present) {
      map['icon_url'] = Variable<String>(iconUrl.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AmenitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('slug: $slug, ')
          ..write('iconUrl: $iconUrl, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ListingAmenitiesTable extends ListingAmenities
    with TableInfo<$ListingAmenitiesTable, ListingAmenity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ListingAmenitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _listingIdMeta = const VerificationMeta(
    'listingId',
  );
  @override
  late final GeneratedColumn<String> listingId = GeneratedColumn<String>(
    'listing_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amenityIdMeta = const VerificationMeta(
    'amenityId',
  );
  @override
  late final GeneratedColumn<String> amenityId = GeneratedColumn<String>(
    'amenity_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [listingId, amenityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'listing_amenities';
  @override
  VerificationContext validateIntegrity(
    Insertable<ListingAmenity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('listing_id')) {
      context.handle(
        _listingIdMeta,
        listingId.isAcceptableOrUnknown(data['listing_id']!, _listingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listingIdMeta);
    }
    if (data.containsKey('amenity_id')) {
      context.handle(
        _amenityIdMeta,
        amenityId.isAcceptableOrUnknown(data['amenity_id']!, _amenityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_amenityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {listingId, amenityId};
  @override
  ListingAmenity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ListingAmenity(
      listingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listing_id'],
      )!,
      amenityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amenity_id'],
      )!,
    );
  }

  @override
  $ListingAmenitiesTable createAlias(String alias) {
    return $ListingAmenitiesTable(attachedDatabase, alias);
  }
}

class ListingAmenity extends DataClass implements Insertable<ListingAmenity> {
  final String listingId;
  final String amenityId;
  const ListingAmenity({required this.listingId, required this.amenityId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['listing_id'] = Variable<String>(listingId);
    map['amenity_id'] = Variable<String>(amenityId);
    return map;
  }

  ListingAmenitiesCompanion toCompanion(bool nullToAbsent) {
    return ListingAmenitiesCompanion(
      listingId: Value(listingId),
      amenityId: Value(amenityId),
    );
  }

  factory ListingAmenity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ListingAmenity(
      listingId: serializer.fromJson<String>(json['listingId']),
      amenityId: serializer.fromJson<String>(json['amenityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'listingId': serializer.toJson<String>(listingId),
      'amenityId': serializer.toJson<String>(amenityId),
    };
  }

  ListingAmenity copyWith({String? listingId, String? amenityId}) =>
      ListingAmenity(
        listingId: listingId ?? this.listingId,
        amenityId: amenityId ?? this.amenityId,
      );
  ListingAmenity copyWithCompanion(ListingAmenitiesCompanion data) {
    return ListingAmenity(
      listingId: data.listingId.present ? data.listingId.value : this.listingId,
      amenityId: data.amenityId.present ? data.amenityId.value : this.amenityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ListingAmenity(')
          ..write('listingId: $listingId, ')
          ..write('amenityId: $amenityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(listingId, amenityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ListingAmenity &&
          other.listingId == this.listingId &&
          other.amenityId == this.amenityId);
}

class ListingAmenitiesCompanion extends UpdateCompanion<ListingAmenity> {
  final Value<String> listingId;
  final Value<String> amenityId;
  final Value<int> rowid;
  const ListingAmenitiesCompanion({
    this.listingId = const Value.absent(),
    this.amenityId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ListingAmenitiesCompanion.insert({
    required String listingId,
    required String amenityId,
    this.rowid = const Value.absent(),
  }) : listingId = Value(listingId),
       amenityId = Value(amenityId);
  static Insertable<ListingAmenity> custom({
    Expression<String>? listingId,
    Expression<String>? amenityId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (listingId != null) 'listing_id': listingId,
      if (amenityId != null) 'amenity_id': amenityId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ListingAmenitiesCompanion copyWith({
    Value<String>? listingId,
    Value<String>? amenityId,
    Value<int>? rowid,
  }) {
    return ListingAmenitiesCompanion(
      listingId: listingId ?? this.listingId,
      amenityId: amenityId ?? this.amenityId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (listingId.present) {
      map['listing_id'] = Variable<String>(listingId.value);
    }
    if (amenityId.present) {
      map['amenity_id'] = Variable<String>(amenityId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ListingAmenitiesCompanion(')
          ..write('listingId: $listingId, ')
          ..write('amenityId: $amenityId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BookingsTable extends Bookings with TableInfo<$BookingsTable, Booking> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _listingIdMeta = const VerificationMeta(
    'listingId',
  );
  @override
  late final GeneratedColumn<String> listingId = GeneratedColumn<String>(
    'listing_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _guestIdMeta = const VerificationMeta(
    'guestId',
  );
  @override
  late final GeneratedColumn<String> guestId = GeneratedColumn<String>(
    'guest_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hostIdMeta = const VerificationMeta('hostId');
  @override
  late final GeneratedColumn<String> hostId = GeneratedColumn<String>(
    'host_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numGuestsMeta = const VerificationMeta(
    'numGuests',
  );
  @override
  late final GeneratedColumn<int> numGuests = GeneratedColumn<int>(
    'num_guests',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _specialRequestsMeta = const VerificationMeta(
    'specialRequests',
  );
  @override
  late final GeneratedColumn<String> specialRequests = GeneratedColumn<String>(
    'special_requests',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancelledAtMeta = const VerificationMeta(
    'cancelledAt',
  );
  @override
  late final GeneratedColumn<DateTime> cancelledAt = GeneratedColumn<DateTime>(
    'cancelled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancellationReasonMeta =
      const VerificationMeta('cancellationReason');
  @override
  late final GeneratedColumn<String> cancellationReason =
      GeneratedColumn<String>(
        'cancellation_reason',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listingId,
    guestId,
    hostId,
    startDate,
    endDate,
    numGuests,
    totalPrice,
    currency,
    status,
    specialRequests,
    cancelledAt,
    cancellationReason,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Booking> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('listing_id')) {
      context.handle(
        _listingIdMeta,
        listingId.isAcceptableOrUnknown(data['listing_id']!, _listingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listingIdMeta);
    }
    if (data.containsKey('guest_id')) {
      context.handle(
        _guestIdMeta,
        guestId.isAcceptableOrUnknown(data['guest_id']!, _guestIdMeta),
      );
    } else if (isInserting) {
      context.missing(_guestIdMeta);
    }
    if (data.containsKey('host_id')) {
      context.handle(
        _hostIdMeta,
        hostId.isAcceptableOrUnknown(data['host_id']!, _hostIdMeta),
      );
    } else if (isInserting) {
      context.missing(_hostIdMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('num_guests')) {
      context.handle(
        _numGuestsMeta,
        numGuests.isAcceptableOrUnknown(data['num_guests']!, _numGuestsMeta),
      );
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('special_requests')) {
      context.handle(
        _specialRequestsMeta,
        specialRequests.isAcceptableOrUnknown(
          data['special_requests']!,
          _specialRequestsMeta,
        ),
      );
    }
    if (data.containsKey('cancelled_at')) {
      context.handle(
        _cancelledAtMeta,
        cancelledAt.isAcceptableOrUnknown(
          data['cancelled_at']!,
          _cancelledAtMeta,
        ),
      );
    }
    if (data.containsKey('cancellation_reason')) {
      context.handle(
        _cancellationReasonMeta,
        cancellationReason.isAcceptableOrUnknown(
          data['cancellation_reason']!,
          _cancellationReasonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Booking map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Booking(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      listingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listing_id'],
      )!,
      guestId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guest_id'],
      )!,
      hostId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}host_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      numGuests: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}num_guests'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      specialRequests: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}special_requests'],
      ),
      cancelledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cancelled_at'],
      ),
      cancellationReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cancellation_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BookingsTable createAlias(String alias) {
    return $BookingsTable(attachedDatabase, alias);
  }
}

class Booking extends DataClass implements Insertable<Booking> {
  final String id;
  final String listingId;
  final String guestId;
  final String hostId;
  final DateTime startDate;
  final DateTime endDate;
  final int numGuests;
  final double totalPrice;
  final String currency;
  final String status;
  final String? specialRequests;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Booking({
    required this.id,
    required this.listingId,
    required this.guestId,
    required this.hostId,
    required this.startDate,
    required this.endDate,
    required this.numGuests,
    required this.totalPrice,
    required this.currency,
    required this.status,
    this.specialRequests,
    this.cancelledAt,
    this.cancellationReason,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['listing_id'] = Variable<String>(listingId);
    map['guest_id'] = Variable<String>(guestId);
    map['host_id'] = Variable<String>(hostId);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['num_guests'] = Variable<int>(numGuests);
    map['total_price'] = Variable<double>(totalPrice);
    map['currency'] = Variable<String>(currency);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || specialRequests != null) {
      map['special_requests'] = Variable<String>(specialRequests);
    }
    if (!nullToAbsent || cancelledAt != null) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt);
    }
    if (!nullToAbsent || cancellationReason != null) {
      map['cancellation_reason'] = Variable<String>(cancellationReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BookingsCompanion toCompanion(bool nullToAbsent) {
    return BookingsCompanion(
      id: Value(id),
      listingId: Value(listingId),
      guestId: Value(guestId),
      hostId: Value(hostId),
      startDate: Value(startDate),
      endDate: Value(endDate),
      numGuests: Value(numGuests),
      totalPrice: Value(totalPrice),
      currency: Value(currency),
      status: Value(status),
      specialRequests: specialRequests == null && nullToAbsent
          ? const Value.absent()
          : Value(specialRequests),
      cancelledAt: cancelledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(cancelledAt),
      cancellationReason: cancellationReason == null && nullToAbsent
          ? const Value.absent()
          : Value(cancellationReason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Booking.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Booking(
      id: serializer.fromJson<String>(json['id']),
      listingId: serializer.fromJson<String>(json['listingId']),
      guestId: serializer.fromJson<String>(json['guestId']),
      hostId: serializer.fromJson<String>(json['hostId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      numGuests: serializer.fromJson<int>(json['numGuests']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      currency: serializer.fromJson<String>(json['currency']),
      status: serializer.fromJson<String>(json['status']),
      specialRequests: serializer.fromJson<String?>(json['specialRequests']),
      cancelledAt: serializer.fromJson<DateTime?>(json['cancelledAt']),
      cancellationReason: serializer.fromJson<String?>(
        json['cancellationReason'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'listingId': serializer.toJson<String>(listingId),
      'guestId': serializer.toJson<String>(guestId),
      'hostId': serializer.toJson<String>(hostId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'numGuests': serializer.toJson<int>(numGuests),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'currency': serializer.toJson<String>(currency),
      'status': serializer.toJson<String>(status),
      'specialRequests': serializer.toJson<String?>(specialRequests),
      'cancelledAt': serializer.toJson<DateTime?>(cancelledAt),
      'cancellationReason': serializer.toJson<String?>(cancellationReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Booking copyWith({
    String? id,
    String? listingId,
    String? guestId,
    String? hostId,
    DateTime? startDate,
    DateTime? endDate,
    int? numGuests,
    double? totalPrice,
    String? currency,
    String? status,
    Value<String?> specialRequests = const Value.absent(),
    Value<DateTime?> cancelledAt = const Value.absent(),
    Value<String?> cancellationReason = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Booking(
    id: id ?? this.id,
    listingId: listingId ?? this.listingId,
    guestId: guestId ?? this.guestId,
    hostId: hostId ?? this.hostId,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    numGuests: numGuests ?? this.numGuests,
    totalPrice: totalPrice ?? this.totalPrice,
    currency: currency ?? this.currency,
    status: status ?? this.status,
    specialRequests: specialRequests.present
        ? specialRequests.value
        : this.specialRequests,
    cancelledAt: cancelledAt.present ? cancelledAt.value : this.cancelledAt,
    cancellationReason: cancellationReason.present
        ? cancellationReason.value
        : this.cancellationReason,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Booking copyWithCompanion(BookingsCompanion data) {
    return Booking(
      id: data.id.present ? data.id.value : this.id,
      listingId: data.listingId.present ? data.listingId.value : this.listingId,
      guestId: data.guestId.present ? data.guestId.value : this.guestId,
      hostId: data.hostId.present ? data.hostId.value : this.hostId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      numGuests: data.numGuests.present ? data.numGuests.value : this.numGuests,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      currency: data.currency.present ? data.currency.value : this.currency,
      status: data.status.present ? data.status.value : this.status,
      specialRequests: data.specialRequests.present
          ? data.specialRequests.value
          : this.specialRequests,
      cancelledAt: data.cancelledAt.present
          ? data.cancelledAt.value
          : this.cancelledAt,
      cancellationReason: data.cancellationReason.present
          ? data.cancellationReason.value
          : this.cancellationReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Booking(')
          ..write('id: $id, ')
          ..write('listingId: $listingId, ')
          ..write('guestId: $guestId, ')
          ..write('hostId: $hostId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('numGuests: $numGuests, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('currency: $currency, ')
          ..write('status: $status, ')
          ..write('specialRequests: $specialRequests, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('cancellationReason: $cancellationReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    listingId,
    guestId,
    hostId,
    startDate,
    endDate,
    numGuests,
    totalPrice,
    currency,
    status,
    specialRequests,
    cancelledAt,
    cancellationReason,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Booking &&
          other.id == this.id &&
          other.listingId == this.listingId &&
          other.guestId == this.guestId &&
          other.hostId == this.hostId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.numGuests == this.numGuests &&
          other.totalPrice == this.totalPrice &&
          other.currency == this.currency &&
          other.status == this.status &&
          other.specialRequests == this.specialRequests &&
          other.cancelledAt == this.cancelledAt &&
          other.cancellationReason == this.cancellationReason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BookingsCompanion extends UpdateCompanion<Booking> {
  final Value<String> id;
  final Value<String> listingId;
  final Value<String> guestId;
  final Value<String> hostId;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<int> numGuests;
  final Value<double> totalPrice;
  final Value<String> currency;
  final Value<String> status;
  final Value<String?> specialRequests;
  final Value<DateTime?> cancelledAt;
  final Value<String?> cancellationReason;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BookingsCompanion({
    this.id = const Value.absent(),
    this.listingId = const Value.absent(),
    this.guestId = const Value.absent(),
    this.hostId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.numGuests = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.currency = const Value.absent(),
    this.status = const Value.absent(),
    this.specialRequests = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    this.cancellationReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BookingsCompanion.insert({
    required String id,
    required String listingId,
    required String guestId,
    required String hostId,
    required DateTime startDate,
    required DateTime endDate,
    this.numGuests = const Value.absent(),
    required double totalPrice,
    this.currency = const Value.absent(),
    this.status = const Value.absent(),
    this.specialRequests = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    this.cancellationReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       listingId = Value(listingId),
       guestId = Value(guestId),
       hostId = Value(hostId),
       startDate = Value(startDate),
       endDate = Value(endDate),
       totalPrice = Value(totalPrice);
  static Insertable<Booking> custom({
    Expression<String>? id,
    Expression<String>? listingId,
    Expression<String>? guestId,
    Expression<String>? hostId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? numGuests,
    Expression<double>? totalPrice,
    Expression<String>? currency,
    Expression<String>? status,
    Expression<String>? specialRequests,
    Expression<DateTime>? cancelledAt,
    Expression<String>? cancellationReason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listingId != null) 'listing_id': listingId,
      if (guestId != null) 'guest_id': guestId,
      if (hostId != null) 'host_id': hostId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (numGuests != null) 'num_guests': numGuests,
      if (totalPrice != null) 'total_price': totalPrice,
      if (currency != null) 'currency': currency,
      if (status != null) 'status': status,
      if (specialRequests != null) 'special_requests': specialRequests,
      if (cancelledAt != null) 'cancelled_at': cancelledAt,
      if (cancellationReason != null) 'cancellation_reason': cancellationReason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BookingsCompanion copyWith({
    Value<String>? id,
    Value<String>? listingId,
    Value<String>? guestId,
    Value<String>? hostId,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<int>? numGuests,
    Value<double>? totalPrice,
    Value<String>? currency,
    Value<String>? status,
    Value<String?>? specialRequests,
    Value<DateTime?>? cancelledAt,
    Value<String?>? cancellationReason,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BookingsCompanion(
      id: id ?? this.id,
      listingId: listingId ?? this.listingId,
      guestId: guestId ?? this.guestId,
      hostId: hostId ?? this.hostId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      numGuests: numGuests ?? this.numGuests,
      totalPrice: totalPrice ?? this.totalPrice,
      currency: currency ?? this.currency,
      status: status ?? this.status,
      specialRequests: specialRequests ?? this.specialRequests,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (listingId.present) {
      map['listing_id'] = Variable<String>(listingId.value);
    }
    if (guestId.present) {
      map['guest_id'] = Variable<String>(guestId.value);
    }
    if (hostId.present) {
      map['host_id'] = Variable<String>(hostId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (numGuests.present) {
      map['num_guests'] = Variable<int>(numGuests.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (specialRequests.present) {
      map['special_requests'] = Variable<String>(specialRequests.value);
    }
    if (cancelledAt.present) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt.value);
    }
    if (cancellationReason.present) {
      map['cancellation_reason'] = Variable<String>(cancellationReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookingsCompanion(')
          ..write('id: $id, ')
          ..write('listingId: $listingId, ')
          ..write('guestId: $guestId, ')
          ..write('hostId: $hostId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('numGuests: $numGuests, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('currency: $currency, ')
          ..write('status: $status, ')
          ..write('specialRequests: $specialRequests, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('cancellationReason: $cancellationReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewsTable extends Reviews with TableInfo<$ReviewsTable, Review> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _listingIdMeta = const VerificationMeta(
    'listingId',
  );
  @override
  late final GeneratedColumn<String> listingId = GeneratedColumn<String>(
    'listing_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorIdMeta = const VerificationMeta(
    'authorId',
  );
  @override
  late final GeneratedColumn<String> authorId = GeneratedColumn<String>(
    'author_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bookingIdMeta = const VerificationMeta(
    'bookingId',
  );
  @override
  late final GeneratedColumn<String> bookingId = GeneratedColumn<String>(
    'booking_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responseMeta = const VerificationMeta(
    'response',
  );
  @override
  late final GeneratedColumn<String> response = GeneratedColumn<String>(
    'response',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responseAtMeta = const VerificationMeta(
    'responseAt',
  );
  @override
  late final GeneratedColumn<DateTime> responseAt = GeneratedColumn<DateTime>(
    'response_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVisibleMeta = const VerificationMeta(
    'isVisible',
  );
  @override
  late final GeneratedColumn<bool> isVisible = GeneratedColumn<bool>(
    'is_visible',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_visible" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    listingId,
    authorId,
    bookingId,
    rating,
    title,
    comment,
    response,
    responseAt,
    isVisible,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<Review> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('listing_id')) {
      context.handle(
        _listingIdMeta,
        listingId.isAcceptableOrUnknown(data['listing_id']!, _listingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listingIdMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_authorIdMeta);
    }
    if (data.containsKey('booking_id')) {
      context.handle(
        _bookingIdMeta,
        bookingId.isAcceptableOrUnknown(data['booking_id']!, _bookingIdMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('response')) {
      context.handle(
        _responseMeta,
        response.isAcceptableOrUnknown(data['response']!, _responseMeta),
      );
    }
    if (data.containsKey('response_at')) {
      context.handle(
        _responseAtMeta,
        responseAt.isAcceptableOrUnknown(data['response_at']!, _responseAtMeta),
      );
    }
    if (data.containsKey('is_visible')) {
      context.handle(
        _isVisibleMeta,
        isVisible.isAcceptableOrUnknown(data['is_visible']!, _isVisibleMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Review map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Review(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      listingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listing_id'],
      )!,
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      )!,
      bookingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}booking_id'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      ),
      response: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response'],
      ),
      responseAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}response_at'],
      ),
      isVisible: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_visible'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReviewsTable createAlias(String alias) {
    return $ReviewsTable(attachedDatabase, alias);
  }
}

class Review extends DataClass implements Insertable<Review> {
  final String id;
  final String listingId;
  final String authorId;
  final String? bookingId;
  final int rating;
  final String? title;
  final String? comment;
  final String? response;
  final DateTime? responseAt;
  final bool isVisible;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Review({
    required this.id,
    required this.listingId,
    required this.authorId,
    this.bookingId,
    required this.rating,
    this.title,
    this.comment,
    this.response,
    this.responseAt,
    required this.isVisible,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['listing_id'] = Variable<String>(listingId);
    map['author_id'] = Variable<String>(authorId);
    if (!nullToAbsent || bookingId != null) {
      map['booking_id'] = Variable<String>(bookingId);
    }
    map['rating'] = Variable<int>(rating);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || comment != null) {
      map['comment'] = Variable<String>(comment);
    }
    if (!nullToAbsent || response != null) {
      map['response'] = Variable<String>(response);
    }
    if (!nullToAbsent || responseAt != null) {
      map['response_at'] = Variable<DateTime>(responseAt);
    }
    map['is_visible'] = Variable<bool>(isVisible);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReviewsCompanion toCompanion(bool nullToAbsent) {
    return ReviewsCompanion(
      id: Value(id),
      listingId: Value(listingId),
      authorId: Value(authorId),
      bookingId: bookingId == null && nullToAbsent
          ? const Value.absent()
          : Value(bookingId),
      rating: Value(rating),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      comment: comment == null && nullToAbsent
          ? const Value.absent()
          : Value(comment),
      response: response == null && nullToAbsent
          ? const Value.absent()
          : Value(response),
      responseAt: responseAt == null && nullToAbsent
          ? const Value.absent()
          : Value(responseAt),
      isVisible: Value(isVisible),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Review.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Review(
      id: serializer.fromJson<String>(json['id']),
      listingId: serializer.fromJson<String>(json['listingId']),
      authorId: serializer.fromJson<String>(json['authorId']),
      bookingId: serializer.fromJson<String?>(json['bookingId']),
      rating: serializer.fromJson<int>(json['rating']),
      title: serializer.fromJson<String?>(json['title']),
      comment: serializer.fromJson<String?>(json['comment']),
      response: serializer.fromJson<String?>(json['response']),
      responseAt: serializer.fromJson<DateTime?>(json['responseAt']),
      isVisible: serializer.fromJson<bool>(json['isVisible']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'listingId': serializer.toJson<String>(listingId),
      'authorId': serializer.toJson<String>(authorId),
      'bookingId': serializer.toJson<String?>(bookingId),
      'rating': serializer.toJson<int>(rating),
      'title': serializer.toJson<String?>(title),
      'comment': serializer.toJson<String?>(comment),
      'response': serializer.toJson<String?>(response),
      'responseAt': serializer.toJson<DateTime?>(responseAt),
      'isVisible': serializer.toJson<bool>(isVisible),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Review copyWith({
    String? id,
    String? listingId,
    String? authorId,
    Value<String?> bookingId = const Value.absent(),
    int? rating,
    Value<String?> title = const Value.absent(),
    Value<String?> comment = const Value.absent(),
    Value<String?> response = const Value.absent(),
    Value<DateTime?> responseAt = const Value.absent(),
    bool? isVisible,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Review(
    id: id ?? this.id,
    listingId: listingId ?? this.listingId,
    authorId: authorId ?? this.authorId,
    bookingId: bookingId.present ? bookingId.value : this.bookingId,
    rating: rating ?? this.rating,
    title: title.present ? title.value : this.title,
    comment: comment.present ? comment.value : this.comment,
    response: response.present ? response.value : this.response,
    responseAt: responseAt.present ? responseAt.value : this.responseAt,
    isVisible: isVisible ?? this.isVisible,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Review copyWithCompanion(ReviewsCompanion data) {
    return Review(
      id: data.id.present ? data.id.value : this.id,
      listingId: data.listingId.present ? data.listingId.value : this.listingId,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      bookingId: data.bookingId.present ? data.bookingId.value : this.bookingId,
      rating: data.rating.present ? data.rating.value : this.rating,
      title: data.title.present ? data.title.value : this.title,
      comment: data.comment.present ? data.comment.value : this.comment,
      response: data.response.present ? data.response.value : this.response,
      responseAt: data.responseAt.present
          ? data.responseAt.value
          : this.responseAt,
      isVisible: data.isVisible.present ? data.isVisible.value : this.isVisible,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Review(')
          ..write('id: $id, ')
          ..write('listingId: $listingId, ')
          ..write('authorId: $authorId, ')
          ..write('bookingId: $bookingId, ')
          ..write('rating: $rating, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('response: $response, ')
          ..write('responseAt: $responseAt, ')
          ..write('isVisible: $isVisible, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    listingId,
    authorId,
    bookingId,
    rating,
    title,
    comment,
    response,
    responseAt,
    isVisible,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Review &&
          other.id == this.id &&
          other.listingId == this.listingId &&
          other.authorId == this.authorId &&
          other.bookingId == this.bookingId &&
          other.rating == this.rating &&
          other.title == this.title &&
          other.comment == this.comment &&
          other.response == this.response &&
          other.responseAt == this.responseAt &&
          other.isVisible == this.isVisible &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReviewsCompanion extends UpdateCompanion<Review> {
  final Value<String> id;
  final Value<String> listingId;
  final Value<String> authorId;
  final Value<String?> bookingId;
  final Value<int> rating;
  final Value<String?> title;
  final Value<String?> comment;
  final Value<String?> response;
  final Value<DateTime?> responseAt;
  final Value<bool> isVisible;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ReviewsCompanion({
    this.id = const Value.absent(),
    this.listingId = const Value.absent(),
    this.authorId = const Value.absent(),
    this.bookingId = const Value.absent(),
    this.rating = const Value.absent(),
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    this.response = const Value.absent(),
    this.responseAt = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewsCompanion.insert({
    required String id,
    required String listingId,
    required String authorId,
    this.bookingId = const Value.absent(),
    required int rating,
    this.title = const Value.absent(),
    this.comment = const Value.absent(),
    this.response = const Value.absent(),
    this.responseAt = const Value.absent(),
    this.isVisible = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       listingId = Value(listingId),
       authorId = Value(authorId),
       rating = Value(rating);
  static Insertable<Review> custom({
    Expression<String>? id,
    Expression<String>? listingId,
    Expression<String>? authorId,
    Expression<String>? bookingId,
    Expression<int>? rating,
    Expression<String>? title,
    Expression<String>? comment,
    Expression<String>? response,
    Expression<DateTime>? responseAt,
    Expression<bool>? isVisible,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (listingId != null) 'listing_id': listingId,
      if (authorId != null) 'author_id': authorId,
      if (bookingId != null) 'booking_id': bookingId,
      if (rating != null) 'rating': rating,
      if (title != null) 'title': title,
      if (comment != null) 'comment': comment,
      if (response != null) 'response': response,
      if (responseAt != null) 'response_at': responseAt,
      if (isVisible != null) 'is_visible': isVisible,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewsCompanion copyWith({
    Value<String>? id,
    Value<String>? listingId,
    Value<String>? authorId,
    Value<String?>? bookingId,
    Value<int>? rating,
    Value<String?>? title,
    Value<String?>? comment,
    Value<String?>? response,
    Value<DateTime?>? responseAt,
    Value<bool>? isVisible,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ReviewsCompanion(
      id: id ?? this.id,
      listingId: listingId ?? this.listingId,
      authorId: authorId ?? this.authorId,
      bookingId: bookingId ?? this.bookingId,
      rating: rating ?? this.rating,
      title: title ?? this.title,
      comment: comment ?? this.comment,
      response: response ?? this.response,
      responseAt: responseAt ?? this.responseAt,
      isVisible: isVisible ?? this.isVisible,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (listingId.present) {
      map['listing_id'] = Variable<String>(listingId.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (bookingId.present) {
      map['booking_id'] = Variable<String>(bookingId.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (response.present) {
      map['response'] = Variable<String>(response.value);
    }
    if (responseAt.present) {
      map['response_at'] = Variable<DateTime>(responseAt.value);
    }
    if (isVisible.present) {
      map['is_visible'] = Variable<bool>(isVisible.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewsCompanion(')
          ..write('id: $id, ')
          ..write('listingId: $listingId, ')
          ..write('authorId: $authorId, ')
          ..write('bookingId: $bookingId, ')
          ..write('rating: $rating, ')
          ..write('title: $title, ')
          ..write('comment: $comment, ')
          ..write('response: $response, ')
          ..write('responseAt: $responseAt, ')
          ..write('isVisible: $isVisible, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _listingIdMeta = const VerificationMeta(
    'listingId',
  );
  @override
  late final GeneratedColumn<String> listingId = GeneratedColumn<String>(
    'listing_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [userId, listingId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('listing_id')) {
      context.handle(
        _listingIdMeta,
        listingId.isAcceptableOrUnknown(data['listing_id']!, _listingIdMeta),
      );
    } else if (isInserting) {
      context.missing(_listingIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, listingId};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      listingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}listing_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final String userId;
  final String listingId;
  final DateTime createdAt;
  const Favorite({
    required this.userId,
    required this.listingId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['listing_id'] = Variable<String>(listingId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      userId: Value(userId),
      listingId: Value(listingId),
      createdAt: Value(createdAt),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      userId: serializer.fromJson<String>(json['userId']),
      listingId: serializer.fromJson<String>(json['listingId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'listingId': serializer.toJson<String>(listingId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Favorite copyWith({String? userId, String? listingId, DateTime? createdAt}) =>
      Favorite(
        userId: userId ?? this.userId,
        listingId: listingId ?? this.listingId,
        createdAt: createdAt ?? this.createdAt,
      );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      userId: data.userId.present ? data.userId.value : this.userId,
      listingId: data.listingId.present ? data.listingId.value : this.listingId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('userId: $userId, ')
          ..write('listingId: $listingId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, listingId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.userId == this.userId &&
          other.listingId == this.listingId &&
          other.createdAt == this.createdAt);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<String> userId;
  final Value<String> listingId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FavoritesCompanion({
    this.userId = const Value.absent(),
    this.listingId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritesCompanion.insert({
    required String userId,
    required String listingId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       listingId = Value(listingId);
  static Insertable<Favorite> custom({
    Expression<String>? userId,
    Expression<String>? listingId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (listingId != null) 'listing_id': listingId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritesCompanion copyWith({
    Value<String>? userId,
    Value<String>? listingId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return FavoritesCompanion(
      userId: userId ?? this.userId,
      listingId: listingId ?? this.listingId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (listingId.present) {
      map['listing_id'] = Variable<String>(listingId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('userId: $userId, ')
          ..write('listingId: $listingId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $ListingsTable listings = $ListingsTable(this);
  late final $ImagesTable images = $ImagesTable(this);
  late final $AmenitiesTable amenities = $AmenitiesTable(this);
  late final $ListingAmenitiesTable listingAmenities = $ListingAmenitiesTable(
    this,
  );
  late final $BookingsTable bookings = $BookingsTable(this);
  late final $ReviewsTable reviews = $ReviewsTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    categories,
    listings,
    images,
    amenities,
    listingAmenities,
    bookings,
    reviews,
    favorites,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String email,
      required String passwordHash,
      required String displayName,
      Value<String?> avatarUrl,
      Value<String?> phone,
      Value<String?> bio,
      Value<bool> isHost,
      Value<bool> isVerified,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> email,
      Value<String> passwordHash,
      Value<String> displayName,
      Value<String?> avatarUrl,
      Value<String?> phone,
      Value<String?> bio,
      Value<bool> isHost,
      Value<bool> isVerified,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHost => $composableBuilder(
    column: $table.isHost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bio => $composableBuilder(
    column: $table.bio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHost => $composableBuilder(
    column: $table.isHost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get avatarUrl =>
      $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get bio =>
      $composableBuilder(column: $table.bio, builder: (column) => column);

  GeneratedColumn<bool> get isHost =>
      $composableBuilder(column: $table.isHost, builder: (column) => column);

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<bool> isHost = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                email: email,
                passwordHash: passwordHash,
                displayName: displayName,
                avatarUrl: avatarUrl,
                phone: phone,
                bio: bio,
                isHost: isHost,
                isVerified: isVerified,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                required String passwordHash,
                required String displayName,
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> bio = const Value.absent(),
                Value<bool> isHost = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                email: email,
                passwordHash: passwordHash,
                displayName: displayName,
                avatarUrl: avatarUrl,
                phone: phone,
                bio: bio,
                isHost: isHost,
                isVerified: isVerified,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({
      required String id,
      required String name,
      required String slug,
      Value<String?> iconUrl,
      Value<String?> description,
      Value<String?> parentId,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> slug,
      Value<String?> iconUrl,
      Value<String?> description,
      Value<String?> parentId,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                slug: slug,
                iconUrl: iconUrl,
                description: description,
                parentId: parentId,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String slug,
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                slug: slug,
                iconUrl: iconUrl,
                description: description,
                parentId: parentId,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$AppDatabase, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;
typedef $$ListingsTableCreateCompanionBuilder =
    ListingsCompanion Function({
      required String id,
      required String hostId,
      required String categoryId,
      required String title,
      Value<String?> description,
      required double pricePerUnit,
      Value<String> currency,
      Value<String> unitType,
      Value<int> maxGuests,
      Value<int?> bedrooms,
      Value<int?> bathrooms,
      Value<String?> address,
      Value<String?> city,
      Value<String?> state,
      Value<String?> country,
      Value<String?> postalCode,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isActive,
      Value<bool> isFeatured,
      Value<double> avgRating,
      Value<int> reviewCount,
      Value<int> minNights,
      Value<int> maxNights,
      Value<String> checkInTime,
      Value<String> checkOutTime,
      Value<String> cancellationPolicy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ListingsTableUpdateCompanionBuilder =
    ListingsCompanion Function({
      Value<String> id,
      Value<String> hostId,
      Value<String> categoryId,
      Value<String> title,
      Value<String?> description,
      Value<double> pricePerUnit,
      Value<String> currency,
      Value<String> unitType,
      Value<int> maxGuests,
      Value<int?> bedrooms,
      Value<int?> bathrooms,
      Value<String?> address,
      Value<String?> city,
      Value<String?> state,
      Value<String?> country,
      Value<String?> postalCode,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<bool> isActive,
      Value<bool> isFeatured,
      Value<double> avgRating,
      Value<int> reviewCount,
      Value<int> minNights,
      Value<int> maxNights,
      Value<String> checkInTime,
      Value<String> checkOutTime,
      Value<String> cancellationPolicy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ListingsTableFilterComposer
    extends Composer<_$AppDatabase, $ListingsTable> {
  $$ListingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hostId => $composableBuilder(
    column: $table.hostId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pricePerUnit => $composableBuilder(
    column: $table.pricePerUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitType => $composableBuilder(
    column: $table.unitType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxGuests => $composableBuilder(
    column: $table.maxGuests,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bedrooms => $composableBuilder(
    column: $table.bedrooms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bathrooms => $composableBuilder(
    column: $table.bathrooms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgRating => $composableBuilder(
    column: $table.avgRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minNights => $composableBuilder(
    column: $table.minNights,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxNights => $composableBuilder(
    column: $table.maxNights,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkOutTime => $composableBuilder(
    column: $table.checkOutTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cancellationPolicy => $composableBuilder(
    column: $table.cancellationPolicy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ListingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ListingsTable> {
  $$ListingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hostId => $composableBuilder(
    column: $table.hostId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pricePerUnit => $composableBuilder(
    column: $table.pricePerUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitType => $composableBuilder(
    column: $table.unitType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxGuests => $composableBuilder(
    column: $table.maxGuests,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bedrooms => $composableBuilder(
    column: $table.bedrooms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bathrooms => $composableBuilder(
    column: $table.bathrooms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgRating => $composableBuilder(
    column: $table.avgRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minNights => $composableBuilder(
    column: $table.minNights,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxNights => $composableBuilder(
    column: $table.maxNights,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkOutTime => $composableBuilder(
    column: $table.checkOutTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cancellationPolicy => $composableBuilder(
    column: $table.cancellationPolicy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ListingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListingsTable> {
  $$ListingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hostId =>
      $composableBuilder(column: $table.hostId, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pricePerUnit => $composableBuilder(
    column: $table.pricePerUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get unitType =>
      $composableBuilder(column: $table.unitType, builder: (column) => column);

  GeneratedColumn<int> get maxGuests =>
      $composableBuilder(column: $table.maxGuests, builder: (column) => column);

  GeneratedColumn<int> get bedrooms =>
      $composableBuilder(column: $table.bedrooms, builder: (column) => column);

  GeneratedColumn<int> get bathrooms =>
      $composableBuilder(column: $table.bathrooms, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get postalCode => $composableBuilder(
    column: $table.postalCode,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isFeatured => $composableBuilder(
    column: $table.isFeatured,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgRating =>
      $composableBuilder(column: $table.avgRating, builder: (column) => column);

  GeneratedColumn<int> get reviewCount => $composableBuilder(
    column: $table.reviewCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minNights =>
      $composableBuilder(column: $table.minNights, builder: (column) => column);

  GeneratedColumn<int> get maxNights =>
      $composableBuilder(column: $table.maxNights, builder: (column) => column);

  GeneratedColumn<String> get checkInTime => $composableBuilder(
    column: $table.checkInTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checkOutTime => $composableBuilder(
    column: $table.checkOutTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cancellationPolicy => $composableBuilder(
    column: $table.cancellationPolicy,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ListingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ListingsTable,
          Listing,
          $$ListingsTableFilterComposer,
          $$ListingsTableOrderingComposer,
          $$ListingsTableAnnotationComposer,
          $$ListingsTableCreateCompanionBuilder,
          $$ListingsTableUpdateCompanionBuilder,
          (Listing, BaseReferences<_$AppDatabase, $ListingsTable, Listing>),
          Listing,
          PrefetchHooks Function()
        > {
  $$ListingsTableTableManager(_$AppDatabase db, $ListingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> hostId = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<double> pricePerUnit = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> unitType = const Value.absent(),
                Value<int> maxGuests = const Value.absent(),
                Value<int?> bedrooms = const Value.absent(),
                Value<int?> bathrooms = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<double> avgRating = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> minNights = const Value.absent(),
                Value<int> maxNights = const Value.absent(),
                Value<String> checkInTime = const Value.absent(),
                Value<String> checkOutTime = const Value.absent(),
                Value<String> cancellationPolicy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ListingsCompanion(
                id: id,
                hostId: hostId,
                categoryId: categoryId,
                title: title,
                description: description,
                pricePerUnit: pricePerUnit,
                currency: currency,
                unitType: unitType,
                maxGuests: maxGuests,
                bedrooms: bedrooms,
                bathrooms: bathrooms,
                address: address,
                city: city,
                state: state,
                country: country,
                postalCode: postalCode,
                latitude: latitude,
                longitude: longitude,
                isActive: isActive,
                isFeatured: isFeatured,
                avgRating: avgRating,
                reviewCount: reviewCount,
                minNights: minNights,
                maxNights: maxNights,
                checkInTime: checkInTime,
                checkOutTime: checkOutTime,
                cancellationPolicy: cancellationPolicy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String hostId,
                required String categoryId,
                required String title,
                Value<String?> description = const Value.absent(),
                required double pricePerUnit,
                Value<String> currency = const Value.absent(),
                Value<String> unitType = const Value.absent(),
                Value<int> maxGuests = const Value.absent(),
                Value<int?> bedrooms = const Value.absent(),
                Value<int?> bathrooms = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> city = const Value.absent(),
                Value<String?> state = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> postalCode = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isFeatured = const Value.absent(),
                Value<double> avgRating = const Value.absent(),
                Value<int> reviewCount = const Value.absent(),
                Value<int> minNights = const Value.absent(),
                Value<int> maxNights = const Value.absent(),
                Value<String> checkInTime = const Value.absent(),
                Value<String> checkOutTime = const Value.absent(),
                Value<String> cancellationPolicy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ListingsCompanion.insert(
                id: id,
                hostId: hostId,
                categoryId: categoryId,
                title: title,
                description: description,
                pricePerUnit: pricePerUnit,
                currency: currency,
                unitType: unitType,
                maxGuests: maxGuests,
                bedrooms: bedrooms,
                bathrooms: bathrooms,
                address: address,
                city: city,
                state: state,
                country: country,
                postalCode: postalCode,
                latitude: latitude,
                longitude: longitude,
                isActive: isActive,
                isFeatured: isFeatured,
                avgRating: avgRating,
                reviewCount: reviewCount,
                minNights: minNights,
                maxNights: maxNights,
                checkInTime: checkInTime,
                checkOutTime: checkOutTime,
                cancellationPolicy: cancellationPolicy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ListingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ListingsTable,
      Listing,
      $$ListingsTableFilterComposer,
      $$ListingsTableOrderingComposer,
      $$ListingsTableAnnotationComposer,
      $$ListingsTableCreateCompanionBuilder,
      $$ListingsTableUpdateCompanionBuilder,
      (Listing, BaseReferences<_$AppDatabase, $ListingsTable, Listing>),
      Listing,
      PrefetchHooks Function()
    >;
typedef $$ImagesTableCreateCompanionBuilder =
    ImagesCompanion Function({
      required String id,
      required String listingId,
      required String url,
      Value<String?> altText,
      Value<int?> width,
      Value<int?> height,
      Value<int> sortOrder,
      Value<bool> isPrimary,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$ImagesTableUpdateCompanionBuilder =
    ImagesCompanion Function({
      Value<String> id,
      Value<String> listingId,
      Value<String> url,
      Value<String?> altText,
      Value<int?> width,
      Value<int?> height,
      Value<int> sortOrder,
      Value<bool> isPrimary,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ImagesTableFilterComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get altText => $composableBuilder(
    column: $table.altText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get altText => $composableBuilder(
    column: $table.altText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get width => $composableBuilder(
    column: $table.width,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImagesTable> {
  $$ImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get listingId =>
      $composableBuilder(column: $table.listingId, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get altText =>
      $composableBuilder(column: $table.altText, builder: (column) => column);

  GeneratedColumn<int> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<int> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImagesTable,
          Image,
          $$ImagesTableFilterComposer,
          $$ImagesTableOrderingComposer,
          $$ImagesTableAnnotationComposer,
          $$ImagesTableCreateCompanionBuilder,
          $$ImagesTableUpdateCompanionBuilder,
          (Image, BaseReferences<_$AppDatabase, $ImagesTable, Image>),
          Image,
          PrefetchHooks Function()
        > {
  $$ImagesTableTableManager(_$AppDatabase db, $ImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> listingId = const Value.absent(),
                Value<String> url = const Value.absent(),
                Value<String?> altText = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImagesCompanion(
                id: id,
                listingId: listingId,
                url: url,
                altText: altText,
                width: width,
                height: height,
                sortOrder: sortOrder,
                isPrimary: isPrimary,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String listingId,
                required String url,
                Value<String?> altText = const Value.absent(),
                Value<int?> width = const Value.absent(),
                Value<int?> height = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImagesCompanion.insert(
                id: id,
                listingId: listingId,
                url: url,
                altText: altText,
                width: width,
                height: height,
                sortOrder: sortOrder,
                isPrimary: isPrimary,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImagesTable,
      Image,
      $$ImagesTableFilterComposer,
      $$ImagesTableOrderingComposer,
      $$ImagesTableAnnotationComposer,
      $$ImagesTableCreateCompanionBuilder,
      $$ImagesTableUpdateCompanionBuilder,
      (Image, BaseReferences<_$AppDatabase, $ImagesTable, Image>),
      Image,
      PrefetchHooks Function()
    >;
typedef $$AmenitiesTableCreateCompanionBuilder =
    AmenitiesCompanion Function({
      required String id,
      required String name,
      required String slug,
      Value<String?> iconUrl,
      Value<String?> category,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$AmenitiesTableUpdateCompanionBuilder =
    AmenitiesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> slug,
      Value<String?> iconUrl,
      Value<String?> category,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AmenitiesTableFilterComposer
    extends Composer<_$AppDatabase, $AmenitiesTable> {
  $$AmenitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AmenitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $AmenitiesTable> {
  $$AmenitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconUrl => $composableBuilder(
    column: $table.iconUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AmenitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AmenitiesTable> {
  $$AmenitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get iconUrl =>
      $composableBuilder(column: $table.iconUrl, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AmenitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AmenitiesTable,
          Amenity,
          $$AmenitiesTableFilterComposer,
          $$AmenitiesTableOrderingComposer,
          $$AmenitiesTableAnnotationComposer,
          $$AmenitiesTableCreateCompanionBuilder,
          $$AmenitiesTableUpdateCompanionBuilder,
          (Amenity, BaseReferences<_$AppDatabase, $AmenitiesTable, Amenity>),
          Amenity,
          PrefetchHooks Function()
        > {
  $$AmenitiesTableTableManager(_$AppDatabase db, $AmenitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AmenitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AmenitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AmenitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AmenitiesCompanion(
                id: id,
                name: name,
                slug: slug,
                iconUrl: iconUrl,
                category: category,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String slug,
                Value<String?> iconUrl = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AmenitiesCompanion.insert(
                id: id,
                name: name,
                slug: slug,
                iconUrl: iconUrl,
                category: category,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AmenitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AmenitiesTable,
      Amenity,
      $$AmenitiesTableFilterComposer,
      $$AmenitiesTableOrderingComposer,
      $$AmenitiesTableAnnotationComposer,
      $$AmenitiesTableCreateCompanionBuilder,
      $$AmenitiesTableUpdateCompanionBuilder,
      (Amenity, BaseReferences<_$AppDatabase, $AmenitiesTable, Amenity>),
      Amenity,
      PrefetchHooks Function()
    >;
typedef $$ListingAmenitiesTableCreateCompanionBuilder =
    ListingAmenitiesCompanion Function({
      required String listingId,
      required String amenityId,
      Value<int> rowid,
    });
typedef $$ListingAmenitiesTableUpdateCompanionBuilder =
    ListingAmenitiesCompanion Function({
      Value<String> listingId,
      Value<String> amenityId,
      Value<int> rowid,
    });

class $$ListingAmenitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ListingAmenitiesTable> {
  $$ListingAmenitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amenityId => $composableBuilder(
    column: $table.amenityId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ListingAmenitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ListingAmenitiesTable> {
  $$ListingAmenitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amenityId => $composableBuilder(
    column: $table.amenityId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ListingAmenitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ListingAmenitiesTable> {
  $$ListingAmenitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get listingId =>
      $composableBuilder(column: $table.listingId, builder: (column) => column);

  GeneratedColumn<String> get amenityId =>
      $composableBuilder(column: $table.amenityId, builder: (column) => column);
}

class $$ListingAmenitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ListingAmenitiesTable,
          ListingAmenity,
          $$ListingAmenitiesTableFilterComposer,
          $$ListingAmenitiesTableOrderingComposer,
          $$ListingAmenitiesTableAnnotationComposer,
          $$ListingAmenitiesTableCreateCompanionBuilder,
          $$ListingAmenitiesTableUpdateCompanionBuilder,
          (
            ListingAmenity,
            BaseReferences<
              _$AppDatabase,
              $ListingAmenitiesTable,
              ListingAmenity
            >,
          ),
          ListingAmenity,
          PrefetchHooks Function()
        > {
  $$ListingAmenitiesTableTableManager(
    _$AppDatabase db,
    $ListingAmenitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ListingAmenitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ListingAmenitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ListingAmenitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> listingId = const Value.absent(),
                Value<String> amenityId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ListingAmenitiesCompanion(
                listingId: listingId,
                amenityId: amenityId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String listingId,
                required String amenityId,
                Value<int> rowid = const Value.absent(),
              }) => ListingAmenitiesCompanion.insert(
                listingId: listingId,
                amenityId: amenityId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ListingAmenitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ListingAmenitiesTable,
      ListingAmenity,
      $$ListingAmenitiesTableFilterComposer,
      $$ListingAmenitiesTableOrderingComposer,
      $$ListingAmenitiesTableAnnotationComposer,
      $$ListingAmenitiesTableCreateCompanionBuilder,
      $$ListingAmenitiesTableUpdateCompanionBuilder,
      (
        ListingAmenity,
        BaseReferences<_$AppDatabase, $ListingAmenitiesTable, ListingAmenity>,
      ),
      ListingAmenity,
      PrefetchHooks Function()
    >;
typedef $$BookingsTableCreateCompanionBuilder =
    BookingsCompanion Function({
      required String id,
      required String listingId,
      required String guestId,
      required String hostId,
      required DateTime startDate,
      required DateTime endDate,
      Value<int> numGuests,
      required double totalPrice,
      Value<String> currency,
      Value<String> status,
      Value<String?> specialRequests,
      Value<DateTime?> cancelledAt,
      Value<String?> cancellationReason,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$BookingsTableUpdateCompanionBuilder =
    BookingsCompanion Function({
      Value<String> id,
      Value<String> listingId,
      Value<String> guestId,
      Value<String> hostId,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<int> numGuests,
      Value<double> totalPrice,
      Value<String> currency,
      Value<String> status,
      Value<String?> specialRequests,
      Value<DateTime?> cancelledAt,
      Value<String?> cancellationReason,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BookingsTableFilterComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guestId => $composableBuilder(
    column: $table.guestId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hostId => $composableBuilder(
    column: $table.hostId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numGuests => $composableBuilder(
    column: $table.numGuests,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialRequests => $composableBuilder(
    column: $table.specialRequests,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cancellationReason => $composableBuilder(
    column: $table.cancellationReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guestId => $composableBuilder(
    column: $table.guestId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hostId => $composableBuilder(
    column: $table.hostId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numGuests => $composableBuilder(
    column: $table.numGuests,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialRequests => $composableBuilder(
    column: $table.specialRequests,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cancellationReason => $composableBuilder(
    column: $table.cancellationReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookingsTable> {
  $$BookingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get listingId =>
      $composableBuilder(column: $table.listingId, builder: (column) => column);

  GeneratedColumn<String> get guestId =>
      $composableBuilder(column: $table.guestId, builder: (column) => column);

  GeneratedColumn<String> get hostId =>
      $composableBuilder(column: $table.hostId, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get numGuests =>
      $composableBuilder(column: $table.numGuests, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get specialRequests => $composableBuilder(
    column: $table.specialRequests,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cancellationReason => $composableBuilder(
    column: $table.cancellationReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BookingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookingsTable,
          Booking,
          $$BookingsTableFilterComposer,
          $$BookingsTableOrderingComposer,
          $$BookingsTableAnnotationComposer,
          $$BookingsTableCreateCompanionBuilder,
          $$BookingsTableUpdateCompanionBuilder,
          (Booking, BaseReferences<_$AppDatabase, $BookingsTable, Booking>),
          Booking,
          PrefetchHooks Function()
        > {
  $$BookingsTableTableManager(_$AppDatabase db, $BookingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> listingId = const Value.absent(),
                Value<String> guestId = const Value.absent(),
                Value<String> hostId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<int> numGuests = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> specialRequests = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                Value<String?> cancellationReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookingsCompanion(
                id: id,
                listingId: listingId,
                guestId: guestId,
                hostId: hostId,
                startDate: startDate,
                endDate: endDate,
                numGuests: numGuests,
                totalPrice: totalPrice,
                currency: currency,
                status: status,
                specialRequests: specialRequests,
                cancelledAt: cancelledAt,
                cancellationReason: cancellationReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String listingId,
                required String guestId,
                required String hostId,
                required DateTime startDate,
                required DateTime endDate,
                Value<int> numGuests = const Value.absent(),
                required double totalPrice,
                Value<String> currency = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> specialRequests = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                Value<String?> cancellationReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BookingsCompanion.insert(
                id: id,
                listingId: listingId,
                guestId: guestId,
                hostId: hostId,
                startDate: startDate,
                endDate: endDate,
                numGuests: numGuests,
                totalPrice: totalPrice,
                currency: currency,
                status: status,
                specialRequests: specialRequests,
                cancelledAt: cancelledAt,
                cancellationReason: cancellationReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookingsTable,
      Booking,
      $$BookingsTableFilterComposer,
      $$BookingsTableOrderingComposer,
      $$BookingsTableAnnotationComposer,
      $$BookingsTableCreateCompanionBuilder,
      $$BookingsTableUpdateCompanionBuilder,
      (Booking, BaseReferences<_$AppDatabase, $BookingsTable, Booking>),
      Booking,
      PrefetchHooks Function()
    >;
typedef $$ReviewsTableCreateCompanionBuilder =
    ReviewsCompanion Function({
      required String id,
      required String listingId,
      required String authorId,
      Value<String?> bookingId,
      required int rating,
      Value<String?> title,
      Value<String?> comment,
      Value<String?> response,
      Value<DateTime?> responseAt,
      Value<bool> isVisible,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ReviewsTableUpdateCompanionBuilder =
    ReviewsCompanion Function({
      Value<String> id,
      Value<String> listingId,
      Value<String> authorId,
      Value<String?> bookingId,
      Value<int> rating,
      Value<String?> title,
      Value<String?> comment,
      Value<String?> response,
      Value<DateTime?> responseAt,
      Value<bool> isVisible,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookingId => $composableBuilder(
    column: $table.bookingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get responseAt => $composableBuilder(
    column: $table.responseAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookingId => $composableBuilder(
    column: $table.bookingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get response => $composableBuilder(
    column: $table.response,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get responseAt => $composableBuilder(
    column: $table.responseAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVisible => $composableBuilder(
    column: $table.isVisible,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewsTable> {
  $$ReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get listingId =>
      $composableBuilder(column: $table.listingId, builder: (column) => column);

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<String> get bookingId =>
      $composableBuilder(column: $table.bookingId, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<String> get response =>
      $composableBuilder(column: $table.response, builder: (column) => column);

  GeneratedColumn<DateTime> get responseAt => $composableBuilder(
    column: $table.responseAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVisible =>
      $composableBuilder(column: $table.isVisible, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewsTable,
          Review,
          $$ReviewsTableFilterComposer,
          $$ReviewsTableOrderingComposer,
          $$ReviewsTableAnnotationComposer,
          $$ReviewsTableCreateCompanionBuilder,
          $$ReviewsTableUpdateCompanionBuilder,
          (Review, BaseReferences<_$AppDatabase, $ReviewsTable, Review>),
          Review,
          PrefetchHooks Function()
        > {
  $$ReviewsTableTableManager(_$AppDatabase db, $ReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> listingId = const Value.absent(),
                Value<String> authorId = const Value.absent(),
                Value<String?> bookingId = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> response = const Value.absent(),
                Value<DateTime?> responseAt = const Value.absent(),
                Value<bool> isVisible = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewsCompanion(
                id: id,
                listingId: listingId,
                authorId: authorId,
                bookingId: bookingId,
                rating: rating,
                title: title,
                comment: comment,
                response: response,
                responseAt: responseAt,
                isVisible: isVisible,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String listingId,
                required String authorId,
                Value<String?> bookingId = const Value.absent(),
                required int rating,
                Value<String?> title = const Value.absent(),
                Value<String?> comment = const Value.absent(),
                Value<String?> response = const Value.absent(),
                Value<DateTime?> responseAt = const Value.absent(),
                Value<bool> isVisible = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewsCompanion.insert(
                id: id,
                listingId: listingId,
                authorId: authorId,
                bookingId: bookingId,
                rating: rating,
                title: title,
                comment: comment,
                response: response,
                responseAt: responseAt,
                isVisible: isVisible,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewsTable,
      Review,
      $$ReviewsTableFilterComposer,
      $$ReviewsTableOrderingComposer,
      $$ReviewsTableAnnotationComposer,
      $$ReviewsTableCreateCompanionBuilder,
      $$ReviewsTableUpdateCompanionBuilder,
      (Review, BaseReferences<_$AppDatabase, $ReviewsTable, Review>),
      Review,
      PrefetchHooks Function()
    >;
typedef $$FavoritesTableCreateCompanionBuilder =
    FavoritesCompanion Function({
      required String userId,
      required String listingId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$FavoritesTableUpdateCompanionBuilder =
    FavoritesCompanion Function({
      Value<String> userId,
      Value<String> listingId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get listingId => $composableBuilder(
    column: $table.listingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get listingId =>
      $composableBuilder(column: $table.listingId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
          Favorite,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> listingId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion(
                userId: userId,
                listingId: listingId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String listingId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritesCompanion.insert(
                userId: userId,
                listingId: listingId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
      Favorite,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$ListingsTableTableManager get listings =>
      $$ListingsTableTableManager(_db, _db.listings);
  $$ImagesTableTableManager get images =>
      $$ImagesTableTableManager(_db, _db.images);
  $$AmenitiesTableTableManager get amenities =>
      $$AmenitiesTableTableManager(_db, _db.amenities);
  $$ListingAmenitiesTableTableManager get listingAmenities =>
      $$ListingAmenitiesTableTableManager(_db, _db.listingAmenities);
  $$BookingsTableTableManager get bookings =>
      $$BookingsTableTableManager(_db, _db.bookings);
  $$ReviewsTableTableManager get reviews =>
      $$ReviewsTableTableManager(_db, _db.reviews);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
}

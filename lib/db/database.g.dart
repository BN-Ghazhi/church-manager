// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BranchesTable extends Branches
    with TableInfo<$BranchesTable, BranchRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressLineMeta = const VerificationMeta(
    'addressLine',
  );
  @override
  late final GeneratedColumn<String> addressLine = GeneratedColumn<String>(
    'address_line',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Ghana'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _establishedAtMeta = const VerificationMeta(
    'establishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> establishedAt =
      GeneratedColumn<DateTime>(
        'established_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _pastorIdMeta = const VerificationMeta(
    'pastorId',
  );
  @override
  late final GeneratedColumn<String> pastorId = GeneratedColumn<String>(
    'pastor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assistantPastorIdMeta = const VerificationMeta(
    'assistantPastorId',
  );
  @override
  late final GeneratedColumn<String> assistantPastorId =
      GeneratedColumn<String>(
        'assistant_pastor_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _accentMeta = const VerificationMeta('accent');
  @override
  late final GeneratedColumn<String> accent = GeneratedColumn<String>(
    'accent',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isHeadquartersMeta = const VerificationMeta(
    'isHeadquarters',
  );
  @override
  late final GeneratedColumn<bool> isHeadquarters = GeneratedColumn<bool>(
    'is_headquarters',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_headquarters" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    code,
    addressLine,
    city,
    state,
    country,
    status,
    establishedAt,
    pastorId,
    assistantPastorId,
    accent,
    isHeadquarters,
    phone,
    email,
    website,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(
    Insertable<BranchRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
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
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('address_line')) {
      context.handle(
        _addressLineMeta,
        addressLine.isAcceptableOrUnknown(
          data['address_line']!,
          _addressLineMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_addressLineMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('established_at')) {
      context.handle(
        _establishedAtMeta,
        establishedAt.isAcceptableOrUnknown(
          data['established_at']!,
          _establishedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_establishedAtMeta);
    }
    if (data.containsKey('pastor_id')) {
      context.handle(
        _pastorIdMeta,
        pastorId.isAcceptableOrUnknown(data['pastor_id']!, _pastorIdMeta),
      );
    }
    if (data.containsKey('assistant_pastor_id')) {
      context.handle(
        _assistantPastorIdMeta,
        assistantPastorId.isAcceptableOrUnknown(
          data['assistant_pastor_id']!,
          _assistantPastorIdMeta,
        ),
      );
    }
    if (data.containsKey('accent')) {
      context.handle(
        _accentMeta,
        accent.isAcceptableOrUnknown(data['accent']!, _accentMeta),
      );
    } else if (isInserting) {
      context.missing(_accentMeta);
    }
    if (data.containsKey('is_headquarters')) {
      context.handle(
        _isHeadquartersMeta,
        isHeadquarters.isAcceptableOrUnknown(
          data['is_headquarters']!,
          _isHeadquartersMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BranchRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BranchRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      addressLine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      establishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}established_at'],
      )!,
      pastorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pastor_id'],
      ),
      assistantPastorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assistant_pastor_id'],
      ),
      accent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent'],
      )!,
      isHeadquarters: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_headquarters'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      )!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class BranchRow extends DataClass implements Insertable<BranchRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String code;
  final String addressLine;
  final String city;
  final String state;
  final String country;
  final String status;
  final DateTime establishedAt;

  /// Nullable so a branch can be created before its pastor record exists.
  final String? pastorId;
  final String? assistantPastorId;
  final String accent;
  final bool isHeadquarters;

  /// Contact details, so a branch card can offer a call, an email or a map.
  /// Optional: a church plant meeting in a school hall may have none of them.
  final String phone;
  final String email;
  final String website;
  const BranchRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.code,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.country,
    required this.status,
    required this.establishedAt,
    this.pastorId,
    this.assistantPastorId,
    required this.accent,
    required this.isHeadquarters,
    required this.phone,
    required this.email,
    required this.website,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    map['address_line'] = Variable<String>(addressLine);
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['country'] = Variable<String>(country);
    map['status'] = Variable<String>(status);
    map['established_at'] = Variable<DateTime>(establishedAt);
    if (!nullToAbsent || pastorId != null) {
      map['pastor_id'] = Variable<String>(pastorId);
    }
    if (!nullToAbsent || assistantPastorId != null) {
      map['assistant_pastor_id'] = Variable<String>(assistantPastorId);
    }
    map['accent'] = Variable<String>(accent);
    map['is_headquarters'] = Variable<bool>(isHeadquarters);
    map['phone'] = Variable<String>(phone);
    map['email'] = Variable<String>(email);
    map['website'] = Variable<String>(website);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      code: Value(code),
      addressLine: Value(addressLine),
      city: Value(city),
      state: Value(state),
      country: Value(country),
      status: Value(status),
      establishedAt: Value(establishedAt),
      pastorId: pastorId == null && nullToAbsent
          ? const Value.absent()
          : Value(pastorId),
      assistantPastorId: assistantPastorId == null && nullToAbsent
          ? const Value.absent()
          : Value(assistantPastorId),
      accent: Value(accent),
      isHeadquarters: Value(isHeadquarters),
      phone: Value(phone),
      email: Value(email),
      website: Value(website),
    );
  }

  factory BranchRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BranchRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      addressLine: serializer.fromJson<String>(json['addressLine']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      status: serializer.fromJson<String>(json['status']),
      establishedAt: serializer.fromJson<DateTime>(json['establishedAt']),
      pastorId: serializer.fromJson<String?>(json['pastorId']),
      assistantPastorId: serializer.fromJson<String?>(
        json['assistantPastorId'],
      ),
      accent: serializer.fromJson<String>(json['accent']),
      isHeadquarters: serializer.fromJson<bool>(json['isHeadquarters']),
      phone: serializer.fromJson<String>(json['phone']),
      email: serializer.fromJson<String>(json['email']),
      website: serializer.fromJson<String>(json['website']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'addressLine': serializer.toJson<String>(addressLine),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'country': serializer.toJson<String>(country),
      'status': serializer.toJson<String>(status),
      'establishedAt': serializer.toJson<DateTime>(establishedAt),
      'pastorId': serializer.toJson<String?>(pastorId),
      'assistantPastorId': serializer.toJson<String?>(assistantPastorId),
      'accent': serializer.toJson<String>(accent),
      'isHeadquarters': serializer.toJson<bool>(isHeadquarters),
      'phone': serializer.toJson<String>(phone),
      'email': serializer.toJson<String>(email),
      'website': serializer.toJson<String>(website),
    };
  }

  BranchRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? code,
    String? addressLine,
    String? city,
    String? state,
    String? country,
    String? status,
    DateTime? establishedAt,
    Value<String?> pastorId = const Value.absent(),
    Value<String?> assistantPastorId = const Value.absent(),
    String? accent,
    bool? isHeadquarters,
    String? phone,
    String? email,
    String? website,
  }) => BranchRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    code: code ?? this.code,
    addressLine: addressLine ?? this.addressLine,
    city: city ?? this.city,
    state: state ?? this.state,
    country: country ?? this.country,
    status: status ?? this.status,
    establishedAt: establishedAt ?? this.establishedAt,
    pastorId: pastorId.present ? pastorId.value : this.pastorId,
    assistantPastorId: assistantPastorId.present
        ? assistantPastorId.value
        : this.assistantPastorId,
    accent: accent ?? this.accent,
    isHeadquarters: isHeadquarters ?? this.isHeadquarters,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    website: website ?? this.website,
  );
  BranchRow copyWithCompanion(BranchesCompanion data) {
    return BranchRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      addressLine: data.addressLine.present
          ? data.addressLine.value
          : this.addressLine,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      country: data.country.present ? data.country.value : this.country,
      status: data.status.present ? data.status.value : this.status,
      establishedAt: data.establishedAt.present
          ? data.establishedAt.value
          : this.establishedAt,
      pastorId: data.pastorId.present ? data.pastorId.value : this.pastorId,
      assistantPastorId: data.assistantPastorId.present
          ? data.assistantPastorId.value
          : this.assistantPastorId,
      accent: data.accent.present ? data.accent.value : this.accent,
      isHeadquarters: data.isHeadquarters.present
          ? data.isHeadquarters.value
          : this.isHeadquarters,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      website: data.website.present ? data.website.value : this.website,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BranchRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('addressLine: $addressLine, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('status: $status, ')
          ..write('establishedAt: $establishedAt, ')
          ..write('pastorId: $pastorId, ')
          ..write('assistantPastorId: $assistantPastorId, ')
          ..write('accent: $accent, ')
          ..write('isHeadquarters: $isHeadquarters, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    code,
    addressLine,
    city,
    state,
    country,
    status,
    establishedAt,
    pastorId,
    assistantPastorId,
    accent,
    isHeadquarters,
    phone,
    email,
    website,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BranchRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.addressLine == this.addressLine &&
          other.city == this.city &&
          other.state == this.state &&
          other.country == this.country &&
          other.status == this.status &&
          other.establishedAt == this.establishedAt &&
          other.pastorId == this.pastorId &&
          other.assistantPastorId == this.assistantPastorId &&
          other.accent == this.accent &&
          other.isHeadquarters == this.isHeadquarters &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.website == this.website);
}

class BranchesCompanion extends UpdateCompanion<BranchRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> code;
  final Value<String> addressLine;
  final Value<String> city;
  final Value<String> state;
  final Value<String> country;
  final Value<String> status;
  final Value<DateTime> establishedAt;
  final Value<String?> pastorId;
  final Value<String?> assistantPastorId;
  final Value<String> accent;
  final Value<bool> isHeadquarters;
  final Value<String> phone;
  final Value<String> email;
  final Value<String> website;
  final Value<int> rowid;
  const BranchesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.addressLine = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.status = const Value.absent(),
    this.establishedAt = const Value.absent(),
    this.pastorId = const Value.absent(),
    this.assistantPastorId = const Value.absent(),
    this.accent = const Value.absent(),
    this.isHeadquarters = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BranchesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String code,
    required String addressLine,
    required String city,
    required String state,
    this.country = const Value.absent(),
    required String status,
    required DateTime establishedAt,
    this.pastorId = const Value.absent(),
    this.assistantPastorId = const Value.absent(),
    required String accent,
    this.isHeadquarters = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.website = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       code = Value(code),
       addressLine = Value(addressLine),
       city = Value(city),
       state = Value(state),
       status = Value(status),
       establishedAt = Value(establishedAt),
       accent = Value(accent);
  static Insertable<BranchRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<String>? addressLine,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? country,
    Expression<String>? status,
    Expression<DateTime>? establishedAt,
    Expression<String>? pastorId,
    Expression<String>? assistantPastorId,
    Expression<String>? accent,
    Expression<bool>? isHeadquarters,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? website,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (addressLine != null) 'address_line': addressLine,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (status != null) 'status': status,
      if (establishedAt != null) 'established_at': establishedAt,
      if (pastorId != null) 'pastor_id': pastorId,
      if (assistantPastorId != null) 'assistant_pastor_id': assistantPastorId,
      if (accent != null) 'accent': accent,
      if (isHeadquarters != null) 'is_headquarters': isHeadquarters,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (website != null) 'website': website,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BranchesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? code,
    Value<String>? addressLine,
    Value<String>? city,
    Value<String>? state,
    Value<String>? country,
    Value<String>? status,
    Value<DateTime>? establishedAt,
    Value<String?>? pastorId,
    Value<String?>? assistantPastorId,
    Value<String>? accent,
    Value<bool>? isHeadquarters,
    Value<String>? phone,
    Value<String>? email,
    Value<String>? website,
    Value<int>? rowid,
  }) {
    return BranchesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      status: status ?? this.status,
      establishedAt: establishedAt ?? this.establishedAt,
      pastorId: pastorId ?? this.pastorId,
      assistantPastorId: assistantPastorId ?? this.assistantPastorId,
      accent: accent ?? this.accent,
      isHeadquarters: isHeadquarters ?? this.isHeadquarters,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (addressLine.present) {
      map['address_line'] = Variable<String>(addressLine.value);
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
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (establishedAt.present) {
      map['established_at'] = Variable<DateTime>(establishedAt.value);
    }
    if (pastorId.present) {
      map['pastor_id'] = Variable<String>(pastorId.value);
    }
    if (assistantPastorId.present) {
      map['assistant_pastor_id'] = Variable<String>(assistantPastorId.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (isHeadquarters.present) {
      map['is_headquarters'] = Variable<bool>(isHeadquarters.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('addressLine: $addressLine, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('status: $status, ')
          ..write('establishedAt: $establishedAt, ')
          ..write('pastorId: $pastorId, ')
          ..write('assistantPastorId: $assistantPastorId, ')
          ..write('accent: $accent, ')
          ..write('isHeadquarters: $isHeadquarters, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('website: $website, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, MemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maritalStatusMeta = const VerificationMeta(
    'maritalStatus',
  );
  @override
  late final GeneratedColumn<String> maritalStatus = GeneratedColumn<String>(
    'marital_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressLineMeta = const VerificationMeta(
    'addressLine',
  );
  @override
  late final GeneratedColumn<String> addressLine = GeneratedColumn<String>(
    'address_line',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Ghana'),
  );
  static const VerificationMeta _isBaptizedMeta = const VerificationMeta(
    'isBaptized',
  );
  @override
  late final GeneratedColumn<bool> isBaptized = GeneratedColumn<bool>(
    'is_baptized',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_baptized" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _familyIdMeta = const VerificationMeta(
    'familyId',
  );
  @override
  late final GeneratedColumn<String> familyId = GeneratedColumn<String>(
    'family_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    firstName,
    lastName,
    email,
    phone,
    gender,
    dateOfBirth,
    maritalStatus,
    status,
    joinedAt,
    addressLine,
    city,
    state,
    country,
    isBaptized,
    title,
    photo,
    branchId,
    groupId,
    familyId,
    notes,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<MemberRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('marital_status')) {
      context.handle(
        _maritalStatusMeta,
        maritalStatus.isAcceptableOrUnknown(
          data['marital_status']!,
          _maritalStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maritalStatusMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_joinedAtMeta);
    }
    if (data.containsKey('address_line')) {
      context.handle(
        _addressLineMeta,
        addressLine.isAcceptableOrUnknown(
          data['address_line']!,
          _addressLineMeta,
        ),
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
    if (data.containsKey('is_baptized')) {
      context.handle(
        _isBaptizedMeta,
        isBaptized.isAcceptableOrUnknown(data['is_baptized']!, _isBaptizedMeta),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('family_id')) {
      context.handle(
        _familyIdMeta,
        familyId.isAcceptableOrUnknown(data['family_id']!, _familyIdMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemberRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      )!,
      maritalStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marital_status'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      )!,
      addressLine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address_line'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      isBaptized: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_baptized'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      ),
      familyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}family_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class MemberRow extends DataClass implements Insertable<MemberRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final DateTime dateOfBirth;
  final String maritalStatus;
  final String status;
  final DateTime joinedAt;
  final String addressLine;
  final String city;
  final String state;
  final String country;
  final bool isBaptized;

  /// An honorific held by the person, e.g. "Pastor", "Reverend", "Deacon".
  ///
  /// Free text and deliberately separate from everything else. A church can have
  /// several pastors at one branch without any of them leading it, so being a
  /// pastor is not a leadership post and not a system role — it is who the
  /// person is. Blank for most members.
  final String title;

  /// Filename of the member's photo inside the app's `photos` directory.
  ///
  /// A filename rather than a full path: the application-support directory moves
  /// between machines and between a native and a sandboxed install, so a stored
  /// absolute path breaks on restore while a filename stays valid. Blank when
  /// there is no photo, which is most members.
  final String photo;

  /// Home branch — every member belongs to exactly one.
  final String branchId;
  final String? groupId;
  final String? familyId;
  final String? notes;

  /// Comma-separated; small enough not to warrant a join table.
  final String tags;
  const MemberRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.dateOfBirth,
    required this.maritalStatus,
    required this.status,
    required this.joinedAt,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.country,
    required this.isBaptized,
    required this.title,
    required this.photo,
    required this.branchId,
    this.groupId,
    this.familyId,
    this.notes,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    map['phone'] = Variable<String>(phone);
    map['gender'] = Variable<String>(gender);
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    map['marital_status'] = Variable<String>(maritalStatus);
    map['status'] = Variable<String>(status);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    map['address_line'] = Variable<String>(addressLine);
    map['city'] = Variable<String>(city);
    map['state'] = Variable<String>(state);
    map['country'] = Variable<String>(country);
    map['is_baptized'] = Variable<bool>(isBaptized);
    map['title'] = Variable<String>(title);
    map['photo'] = Variable<String>(photo);
    map['branch_id'] = Variable<String>(branchId);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    if (!nullToAbsent || familyId != null) {
      map['family_id'] = Variable<String>(familyId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      phone: Value(phone),
      gender: Value(gender),
      dateOfBirth: Value(dateOfBirth),
      maritalStatus: Value(maritalStatus),
      status: Value(status),
      joinedAt: Value(joinedAt),
      addressLine: Value(addressLine),
      city: Value(city),
      state: Value(state),
      country: Value(country),
      isBaptized: Value(isBaptized),
      title: Value(title),
      photo: Value(photo),
      branchId: Value(branchId),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      familyId: familyId == null && nullToAbsent
          ? const Value.absent()
          : Value(familyId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      tags: Value(tags),
    );
  }

  factory MemberRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemberRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String>(json['phone']),
      gender: serializer.fromJson<String>(json['gender']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      maritalStatus: serializer.fromJson<String>(json['maritalStatus']),
      status: serializer.fromJson<String>(json['status']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
      addressLine: serializer.fromJson<String>(json['addressLine']),
      city: serializer.fromJson<String>(json['city']),
      state: serializer.fromJson<String>(json['state']),
      country: serializer.fromJson<String>(json['country']),
      isBaptized: serializer.fromJson<bool>(json['isBaptized']),
      title: serializer.fromJson<String>(json['title']),
      photo: serializer.fromJson<String>(json['photo']),
      branchId: serializer.fromJson<String>(json['branchId']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      familyId: serializer.fromJson<String?>(json['familyId']),
      notes: serializer.fromJson<String?>(json['notes']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String>(phone),
      'gender': serializer.toJson<String>(gender),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'maritalStatus': serializer.toJson<String>(maritalStatus),
      'status': serializer.toJson<String>(status),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
      'addressLine': serializer.toJson<String>(addressLine),
      'city': serializer.toJson<String>(city),
      'state': serializer.toJson<String>(state),
      'country': serializer.toJson<String>(country),
      'isBaptized': serializer.toJson<bool>(isBaptized),
      'title': serializer.toJson<String>(title),
      'photo': serializer.toJson<String>(photo),
      'branchId': serializer.toJson<String>(branchId),
      'groupId': serializer.toJson<String?>(groupId),
      'familyId': serializer.toJson<String?>(familyId),
      'notes': serializer.toJson<String?>(notes),
      'tags': serializer.toJson<String>(tags),
    };
  }

  MemberRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? gender,
    DateTime? dateOfBirth,
    String? maritalStatus,
    String? status,
    DateTime? joinedAt,
    String? addressLine,
    String? city,
    String? state,
    String? country,
    bool? isBaptized,
    String? title,
    String? photo,
    String? branchId,
    Value<String?> groupId = const Value.absent(),
    Value<String?> familyId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? tags,
  }) => MemberRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    gender: gender ?? this.gender,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    maritalStatus: maritalStatus ?? this.maritalStatus,
    status: status ?? this.status,
    joinedAt: joinedAt ?? this.joinedAt,
    addressLine: addressLine ?? this.addressLine,
    city: city ?? this.city,
    state: state ?? this.state,
    country: country ?? this.country,
    isBaptized: isBaptized ?? this.isBaptized,
    title: title ?? this.title,
    photo: photo ?? this.photo,
    branchId: branchId ?? this.branchId,
    groupId: groupId.present ? groupId.value : this.groupId,
    familyId: familyId.present ? familyId.value : this.familyId,
    notes: notes.present ? notes.value : this.notes,
    tags: tags ?? this.tags,
  );
  MemberRow copyWithCompanion(MembersCompanion data) {
    return MemberRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      maritalStatus: data.maritalStatus.present
          ? data.maritalStatus.value
          : this.maritalStatus,
      status: data.status.present ? data.status.value : this.status,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
      addressLine: data.addressLine.present
          ? data.addressLine.value
          : this.addressLine,
      city: data.city.present ? data.city.value : this.city,
      state: data.state.present ? data.state.value : this.state,
      country: data.country.present ? data.country.value : this.country,
      isBaptized: data.isBaptized.present
          ? data.isBaptized.value
          : this.isBaptized,
      title: data.title.present ? data.title.value : this.title,
      photo: data.photo.present ? data.photo.value : this.photo,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      familyId: data.familyId.present ? data.familyId.value : this.familyId,
      notes: data.notes.present ? data.notes.value : this.notes,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MemberRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('status: $status, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('addressLine: $addressLine, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('isBaptized: $isBaptized, ')
          ..write('title: $title, ')
          ..write('photo: $photo, ')
          ..write('branchId: $branchId, ')
          ..write('groupId: $groupId, ')
          ..write('familyId: $familyId, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    createdAt,
    updatedAt,
    deletedAt,
    id,
    firstName,
    lastName,
    email,
    phone,
    gender,
    dateOfBirth,
    maritalStatus,
    status,
    joinedAt,
    addressLine,
    city,
    state,
    country,
    isBaptized,
    title,
    photo,
    branchId,
    groupId,
    familyId,
    notes,
    tags,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemberRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.maritalStatus == this.maritalStatus &&
          other.status == this.status &&
          other.joinedAt == this.joinedAt &&
          other.addressLine == this.addressLine &&
          other.city == this.city &&
          other.state == this.state &&
          other.country == this.country &&
          other.isBaptized == this.isBaptized &&
          other.title == this.title &&
          other.photo == this.photo &&
          other.branchId == this.branchId &&
          other.groupId == this.groupId &&
          other.familyId == this.familyId &&
          other.notes == this.notes &&
          other.tags == this.tags);
}

class MembersCompanion extends UpdateCompanion<MemberRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String> phone;
  final Value<String> gender;
  final Value<DateTime> dateOfBirth;
  final Value<String> maritalStatus;
  final Value<String> status;
  final Value<DateTime> joinedAt;
  final Value<String> addressLine;
  final Value<String> city;
  final Value<String> state;
  final Value<String> country;
  final Value<bool> isBaptized;
  final Value<String> title;
  final Value<String> photo;
  final Value<String> branchId;
  final Value<String?> groupId;
  final Value<String?> familyId;
  final Value<String?> notes;
  final Value<String> tags;
  final Value<int> rowid;
  const MembersCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.maritalStatus = const Value.absent(),
    this.status = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.addressLine = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.isBaptized = const Value.absent(),
    this.title = const Value.absent(),
    this.photo = const Value.absent(),
    this.branchId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.familyId = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MembersCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String firstName,
    required String lastName,
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    required String gender,
    required DateTime dateOfBirth,
    required String maritalStatus,
    required String status,
    required DateTime joinedAt,
    this.addressLine = const Value.absent(),
    this.city = const Value.absent(),
    this.state = const Value.absent(),
    this.country = const Value.absent(),
    this.isBaptized = const Value.absent(),
    this.title = const Value.absent(),
    this.photo = const Value.absent(),
    required String branchId,
    this.groupId = const Value.absent(),
    this.familyId = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       firstName = Value(firstName),
       lastName = Value(lastName),
       gender = Value(gender),
       dateOfBirth = Value(dateOfBirth),
       maritalStatus = Value(maritalStatus),
       status = Value(status),
       joinedAt = Value(joinedAt),
       branchId = Value(branchId);
  static Insertable<MemberRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? gender,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? maritalStatus,
    Expression<String>? status,
    Expression<DateTime>? joinedAt,
    Expression<String>? addressLine,
    Expression<String>? city,
    Expression<String>? state,
    Expression<String>? country,
    Expression<bool>? isBaptized,
    Expression<String>? title,
    Expression<String>? photo,
    Expression<String>? branchId,
    Expression<String>? groupId,
    Expression<String>? familyId,
    Expression<String>? notes,
    Expression<String>? tags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (maritalStatus != null) 'marital_status': maritalStatus,
      if (status != null) 'status': status,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (addressLine != null) 'address_line': addressLine,
      if (city != null) 'city': city,
      if (state != null) 'state': state,
      if (country != null) 'country': country,
      if (isBaptized != null) 'is_baptized': isBaptized,
      if (title != null) 'title': title,
      if (photo != null) 'photo': photo,
      if (branchId != null) 'branch_id': branchId,
      if (groupId != null) 'group_id': groupId,
      if (familyId != null) 'family_id': familyId,
      if (notes != null) 'notes': notes,
      if (tags != null) 'tags': tags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MembersCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? email,
    Value<String>? phone,
    Value<String>? gender,
    Value<DateTime>? dateOfBirth,
    Value<String>? maritalStatus,
    Value<String>? status,
    Value<DateTime>? joinedAt,
    Value<String>? addressLine,
    Value<String>? city,
    Value<String>? state,
    Value<String>? country,
    Value<bool>? isBaptized,
    Value<String>? title,
    Value<String>? photo,
    Value<String>? branchId,
    Value<String?>? groupId,
    Value<String?>? familyId,
    Value<String?>? notes,
    Value<String>? tags,
    Value<int>? rowid,
  }) {
    return MembersCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      isBaptized: isBaptized ?? this.isBaptized,
      title: title ?? this.title,
      photo: photo ?? this.photo,
      branchId: branchId ?? this.branchId,
      groupId: groupId ?? this.groupId,
      familyId: familyId ?? this.familyId,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (maritalStatus.present) {
      map['marital_status'] = Variable<String>(maritalStatus.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (addressLine.present) {
      map['address_line'] = Variable<String>(addressLine.value);
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
    if (isBaptized.present) {
      map['is_baptized'] = Variable<bool>(isBaptized.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (familyId.present) {
      map['family_id'] = Variable<String>(familyId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('maritalStatus: $maritalStatus, ')
          ..write('status: $status, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('addressLine: $addressLine, ')
          ..write('city: $city, ')
          ..write('state: $state, ')
          ..write('country: $country, ')
          ..write('isBaptized: $isBaptized, ')
          ..write('title: $title, ')
          ..write('photo: $photo, ')
          ..write('branchId: $branchId, ')
          ..write('groupId: $groupId, ')
          ..write('familyId: $familyId, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DepartmentTypesTable extends DepartmentTypes
    with TableInfo<$DepartmentTypesTable, DepartmentTypeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepartmentTypesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('groups'),
  );
  static const VerificationMeta _accentMeta = const VerificationMeta('accent');
  @override
  late final GeneratedColumn<String> accent = GeneratedColumn<String>(
    'accent',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCoreMeta = const VerificationMeta('isCore');
  @override
  late final GeneratedColumn<bool> isCore = GeneratedColumn<bool>(
    'is_core',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_core" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _minAgeMeta = const VerificationMeta('minAge');
  @override
  late final GeneratedColumn<int> minAge = GeneratedColumn<int>(
    'min_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxAgeMeta = const VerificationMeta('maxAge');
  @override
  late final GeneratedColumn<int> maxAge = GeneratedColumn<int>(
    'max_age',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    description,
    icon,
    accent,
    isCore,
    minAge,
    maxAge,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'department_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<DepartmentTypeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
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
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('accent')) {
      context.handle(
        _accentMeta,
        accent.isAcceptableOrUnknown(data['accent']!, _accentMeta),
      );
    } else if (isInserting) {
      context.missing(_accentMeta);
    }
    if (data.containsKey('is_core')) {
      context.handle(
        _isCoreMeta,
        isCore.isAcceptableOrUnknown(data['is_core']!, _isCoreMeta),
      );
    }
    if (data.containsKey('min_age')) {
      context.handle(
        _minAgeMeta,
        minAge.isAcceptableOrUnknown(data['min_age']!, _minAgeMeta),
      );
    }
    if (data.containsKey('max_age')) {
      context.handle(
        _maxAgeMeta,
        maxAge.isAcceptableOrUnknown(data['max_age']!, _maxAgeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DepartmentTypeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DepartmentTypeRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      accent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent'],
      )!,
      isCore: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_core'],
      )!,
      minAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_age'],
      ),
      maxAge: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_age'],
      ),
    );
  }

  @override
  $DepartmentTypesTable createAlias(String alias) {
    return $DepartmentTypesTable(attachedDatabase, alias);
  }
}

class DepartmentTypeRow extends DataClass
    implements Insertable<DepartmentTypeRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String name;
  final String description;
  final String icon;
  final String accent;
  final bool isCore;
  final int? minAge;
  final int? maxAge;
  const DepartmentTypeRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.accent,
    required this.isCore,
    this.minAge,
    this.maxAge,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['icon'] = Variable<String>(icon);
    map['accent'] = Variable<String>(accent);
    map['is_core'] = Variable<bool>(isCore);
    if (!nullToAbsent || minAge != null) {
      map['min_age'] = Variable<int>(minAge);
    }
    if (!nullToAbsent || maxAge != null) {
      map['max_age'] = Variable<int>(maxAge);
    }
    return map;
  }

  DepartmentTypesCompanion toCompanion(bool nullToAbsent) {
    return DepartmentTypesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      description: Value(description),
      icon: Value(icon),
      accent: Value(accent),
      isCore: Value(isCore),
      minAge: minAge == null && nullToAbsent
          ? const Value.absent()
          : Value(minAge),
      maxAge: maxAge == null && nullToAbsent
          ? const Value.absent()
          : Value(maxAge),
    );
  }

  factory DepartmentTypeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DepartmentTypeRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      accent: serializer.fromJson<String>(json['accent']),
      isCore: serializer.fromJson<bool>(json['isCore']),
      minAge: serializer.fromJson<int?>(json['minAge']),
      maxAge: serializer.fromJson<int?>(json['maxAge']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String>(icon),
      'accent': serializer.toJson<String>(accent),
      'isCore': serializer.toJson<bool>(isCore),
      'minAge': serializer.toJson<int?>(minAge),
      'maxAge': serializer.toJson<int?>(maxAge),
    };
  }

  DepartmentTypeRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? description,
    String? icon,
    String? accent,
    bool? isCore,
    Value<int?> minAge = const Value.absent(),
    Value<int?> maxAge = const Value.absent(),
  }) => DepartmentTypeRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    accent: accent ?? this.accent,
    isCore: isCore ?? this.isCore,
    minAge: minAge.present ? minAge.value : this.minAge,
    maxAge: maxAge.present ? maxAge.value : this.maxAge,
  );
  DepartmentTypeRow copyWithCompanion(DepartmentTypesCompanion data) {
    return DepartmentTypeRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      accent: data.accent.present ? data.accent.value : this.accent,
      isCore: data.isCore.present ? data.isCore.value : this.isCore,
      minAge: data.minAge.present ? data.minAge.value : this.minAge,
      maxAge: data.maxAge.present ? data.maxAge.value : this.maxAge,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentTypeRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('accent: $accent, ')
          ..write('isCore: $isCore, ')
          ..write('minAge: $minAge, ')
          ..write('maxAge: $maxAge')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    description,
    icon,
    accent,
    isCore,
    minAge,
    maxAge,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DepartmentTypeRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.accent == this.accent &&
          other.isCore == this.isCore &&
          other.minAge == this.minAge &&
          other.maxAge == this.maxAge);
}

class DepartmentTypesCompanion extends UpdateCompanion<DepartmentTypeRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> icon;
  final Value<String> accent;
  final Value<bool> isCore;
  final Value<int?> minAge;
  final Value<int?> maxAge;
  final Value<int> rowid;
  const DepartmentTypesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.accent = const Value.absent(),
    this.isCore = const Value.absent(),
    this.minAge = const Value.absent(),
    this.maxAge = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DepartmentTypesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    required String accent,
    this.isCore = const Value.absent(),
    this.minAge = const Value.absent(),
    this.maxAge = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       accent = Value(accent);
  static Insertable<DepartmentTypeRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? accent,
    Expression<bool>? isCore,
    Expression<int>? minAge,
    Expression<int>? maxAge,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (accent != null) 'accent': accent,
      if (isCore != null) 'is_core': isCore,
      if (minAge != null) 'min_age': minAge,
      if (maxAge != null) 'max_age': maxAge,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DepartmentTypesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? icon,
    Value<String>? accent,
    Value<bool>? isCore,
    Value<int?>? minAge,
    Value<int?>? maxAge,
    Value<int>? rowid,
  }) {
    return DepartmentTypesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      accent: accent ?? this.accent,
      isCore: isCore ?? this.isCore,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (accent.present) {
      map['accent'] = Variable<String>(accent.value);
    }
    if (isCore.present) {
      map['is_core'] = Variable<bool>(isCore.value);
    }
    if (minAge.present) {
      map['min_age'] = Variable<int>(minAge.value);
    }
    if (maxAge.present) {
      map['max_age'] = Variable<int>(maxAge.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentTypesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('accent: $accent, ')
          ..write('isCore: $isCore, ')
          ..write('minAge: $minAge, ')
          ..write('maxAge: $maxAge, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DepartmentsTable extends Departments
    with TableInfo<$DepartmentsTable, DepartmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepartmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeIdMeta = const VerificationMeta('typeId');
  @override
  late final GeneratedColumn<String> typeId = GeneratedColumn<String>(
    'type_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES department_types (id)',
    ),
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _headIdMeta = const VerificationMeta('headId');
  @override
  late final GeneratedColumn<String> headId = GeneratedColumn<String>(
    'head_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _assistantHeadIdMeta = const VerificationMeta(
    'assistantHeadId',
  );
  @override
  late final GeneratedColumn<String> assistantHeadId = GeneratedColumn<String>(
    'assistant_head_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _meetingDayMeta = const VerificationMeta(
    'meetingDay',
  );
  @override
  late final GeneratedColumn<String> meetingDay = GeneratedColumn<String>(
    'meeting_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingTimeMeta = const VerificationMeta(
    'meetingTime',
  );
  @override
  late final GeneratedColumn<String> meetingTime = GeneratedColumn<String>(
    'meeting_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    typeId,
    branchId,
    headId,
    assistantHeadId,
    meetingDay,
    meetingTime,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'departments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DepartmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type_id')) {
      context.handle(
        _typeIdMeta,
        typeId.isAcceptableOrUnknown(data['type_id']!, _typeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_typeIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('head_id')) {
      context.handle(
        _headIdMeta,
        headId.isAcceptableOrUnknown(data['head_id']!, _headIdMeta),
      );
    }
    if (data.containsKey('assistant_head_id')) {
      context.handle(
        _assistantHeadIdMeta,
        assistantHeadId.isAcceptableOrUnknown(
          data['assistant_head_id']!,
          _assistantHeadIdMeta,
        ),
      );
    }
    if (data.containsKey('meeting_day')) {
      context.handle(
        _meetingDayMeta,
        meetingDay.isAcceptableOrUnknown(data['meeting_day']!, _meetingDayMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingDayMeta);
    }
    if (data.containsKey('meeting_time')) {
      context.handle(
        _meetingTimeMeta,
        meetingTime.isAcceptableOrUnknown(
          data['meeting_time']!,
          _meetingTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meetingTimeMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DepartmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DepartmentRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      typeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type_id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      headId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}head_id'],
      ),
      assistantHeadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assistant_head_id'],
      ),
      meetingDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_day'],
      )!,
      meetingTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_time'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $DepartmentsTable createAlias(String alias) {
    return $DepartmentsTable(attachedDatabase, alias);
  }
}

class DepartmentRow extends DataClass implements Insertable<DepartmentRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String typeId;
  final String branchId;
  final String? headId;
  final String? assistantHeadId;
  final String meetingDay;
  final String meetingTime;
  final String? notes;
  const DepartmentRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.typeId,
    required this.branchId,
    this.headId,
    this.assistantHeadId,
    required this.meetingDay,
    required this.meetingTime,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['type_id'] = Variable<String>(typeId);
    map['branch_id'] = Variable<String>(branchId);
    if (!nullToAbsent || headId != null) {
      map['head_id'] = Variable<String>(headId);
    }
    if (!nullToAbsent || assistantHeadId != null) {
      map['assistant_head_id'] = Variable<String>(assistantHeadId);
    }
    map['meeting_day'] = Variable<String>(meetingDay);
    map['meeting_time'] = Variable<String>(meetingTime);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  DepartmentsCompanion toCompanion(bool nullToAbsent) {
    return DepartmentsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      typeId: Value(typeId),
      branchId: Value(branchId),
      headId: headId == null && nullToAbsent
          ? const Value.absent()
          : Value(headId),
      assistantHeadId: assistantHeadId == null && nullToAbsent
          ? const Value.absent()
          : Value(assistantHeadId),
      meetingDay: Value(meetingDay),
      meetingTime: Value(meetingTime),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory DepartmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DepartmentRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      typeId: serializer.fromJson<String>(json['typeId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      headId: serializer.fromJson<String?>(json['headId']),
      assistantHeadId: serializer.fromJson<String?>(json['assistantHeadId']),
      meetingDay: serializer.fromJson<String>(json['meetingDay']),
      meetingTime: serializer.fromJson<String>(json['meetingTime']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'typeId': serializer.toJson<String>(typeId),
      'branchId': serializer.toJson<String>(branchId),
      'headId': serializer.toJson<String?>(headId),
      'assistantHeadId': serializer.toJson<String?>(assistantHeadId),
      'meetingDay': serializer.toJson<String>(meetingDay),
      'meetingTime': serializer.toJson<String>(meetingTime),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  DepartmentRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? typeId,
    String? branchId,
    Value<String?> headId = const Value.absent(),
    Value<String?> assistantHeadId = const Value.absent(),
    String? meetingDay,
    String? meetingTime,
    Value<String?> notes = const Value.absent(),
  }) => DepartmentRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    typeId: typeId ?? this.typeId,
    branchId: branchId ?? this.branchId,
    headId: headId.present ? headId.value : this.headId,
    assistantHeadId: assistantHeadId.present
        ? assistantHeadId.value
        : this.assistantHeadId,
    meetingDay: meetingDay ?? this.meetingDay,
    meetingTime: meetingTime ?? this.meetingTime,
    notes: notes.present ? notes.value : this.notes,
  );
  DepartmentRow copyWithCompanion(DepartmentsCompanion data) {
    return DepartmentRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      typeId: data.typeId.present ? data.typeId.value : this.typeId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      headId: data.headId.present ? data.headId.value : this.headId,
      assistantHeadId: data.assistantHeadId.present
          ? data.assistantHeadId.value
          : this.assistantHeadId,
      meetingDay: data.meetingDay.present
          ? data.meetingDay.value
          : this.meetingDay,
      meetingTime: data.meetingTime.present
          ? data.meetingTime.value
          : this.meetingTime,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('typeId: $typeId, ')
          ..write('branchId: $branchId, ')
          ..write('headId: $headId, ')
          ..write('assistantHeadId: $assistantHeadId, ')
          ..write('meetingDay: $meetingDay, ')
          ..write('meetingTime: $meetingTime, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    typeId,
    branchId,
    headId,
    assistantHeadId,
    meetingDay,
    meetingTime,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DepartmentRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.typeId == this.typeId &&
          other.branchId == this.branchId &&
          other.headId == this.headId &&
          other.assistantHeadId == this.assistantHeadId &&
          other.meetingDay == this.meetingDay &&
          other.meetingTime == this.meetingTime &&
          other.notes == this.notes);
}

class DepartmentsCompanion extends UpdateCompanion<DepartmentRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> typeId;
  final Value<String> branchId;
  final Value<String?> headId;
  final Value<String?> assistantHeadId;
  final Value<String> meetingDay;
  final Value<String> meetingTime;
  final Value<String?> notes;
  final Value<int> rowid;
  const DepartmentsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.typeId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.headId = const Value.absent(),
    this.assistantHeadId = const Value.absent(),
    this.meetingDay = const Value.absent(),
    this.meetingTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DepartmentsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String typeId,
    required String branchId,
    this.headId = const Value.absent(),
    this.assistantHeadId = const Value.absent(),
    required String meetingDay,
    required String meetingTime,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       typeId = Value(typeId),
       branchId = Value(branchId),
       meetingDay = Value(meetingDay),
       meetingTime = Value(meetingTime);
  static Insertable<DepartmentRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? typeId,
    Expression<String>? branchId,
    Expression<String>? headId,
    Expression<String>? assistantHeadId,
    Expression<String>? meetingDay,
    Expression<String>? meetingTime,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (typeId != null) 'type_id': typeId,
      if (branchId != null) 'branch_id': branchId,
      if (headId != null) 'head_id': headId,
      if (assistantHeadId != null) 'assistant_head_id': assistantHeadId,
      if (meetingDay != null) 'meeting_day': meetingDay,
      if (meetingTime != null) 'meeting_time': meetingTime,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DepartmentsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? typeId,
    Value<String>? branchId,
    Value<String?>? headId,
    Value<String?>? assistantHeadId,
    Value<String>? meetingDay,
    Value<String>? meetingTime,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return DepartmentsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      typeId: typeId ?? this.typeId,
      branchId: branchId ?? this.branchId,
      headId: headId ?? this.headId,
      assistantHeadId: assistantHeadId ?? this.assistantHeadId,
      meetingDay: meetingDay ?? this.meetingDay,
      meetingTime: meetingTime ?? this.meetingTime,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (typeId.present) {
      map['type_id'] = Variable<String>(typeId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (headId.present) {
      map['head_id'] = Variable<String>(headId.value);
    }
    if (assistantHeadId.present) {
      map['assistant_head_id'] = Variable<String>(assistantHeadId.value);
    }
    if (meetingDay.present) {
      map['meeting_day'] = Variable<String>(meetingDay.value);
    }
    if (meetingTime.present) {
      map['meeting_time'] = Variable<String>(meetingTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('typeId: $typeId, ')
          ..write('branchId: $branchId, ')
          ..write('headId: $headId, ')
          ..write('assistantHeadId: $assistantHeadId, ')
          ..write('meetingDay: $meetingDay, ')
          ..write('meetingTime: $meetingTime, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DepartmentMembersTable extends DepartmentMembers
    with TableInfo<$DepartmentMembersTable, DepartmentMemberRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepartmentMembersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _departmentIdMeta = const VerificationMeta(
    'departmentId',
  );
  @override
  late final GeneratedColumn<String> departmentId = GeneratedColumn<String>(
    'department_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES departments (id)',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _joinedAtMeta = const VerificationMeta(
    'joinedAt',
  );
  @override
  late final GeneratedColumn<DateTime> joinedAt = GeneratedColumn<DateTime>(
    'joined_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [departmentId, memberId, joinedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'department_members';
  @override
  VerificationContext validateIntegrity(
    Insertable<DepartmentMemberRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('department_id')) {
      context.handle(
        _departmentIdMeta,
        departmentId.isAcceptableOrUnknown(
          data['department_id']!,
          _departmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_departmentIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('joined_at')) {
      context.handle(
        _joinedAtMeta,
        joinedAt.isAcceptableOrUnknown(data['joined_at']!, _joinedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {departmentId, memberId};
  @override
  DepartmentMemberRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DepartmentMemberRow(
      departmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      joinedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}joined_at'],
      )!,
    );
  }

  @override
  $DepartmentMembersTable createAlias(String alias) {
    return $DepartmentMembersTable(attachedDatabase, alias);
  }
}

class DepartmentMemberRow extends DataClass
    implements Insertable<DepartmentMemberRow> {
  final String departmentId;
  final String memberId;
  final DateTime joinedAt;
  const DepartmentMemberRow({
    required this.departmentId,
    required this.memberId,
    required this.joinedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['department_id'] = Variable<String>(departmentId);
    map['member_id'] = Variable<String>(memberId);
    map['joined_at'] = Variable<DateTime>(joinedAt);
    return map;
  }

  DepartmentMembersCompanion toCompanion(bool nullToAbsent) {
    return DepartmentMembersCompanion(
      departmentId: Value(departmentId),
      memberId: Value(memberId),
      joinedAt: Value(joinedAt),
    );
  }

  factory DepartmentMemberRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DepartmentMemberRow(
      departmentId: serializer.fromJson<String>(json['departmentId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      joinedAt: serializer.fromJson<DateTime>(json['joinedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'departmentId': serializer.toJson<String>(departmentId),
      'memberId': serializer.toJson<String>(memberId),
      'joinedAt': serializer.toJson<DateTime>(joinedAt),
    };
  }

  DepartmentMemberRow copyWith({
    String? departmentId,
    String? memberId,
    DateTime? joinedAt,
  }) => DepartmentMemberRow(
    departmentId: departmentId ?? this.departmentId,
    memberId: memberId ?? this.memberId,
    joinedAt: joinedAt ?? this.joinedAt,
  );
  DepartmentMemberRow copyWithCompanion(DepartmentMembersCompanion data) {
    return DepartmentMemberRow(
      departmentId: data.departmentId.present
          ? data.departmentId.value
          : this.departmentId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      joinedAt: data.joinedAt.present ? data.joinedAt.value : this.joinedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentMemberRow(')
          ..write('departmentId: $departmentId, ')
          ..write('memberId: $memberId, ')
          ..write('joinedAt: $joinedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(departmentId, memberId, joinedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DepartmentMemberRow &&
          other.departmentId == this.departmentId &&
          other.memberId == this.memberId &&
          other.joinedAt == this.joinedAt);
}

class DepartmentMembersCompanion extends UpdateCompanion<DepartmentMemberRow> {
  final Value<String> departmentId;
  final Value<String> memberId;
  final Value<DateTime> joinedAt;
  final Value<int> rowid;
  const DepartmentMembersCompanion({
    this.departmentId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.joinedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DepartmentMembersCompanion.insert({
    required String departmentId,
    required String memberId,
    this.joinedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : departmentId = Value(departmentId),
       memberId = Value(memberId);
  static Insertable<DepartmentMemberRow> custom({
    Expression<String>? departmentId,
    Expression<String>? memberId,
    Expression<DateTime>? joinedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (departmentId != null) 'department_id': departmentId,
      if (memberId != null) 'member_id': memberId,
      if (joinedAt != null) 'joined_at': joinedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DepartmentMembersCompanion copyWith({
    Value<String>? departmentId,
    Value<String>? memberId,
    Value<DateTime>? joinedAt,
    Value<int>? rowid,
  }) {
    return DepartmentMembersCompanion(
      departmentId: departmentId ?? this.departmentId,
      memberId: memberId ?? this.memberId,
      joinedAt: joinedAt ?? this.joinedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (departmentId.present) {
      map['department_id'] = Variable<String>(departmentId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (joinedAt.present) {
      map['joined_at'] = Variable<DateTime>(joinedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepartmentMembersCompanion(')
          ..write('departmentId: $departmentId, ')
          ..write('memberId: $memberId, ')
          ..write('joinedAt: $joinedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserAccountsTable extends UserAccounts
    with TableInfo<$UserAccountsTable, UserAccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAccountsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
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
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordSaltMeta = const VerificationMeta(
    'passwordSalt',
  );
  @override
  late final GeneratedColumn<String> passwordSalt = GeneratedColumn<String>(
    'password_salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _departmentIdMeta = const VerificationMeta(
    'departmentId',
  );
  @override
  late final GeneratedColumn<String> departmentId = GeneratedColumn<String>(
    'department_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES departments (id)',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _canSeeAllBranchesMeta = const VerificationMeta(
    'canSeeAllBranches',
  );
  @override
  late final GeneratedColumn<bool> canSeeAllBranches = GeneratedColumn<bool>(
    'can_see_all_branches',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("can_see_all_branches" IN (0, 1))',
    ),
  );
  static const VerificationMeta _lastActiveAtMeta = const VerificationMeta(
    'lastActiveAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastActiveAt = GeneratedColumn<DateTime>(
    'last_active_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mustChangePasswordMeta =
      const VerificationMeta('mustChangePassword');
  @override
  late final GeneratedColumn<bool> mustChangePassword = GeneratedColumn<bool>(
    'must_change_password',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("must_change_password" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    username,
    passwordHash,
    passwordSalt,
    role,
    status,
    branchId,
    departmentId,
    memberId,
    canSeeAllBranches,
    lastActiveAt,
    mustChangePassword,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
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
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
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
    if (data.containsKey('password_salt')) {
      context.handle(
        _passwordSaltMeta,
        passwordSalt.isAcceptableOrUnknown(
          data['password_salt']!,
          _passwordSaltMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_passwordSaltMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('department_id')) {
      context.handle(
        _departmentIdMeta,
        departmentId.isAcceptableOrUnknown(
          data['department_id']!,
          _departmentIdMeta,
        ),
      );
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('can_see_all_branches')) {
      context.handle(
        _canSeeAllBranchesMeta,
        canSeeAllBranches.isAcceptableOrUnknown(
          data['can_see_all_branches']!,
          _canSeeAllBranchesMeta,
        ),
      );
    }
    if (data.containsKey('last_active_at')) {
      context.handle(
        _lastActiveAtMeta,
        lastActiveAt.isAcceptableOrUnknown(
          data['last_active_at']!,
          _lastActiveAtMeta,
        ),
      );
    }
    if (data.containsKey('must_change_password')) {
      context.handle(
        _mustChangePasswordMeta,
        mustChangePassword.isAcceptableOrUnknown(
          data['must_change_password']!,
          _mustChangePasswordMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserAccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAccountRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      )!,
      passwordSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_salt'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      ),
      departmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department_id'],
      ),
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      ),
      canSeeAllBranches: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}can_see_all_branches'],
      ),
      lastActiveAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_active_at'],
      ),
      mustChangePassword: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}must_change_password'],
      )!,
    );
  }

  @override
  $UserAccountsTable createAlias(String alias) {
    return $UserAccountsTable(attachedDatabase, alias);
  }
}

class UserAccountRow extends DataClass implements Insertable<UserAccountRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String name;

  /// The sign-in name. Lower-cased at write time, and unique.
  ///
  /// A username rather than an email address: a church office is not a place
  /// where everyone has a work email, and asking for one to log in excludes the
  /// people most likely to be using this. The consequence is that there is no
  /// address to send a password reset to, so a Super Admin resets passwords
  /// from Roles & Access instead.
  final String username;

  /// PBKDF2-derived, never the plain password. See `lib/db/password.dart`.
  final String passwordHash;
  final String passwordSalt;
  final String role;
  final String status;

  /// Null for church-wide roles that span every branch.
  final String? branchId;

  /// Set for department heads and volunteers.
  final String? departmentId;

  /// Links the account to a member record where one exists.
  final String? memberId;

  /// Cross-branch visibility, granted per account.
  ///
  /// Null means "inherit the role default", which is church-wide only for
  /// Super Admin. Storing the grant here rather than deriving it from the role
  /// is what lets one Senior Pastor see every branch while another does not.
  final bool? canSeeAllBranches;
  final DateTime? lastActiveAt;

  /// Forces a password change on next sign-in.
  final bool mustChangePassword;
  const UserAccountRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.name,
    required this.username,
    required this.passwordHash,
    required this.passwordSalt,
    required this.role,
    required this.status,
    this.branchId,
    this.departmentId,
    this.memberId,
    this.canSeeAllBranches,
    this.lastActiveAt,
    required this.mustChangePassword,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['username'] = Variable<String>(username);
    map['password_hash'] = Variable<String>(passwordHash);
    map['password_salt'] = Variable<String>(passwordSalt);
    map['role'] = Variable<String>(role);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    if (!nullToAbsent || departmentId != null) {
      map['department_id'] = Variable<String>(departmentId);
    }
    if (!nullToAbsent || memberId != null) {
      map['member_id'] = Variable<String>(memberId);
    }
    if (!nullToAbsent || canSeeAllBranches != null) {
      map['can_see_all_branches'] = Variable<bool>(canSeeAllBranches);
    }
    if (!nullToAbsent || lastActiveAt != null) {
      map['last_active_at'] = Variable<DateTime>(lastActiveAt);
    }
    map['must_change_password'] = Variable<bool>(mustChangePassword);
    return map;
  }

  UserAccountsCompanion toCompanion(bool nullToAbsent) {
    return UserAccountsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      name: Value(name),
      username: Value(username),
      passwordHash: Value(passwordHash),
      passwordSalt: Value(passwordSalt),
      role: Value(role),
      status: Value(status),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      departmentId: departmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(departmentId),
      memberId: memberId == null && nullToAbsent
          ? const Value.absent()
          : Value(memberId),
      canSeeAllBranches: canSeeAllBranches == null && nullToAbsent
          ? const Value.absent()
          : Value(canSeeAllBranches),
      lastActiveAt: lastActiveAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastActiveAt),
      mustChangePassword: Value(mustChangePassword),
    );
  }

  factory UserAccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAccountRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      username: serializer.fromJson<String>(json['username']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      passwordSalt: serializer.fromJson<String>(json['passwordSalt']),
      role: serializer.fromJson<String>(json['role']),
      status: serializer.fromJson<String>(json['status']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      departmentId: serializer.fromJson<String?>(json['departmentId']),
      memberId: serializer.fromJson<String?>(json['memberId']),
      canSeeAllBranches: serializer.fromJson<bool?>(json['canSeeAllBranches']),
      lastActiveAt: serializer.fromJson<DateTime?>(json['lastActiveAt']),
      mustChangePassword: serializer.fromJson<bool>(json['mustChangePassword']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'username': serializer.toJson<String>(username),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'passwordSalt': serializer.toJson<String>(passwordSalt),
      'role': serializer.toJson<String>(role),
      'status': serializer.toJson<String>(status),
      'branchId': serializer.toJson<String?>(branchId),
      'departmentId': serializer.toJson<String?>(departmentId),
      'memberId': serializer.toJson<String?>(memberId),
      'canSeeAllBranches': serializer.toJson<bool?>(canSeeAllBranches),
      'lastActiveAt': serializer.toJson<DateTime?>(lastActiveAt),
      'mustChangePassword': serializer.toJson<bool>(mustChangePassword),
    };
  }

  UserAccountRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? name,
    String? username,
    String? passwordHash,
    String? passwordSalt,
    String? role,
    String? status,
    Value<String?> branchId = const Value.absent(),
    Value<String?> departmentId = const Value.absent(),
    Value<String?> memberId = const Value.absent(),
    Value<bool?> canSeeAllBranches = const Value.absent(),
    Value<DateTime?> lastActiveAt = const Value.absent(),
    bool? mustChangePassword,
  }) => UserAccountRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    name: name ?? this.name,
    username: username ?? this.username,
    passwordHash: passwordHash ?? this.passwordHash,
    passwordSalt: passwordSalt ?? this.passwordSalt,
    role: role ?? this.role,
    status: status ?? this.status,
    branchId: branchId.present ? branchId.value : this.branchId,
    departmentId: departmentId.present ? departmentId.value : this.departmentId,
    memberId: memberId.present ? memberId.value : this.memberId,
    canSeeAllBranches: canSeeAllBranches.present
        ? canSeeAllBranches.value
        : this.canSeeAllBranches,
    lastActiveAt: lastActiveAt.present ? lastActiveAt.value : this.lastActiveAt,
    mustChangePassword: mustChangePassword ?? this.mustChangePassword,
  );
  UserAccountRow copyWithCompanion(UserAccountsCompanion data) {
    return UserAccountRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      username: data.username.present ? data.username.value : this.username,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      passwordSalt: data.passwordSalt.present
          ? data.passwordSalt.value
          : this.passwordSalt,
      role: data.role.present ? data.role.value : this.role,
      status: data.status.present ? data.status.value : this.status,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      departmentId: data.departmentId.present
          ? data.departmentId.value
          : this.departmentId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      canSeeAllBranches: data.canSeeAllBranches.present
          ? data.canSeeAllBranches.value
          : this.canSeeAllBranches,
      lastActiveAt: data.lastActiveAt.present
          ? data.lastActiveAt.value
          : this.lastActiveAt,
      mustChangePassword: data.mustChangePassword.present
          ? data.mustChangePassword.value
          : this.mustChangePassword,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAccountRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('branchId: $branchId, ')
          ..write('departmentId: $departmentId, ')
          ..write('memberId: $memberId, ')
          ..write('canSeeAllBranches: $canSeeAllBranches, ')
          ..write('lastActiveAt: $lastActiveAt, ')
          ..write('mustChangePassword: $mustChangePassword')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    name,
    username,
    passwordHash,
    passwordSalt,
    role,
    status,
    branchId,
    departmentId,
    memberId,
    canSeeAllBranches,
    lastActiveAt,
    mustChangePassword,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAccountRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.name == this.name &&
          other.username == this.username &&
          other.passwordHash == this.passwordHash &&
          other.passwordSalt == this.passwordSalt &&
          other.role == this.role &&
          other.status == this.status &&
          other.branchId == this.branchId &&
          other.departmentId == this.departmentId &&
          other.memberId == this.memberId &&
          other.canSeeAllBranches == this.canSeeAllBranches &&
          other.lastActiveAt == this.lastActiveAt &&
          other.mustChangePassword == this.mustChangePassword);
}

class UserAccountsCompanion extends UpdateCompanion<UserAccountRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> name;
  final Value<String> username;
  final Value<String> passwordHash;
  final Value<String> passwordSalt;
  final Value<String> role;
  final Value<String> status;
  final Value<String?> branchId;
  final Value<String?> departmentId;
  final Value<String?> memberId;
  final Value<bool?> canSeeAllBranches;
  final Value<DateTime?> lastActiveAt;
  final Value<bool> mustChangePassword;
  final Value<int> rowid;
  const UserAccountsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.username = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.passwordSalt = const Value.absent(),
    this.role = const Value.absent(),
    this.status = const Value.absent(),
    this.branchId = const Value.absent(),
    this.departmentId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.canSeeAllBranches = const Value.absent(),
    this.lastActiveAt = const Value.absent(),
    this.mustChangePassword = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAccountsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String name,
    required String username,
    required String passwordHash,
    required String passwordSalt,
    required String role,
    required String status,
    this.branchId = const Value.absent(),
    this.departmentId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.canSeeAllBranches = const Value.absent(),
    this.lastActiveAt = const Value.absent(),
    this.mustChangePassword = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       username = Value(username),
       passwordHash = Value(passwordHash),
       passwordSalt = Value(passwordSalt),
       role = Value(role),
       status = Value(status);
  static Insertable<UserAccountRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? username,
    Expression<String>? passwordHash,
    Expression<String>? passwordSalt,
    Expression<String>? role,
    Expression<String>? status,
    Expression<String>? branchId,
    Expression<String>? departmentId,
    Expression<String>? memberId,
    Expression<bool>? canSeeAllBranches,
    Expression<DateTime>? lastActiveAt,
    Expression<bool>? mustChangePassword,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (username != null) 'username': username,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (passwordSalt != null) 'password_salt': passwordSalt,
      if (role != null) 'role': role,
      if (status != null) 'status': status,
      if (branchId != null) 'branch_id': branchId,
      if (departmentId != null) 'department_id': departmentId,
      if (memberId != null) 'member_id': memberId,
      if (canSeeAllBranches != null) 'can_see_all_branches': canSeeAllBranches,
      if (lastActiveAt != null) 'last_active_at': lastActiveAt,
      if (mustChangePassword != null)
        'must_change_password': mustChangePassword,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAccountsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? name,
    Value<String>? username,
    Value<String>? passwordHash,
    Value<String>? passwordSalt,
    Value<String>? role,
    Value<String>? status,
    Value<String?>? branchId,
    Value<String?>? departmentId,
    Value<String?>? memberId,
    Value<bool?>? canSeeAllBranches,
    Value<DateTime?>? lastActiveAt,
    Value<bool>? mustChangePassword,
    Value<int>? rowid,
  }) {
    return UserAccountsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      passwordSalt: passwordSalt ?? this.passwordSalt,
      role: role ?? this.role,
      status: status ?? this.status,
      branchId: branchId ?? this.branchId,
      departmentId: departmentId ?? this.departmentId,
      memberId: memberId ?? this.memberId,
      canSeeAllBranches: canSeeAllBranches ?? this.canSeeAllBranches,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      mustChangePassword: mustChangePassword ?? this.mustChangePassword,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (passwordSalt.present) {
      map['password_salt'] = Variable<String>(passwordSalt.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (departmentId.present) {
      map['department_id'] = Variable<String>(departmentId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (canSeeAllBranches.present) {
      map['can_see_all_branches'] = Variable<bool>(canSeeAllBranches.value);
    }
    if (lastActiveAt.present) {
      map['last_active_at'] = Variable<DateTime>(lastActiveAt.value);
    }
    if (mustChangePassword.present) {
      map['must_change_password'] = Variable<bool>(mustChangePassword.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAccountsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('username: $username, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('passwordSalt: $passwordSalt, ')
          ..write('role: $role, ')
          ..write('status: $status, ')
          ..write('branchId: $branchId, ')
          ..write('departmentId: $departmentId, ')
          ..write('memberId: $memberId, ')
          ..write('canSeeAllBranches: $canSeeAllBranches, ')
          ..write('lastActiveAt: $lastActiveAt, ')
          ..write('mustChangePassword: $mustChangePassword, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttendanceRecordsTable extends AttendanceRecords
    with TableInfo<$AttendanceRecordsTable, AttendanceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceNameMeta = const VerificationMeta(
    'serviceName',
  );
  @override
  late final GeneratedColumn<String> serviceName = GeneratedColumn<String>(
    'service_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _adultsMeta = const VerificationMeta('adults');
  @override
  late final GeneratedColumn<int> adults = GeneratedColumn<int>(
    'adults',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _childrenMeta = const VerificationMeta(
    'children',
  );
  @override
  late final GeneratedColumn<int> children = GeneratedColumn<int>(
    'children',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _visitorsMeta = const VerificationMeta(
    'visitors',
  );
  @override
  late final GeneratedColumn<int> visitors = GeneratedColumn<int>(
    'visitors',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _onlineMeta = const VerificationMeta('online');
  @override
  late final GeneratedColumn<int> online = GeneratedColumn<int>(
    'online',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    date,
    serviceName,
    adults,
    children,
    visitors,
    online,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('service_name')) {
      context.handle(
        _serviceNameMeta,
        serviceName.isAcceptableOrUnknown(
          data['service_name']!,
          _serviceNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceNameMeta);
    }
    if (data.containsKey('adults')) {
      context.handle(
        _adultsMeta,
        adults.isAcceptableOrUnknown(data['adults']!, _adultsMeta),
      );
    }
    if (data.containsKey('children')) {
      context.handle(
        _childrenMeta,
        children.isAcceptableOrUnknown(data['children']!, _childrenMeta),
      );
    }
    if (data.containsKey('visitors')) {
      context.handle(
        _visitorsMeta,
        visitors.isAcceptableOrUnknown(data['visitors']!, _visitorsMeta),
      );
    }
    if (data.containsKey('online')) {
      context.handle(
        _onlineMeta,
        online.isAcceptableOrUnknown(data['online']!, _onlineMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttendanceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      serviceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_name'],
      )!,
      adults: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}adults'],
      )!,
      children: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}children'],
      )!,
      visitors: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}visitors'],
      )!,
      online: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}online'],
      )!,
    );
  }

  @override
  $AttendanceRecordsTable createAlias(String alias) {
    return $AttendanceRecordsTable(attachedDatabase, alias);
  }
}

class AttendanceRow extends DataClass implements Insertable<AttendanceRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final DateTime date;
  final String serviceName;
  final int adults;
  final int children;
  final int visitors;
  final int online;
  const AttendanceRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.date,
    required this.serviceName,
    required this.adults,
    required this.children,
    required this.visitors,
    required this.online,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['date'] = Variable<DateTime>(date);
    map['service_name'] = Variable<String>(serviceName);
    map['adults'] = Variable<int>(adults);
    map['children'] = Variable<int>(children);
    map['visitors'] = Variable<int>(visitors);
    map['online'] = Variable<int>(online);
    return map;
  }

  AttendanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceRecordsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      date: Value(date),
      serviceName: Value(serviceName),
      adults: Value(adults),
      children: Value(children),
      visitors: Value(visitors),
      online: Value(online),
    );
  }

  factory AttendanceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      date: serializer.fromJson<DateTime>(json['date']),
      serviceName: serializer.fromJson<String>(json['serviceName']),
      adults: serializer.fromJson<int>(json['adults']),
      children: serializer.fromJson<int>(json['children']),
      visitors: serializer.fromJson<int>(json['visitors']),
      online: serializer.fromJson<int>(json['online']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'date': serializer.toJson<DateTime>(date),
      'serviceName': serializer.toJson<String>(serviceName),
      'adults': serializer.toJson<int>(adults),
      'children': serializer.toJson<int>(children),
      'visitors': serializer.toJson<int>(visitors),
      'online': serializer.toJson<int>(online),
    };
  }

  AttendanceRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    DateTime? date,
    String? serviceName,
    int? adults,
    int? children,
    int? visitors,
    int? online,
  }) => AttendanceRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    date: date ?? this.date,
    serviceName: serviceName ?? this.serviceName,
    adults: adults ?? this.adults,
    children: children ?? this.children,
    visitors: visitors ?? this.visitors,
    online: online ?? this.online,
  );
  AttendanceRow copyWithCompanion(AttendanceRecordsCompanion data) {
    return AttendanceRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      date: data.date.present ? data.date.value : this.date,
      serviceName: data.serviceName.present
          ? data.serviceName.value
          : this.serviceName,
      adults: data.adults.present ? data.adults.value : this.adults,
      children: data.children.present ? data.children.value : this.children,
      visitors: data.visitors.present ? data.visitors.value : this.visitors,
      online: data.online.present ? data.online.value : this.online,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('date: $date, ')
          ..write('serviceName: $serviceName, ')
          ..write('adults: $adults, ')
          ..write('children: $children, ')
          ..write('visitors: $visitors, ')
          ..write('online: $online')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    date,
    serviceName,
    adults,
    children,
    visitors,
    online,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.date == this.date &&
          other.serviceName == this.serviceName &&
          other.adults == this.adults &&
          other.children == this.children &&
          other.visitors == this.visitors &&
          other.online == this.online);
}

class AttendanceRecordsCompanion extends UpdateCompanion<AttendanceRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<DateTime> date;
  final Value<String> serviceName;
  final Value<int> adults;
  final Value<int> children;
  final Value<int> visitors;
  final Value<int> online;
  final Value<int> rowid;
  const AttendanceRecordsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.date = const Value.absent(),
    this.serviceName = const Value.absent(),
    this.adults = const Value.absent(),
    this.children = const Value.absent(),
    this.visitors = const Value.absent(),
    this.online = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttendanceRecordsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required DateTime date,
    required String serviceName,
    this.adults = const Value.absent(),
    this.children = const Value.absent(),
    this.visitors = const Value.absent(),
    this.online = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       date = Value(date),
       serviceName = Value(serviceName);
  static Insertable<AttendanceRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<DateTime>? date,
    Expression<String>? serviceName,
    Expression<int>? adults,
    Expression<int>? children,
    Expression<int>? visitors,
    Expression<int>? online,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (date != null) 'date': date,
      if (serviceName != null) 'service_name': serviceName,
      if (adults != null) 'adults': adults,
      if (children != null) 'children': children,
      if (visitors != null) 'visitors': visitors,
      if (online != null) 'online': online,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttendanceRecordsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<DateTime>? date,
    Value<String>? serviceName,
    Value<int>? adults,
    Value<int>? children,
    Value<int>? visitors,
    Value<int>? online,
    Value<int>? rowid,
  }) {
    return AttendanceRecordsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      date: date ?? this.date,
      serviceName: serviceName ?? this.serviceName,
      adults: adults ?? this.adults,
      children: children ?? this.children,
      visitors: visitors ?? this.visitors,
      online: online ?? this.online,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (serviceName.present) {
      map['service_name'] = Variable<String>(serviceName.value);
    }
    if (adults.present) {
      map['adults'] = Variable<int>(adults.value);
    }
    if (children.present) {
      map['children'] = Variable<int>(children.value);
    }
    if (visitors.present) {
      map['visitors'] = Variable<int>(visitors.value);
    }
    if (online.present) {
      map['online'] = Variable<int>(online.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecordsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('date: $date, ')
          ..write('serviceName: $serviceName, ')
          ..write('adults: $adults, ')
          ..write('children: $children, ')
          ..write('visitors: $visitors, ')
          ..write('online: $online, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CheckInsTable extends CheckIns
    with TableInfo<$CheckInsTable, CheckInRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _attendanceIdMeta = const VerificationMeta(
    'attendanceId',
  );
  @override
  late final GeneratedColumn<String> attendanceId = GeneratedColumn<String>(
    'attendance_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES attendance_records (id)',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _checkedInAtMeta = const VerificationMeta(
    'checkedInAt',
  );
  @override
  late final GeneratedColumn<DateTime> checkedInAt = GeneratedColumn<DateTime>(
    'checked_in_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [attendanceId, memberId, checkedInAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<CheckInRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('attendance_id')) {
      context.handle(
        _attendanceIdMeta,
        attendanceId.isAcceptableOrUnknown(
          data['attendance_id']!,
          _attendanceIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attendanceIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('checked_in_at')) {
      context.handle(
        _checkedInAtMeta,
        checkedInAt.isAcceptableOrUnknown(
          data['checked_in_at']!,
          _checkedInAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {attendanceId, memberId};
  @override
  CheckInRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CheckInRow(
      attendanceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attendance_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      checkedInAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}checked_in_at'],
      )!,
    );
  }

  @override
  $CheckInsTable createAlias(String alias) {
    return $CheckInsTable(attachedDatabase, alias);
  }
}

class CheckInRow extends DataClass implements Insertable<CheckInRow> {
  final String attendanceId;
  final String memberId;
  final DateTime checkedInAt;
  const CheckInRow({
    required this.attendanceId,
    required this.memberId,
    required this.checkedInAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['attendance_id'] = Variable<String>(attendanceId);
    map['member_id'] = Variable<String>(memberId);
    map['checked_in_at'] = Variable<DateTime>(checkedInAt);
    return map;
  }

  CheckInsCompanion toCompanion(bool nullToAbsent) {
    return CheckInsCompanion(
      attendanceId: Value(attendanceId),
      memberId: Value(memberId),
      checkedInAt: Value(checkedInAt),
    );
  }

  factory CheckInRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CheckInRow(
      attendanceId: serializer.fromJson<String>(json['attendanceId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      checkedInAt: serializer.fromJson<DateTime>(json['checkedInAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'attendanceId': serializer.toJson<String>(attendanceId),
      'memberId': serializer.toJson<String>(memberId),
      'checkedInAt': serializer.toJson<DateTime>(checkedInAt),
    };
  }

  CheckInRow copyWith({
    String? attendanceId,
    String? memberId,
    DateTime? checkedInAt,
  }) => CheckInRow(
    attendanceId: attendanceId ?? this.attendanceId,
    memberId: memberId ?? this.memberId,
    checkedInAt: checkedInAt ?? this.checkedInAt,
  );
  CheckInRow copyWithCompanion(CheckInsCompanion data) {
    return CheckInRow(
      attendanceId: data.attendanceId.present
          ? data.attendanceId.value
          : this.attendanceId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      checkedInAt: data.checkedInAt.present
          ? data.checkedInAt.value
          : this.checkedInAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CheckInRow(')
          ..write('attendanceId: $attendanceId, ')
          ..write('memberId: $memberId, ')
          ..write('checkedInAt: $checkedInAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(attendanceId, memberId, checkedInAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CheckInRow &&
          other.attendanceId == this.attendanceId &&
          other.memberId == this.memberId &&
          other.checkedInAt == this.checkedInAt);
}

class CheckInsCompanion extends UpdateCompanion<CheckInRow> {
  final Value<String> attendanceId;
  final Value<String> memberId;
  final Value<DateTime> checkedInAt;
  final Value<int> rowid;
  const CheckInsCompanion({
    this.attendanceId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.checkedInAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CheckInsCompanion.insert({
    required String attendanceId,
    required String memberId,
    this.checkedInAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : attendanceId = Value(attendanceId),
       memberId = Value(memberId);
  static Insertable<CheckInRow> custom({
    Expression<String>? attendanceId,
    Expression<String>? memberId,
    Expression<DateTime>? checkedInAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (attendanceId != null) 'attendance_id': attendanceId,
      if (memberId != null) 'member_id': memberId,
      if (checkedInAt != null) 'checked_in_at': checkedInAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CheckInsCompanion copyWith({
    Value<String>? attendanceId,
    Value<String>? memberId,
    Value<DateTime>? checkedInAt,
    Value<int>? rowid,
  }) {
    return CheckInsCompanion(
      attendanceId: attendanceId ?? this.attendanceId,
      memberId: memberId ?? this.memberId,
      checkedInAt: checkedInAt ?? this.checkedInAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (attendanceId.present) {
      map['attendance_id'] = Variable<String>(attendanceId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (checkedInAt.present) {
      map['checked_in_at'] = Variable<DateTime>(checkedInAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CheckInsCompanion(')
          ..write('attendanceId: $attendanceId, ')
          ..write('memberId: $memberId, ')
          ..write('checkedInAt: $checkedInAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DonationsTable extends Donations
    with TableInfo<$DonationsTable, DonationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DonationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _donorNameMeta = const VerificationMeta(
    'donorName',
  );
  @override
  late final GeneratedColumn<String> donorName = GeneratedColumn<String>(
    'donor_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fundMeta = const VerificationMeta('fund');
  @override
  late final GeneratedColumn<String> fund = GeneratedColumn<String>(
    'fund',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    memberId,
    donorName,
    amount,
    fund,
    method,
    date,
    reference,
    isRecurring,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'donations';
  @override
  VerificationContext validateIntegrity(
    Insertable<DonationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('donor_name')) {
      context.handle(
        _donorNameMeta,
        donorName.isAcceptableOrUnknown(data['donor_name']!, _donorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_donorNameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('fund')) {
      context.handle(
        _fundMeta,
        fund.isAcceptableOrUnknown(data['fund']!, _fundMeta),
      );
    } else if (isInserting) {
      context.missing(_fundMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DonationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DonationRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      ),
      donorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}donor_name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      fund: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fund'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      )!,
      isRecurring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recurring'],
      )!,
    );
  }

  @override
  $DonationsTable createAlias(String alias) {
    return $DonationsTable(attachedDatabase, alias);
  }
}

class DonationRow extends DataClass implements Insertable<DonationRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String? memberId;
  final String donorName;
  final double amount;
  final String fund;
  final String method;
  final DateTime date;
  final String reference;
  final bool isRecurring;
  const DonationRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    this.memberId,
    required this.donorName,
    required this.amount,
    required this.fund,
    required this.method,
    required this.date,
    required this.reference,
    required this.isRecurring,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    if (!nullToAbsent || memberId != null) {
      map['member_id'] = Variable<String>(memberId);
    }
    map['donor_name'] = Variable<String>(donorName);
    map['amount'] = Variable<double>(amount);
    map['fund'] = Variable<String>(fund);
    map['method'] = Variable<String>(method);
    map['date'] = Variable<DateTime>(date);
    map['reference'] = Variable<String>(reference);
    map['is_recurring'] = Variable<bool>(isRecurring);
    return map;
  }

  DonationsCompanion toCompanion(bool nullToAbsent) {
    return DonationsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      memberId: memberId == null && nullToAbsent
          ? const Value.absent()
          : Value(memberId),
      donorName: Value(donorName),
      amount: Value(amount),
      fund: Value(fund),
      method: Value(method),
      date: Value(date),
      reference: Value(reference),
      isRecurring: Value(isRecurring),
    );
  }

  factory DonationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DonationRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      memberId: serializer.fromJson<String?>(json['memberId']),
      donorName: serializer.fromJson<String>(json['donorName']),
      amount: serializer.fromJson<double>(json['amount']),
      fund: serializer.fromJson<String>(json['fund']),
      method: serializer.fromJson<String>(json['method']),
      date: serializer.fromJson<DateTime>(json['date']),
      reference: serializer.fromJson<String>(json['reference']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'memberId': serializer.toJson<String?>(memberId),
      'donorName': serializer.toJson<String>(donorName),
      'amount': serializer.toJson<double>(amount),
      'fund': serializer.toJson<String>(fund),
      'method': serializer.toJson<String>(method),
      'date': serializer.toJson<DateTime>(date),
      'reference': serializer.toJson<String>(reference),
      'isRecurring': serializer.toJson<bool>(isRecurring),
    };
  }

  DonationRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    Value<String?> memberId = const Value.absent(),
    String? donorName,
    double? amount,
    String? fund,
    String? method,
    DateTime? date,
    String? reference,
    bool? isRecurring,
  }) => DonationRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    memberId: memberId.present ? memberId.value : this.memberId,
    donorName: donorName ?? this.donorName,
    amount: amount ?? this.amount,
    fund: fund ?? this.fund,
    method: method ?? this.method,
    date: date ?? this.date,
    reference: reference ?? this.reference,
    isRecurring: isRecurring ?? this.isRecurring,
  );
  DonationRow copyWithCompanion(DonationsCompanion data) {
    return DonationRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      donorName: data.donorName.present ? data.donorName.value : this.donorName,
      amount: data.amount.present ? data.amount.value : this.amount,
      fund: data.fund.present ? data.fund.value : this.fund,
      method: data.method.present ? data.method.value : this.method,
      date: data.date.present ? data.date.value : this.date,
      reference: data.reference.present ? data.reference.value : this.reference,
      isRecurring: data.isRecurring.present
          ? data.isRecurring.value
          : this.isRecurring,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DonationRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('memberId: $memberId, ')
          ..write('donorName: $donorName, ')
          ..write('amount: $amount, ')
          ..write('fund: $fund, ')
          ..write('method: $method, ')
          ..write('date: $date, ')
          ..write('reference: $reference, ')
          ..write('isRecurring: $isRecurring')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    memberId,
    donorName,
    amount,
    fund,
    method,
    date,
    reference,
    isRecurring,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DonationRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.memberId == this.memberId &&
          other.donorName == this.donorName &&
          other.amount == this.amount &&
          other.fund == this.fund &&
          other.method == this.method &&
          other.date == this.date &&
          other.reference == this.reference &&
          other.isRecurring == this.isRecurring);
}

class DonationsCompanion extends UpdateCompanion<DonationRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String?> memberId;
  final Value<String> donorName;
  final Value<double> amount;
  final Value<String> fund;
  final Value<String> method;
  final Value<DateTime> date;
  final Value<String> reference;
  final Value<bool> isRecurring;
  final Value<int> rowid;
  const DonationsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.donorName = const Value.absent(),
    this.amount = const Value.absent(),
    this.fund = const Value.absent(),
    this.method = const Value.absent(),
    this.date = const Value.absent(),
    this.reference = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DonationsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    this.memberId = const Value.absent(),
    required String donorName,
    required double amount,
    required String fund,
    required String method,
    required DateTime date,
    required String reference,
    this.isRecurring = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       donorName = Value(donorName),
       amount = Value(amount),
       fund = Value(fund),
       method = Value(method),
       date = Value(date),
       reference = Value(reference);
  static Insertable<DonationRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? memberId,
    Expression<String>? donorName,
    Expression<double>? amount,
    Expression<String>? fund,
    Expression<String>? method,
    Expression<DateTime>? date,
    Expression<String>? reference,
    Expression<bool>? isRecurring,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (memberId != null) 'member_id': memberId,
      if (donorName != null) 'donor_name': donorName,
      if (amount != null) 'amount': amount,
      if (fund != null) 'fund': fund,
      if (method != null) 'method': method,
      if (date != null) 'date': date,
      if (reference != null) 'reference': reference,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DonationsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String?>? memberId,
    Value<String>? donorName,
    Value<double>? amount,
    Value<String>? fund,
    Value<String>? method,
    Value<DateTime>? date,
    Value<String>? reference,
    Value<bool>? isRecurring,
    Value<int>? rowid,
  }) {
    return DonationsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      memberId: memberId ?? this.memberId,
      donorName: donorName ?? this.donorName,
      amount: amount ?? this.amount,
      fund: fund ?? this.fund,
      method: method ?? this.method,
      date: date ?? this.date,
      reference: reference ?? this.reference,
      isRecurring: isRecurring ?? this.isRecurring,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (donorName.present) {
      map['donor_name'] = Variable<String>(donorName.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (fund.present) {
      map['fund'] = Variable<String>(fund.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DonationsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('memberId: $memberId, ')
          ..write('donorName: $donorName, ')
          ..write('amount: $amount, ')
          ..write('fund: $fund, ')
          ..write('method: $method, ')
          ..write('date: $date, ')
          ..write('reference: $reference, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses
    with TableInfo<$ExpensesTable, ExpenseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vendorMeta = const VerificationMeta('vendor');
  @override
  late final GeneratedColumn<String> vendor = GeneratedColumn<String>(
    'vendor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _approvedByMeta = const VerificationMeta(
    'approvedBy',
  );
  @override
  late final GeneratedColumn<String> approvedBy = GeneratedColumn<String>(
    'approved_by',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    category,
    vendor,
    amount,
    date,
    approvedBy,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('vendor')) {
      context.handle(
        _vendorMeta,
        vendor.isAcceptableOrUnknown(data['vendor']!, _vendorMeta),
      );
    } else if (isInserting) {
      context.missing(_vendorMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('approved_by')) {
      context.handle(
        _approvedByMeta,
        approvedBy.isAcceptableOrUnknown(data['approved_by']!, _approvedByMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      vendor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vendor'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      approvedBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}approved_by'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class ExpenseRow extends DataClass implements Insertable<ExpenseRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String category;
  final String vendor;
  final double amount;
  final DateTime date;
  final String? approvedBy;
  final String status;
  const ExpenseRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.category,
    required this.vendor,
    required this.amount,
    required this.date,
    this.approvedBy,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['category'] = Variable<String>(category);
    map['vendor'] = Variable<String>(vendor);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || approvedBy != null) {
      map['approved_by'] = Variable<String>(approvedBy);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      category: Value(category),
      vendor: Value(vendor),
      amount: Value(amount),
      date: Value(date),
      approvedBy: approvedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedBy),
      status: Value(status),
    );
  }

  factory ExpenseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      category: serializer.fromJson<String>(json['category']),
      vendor: serializer.fromJson<String>(json['vendor']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      approvedBy: serializer.fromJson<String?>(json['approvedBy']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'category': serializer.toJson<String>(category),
      'vendor': serializer.toJson<String>(vendor),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'approvedBy': serializer.toJson<String?>(approvedBy),
      'status': serializer.toJson<String>(status),
    };
  }

  ExpenseRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? category,
    String? vendor,
    double? amount,
    DateTime? date,
    Value<String?> approvedBy = const Value.absent(),
    String? status,
  }) => ExpenseRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    category: category ?? this.category,
    vendor: vendor ?? this.vendor,
    amount: amount ?? this.amount,
    date: date ?? this.date,
    approvedBy: approvedBy.present ? approvedBy.value : this.approvedBy,
    status: status ?? this.status,
  );
  ExpenseRow copyWithCompanion(ExpensesCompanion data) {
    return ExpenseRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      category: data.category.present ? data.category.value : this.category,
      vendor: data.vendor.present ? data.vendor.value : this.vendor,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      approvedBy: data.approvedBy.present
          ? data.approvedBy.value
          : this.approvedBy,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('category: $category, ')
          ..write('vendor: $vendor, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    category,
    vendor,
    amount,
    date,
    approvedBy,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.category == this.category &&
          other.vendor == this.vendor &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.approvedBy == this.approvedBy &&
          other.status == this.status);
}

class ExpensesCompanion extends UpdateCompanion<ExpenseRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> category;
  final Value<String> vendor;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String?> approvedBy;
  final Value<String> status;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.category = const Value.absent(),
    this.vendor = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String category,
    required String vendor,
    required double amount,
    required DateTime date,
    this.approvedBy = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       category = Value(category),
       vendor = Value(vendor),
       amount = Value(amount),
       date = Value(date),
       status = Value(status);
  static Insertable<ExpenseRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? category,
    Expression<String>? vendor,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? approvedBy,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (category != null) 'category': category,
      if (vendor != null) 'vendor': vendor,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (approvedBy != null) 'approved_by': approvedBy,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? category,
    Value<String>? vendor,
    Value<double>? amount,
    Value<DateTime>? date,
    Value<String?>? approvedBy,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return ExpensesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      category: category ?? this.category,
      vendor: vendor ?? this.vendor,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      approvedBy: approvedBy ?? this.approvedBy,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (vendor.present) {
      map['vendor'] = Variable<String>(vendor.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<String>(approvedBy.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('category: $category, ')
          ..write('vendor: $vendor, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PledgesTable extends Pledges with TableInfo<$PledgesTable, PledgeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PledgesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _campaignMeta = const VerificationMeta(
    'campaign',
  );
  @override
  late final GeneratedColumn<String> campaign = GeneratedColumn<String>(
    'campaign',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pledgedMeta = const VerificationMeta(
    'pledged',
  );
  @override
  late final GeneratedColumn<double> pledged = GeneratedColumn<double>(
    'pledged',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fulfilledMeta = const VerificationMeta(
    'fulfilled',
  );
  @override
  late final GeneratedColumn<double> fulfilled = GeneratedColumn<double>(
    'fulfilled',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    memberId,
    campaign,
    pledged,
    fulfilled,
    dueDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pledges';
  @override
  VerificationContext validateIntegrity(
    Insertable<PledgeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('campaign')) {
      context.handle(
        _campaignMeta,
        campaign.isAcceptableOrUnknown(data['campaign']!, _campaignMeta),
      );
    } else if (isInserting) {
      context.missing(_campaignMeta);
    }
    if (data.containsKey('pledged')) {
      context.handle(
        _pledgedMeta,
        pledged.isAcceptableOrUnknown(data['pledged']!, _pledgedMeta),
      );
    } else if (isInserting) {
      context.missing(_pledgedMeta);
    }
    if (data.containsKey('fulfilled')) {
      context.handle(
        _fulfilledMeta,
        fulfilled.isAcceptableOrUnknown(data['fulfilled']!, _fulfilledMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PledgeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PledgeRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      campaign: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campaign'],
      )!,
      pledged: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pledged'],
      )!,
      fulfilled: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fulfilled'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
    );
  }

  @override
  $PledgesTable createAlias(String alias) {
    return $PledgesTable(attachedDatabase, alias);
  }
}

class PledgeRow extends DataClass implements Insertable<PledgeRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String memberId;
  final String campaign;
  final double pledged;
  final double fulfilled;
  final DateTime dueDate;
  const PledgeRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.memberId,
    required this.campaign,
    required this.pledged,
    required this.fulfilled,
    required this.dueDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['member_id'] = Variable<String>(memberId);
    map['campaign'] = Variable<String>(campaign);
    map['pledged'] = Variable<double>(pledged);
    map['fulfilled'] = Variable<double>(fulfilled);
    map['due_date'] = Variable<DateTime>(dueDate);
    return map;
  }

  PledgesCompanion toCompanion(bool nullToAbsent) {
    return PledgesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      memberId: Value(memberId),
      campaign: Value(campaign),
      pledged: Value(pledged),
      fulfilled: Value(fulfilled),
      dueDate: Value(dueDate),
    );
  }

  factory PledgeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PledgeRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      campaign: serializer.fromJson<String>(json['campaign']),
      pledged: serializer.fromJson<double>(json['pledged']),
      fulfilled: serializer.fromJson<double>(json['fulfilled']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'memberId': serializer.toJson<String>(memberId),
      'campaign': serializer.toJson<String>(campaign),
      'pledged': serializer.toJson<double>(pledged),
      'fulfilled': serializer.toJson<double>(fulfilled),
      'dueDate': serializer.toJson<DateTime>(dueDate),
    };
  }

  PledgeRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? memberId,
    String? campaign,
    double? pledged,
    double? fulfilled,
    DateTime? dueDate,
  }) => PledgeRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    memberId: memberId ?? this.memberId,
    campaign: campaign ?? this.campaign,
    pledged: pledged ?? this.pledged,
    fulfilled: fulfilled ?? this.fulfilled,
    dueDate: dueDate ?? this.dueDate,
  );
  PledgeRow copyWithCompanion(PledgesCompanion data) {
    return PledgeRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      campaign: data.campaign.present ? data.campaign.value : this.campaign,
      pledged: data.pledged.present ? data.pledged.value : this.pledged,
      fulfilled: data.fulfilled.present ? data.fulfilled.value : this.fulfilled,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PledgeRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('memberId: $memberId, ')
          ..write('campaign: $campaign, ')
          ..write('pledged: $pledged, ')
          ..write('fulfilled: $fulfilled, ')
          ..write('dueDate: $dueDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    memberId,
    campaign,
    pledged,
    fulfilled,
    dueDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PledgeRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.memberId == this.memberId &&
          other.campaign == this.campaign &&
          other.pledged == this.pledged &&
          other.fulfilled == this.fulfilled &&
          other.dueDate == this.dueDate);
}

class PledgesCompanion extends UpdateCompanion<PledgeRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> memberId;
  final Value<String> campaign;
  final Value<double> pledged;
  final Value<double> fulfilled;
  final Value<DateTime> dueDate;
  final Value<int> rowid;
  const PledgesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.campaign = const Value.absent(),
    this.pledged = const Value.absent(),
    this.fulfilled = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PledgesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String memberId,
    required String campaign,
    required double pledged,
    this.fulfilled = const Value.absent(),
    required DateTime dueDate,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       memberId = Value(memberId),
       campaign = Value(campaign),
       pledged = Value(pledged),
       dueDate = Value(dueDate);
  static Insertable<PledgeRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? memberId,
    Expression<String>? campaign,
    Expression<double>? pledged,
    Expression<double>? fulfilled,
    Expression<DateTime>? dueDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (memberId != null) 'member_id': memberId,
      if (campaign != null) 'campaign': campaign,
      if (pledged != null) 'pledged': pledged,
      if (fulfilled != null) 'fulfilled': fulfilled,
      if (dueDate != null) 'due_date': dueDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PledgesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? memberId,
    Value<String>? campaign,
    Value<double>? pledged,
    Value<double>? fulfilled,
    Value<DateTime>? dueDate,
    Value<int>? rowid,
  }) {
    return PledgesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      memberId: memberId ?? this.memberId,
      campaign: campaign ?? this.campaign,
      pledged: pledged ?? this.pledged,
      fulfilled: fulfilled ?? this.fulfilled,
      dueDate: dueDate ?? this.dueDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (campaign.present) {
      map['campaign'] = Variable<String>(campaign.value);
    }
    if (pledged.present) {
      map['pledged'] = Variable<double>(pledged.value);
    }
    if (fulfilled.present) {
      map['fulfilled'] = Variable<double>(fulfilled.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PledgesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('memberId: $memberId, ')
          ..write('campaign: $campaign, ')
          ..write('pledged: $pledged, ')
          ..write('fulfilled: $fulfilled, ')
          ..write('dueDate: $dueDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, EventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startsAtMeta = const VerificationMeta(
    'startsAt',
  );
  @override
  late final GeneratedColumn<DateTime> startsAt = GeneratedColumn<DateTime>(
    'starts_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endsAtMeta = const VerificationMeta('endsAt');
  @override
  late final GeneratedColumn<DateTime> endsAt = GeneratedColumn<DateTime>(
    'ends_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _organizerIdMeta = const VerificationMeta(
    'organizerId',
  );
  @override
  late final GeneratedColumn<String> organizerId = GeneratedColumn<String>(
    'organizer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedAttendanceMeta =
      const VerificationMeta('expectedAttendance');
  @override
  late final GeneratedColumn<int> expectedAttendance = GeneratedColumn<int>(
    'expected_attendance',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _registeredCountMeta = const VerificationMeta(
    'registeredCount',
  );
  @override
  late final GeneratedColumn<int> registeredCount = GeneratedColumn<int>(
    'registered_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isRecurringMeta = const VerificationMeta(
    'isRecurring',
  );
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
    'is_recurring',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_recurring" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    title,
    description,
    category,
    startsAt,
    endsAt,
    location,
    organizerId,
    expectedAttendance,
    registeredCount,
    isRecurring,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
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
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('starts_at')) {
      context.handle(
        _startsAtMeta,
        startsAt.isAcceptableOrUnknown(data['starts_at']!, _startsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startsAtMeta);
    }
    if (data.containsKey('ends_at')) {
      context.handle(
        _endsAtMeta,
        endsAt.isAcceptableOrUnknown(data['ends_at']!, _endsAtMeta),
      );
    } else if (isInserting) {
      context.missing(_endsAtMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('organizer_id')) {
      context.handle(
        _organizerIdMeta,
        organizerId.isAcceptableOrUnknown(
          data['organizer_id']!,
          _organizerIdMeta,
        ),
      );
    }
    if (data.containsKey('expected_attendance')) {
      context.handle(
        _expectedAttendanceMeta,
        expectedAttendance.isAcceptableOrUnknown(
          data['expected_attendance']!,
          _expectedAttendanceMeta,
        ),
      );
    }
    if (data.containsKey('registered_count')) {
      context.handle(
        _registeredCountMeta,
        registeredCount.isAcceptableOrUnknown(
          data['registered_count']!,
          _registeredCountMeta,
        ),
      );
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
        _isRecurringMeta,
        isRecurring.isAcceptableOrUnknown(
          data['is_recurring']!,
          _isRecurringMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      startsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}starts_at'],
      )!,
      endsAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ends_at'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      organizerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}organizer_id'],
      ),
      expectedAttendance: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}expected_attendance'],
      )!,
      registeredCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}registered_count'],
      )!,
      isRecurring: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_recurring'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class EventRow extends DataClass implements Insertable<EventRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String title;
  final String description;
  final String category;
  final DateTime startsAt;
  final DateTime endsAt;
  final String location;
  final String? organizerId;
  final int expectedAttendance;
  final int registeredCount;
  final bool isRecurring;
  const EventRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.title,
    required this.description,
    required this.category,
    required this.startsAt,
    required this.endsAt,
    required this.location,
    this.organizerId,
    required this.expectedAttendance,
    required this.registeredCount,
    required this.isRecurring,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['starts_at'] = Variable<DateTime>(startsAt);
    map['ends_at'] = Variable<DateTime>(endsAt);
    map['location'] = Variable<String>(location);
    if (!nullToAbsent || organizerId != null) {
      map['organizer_id'] = Variable<String>(organizerId);
    }
    map['expected_attendance'] = Variable<int>(expectedAttendance);
    map['registered_count'] = Variable<int>(registeredCount);
    map['is_recurring'] = Variable<bool>(isRecurring);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      title: Value(title),
      description: Value(description),
      category: Value(category),
      startsAt: Value(startsAt),
      endsAt: Value(endsAt),
      location: Value(location),
      organizerId: organizerId == null && nullToAbsent
          ? const Value.absent()
          : Value(organizerId),
      expectedAttendance: Value(expectedAttendance),
      registeredCount: Value(registeredCount),
      isRecurring: Value(isRecurring),
    );
  }

  factory EventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      startsAt: serializer.fromJson<DateTime>(json['startsAt']),
      endsAt: serializer.fromJson<DateTime>(json['endsAt']),
      location: serializer.fromJson<String>(json['location']),
      organizerId: serializer.fromJson<String?>(json['organizerId']),
      expectedAttendance: serializer.fromJson<int>(json['expectedAttendance']),
      registeredCount: serializer.fromJson<int>(json['registeredCount']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'startsAt': serializer.toJson<DateTime>(startsAt),
      'endsAt': serializer.toJson<DateTime>(endsAt),
      'location': serializer.toJson<String>(location),
      'organizerId': serializer.toJson<String?>(organizerId),
      'expectedAttendance': serializer.toJson<int>(expectedAttendance),
      'registeredCount': serializer.toJson<int>(registeredCount),
      'isRecurring': serializer.toJson<bool>(isRecurring),
    };
  }

  EventRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? title,
    String? description,
    String? category,
    DateTime? startsAt,
    DateTime? endsAt,
    String? location,
    Value<String?> organizerId = const Value.absent(),
    int? expectedAttendance,
    int? registeredCount,
    bool? isRecurring,
  }) => EventRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    title: title ?? this.title,
    description: description ?? this.description,
    category: category ?? this.category,
    startsAt: startsAt ?? this.startsAt,
    endsAt: endsAt ?? this.endsAt,
    location: location ?? this.location,
    organizerId: organizerId.present ? organizerId.value : this.organizerId,
    expectedAttendance: expectedAttendance ?? this.expectedAttendance,
    registeredCount: registeredCount ?? this.registeredCount,
    isRecurring: isRecurring ?? this.isRecurring,
  );
  EventRow copyWithCompanion(EventsCompanion data) {
    return EventRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      startsAt: data.startsAt.present ? data.startsAt.value : this.startsAt,
      endsAt: data.endsAt.present ? data.endsAt.value : this.endsAt,
      location: data.location.present ? data.location.value : this.location,
      organizerId: data.organizerId.present
          ? data.organizerId.value
          : this.organizerId,
      expectedAttendance: data.expectedAttendance.present
          ? data.expectedAttendance.value
          : this.expectedAttendance,
      registeredCount: data.registeredCount.present
          ? data.registeredCount.value
          : this.registeredCount,
      isRecurring: data.isRecurring.present
          ? data.isRecurring.value
          : this.isRecurring,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('location: $location, ')
          ..write('organizerId: $organizerId, ')
          ..write('expectedAttendance: $expectedAttendance, ')
          ..write('registeredCount: $registeredCount, ')
          ..write('isRecurring: $isRecurring')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    title,
    description,
    category,
    startsAt,
    endsAt,
    location,
    organizerId,
    expectedAttendance,
    registeredCount,
    isRecurring,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.title == this.title &&
          other.description == this.description &&
          other.category == this.category &&
          other.startsAt == this.startsAt &&
          other.endsAt == this.endsAt &&
          other.location == this.location &&
          other.organizerId == this.organizerId &&
          other.expectedAttendance == this.expectedAttendance &&
          other.registeredCount == this.registeredCount &&
          other.isRecurring == this.isRecurring);
}

class EventsCompanion extends UpdateCompanion<EventRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> title;
  final Value<String> description;
  final Value<String> category;
  final Value<DateTime> startsAt;
  final Value<DateTime> endsAt;
  final Value<String> location;
  final Value<String?> organizerId;
  final Value<int> expectedAttendance;
  final Value<int> registeredCount;
  final Value<bool> isRecurring;
  final Value<int> rowid;
  const EventsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.startsAt = const Value.absent(),
    this.endsAt = const Value.absent(),
    this.location = const Value.absent(),
    this.organizerId = const Value.absent(),
    this.expectedAttendance = const Value.absent(),
    this.registeredCount = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String title,
    this.description = const Value.absent(),
    required String category,
    required DateTime startsAt,
    required DateTime endsAt,
    this.location = const Value.absent(),
    this.organizerId = const Value.absent(),
    this.expectedAttendance = const Value.absent(),
    this.registeredCount = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       title = Value(title),
       category = Value(category),
       startsAt = Value(startsAt),
       endsAt = Value(endsAt);
  static Insertable<EventRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? category,
    Expression<DateTime>? startsAt,
    Expression<DateTime>? endsAt,
    Expression<String>? location,
    Expression<String>? organizerId,
    Expression<int>? expectedAttendance,
    Expression<int>? registeredCount,
    Expression<bool>? isRecurring,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (startsAt != null) 'starts_at': startsAt,
      if (endsAt != null) 'ends_at': endsAt,
      if (location != null) 'location': location,
      if (organizerId != null) 'organizer_id': organizerId,
      if (expectedAttendance != null) 'expected_attendance': expectedAttendance,
      if (registeredCount != null) 'registered_count': registeredCount,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? title,
    Value<String>? description,
    Value<String>? category,
    Value<DateTime>? startsAt,
    Value<DateTime>? endsAt,
    Value<String>? location,
    Value<String?>? organizerId,
    Value<int>? expectedAttendance,
    Value<int>? registeredCount,
    Value<bool>? isRecurring,
    Value<int>? rowid,
  }) {
    return EventsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      location: location ?? this.location,
      organizerId: organizerId ?? this.organizerId,
      expectedAttendance: expectedAttendance ?? this.expectedAttendance,
      registeredCount: registeredCount ?? this.registeredCount,
      isRecurring: isRecurring ?? this.isRecurring,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (startsAt.present) {
      map['starts_at'] = Variable<DateTime>(startsAt.value);
    }
    if (endsAt.present) {
      map['ends_at'] = Variable<DateTime>(endsAt.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (organizerId.present) {
      map['organizer_id'] = Variable<String>(organizerId.value);
    }
    if (expectedAttendance.present) {
      map['expected_attendance'] = Variable<int>(expectedAttendance.value);
    }
    if (registeredCount.present) {
      map['registered_count'] = Variable<int>(registeredCount.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('startsAt: $startsAt, ')
          ..write('endsAt: $endsAt, ')
          ..write('location: $location, ')
          ..write('organizerId: $organizerId, ')
          ..write('expectedAttendance: $expectedAttendance, ')
          ..write('registeredCount: $registeredCount, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareRequestsTable extends CareRequests
    with TableInfo<$CareRequestsTable, CareRequestRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareRequestsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assignedToIdMeta = const VerificationMeta(
    'assignedToId',
  );
  @override
  late final GeneratedColumn<String> assignedToId = GeneratedColumn<String>(
    'assigned_to_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    memberId,
    type,
    summary,
    status,
    priority,
    assignedToId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareRequestRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    } else if (isInserting) {
      context.missing(_memberIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    } else if (isInserting) {
      context.missing(_summaryMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    if (data.containsKey('assigned_to_id')) {
      context.handle(
        _assignedToIdMeta,
        assignedToId.isAcceptableOrUnknown(
          data['assigned_to_id']!,
          _assignedToIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareRequestRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareRequestRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      assignedToId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assigned_to_id'],
      ),
    );
  }

  @override
  $CareRequestsTable createAlias(String alias) {
    return $CareRequestsTable(attachedDatabase, alias);
  }
}

class CareRequestRow extends DataClass implements Insertable<CareRequestRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String memberId;
  final String type;
  final String summary;
  final String status;
  final String priority;
  final String? assignedToId;
  const CareRequestRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.memberId,
    required this.type,
    required this.summary,
    required this.status,
    required this.priority,
    this.assignedToId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['member_id'] = Variable<String>(memberId);
    map['type'] = Variable<String>(type);
    map['summary'] = Variable<String>(summary);
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || assignedToId != null) {
      map['assigned_to_id'] = Variable<String>(assignedToId);
    }
    return map;
  }

  CareRequestsCompanion toCompanion(bool nullToAbsent) {
    return CareRequestsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      memberId: Value(memberId),
      type: Value(type),
      summary: Value(summary),
      status: Value(status),
      priority: Value(priority),
      assignedToId: assignedToId == null && nullToAbsent
          ? const Value.absent()
          : Value(assignedToId),
    );
  }

  factory CareRequestRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareRequestRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      memberId: serializer.fromJson<String>(json['memberId']),
      type: serializer.fromJson<String>(json['type']),
      summary: serializer.fromJson<String>(json['summary']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      assignedToId: serializer.fromJson<String?>(json['assignedToId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'memberId': serializer.toJson<String>(memberId),
      'type': serializer.toJson<String>(type),
      'summary': serializer.toJson<String>(summary),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'assignedToId': serializer.toJson<String?>(assignedToId),
    };
  }

  CareRequestRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? memberId,
    String? type,
    String? summary,
    String? status,
    String? priority,
    Value<String?> assignedToId = const Value.absent(),
  }) => CareRequestRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    memberId: memberId ?? this.memberId,
    type: type ?? this.type,
    summary: summary ?? this.summary,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    assignedToId: assignedToId.present ? assignedToId.value : this.assignedToId,
  );
  CareRequestRow copyWithCompanion(CareRequestsCompanion data) {
    return CareRequestRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      type: data.type.present ? data.type.value : this.type,
      summary: data.summary.present ? data.summary.value : this.summary,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      assignedToId: data.assignedToId.present
          ? data.assignedToId.value
          : this.assignedToId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareRequestRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('memberId: $memberId, ')
          ..write('type: $type, ')
          ..write('summary: $summary, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('assignedToId: $assignedToId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    memberId,
    type,
    summary,
    status,
    priority,
    assignedToId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareRequestRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.memberId == this.memberId &&
          other.type == this.type &&
          other.summary == this.summary &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.assignedToId == this.assignedToId);
}

class CareRequestsCompanion extends UpdateCompanion<CareRequestRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> memberId;
  final Value<String> type;
  final Value<String> summary;
  final Value<String> status;
  final Value<String> priority;
  final Value<String?> assignedToId;
  final Value<int> rowid;
  const CareRequestsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.memberId = const Value.absent(),
    this.type = const Value.absent(),
    this.summary = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.assignedToId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareRequestsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String memberId,
    required String type,
    required String summary,
    required String status,
    required String priority,
    this.assignedToId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       memberId = Value(memberId),
       type = Value(type),
       summary = Value(summary),
       status = Value(status),
       priority = Value(priority);
  static Insertable<CareRequestRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? memberId,
    Expression<String>? type,
    Expression<String>? summary,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<String>? assignedToId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (memberId != null) 'member_id': memberId,
      if (type != null) 'type': type,
      if (summary != null) 'summary': summary,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (assignedToId != null) 'assigned_to_id': assignedToId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareRequestsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? memberId,
    Value<String>? type,
    Value<String>? summary,
    Value<String>? status,
    Value<String>? priority,
    Value<String?>? assignedToId,
    Value<int>? rowid,
  }) {
    return CareRequestsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      memberId: memberId ?? this.memberId,
      type: type ?? this.type,
      summary: summary ?? this.summary,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedToId: assignedToId ?? this.assignedToId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (assignedToId.present) {
      map['assigned_to_id'] = Variable<String>(assignedToId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareRequestsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('memberId: $memberId, ')
          ..write('type: $type, ')
          ..write('summary: $summary, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('assignedToId: $assignedToId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $VolunteerSlotsTable extends VolunteerSlots
    with TableInfo<$VolunteerSlotsTable, VolunteerSlotRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VolunteerSlotsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serviceNameMeta = const VerificationMeta(
    'serviceName',
  );
  @override
  late final GeneratedColumn<String> serviceName = GeneratedColumn<String>(
    'service_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<String> memberId = GeneratedColumn<String>(
    'member_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES members (id)',
    ),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    date,
    serviceName,
    role,
    memberId,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'volunteer_slots';
  @override
  VerificationContext validateIntegrity(
    Insertable<VolunteerSlotRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('service_name')) {
      context.handle(
        _serviceNameMeta,
        serviceName.isAcceptableOrUnknown(
          data['service_name']!,
          _serviceNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_serviceNameMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VolunteerSlotRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VolunteerSlotRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      serviceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_name'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $VolunteerSlotsTable createAlias(String alias) {
    return $VolunteerSlotsTable(attachedDatabase, alias);
  }
}

class VolunteerSlotRow extends DataClass
    implements Insertable<VolunteerSlotRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final DateTime date;
  final String serviceName;
  final String role;
  final String? memberId;
  final String status;
  const VolunteerSlotRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.date,
    required this.serviceName,
    required this.role,
    this.memberId,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['date'] = Variable<DateTime>(date);
    map['service_name'] = Variable<String>(serviceName);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || memberId != null) {
      map['member_id'] = Variable<String>(memberId);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  VolunteerSlotsCompanion toCompanion(bool nullToAbsent) {
    return VolunteerSlotsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      date: Value(date),
      serviceName: Value(serviceName),
      role: Value(role),
      memberId: memberId == null && nullToAbsent
          ? const Value.absent()
          : Value(memberId),
      status: Value(status),
    );
  }

  factory VolunteerSlotRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VolunteerSlotRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      date: serializer.fromJson<DateTime>(json['date']),
      serviceName: serializer.fromJson<String>(json['serviceName']),
      role: serializer.fromJson<String>(json['role']),
      memberId: serializer.fromJson<String?>(json['memberId']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'date': serializer.toJson<DateTime>(date),
      'serviceName': serializer.toJson<String>(serviceName),
      'role': serializer.toJson<String>(role),
      'memberId': serializer.toJson<String?>(memberId),
      'status': serializer.toJson<String>(status),
    };
  }

  VolunteerSlotRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    DateTime? date,
    String? serviceName,
    String? role,
    Value<String?> memberId = const Value.absent(),
    String? status,
  }) => VolunteerSlotRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    date: date ?? this.date,
    serviceName: serviceName ?? this.serviceName,
    role: role ?? this.role,
    memberId: memberId.present ? memberId.value : this.memberId,
    status: status ?? this.status,
  );
  VolunteerSlotRow copyWithCompanion(VolunteerSlotsCompanion data) {
    return VolunteerSlotRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      date: data.date.present ? data.date.value : this.date,
      serviceName: data.serviceName.present
          ? data.serviceName.value
          : this.serviceName,
      role: data.role.present ? data.role.value : this.role,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VolunteerSlotRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('date: $date, ')
          ..write('serviceName: $serviceName, ')
          ..write('role: $role, ')
          ..write('memberId: $memberId, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    date,
    serviceName,
    role,
    memberId,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VolunteerSlotRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.date == this.date &&
          other.serviceName == this.serviceName &&
          other.role == this.role &&
          other.memberId == this.memberId &&
          other.status == this.status);
}

class VolunteerSlotsCompanion extends UpdateCompanion<VolunteerSlotRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<DateTime> date;
  final Value<String> serviceName;
  final Value<String> role;
  final Value<String?> memberId;
  final Value<String> status;
  final Value<int> rowid;
  const VolunteerSlotsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.date = const Value.absent(),
    this.serviceName = const Value.absent(),
    this.role = const Value.absent(),
    this.memberId = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VolunteerSlotsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required DateTime date,
    required String serviceName,
    required String role,
    this.memberId = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       date = Value(date),
       serviceName = Value(serviceName),
       role = Value(role),
       status = Value(status);
  static Insertable<VolunteerSlotRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<DateTime>? date,
    Expression<String>? serviceName,
    Expression<String>? role,
    Expression<String>? memberId,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (date != null) 'date': date,
      if (serviceName != null) 'service_name': serviceName,
      if (role != null) 'role': role,
      if (memberId != null) 'member_id': memberId,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VolunteerSlotsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<DateTime>? date,
    Value<String>? serviceName,
    Value<String>? role,
    Value<String?>? memberId,
    Value<String>? status,
    Value<int>? rowid,
  }) {
    return VolunteerSlotsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      date: date ?? this.date,
      serviceName: serviceName ?? this.serviceName,
      role: role ?? this.role,
      memberId: memberId ?? this.memberId,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (serviceName.present) {
      map['service_name'] = Variable<String>(serviceName.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<String>(memberId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VolunteerSlotsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('date: $date, ')
          ..write('serviceName: $serviceName, ')
          ..write('role: $role, ')
          ..write('memberId: $memberId, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AssetsTable extends Assets with TableInfo<$AssetsTable, AssetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssetsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _serialMeta = const VerificationMeta('serial');
  @override
  late final GeneratedColumn<String> serial = GeneratedColumn<String>(
    'serial',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _purchasedAtMeta = const VerificationMeta(
    'purchasedAt',
  );
  @override
  late final GeneratedColumn<DateTime> purchasedAt = GeneratedColumn<DateTime>(
    'purchased_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    name,
    category,
    serial,
    condition,
    location,
    purchasedAt,
    value,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('serial')) {
      context.handle(
        _serialMeta,
        serial.isAcceptableOrUnknown(data['serial']!, _serialMeta),
      );
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    } else if (isInserting) {
      context.missing(_conditionMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('purchased_at')) {
      context.handle(
        _purchasedAtMeta,
        purchasedAt.isAcceptableOrUnknown(
          data['purchased_at']!,
          _purchasedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_purchasedAtMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssetRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      serial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serial'],
      )!,
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      purchasedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}purchased_at'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AssetsTable createAlias(String alias) {
    return $AssetsTable(attachedDatabase, alias);
  }
}

class AssetRow extends DataClass implements Insertable<AssetRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String name;
  final String category;
  final String serial;
  final String condition;
  final String location;
  final DateTime purchasedAt;
  final double value;
  const AssetRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.name,
    required this.category,
    required this.serial,
    required this.condition,
    required this.location,
    required this.purchasedAt,
    required this.value,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['serial'] = Variable<String>(serial);
    map['condition'] = Variable<String>(condition);
    map['location'] = Variable<String>(location);
    map['purchased_at'] = Variable<DateTime>(purchasedAt);
    map['value'] = Variable<double>(value);
    return map;
  }

  AssetsCompanion toCompanion(bool nullToAbsent) {
    return AssetsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      category: Value(category),
      serial: Value(serial),
      condition: Value(condition),
      location: Value(location),
      purchasedAt: Value(purchasedAt),
      value: Value(value),
    );
  }

  factory AssetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssetRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      serial: serializer.fromJson<String>(json['serial']),
      condition: serializer.fromJson<String>(json['condition']),
      location: serializer.fromJson<String>(json['location']),
      purchasedAt: serializer.fromJson<DateTime>(json['purchasedAt']),
      value: serializer.fromJson<double>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'serial': serializer.toJson<String>(serial),
      'condition': serializer.toJson<String>(condition),
      'location': serializer.toJson<String>(location),
      'purchasedAt': serializer.toJson<DateTime>(purchasedAt),
      'value': serializer.toJson<double>(value),
    };
  }

  AssetRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? name,
    String? category,
    String? serial,
    String? condition,
    String? location,
    DateTime? purchasedAt,
    double? value,
  }) => AssetRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    category: category ?? this.category,
    serial: serial ?? this.serial,
    condition: condition ?? this.condition,
    location: location ?? this.location,
    purchasedAt: purchasedAt ?? this.purchasedAt,
    value: value ?? this.value,
  );
  AssetRow copyWithCompanion(AssetsCompanion data) {
    return AssetRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      serial: data.serial.present ? data.serial.value : this.serial,
      condition: data.condition.present ? data.condition.value : this.condition,
      location: data.location.present ? data.location.value : this.location,
      purchasedAt: data.purchasedAt.present
          ? data.purchasedAt.value
          : this.purchasedAt,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssetRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('serial: $serial, ')
          ..write('condition: $condition, ')
          ..write('location: $location, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    name,
    category,
    serial,
    condition,
    location,
    purchasedAt,
    value,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssetRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.category == this.category &&
          other.serial == this.serial &&
          other.condition == this.condition &&
          other.location == this.location &&
          other.purchasedAt == this.purchasedAt &&
          other.value == this.value);
}

class AssetsCompanion extends UpdateCompanion<AssetRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String> category;
  final Value<String> serial;
  final Value<String> condition;
  final Value<String> location;
  final Value<DateTime> purchasedAt;
  final Value<double> value;
  final Value<int> rowid;
  const AssetsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.serial = const Value.absent(),
    this.condition = const Value.absent(),
    this.location = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssetsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String name,
    required String category,
    this.serial = const Value.absent(),
    required String condition,
    this.location = const Value.absent(),
    required DateTime purchasedAt,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       name = Value(name),
       category = Value(category),
       condition = Value(condition),
       purchasedAt = Value(purchasedAt);
  static Insertable<AssetRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? serial,
    Expression<String>? condition,
    Expression<String>? location,
    Expression<DateTime>? purchasedAt,
    Expression<double>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (serial != null) 'serial': serial,
      if (condition != null) 'condition': condition,
      if (location != null) 'location': location,
      if (purchasedAt != null) 'purchased_at': purchasedAt,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssetsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? name,
    Value<String>? category,
    Value<String>? serial,
    Value<String>? condition,
    Value<String>? location,
    Value<DateTime>? purchasedAt,
    Value<double>? value,
    Value<int>? rowid,
  }) {
    return AssetsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      category: category ?? this.category,
      serial: serial ?? this.serial,
      condition: condition ?? this.condition,
      location: location ?? this.location,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (serial.present) {
      map['serial'] = Variable<String>(serial.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (purchasedAt.present) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssetsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('serial: $serial, ')
          ..write('condition: $condition, ')
          ..write('location: $location, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CampaignsTable extends Campaigns
    with TableInfo<$CampaignsTable, CampaignRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampaignsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _channelMeta = const VerificationMeta(
    'channel',
  );
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
    'channel',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audienceMeta = const VerificationMeta(
    'audience',
  );
  @override
  late final GeneratedColumn<String> audience = GeneratedColumn<String>(
    'audience',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientsMeta = const VerificationMeta(
    'recipients',
  );
  @override
  late final GeneratedColumn<int> recipients = GeneratedColumn<int>(
    'recipients',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _openRateMeta = const VerificationMeta(
    'openRate',
  );
  @override
  late final GeneratedColumn<int> openRate = GeneratedColumn<int>(
    'open_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledForMeta = const VerificationMeta(
    'scheduledFor',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
    'scheduled_for',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    subject,
    body,
    channel,
    status,
    audience,
    recipients,
    openRate,
    sentAt,
    scheduledFor,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campaigns';
  @override
  VerificationContext validateIntegrity(
    Insertable<CampaignRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    }
    if (data.containsKey('channel')) {
      context.handle(
        _channelMeta,
        channel.isAcceptableOrUnknown(data['channel']!, _channelMeta),
      );
    } else if (isInserting) {
      context.missing(_channelMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('audience')) {
      context.handle(
        _audienceMeta,
        audience.isAcceptableOrUnknown(data['audience']!, _audienceMeta),
      );
    } else if (isInserting) {
      context.missing(_audienceMeta);
    }
    if (data.containsKey('recipients')) {
      context.handle(
        _recipientsMeta,
        recipients.isAcceptableOrUnknown(data['recipients']!, _recipientsMeta),
      );
    }
    if (data.containsKey('open_rate')) {
      context.handle(
        _openRateMeta,
        openRate.isAcceptableOrUnknown(data['open_rate']!, _openRateMeta),
      );
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
        _scheduledForMeta,
        scheduledFor.isAcceptableOrUnknown(
          data['scheduled_for']!,
          _scheduledForMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CampaignRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CampaignRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      channel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      audience: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audience'],
      )!,
      recipients: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipients'],
      )!,
      openRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}open_rate'],
      ),
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      ),
      scheduledFor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_for'],
      ),
    );
  }

  @override
  $CampaignsTable createAlias(String alias) {
    return $CampaignsTable(attachedDatabase, alias);
  }
}

class CampaignRow extends DataClass implements Insertable<CampaignRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String subject;
  final String body;
  final String channel;
  final String status;
  final String audience;
  final int recipients;
  final int? openRate;
  final DateTime? sentAt;
  final DateTime? scheduledFor;
  const CampaignRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.subject,
    required this.body,
    required this.channel,
    required this.status,
    required this.audience,
    required this.recipients,
    this.openRate,
    this.sentAt,
    this.scheduledFor,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['subject'] = Variable<String>(subject);
    map['body'] = Variable<String>(body);
    map['channel'] = Variable<String>(channel);
    map['status'] = Variable<String>(status);
    map['audience'] = Variable<String>(audience);
    map['recipients'] = Variable<int>(recipients);
    if (!nullToAbsent || openRate != null) {
      map['open_rate'] = Variable<int>(openRate);
    }
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    if (!nullToAbsent || scheduledFor != null) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    }
    return map;
  }

  CampaignsCompanion toCompanion(bool nullToAbsent) {
    return CampaignsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      subject: Value(subject),
      body: Value(body),
      channel: Value(channel),
      status: Value(status),
      audience: Value(audience),
      recipients: Value(recipients),
      openRate: openRate == null && nullToAbsent
          ? const Value.absent()
          : Value(openRate),
      sentAt: sentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentAt),
      scheduledFor: scheduledFor == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledFor),
    );
  }

  factory CampaignRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CampaignRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      subject: serializer.fromJson<String>(json['subject']),
      body: serializer.fromJson<String>(json['body']),
      channel: serializer.fromJson<String>(json['channel']),
      status: serializer.fromJson<String>(json['status']),
      audience: serializer.fromJson<String>(json['audience']),
      recipients: serializer.fromJson<int>(json['recipients']),
      openRate: serializer.fromJson<int?>(json['openRate']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      scheduledFor: serializer.fromJson<DateTime?>(json['scheduledFor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'subject': serializer.toJson<String>(subject),
      'body': serializer.toJson<String>(body),
      'channel': serializer.toJson<String>(channel),
      'status': serializer.toJson<String>(status),
      'audience': serializer.toJson<String>(audience),
      'recipients': serializer.toJson<int>(recipients),
      'openRate': serializer.toJson<int?>(openRate),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'scheduledFor': serializer.toJson<DateTime?>(scheduledFor),
    };
  }

  CampaignRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? subject,
    String? body,
    String? channel,
    String? status,
    String? audience,
    int? recipients,
    Value<int?> openRate = const Value.absent(),
    Value<DateTime?> sentAt = const Value.absent(),
    Value<DateTime?> scheduledFor = const Value.absent(),
  }) => CampaignRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    subject: subject ?? this.subject,
    body: body ?? this.body,
    channel: channel ?? this.channel,
    status: status ?? this.status,
    audience: audience ?? this.audience,
    recipients: recipients ?? this.recipients,
    openRate: openRate.present ? openRate.value : this.openRate,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
    scheduledFor: scheduledFor.present ? scheduledFor.value : this.scheduledFor,
  );
  CampaignRow copyWithCompanion(CampaignsCompanion data) {
    return CampaignRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      subject: data.subject.present ? data.subject.value : this.subject,
      body: data.body.present ? data.body.value : this.body,
      channel: data.channel.present ? data.channel.value : this.channel,
      status: data.status.present ? data.status.value : this.status,
      audience: data.audience.present ? data.audience.value : this.audience,
      recipients: data.recipients.present
          ? data.recipients.value
          : this.recipients,
      openRate: data.openRate.present ? data.openRate.value : this.openRate,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      scheduledFor: data.scheduledFor.present
          ? data.scheduledFor.value
          : this.scheduledFor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CampaignRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('subject: $subject, ')
          ..write('body: $body, ')
          ..write('channel: $channel, ')
          ..write('status: $status, ')
          ..write('audience: $audience, ')
          ..write('recipients: $recipients, ')
          ..write('openRate: $openRate, ')
          ..write('sentAt: $sentAt, ')
          ..write('scheduledFor: $scheduledFor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    subject,
    body,
    channel,
    status,
    audience,
    recipients,
    openRate,
    sentAt,
    scheduledFor,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CampaignRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.subject == this.subject &&
          other.body == this.body &&
          other.channel == this.channel &&
          other.status == this.status &&
          other.audience == this.audience &&
          other.recipients == this.recipients &&
          other.openRate == this.openRate &&
          other.sentAt == this.sentAt &&
          other.scheduledFor == this.scheduledFor);
}

class CampaignsCompanion extends UpdateCompanion<CampaignRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> subject;
  final Value<String> body;
  final Value<String> channel;
  final Value<String> status;
  final Value<String> audience;
  final Value<int> recipients;
  final Value<int?> openRate;
  final Value<DateTime?> sentAt;
  final Value<DateTime?> scheduledFor;
  final Value<int> rowid;
  const CampaignsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.subject = const Value.absent(),
    this.body = const Value.absent(),
    this.channel = const Value.absent(),
    this.status = const Value.absent(),
    this.audience = const Value.absent(),
    this.recipients = const Value.absent(),
    this.openRate = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CampaignsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String subject,
    this.body = const Value.absent(),
    required String channel,
    required String status,
    required String audience,
    this.recipients = const Value.absent(),
    this.openRate = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       subject = Value(subject),
       channel = Value(channel),
       status = Value(status),
       audience = Value(audience);
  static Insertable<CampaignRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? subject,
    Expression<String>? body,
    Expression<String>? channel,
    Expression<String>? status,
    Expression<String>? audience,
    Expression<int>? recipients,
    Expression<int>? openRate,
    Expression<DateTime>? sentAt,
    Expression<DateTime>? scheduledFor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (subject != null) 'subject': subject,
      if (body != null) 'body': body,
      if (channel != null) 'channel': channel,
      if (status != null) 'status': status,
      if (audience != null) 'audience': audience,
      if (recipients != null) 'recipients': recipients,
      if (openRate != null) 'open_rate': openRate,
      if (sentAt != null) 'sent_at': sentAt,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CampaignsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? subject,
    Value<String>? body,
    Value<String>? channel,
    Value<String>? status,
    Value<String>? audience,
    Value<int>? recipients,
    Value<int?>? openRate,
    Value<DateTime?>? sentAt,
    Value<DateTime?>? scheduledFor,
    Value<int>? rowid,
  }) {
    return CampaignsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      subject: subject ?? this.subject,
      body: body ?? this.body,
      channel: channel ?? this.channel,
      status: status ?? this.status,
      audience: audience ?? this.audience,
      recipients: recipients ?? this.recipients,
      openRate: openRate ?? this.openRate,
      sentAt: sentAt ?? this.sentAt,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (audience.present) {
      map['audience'] = Variable<String>(audience.value);
    }
    if (recipients.present) {
      map['recipients'] = Variable<int>(recipients.value);
    }
    if (openRate.present) {
      map['open_rate'] = Variable<int>(openRate.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('subject: $subject, ')
          ..write('body: $body, ')
          ..write('channel: $channel, ')
          ..write('status: $status, ')
          ..write('audience: $audience, ')
          ..write('recipients: $recipients, ')
          ..write('openRate: $openRate, ')
          ..write('sentAt: $sentAt, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnnouncementsTable extends Announcements
    with TableInfo<$AnnouncementsTable, AnnouncementRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnnouncementsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _postedAtMeta = const VerificationMeta(
    'postedAt',
  );
  @override
  late final GeneratedColumn<DateTime> postedAt = GeneratedColumn<DateTime>(
    'posted_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinnedMeta = const VerificationMeta('pinned');
  @override
  late final GeneratedColumn<bool> pinned = GeneratedColumn<bool>(
    'pinned',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pinned" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    title,
    body,
    authorId,
    postedAt,
    pinned,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'announcements';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnnouncementRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('author_id')) {
      context.handle(
        _authorIdMeta,
        authorId.isAcceptableOrUnknown(data['author_id']!, _authorIdMeta),
      );
    }
    if (data.containsKey('posted_at')) {
      context.handle(
        _postedAtMeta,
        postedAt.isAcceptableOrUnknown(data['posted_at']!, _postedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_postedAtMeta);
    }
    if (data.containsKey('pinned')) {
      context.handle(
        _pinnedMeta,
        pinned.isAcceptableOrUnknown(data['pinned']!, _pinnedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnnouncementRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnnouncementRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      authorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author_id'],
      ),
      postedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}posted_at'],
      )!,
      pinned: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pinned'],
      )!,
    );
  }

  @override
  $AnnouncementsTable createAlias(String alias) {
    return $AnnouncementsTable(attachedDatabase, alias);
  }
}

class AnnouncementRow extends DataClass implements Insertable<AnnouncementRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String title;
  final String body;
  final String? authorId;
  final DateTime postedAt;
  final bool pinned;
  const AnnouncementRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.title,
    required this.body,
    this.authorId,
    required this.postedAt,
    required this.pinned,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || authorId != null) {
      map['author_id'] = Variable<String>(authorId);
    }
    map['posted_at'] = Variable<DateTime>(postedAt);
    map['pinned'] = Variable<bool>(pinned);
    return map;
  }

  AnnouncementsCompanion toCompanion(bool nullToAbsent) {
    return AnnouncementsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      title: Value(title),
      body: Value(body),
      authorId: authorId == null && nullToAbsent
          ? const Value.absent()
          : Value(authorId),
      postedAt: Value(postedAt),
      pinned: Value(pinned),
    );
  }

  factory AnnouncementRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnnouncementRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      authorId: serializer.fromJson<String?>(json['authorId']),
      postedAt: serializer.fromJson<DateTime>(json['postedAt']),
      pinned: serializer.fromJson<bool>(json['pinned']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'authorId': serializer.toJson<String?>(authorId),
      'postedAt': serializer.toJson<DateTime>(postedAt),
      'pinned': serializer.toJson<bool>(pinned),
    };
  }

  AnnouncementRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? title,
    String? body,
    Value<String?> authorId = const Value.absent(),
    DateTime? postedAt,
    bool? pinned,
  }) => AnnouncementRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    title: title ?? this.title,
    body: body ?? this.body,
    authorId: authorId.present ? authorId.value : this.authorId,
    postedAt: postedAt ?? this.postedAt,
    pinned: pinned ?? this.pinned,
  );
  AnnouncementRow copyWithCompanion(AnnouncementsCompanion data) {
    return AnnouncementRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      authorId: data.authorId.present ? data.authorId.value : this.authorId,
      postedAt: data.postedAt.present ? data.postedAt.value : this.postedAt,
      pinned: data.pinned.present ? data.pinned.value : this.pinned,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnnouncementRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('authorId: $authorId, ')
          ..write('postedAt: $postedAt, ')
          ..write('pinned: $pinned')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    title,
    body,
    authorId,
    postedAt,
    pinned,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnnouncementRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.title == this.title &&
          other.body == this.body &&
          other.authorId == this.authorId &&
          other.postedAt == this.postedAt &&
          other.pinned == this.pinned);
}

class AnnouncementsCompanion extends UpdateCompanion<AnnouncementRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> title;
  final Value<String> body;
  final Value<String?> authorId;
  final Value<DateTime> postedAt;
  final Value<bool> pinned;
  final Value<int> rowid;
  const AnnouncementsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.authorId = const Value.absent(),
    this.postedAt = const Value.absent(),
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnnouncementsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String title,
    required String body,
    this.authorId = const Value.absent(),
    required DateTime postedAt,
    this.pinned = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       title = Value(title),
       body = Value(body),
       postedAt = Value(postedAt);
  static Insertable<AnnouncementRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? authorId,
    Expression<DateTime>? postedAt,
    Expression<bool>? pinned,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (authorId != null) 'author_id': authorId,
      if (postedAt != null) 'posted_at': postedAt,
      if (pinned != null) 'pinned': pinned,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnnouncementsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? title,
    Value<String>? body,
    Value<String?>? authorId,
    Value<DateTime>? postedAt,
    Value<bool>? pinned,
    Value<int>? rowid,
  }) {
    return AnnouncementsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      title: title ?? this.title,
      body: body ?? this.body,
      authorId: authorId ?? this.authorId,
      postedAt: postedAt ?? this.postedAt,
      pinned: pinned ?? this.pinned,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (authorId.present) {
      map['author_id'] = Variable<String>(authorId.value);
    }
    if (postedAt.present) {
      map['posted_at'] = Variable<DateTime>(postedAt.value);
    }
    if (pinned.present) {
      map['pinned'] = Variable<bool>(pinned.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnnouncementsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('authorId: $authorId, ')
          ..write('postedAt: $postedAt, ')
          ..write('pinned: $pinned, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoursesTable extends Courses with TableInfo<$CoursesTable, CourseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lessonsMeta = const VerificationMeta(
    'lessons',
  );
  @override
  late final GeneratedColumn<int> lessons = GeneratedColumn<int>(
    'lessons',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _enrolledMeta = const VerificationMeta(
    'enrolled',
  );
  @override
  late final GeneratedColumn<int> enrolled = GeneratedColumn<int>(
    'enrolled',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<int> completed = GeneratedColumn<int>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _facilitatorIdMeta = const VerificationMeta(
    'facilitatorId',
  );
  @override
  late final GeneratedColumn<String> facilitatorId = GeneratedColumn<String>(
    'facilitator_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    name,
    description,
    lessons,
    enrolled,
    completed,
    facilitatorId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'courses';
  @override
  VerificationContext validateIntegrity(
    Insertable<CourseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('lessons')) {
      context.handle(
        _lessonsMeta,
        lessons.isAcceptableOrUnknown(data['lessons']!, _lessonsMeta),
      );
    }
    if (data.containsKey('enrolled')) {
      context.handle(
        _enrolledMeta,
        enrolled.isAcceptableOrUnknown(data['enrolled']!, _enrolledMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('facilitator_id')) {
      context.handle(
        _facilitatorIdMeta,
        facilitatorId.isAcceptableOrUnknown(
          data['facilitator_id']!,
          _facilitatorIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CourseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CourseRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      lessons: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lessons'],
      )!,
      enrolled: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}enrolled'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed'],
      )!,
      facilitatorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facilitator_id'],
      ),
    );
  }

  @override
  $CoursesTable createAlias(String alias) {
    return $CoursesTable(attachedDatabase, alias);
  }
}

class CourseRow extends DataClass implements Insertable<CourseRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String name;
  final String description;
  final int lessons;
  final int enrolled;
  final int completed;
  final String? facilitatorId;
  const CourseRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.name,
    required this.description,
    required this.lessons,
    required this.enrolled,
    required this.completed,
    this.facilitatorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['lessons'] = Variable<int>(lessons);
    map['enrolled'] = Variable<int>(enrolled);
    map['completed'] = Variable<int>(completed);
    if (!nullToAbsent || facilitatorId != null) {
      map['facilitator_id'] = Variable<String>(facilitatorId);
    }
    return map;
  }

  CoursesCompanion toCompanion(bool nullToAbsent) {
    return CoursesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      description: Value(description),
      lessons: Value(lessons),
      enrolled: Value(enrolled),
      completed: Value(completed),
      facilitatorId: facilitatorId == null && nullToAbsent
          ? const Value.absent()
          : Value(facilitatorId),
    );
  }

  factory CourseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CourseRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      lessons: serializer.fromJson<int>(json['lessons']),
      enrolled: serializer.fromJson<int>(json['enrolled']),
      completed: serializer.fromJson<int>(json['completed']),
      facilitatorId: serializer.fromJson<String?>(json['facilitatorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'lessons': serializer.toJson<int>(lessons),
      'enrolled': serializer.toJson<int>(enrolled),
      'completed': serializer.toJson<int>(completed),
      'facilitatorId': serializer.toJson<String?>(facilitatorId),
    };
  }

  CourseRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? name,
    String? description,
    int? lessons,
    int? enrolled,
    int? completed,
    Value<String?> facilitatorId = const Value.absent(),
  }) => CourseRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    description: description ?? this.description,
    lessons: lessons ?? this.lessons,
    enrolled: enrolled ?? this.enrolled,
    completed: completed ?? this.completed,
    facilitatorId: facilitatorId.present
        ? facilitatorId.value
        : this.facilitatorId,
  );
  CourseRow copyWithCompanion(CoursesCompanion data) {
    return CourseRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      lessons: data.lessons.present ? data.lessons.value : this.lessons,
      enrolled: data.enrolled.present ? data.enrolled.value : this.enrolled,
      completed: data.completed.present ? data.completed.value : this.completed,
      facilitatorId: data.facilitatorId.present
          ? data.facilitatorId.value
          : this.facilitatorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CourseRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('lessons: $lessons, ')
          ..write('enrolled: $enrolled, ')
          ..write('completed: $completed, ')
          ..write('facilitatorId: $facilitatorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    name,
    description,
    lessons,
    enrolled,
    completed,
    facilitatorId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CourseRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.description == this.description &&
          other.lessons == this.lessons &&
          other.enrolled == this.enrolled &&
          other.completed == this.completed &&
          other.facilitatorId == this.facilitatorId);
}

class CoursesCompanion extends UpdateCompanion<CourseRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String> description;
  final Value<int> lessons;
  final Value<int> enrolled;
  final Value<int> completed;
  final Value<String?> facilitatorId;
  final Value<int> rowid;
  const CoursesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.lessons = const Value.absent(),
    this.enrolled = const Value.absent(),
    this.completed = const Value.absent(),
    this.facilitatorId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoursesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String name,
    this.description = const Value.absent(),
    this.lessons = const Value.absent(),
    this.enrolled = const Value.absent(),
    this.completed = const Value.absent(),
    this.facilitatorId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       name = Value(name);
  static Insertable<CourseRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? lessons,
    Expression<int>? enrolled,
    Expression<int>? completed,
    Expression<String>? facilitatorId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (lessons != null) 'lessons': lessons,
      if (enrolled != null) 'enrolled': enrolled,
      if (completed != null) 'completed': completed,
      if (facilitatorId != null) 'facilitator_id': facilitatorId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoursesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? name,
    Value<String>? description,
    Value<int>? lessons,
    Value<int>? enrolled,
    Value<int>? completed,
    Value<String?>? facilitatorId,
    Value<int>? rowid,
  }) {
    return CoursesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      description: description ?? this.description,
      lessons: lessons ?? this.lessons,
      enrolled: enrolled ?? this.enrolled,
      completed: completed ?? this.completed,
      facilitatorId: facilitatorId ?? this.facilitatorId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (lessons.present) {
      map['lessons'] = Variable<int>(lessons.value);
    }
    if (enrolled.present) {
      map['enrolled'] = Variable<int>(enrolled.value);
    }
    if (completed.present) {
      map['completed'] = Variable<int>(completed.value);
    }
    if (facilitatorId.present) {
      map['facilitator_id'] = Variable<String>(facilitatorId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('lessons: $lessons, ')
          ..write('enrolled: $enrolled, ')
          ..write('completed: $completed, ')
          ..write('facilitatorId: $facilitatorId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SmallGroupsTable extends SmallGroups
    with TableInfo<$SmallGroupsTable, SmallGroupRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SmallGroupsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES branches (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _leaderIdMeta = const VerificationMeta(
    'leaderId',
  );
  @override
  late final GeneratedColumn<String> leaderId = GeneratedColumn<String>(
    'leader_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _meetingDayMeta = const VerificationMeta(
    'meetingDay',
  );
  @override
  late final GeneratedColumn<String> meetingDay = GeneratedColumn<String>(
    'meeting_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _meetingTimeMeta = const VerificationMeta(
    'meetingTime',
  );
  @override
  late final GeneratedColumn<String> meetingTime = GeneratedColumn<String>(
    'meeting_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _capacityMeta = const VerificationMeta(
    'capacity',
  );
  @override
  late final GeneratedColumn<int> capacity = GeneratedColumn<int>(
    'capacity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    name,
    leaderId,
    location,
    meetingDay,
    meetingTime,
    capacity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'small_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<SmallGroupRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('leader_id')) {
      context.handle(
        _leaderIdMeta,
        leaderId.isAcceptableOrUnknown(data['leader_id']!, _leaderIdMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('meeting_day')) {
      context.handle(
        _meetingDayMeta,
        meetingDay.isAcceptableOrUnknown(data['meeting_day']!, _meetingDayMeta),
      );
    } else if (isInserting) {
      context.missing(_meetingDayMeta);
    }
    if (data.containsKey('meeting_time')) {
      context.handle(
        _meetingTimeMeta,
        meetingTime.isAcceptableOrUnknown(
          data['meeting_time']!,
          _meetingTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_meetingTimeMeta);
    }
    if (data.containsKey('capacity')) {
      context.handle(
        _capacityMeta,
        capacity.isAcceptableOrUnknown(data['capacity']!, _capacityMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SmallGroupRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SmallGroupRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      leaderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}leader_id'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      meetingDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_day'],
      )!,
      meetingTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meeting_time'],
      )!,
      capacity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}capacity'],
      )!,
    );
  }

  @override
  $SmallGroupsTable createAlias(String alias) {
    return $SmallGroupsTable(attachedDatabase, alias);
  }
}

class SmallGroupRow extends DataClass implements Insertable<SmallGroupRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;
  final String id;
  final String branchId;
  final String name;
  final String? leaderId;
  final String location;
  final String meetingDay;
  final String meetingTime;
  final int capacity;
  const SmallGroupRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.id,
    required this.branchId,
    required this.name,
    this.leaderId,
    required this.location,
    required this.meetingDay,
    required this.meetingTime,
    required this.capacity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['id'] = Variable<String>(id);
    map['branch_id'] = Variable<String>(branchId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || leaderId != null) {
      map['leader_id'] = Variable<String>(leaderId);
    }
    map['location'] = Variable<String>(location);
    map['meeting_day'] = Variable<String>(meetingDay);
    map['meeting_time'] = Variable<String>(meetingTime);
    map['capacity'] = Variable<int>(capacity);
    return map;
  }

  SmallGroupsCompanion toCompanion(bool nullToAbsent) {
    return SmallGroupsCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      id: Value(id),
      branchId: Value(branchId),
      name: Value(name),
      leaderId: leaderId == null && nullToAbsent
          ? const Value.absent()
          : Value(leaderId),
      location: Value(location),
      meetingDay: Value(meetingDay),
      meetingTime: Value(meetingTime),
      capacity: Value(capacity),
    );
  }

  factory SmallGroupRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SmallGroupRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      id: serializer.fromJson<String>(json['id']),
      branchId: serializer.fromJson<String>(json['branchId']),
      name: serializer.fromJson<String>(json['name']),
      leaderId: serializer.fromJson<String?>(json['leaderId']),
      location: serializer.fromJson<String>(json['location']),
      meetingDay: serializer.fromJson<String>(json['meetingDay']),
      meetingTime: serializer.fromJson<String>(json['meetingTime']),
      capacity: serializer.fromJson<int>(json['capacity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'id': serializer.toJson<String>(id),
      'branchId': serializer.toJson<String>(branchId),
      'name': serializer.toJson<String>(name),
      'leaderId': serializer.toJson<String?>(leaderId),
      'location': serializer.toJson<String>(location),
      'meetingDay': serializer.toJson<String>(meetingDay),
      'meetingTime': serializer.toJson<String>(meetingTime),
      'capacity': serializer.toJson<int>(capacity),
    };
  }

  SmallGroupRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? id,
    String? branchId,
    String? name,
    Value<String?> leaderId = const Value.absent(),
    String? location,
    String? meetingDay,
    String? meetingTime,
    int? capacity,
  }) => SmallGroupRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    id: id ?? this.id,
    branchId: branchId ?? this.branchId,
    name: name ?? this.name,
    leaderId: leaderId.present ? leaderId.value : this.leaderId,
    location: location ?? this.location,
    meetingDay: meetingDay ?? this.meetingDay,
    meetingTime: meetingTime ?? this.meetingTime,
    capacity: capacity ?? this.capacity,
  );
  SmallGroupRow copyWithCompanion(SmallGroupsCompanion data) {
    return SmallGroupRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      id: data.id.present ? data.id.value : this.id,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      name: data.name.present ? data.name.value : this.name,
      leaderId: data.leaderId.present ? data.leaderId.value : this.leaderId,
      location: data.location.present ? data.location.value : this.location,
      meetingDay: data.meetingDay.present
          ? data.meetingDay.value
          : this.meetingDay,
      meetingTime: data.meetingTime.present
          ? data.meetingTime.value
          : this.meetingTime,
      capacity: data.capacity.present ? data.capacity.value : this.capacity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SmallGroupRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('leaderId: $leaderId, ')
          ..write('location: $location, ')
          ..write('meetingDay: $meetingDay, ')
          ..write('meetingTime: $meetingTime, ')
          ..write('capacity: $capacity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    createdAt,
    updatedAt,
    deletedAt,
    id,
    branchId,
    name,
    leaderId,
    location,
    meetingDay,
    meetingTime,
    capacity,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SmallGroupRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.id == this.id &&
          other.branchId == this.branchId &&
          other.name == this.name &&
          other.leaderId == this.leaderId &&
          other.location == this.location &&
          other.meetingDay == this.meetingDay &&
          other.meetingTime == this.meetingTime &&
          other.capacity == this.capacity);
}

class SmallGroupsCompanion extends UpdateCompanion<SmallGroupRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> id;
  final Value<String> branchId;
  final Value<String> name;
  final Value<String?> leaderId;
  final Value<String> location;
  final Value<String> meetingDay;
  final Value<String> meetingTime;
  final Value<int> capacity;
  final Value<int> rowid;
  const SmallGroupsCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.id = const Value.absent(),
    this.branchId = const Value.absent(),
    this.name = const Value.absent(),
    this.leaderId = const Value.absent(),
    this.location = const Value.absent(),
    this.meetingDay = const Value.absent(),
    this.meetingTime = const Value.absent(),
    this.capacity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SmallGroupsCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String id,
    required String branchId,
    required String name,
    this.leaderId = const Value.absent(),
    this.location = const Value.absent(),
    required String meetingDay,
    required String meetingTime,
    this.capacity = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       branchId = Value(branchId),
       name = Value(name),
       meetingDay = Value(meetingDay),
       meetingTime = Value(meetingTime);
  static Insertable<SmallGroupRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? id,
    Expression<String>? branchId,
    Expression<String>? name,
    Expression<String>? leaderId,
    Expression<String>? location,
    Expression<String>? meetingDay,
    Expression<String>? meetingTime,
    Expression<int>? capacity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (id != null) 'id': id,
      if (branchId != null) 'branch_id': branchId,
      if (name != null) 'name': name,
      if (leaderId != null) 'leader_id': leaderId,
      if (location != null) 'location': location,
      if (meetingDay != null) 'meeting_day': meetingDay,
      if (meetingTime != null) 'meeting_time': meetingTime,
      if (capacity != null) 'capacity': capacity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SmallGroupsCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? id,
    Value<String>? branchId,
    Value<String>? name,
    Value<String?>? leaderId,
    Value<String>? location,
    Value<String>? meetingDay,
    Value<String>? meetingTime,
    Value<int>? capacity,
    Value<int>? rowid,
  }) {
    return SmallGroupsCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      id: id ?? this.id,
      branchId: branchId ?? this.branchId,
      name: name ?? this.name,
      leaderId: leaderId ?? this.leaderId,
      location: location ?? this.location,
      meetingDay: meetingDay ?? this.meetingDay,
      meetingTime: meetingTime ?? this.meetingTime,
      capacity: capacity ?? this.capacity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (leaderId.present) {
      map['leader_id'] = Variable<String>(leaderId.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (meetingDay.present) {
      map['meeting_day'] = Variable<String>(meetingDay.value);
    }
    if (meetingTime.present) {
      map['meeting_time'] = Variable<String>(meetingTime.value);
    }
    if (capacity.present) {
      map['capacity'] = Variable<int>(capacity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SmallGroupsCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('id: $id, ')
          ..write('branchId: $branchId, ')
          ..write('name: $name, ')
          ..write('leaderId: $leaderId, ')
          ..write('location: $location, ')
          ..write('meetingDay: $meetingDay, ')
          ..write('meetingTime: $meetingTime, ')
          ..write('capacity: $capacity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PermissionOverridesTable extends PermissionOverrides
    with TableInfo<$PermissionOverridesTable, PermissionOverrideRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PermissionOverridesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moduleMeta = const VerificationMeta('module');
  @override
  late final GeneratedColumn<String> module = GeneratedColumn<String>(
    'module',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<String> level = GeneratedColumn<String>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    createdAt,
    updatedAt,
    deletedAt,
    module,
    role,
    level,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'permission_overrides';
  @override
  VerificationContext validateIntegrity(
    Insertable<PermissionOverrideRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('module')) {
      context.handle(
        _moduleMeta,
        module.isAcceptableOrUnknown(data['module']!, _moduleMeta),
      );
    } else if (isInserting) {
      context.missing(_moduleMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {module, role};
  @override
  PermissionOverrideRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PermissionOverrideRow(
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      module: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}module'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}level'],
      )!,
    );
  }

  @override
  $PermissionOverridesTable createAlias(String alias) {
    return $PermissionOverridesTable(attachedDatabase, alias);
  }
}

class PermissionOverrideRow extends DataClass
    implements Insertable<PermissionOverrideRow> {
  final DateTime createdAt;
  final DateTime updatedAt;

  /// Set instead of deleting the row. All queries filter these out.
  final DateTime? deletedAt;

  /// The module name as it appears in the matrix, e.g. 'Attendance'.
  final String module;

  /// The [UserRole] name, e.g. 'branchAdmin'.
  final String role;

  /// The [PermissionLevel] name, e.g. 'read'.
  final String level;
  const PermissionOverrideRow({
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.module,
    required this.role,
    required this.level,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['module'] = Variable<String>(module);
    map['role'] = Variable<String>(role);
    map['level'] = Variable<String>(level);
    return map;
  }

  PermissionOverridesCompanion toCompanion(bool nullToAbsent) {
    return PermissionOverridesCompanion(
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      module: Value(module),
      role: Value(role),
      level: Value(level),
    );
  }

  factory PermissionOverrideRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PermissionOverrideRow(
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      module: serializer.fromJson<String>(json['module']),
      role: serializer.fromJson<String>(json['role']),
      level: serializer.fromJson<String>(json['level']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'module': serializer.toJson<String>(module),
      'role': serializer.toJson<String>(role),
      'level': serializer.toJson<String>(level),
    };
  }

  PermissionOverrideRow copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? module,
    String? role,
    String? level,
  }) => PermissionOverrideRow(
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    module: module ?? this.module,
    role: role ?? this.role,
    level: level ?? this.level,
  );
  PermissionOverrideRow copyWithCompanion(PermissionOverridesCompanion data) {
    return PermissionOverrideRow(
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      module: data.module.present ? data.module.value : this.module,
      role: data.role.present ? data.role.value : this.role,
      level: data.level.present ? data.level.value : this.level,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PermissionOverrideRow(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('module: $module, ')
          ..write('role: $role, ')
          ..write('level: $level')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(createdAt, updatedAt, deletedAt, module, role, level);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PermissionOverrideRow &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.module == this.module &&
          other.role == this.role &&
          other.level == this.level);
}

class PermissionOverridesCompanion
    extends UpdateCompanion<PermissionOverrideRow> {
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> module;
  final Value<String> role;
  final Value<String> level;
  final Value<int> rowid;
  const PermissionOverridesCompanion({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.module = const Value.absent(),
    this.role = const Value.absent(),
    this.level = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PermissionOverridesCompanion.insert({
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String module,
    required String role,
    required String level,
    this.rowid = const Value.absent(),
  }) : module = Value(module),
       role = Value(role),
       level = Value(level);
  static Insertable<PermissionOverrideRow> custom({
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? module,
    Expression<String>? role,
    Expression<String>? level,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (module != null) 'module': module,
      if (role != null) 'role': role,
      if (level != null) 'level': level,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PermissionOverridesCompanion copyWith({
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? module,
    Value<String>? role,
    Value<String>? level,
    Value<int>? rowid,
  }) {
    return PermissionOverridesCompanion(
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      module: module ?? this.module,
      role: role ?? this.role,
      level: level ?? this.level,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (module.present) {
      map['module'] = Variable<String>(module.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (level.present) {
      map['level'] = Variable<String>(level.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissionOverridesCompanion(')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('module: $module, ')
          ..write('role: $role, ')
          ..write('level: $level, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingRow extends DataClass implements Insertable<SettingRow> {
  final String key;
  final String value;
  const SettingRow({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory SettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  SettingRow copyWith({String? key, String? value}) =>
      SettingRow(key: key ?? this.key, value: value ?? this.value);
  SettingRow copyWithCompanion(SettingsCompanion data) {
    return SettingRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingRow(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingRow &&
          other.key == this.key &&
          other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<SettingRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<SettingRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BranchesTable branches = $BranchesTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $DepartmentTypesTable departmentTypes = $DepartmentTypesTable(
    this,
  );
  late final $DepartmentsTable departments = $DepartmentsTable(this);
  late final $DepartmentMembersTable departmentMembers =
      $DepartmentMembersTable(this);
  late final $UserAccountsTable userAccounts = $UserAccountsTable(this);
  late final $AttendanceRecordsTable attendanceRecords =
      $AttendanceRecordsTable(this);
  late final $CheckInsTable checkIns = $CheckInsTable(this);
  late final $DonationsTable donations = $DonationsTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $PledgesTable pledges = $PledgesTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $CareRequestsTable careRequests = $CareRequestsTable(this);
  late final $VolunteerSlotsTable volunteerSlots = $VolunteerSlotsTable(this);
  late final $AssetsTable assets = $AssetsTable(this);
  late final $CampaignsTable campaigns = $CampaignsTable(this);
  late final $AnnouncementsTable announcements = $AnnouncementsTable(this);
  late final $CoursesTable courses = $CoursesTable(this);
  late final $SmallGroupsTable smallGroups = $SmallGroupsTable(this);
  late final $PermissionOverridesTable permissionOverrides =
      $PermissionOverridesTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    branches,
    members,
    departmentTypes,
    departments,
    departmentMembers,
    userAccounts,
    attendanceRecords,
    checkIns,
    donations,
    expenses,
    pledges,
    events,
    careRequests,
    volunteerSlots,
    assets,
    campaigns,
    announcements,
    courses,
    smallGroups,
    permissionOverrides,
    settings,
  ];
}

typedef $$BranchesTableCreateCompanionBuilder =
    BranchesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      required String code,
      required String addressLine,
      required String city,
      required String state,
      Value<String> country,
      required String status,
      required DateTime establishedAt,
      Value<String?> pastorId,
      Value<String?> assistantPastorId,
      required String accent,
      Value<bool> isHeadquarters,
      Value<String> phone,
      Value<String> email,
      Value<String> website,
      Value<int> rowid,
    });
typedef $$BranchesTableUpdateCompanionBuilder =
    BranchesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String> code,
      Value<String> addressLine,
      Value<String> city,
      Value<String> state,
      Value<String> country,
      Value<String> status,
      Value<DateTime> establishedAt,
      Value<String?> pastorId,
      Value<String?> assistantPastorId,
      Value<String> accent,
      Value<bool> isHeadquarters,
      Value<String> phone,
      Value<String> email,
      Value<String> website,
      Value<int> rowid,
    });

final class $$BranchesTableReferences
    extends BaseReferences<_$AppDatabase, $BranchesTable, BranchRow> {
  $$BranchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MembersTable, List<MemberRow>> _membersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.members,
    aliasName: 'branches__id__members__branch_id',
  );

  $$MembersTableProcessedTableManager get membersRefs {
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_membersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DepartmentsTable, List<DepartmentRow>>
  _departmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.departments,
    aliasName: 'branches__id__departments__branch_id',
  );

  $$DepartmentsTableProcessedTableManager get departmentsRefs {
    final manager = $$DepartmentsTableTableManager(
      $_db,
      $_db.departments,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_departmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserAccountsTable, List<UserAccountRow>>
  _userAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAccounts,
    aliasName: 'branches__id__user_accounts__branch_id',
  );

  $$UserAccountsTableProcessedTableManager get userAccountsRefs {
    final manager = $$UserAccountsTableTableManager(
      $_db,
      $_db.userAccounts,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userAccountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AttendanceRecordsTable, List<AttendanceRow>>
  _attendanceRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.attendanceRecords,
        aliasName: 'branches__id__attendance_records__branch_id',
      );

  $$AttendanceRecordsTableProcessedTableManager get attendanceRecordsRefs {
    final manager = $$AttendanceRecordsTableTableManager(
      $_db,
      $_db.attendanceRecords,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attendanceRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DonationsTable, List<DonationRow>>
  _donationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.donations,
    aliasName: 'branches__id__donations__branch_id',
  );

  $$DonationsTableProcessedTableManager get donationsRefs {
    final manager = $$DonationsTableTableManager(
      $_db,
      $_db.donations,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_donationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<ExpenseRow>>
  _expensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'branches__id__expenses__branch_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PledgesTable, List<PledgeRow>> _pledgesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pledges,
    aliasName: 'branches__id__pledges__branch_id',
  );

  $$PledgesTableProcessedTableManager get pledgesRefs {
    final manager = $$PledgesTableTableManager(
      $_db,
      $_db.pledges,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pledgesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EventsTable, List<EventRow>> _eventsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.events,
    aliasName: 'branches__id__events__branch_id',
  );

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager(
      $_db,
      $_db.events,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareRequestsTable, List<CareRequestRow>>
  _careRequestsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careRequests,
    aliasName: 'branches__id__care_requests__branch_id',
  );

  $$CareRequestsTableProcessedTableManager get careRequestsRefs {
    final manager = $$CareRequestsTableTableManager(
      $_db,
      $_db.careRequests,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careRequestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VolunteerSlotsTable, List<VolunteerSlotRow>>
  _volunteerSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.volunteerSlots,
    aliasName: 'branches__id__volunteer_slots__branch_id',
  );

  $$VolunteerSlotsTableProcessedTableManager get volunteerSlotsRefs {
    final manager = $$VolunteerSlotsTableTableManager(
      $_db,
      $_db.volunteerSlots,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_volunteerSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AssetsTable, List<AssetRow>> _assetsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.assets,
    aliasName: 'branches__id__assets__branch_id',
  );

  $$AssetsTableProcessedTableManager get assetsRefs {
    final manager = $$AssetsTableTableManager(
      $_db,
      $_db.assets,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_assetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CampaignsTable, List<CampaignRow>>
  _campaignsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.campaigns,
    aliasName: 'branches__id__campaigns__branch_id',
  );

  $$CampaignsTableProcessedTableManager get campaignsRefs {
    final manager = $$CampaignsTableTableManager(
      $_db,
      $_db.campaigns,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_campaignsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnnouncementsTable, List<AnnouncementRow>>
  _announcementsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.announcements,
    aliasName: 'branches__id__announcements__branch_id',
  );

  $$AnnouncementsTableProcessedTableManager get announcementsRefs {
    final manager = $$AnnouncementsTableTableManager(
      $_db,
      $_db.announcements,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_announcementsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoursesTable, List<CourseRow>> _coursesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.courses,
    aliasName: 'branches__id__courses__branch_id',
  );

  $$CoursesTableProcessedTableManager get coursesRefs {
    final manager = $$CoursesTableTableManager(
      $_db,
      $_db.courses,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_coursesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SmallGroupsTable, List<SmallGroupRow>>
  _smallGroupsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.smallGroups,
    aliasName: 'branches__id__small_groups__branch_id',
  );

  $$SmallGroupsTableProcessedTableManager get smallGroupsRefs {
    final manager = $$SmallGroupsTableTableManager(
      $_db,
      $_db.smallGroups,
    ).filter((f) => f.branchId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_smallGroupsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
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

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get establishedAt => $composableBuilder(
    column: $table.establishedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pastorId => $composableBuilder(
    column: $table.pastorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assistantPastorId => $composableBuilder(
    column: $table.assistantPastorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHeadquarters => $composableBuilder(
    column: $table.isHeadquarters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> membersRefs(
    Expression<bool> Function($$MembersTableFilterComposer f) f,
  ) {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> departmentsRefs(
    Expression<bool> Function($$DepartmentsTableFilterComposer f) f,
  ) {
    final $$DepartmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableFilterComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userAccountsRefs(
    Expression<bool> Function($$UserAccountsTableFilterComposer f) f,
  ) {
    final $$UserAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAccounts,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAccountsTableFilterComposer(
            $db: $db,
            $table: $db.userAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> attendanceRecordsRefs(
    Expression<bool> Function($$AttendanceRecordsTableFilterComposer f) f,
  ) {
    final $$AttendanceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceRecords,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.attendanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> donationsRefs(
    Expression<bool> Function($$DonationsTableFilterComposer f) f,
  ) {
    final $$DonationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donations,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonationsTableFilterComposer(
            $db: $db,
            $table: $db.donations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pledgesRefs(
    Expression<bool> Function($$PledgesTableFilterComposer f) f,
  ) {
    final $$PledgesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pledges,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PledgesTableFilterComposer(
            $db: $db,
            $table: $db.pledges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> eventsRefs(
    Expression<bool> Function($$EventsTableFilterComposer f) f,
  ) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableFilterComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careRequestsRefs(
    Expression<bool> Function($$CareRequestsTableFilterComposer f) f,
  ) {
    final $$CareRequestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRequests,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRequestsTableFilterComposer(
            $db: $db,
            $table: $db.careRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> volunteerSlotsRefs(
    Expression<bool> Function($$VolunteerSlotsTableFilterComposer f) f,
  ) {
    final $$VolunteerSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.volunteerSlots,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolunteerSlotsTableFilterComposer(
            $db: $db,
            $table: $db.volunteerSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> assetsRefs(
    Expression<bool> Function($$AssetsTableFilterComposer f) f,
  ) {
    final $$AssetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableFilterComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> campaignsRefs(
    Expression<bool> Function($$CampaignsTableFilterComposer f) f,
  ) {
    final $$CampaignsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableFilterComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> announcementsRefs(
    Expression<bool> Function($$AnnouncementsTableFilterComposer f) f,
  ) {
    final $$AnnouncementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.announcements,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnouncementsTableFilterComposer(
            $db: $db,
            $table: $db.announcements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coursesRefs(
    Expression<bool> Function($$CoursesTableFilterComposer f) f,
  ) {
    final $$CoursesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableFilterComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> smallGroupsRefs(
    Expression<bool> Function($$SmallGroupsTableFilterComposer f) f,
  ) {
    final $$SmallGroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smallGroups,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmallGroupsTableFilterComposer(
            $db: $db,
            $table: $db.smallGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
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

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get establishedAt => $composableBuilder(
    column: $table.establishedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pastorId => $composableBuilder(
    column: $table.pastorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assistantPastorId => $composableBuilder(
    column: $table.assistantPastorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHeadquarters => $composableBuilder(
    column: $table.isHeadquarters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get establishedAt => $composableBuilder(
    column: $table.establishedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pastorId =>
      $composableBuilder(column: $table.pastorId, builder: (column) => column);

  GeneratedColumn<String> get assistantPastorId => $composableBuilder(
    column: $table.assistantPastorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<bool> get isHeadquarters => $composableBuilder(
    column: $table.isHeadquarters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  Expression<T> membersRefs<T extends Object>(
    Expression<T> Function($$MembersTableAnnotationComposer a) f,
  ) {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> departmentsRefs<T extends Object>(
    Expression<T> Function($$DepartmentsTableAnnotationComposer a) f,
  ) {
    final $$DepartmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userAccountsRefs<T extends Object>(
    Expression<T> Function($$UserAccountsTableAnnotationComposer a) f,
  ) {
    final $$UserAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAccounts,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.userAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> attendanceRecordsRefs<T extends Object>(
    Expression<T> Function($$AttendanceRecordsTableAnnotationComposer a) f,
  ) {
    final $$AttendanceRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.attendanceRecords,
          getReferencedColumn: (t) => t.branchId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AttendanceRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.attendanceRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> donationsRefs<T extends Object>(
    Expression<T> Function($$DonationsTableAnnotationComposer a) f,
  ) {
    final $$DonationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donations,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonationsTableAnnotationComposer(
            $db: $db,
            $table: $db.donations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pledgesRefs<T extends Object>(
    Expression<T> Function($$PledgesTableAnnotationComposer a) f,
  ) {
    final $$PledgesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pledges,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PledgesTableAnnotationComposer(
            $db: $db,
            $table: $db.pledges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
    Expression<T> Function($$EventsTableAnnotationComposer a) f,
  ) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.events,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventsTableAnnotationComposer(
            $db: $db,
            $table: $db.events,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careRequestsRefs<T extends Object>(
    Expression<T> Function($$CareRequestsTableAnnotationComposer a) f,
  ) {
    final $$CareRequestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRequests,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRequestsTableAnnotationComposer(
            $db: $db,
            $table: $db.careRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> volunteerSlotsRefs<T extends Object>(
    Expression<T> Function($$VolunteerSlotsTableAnnotationComposer a) f,
  ) {
    final $$VolunteerSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.volunteerSlots,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolunteerSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.volunteerSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> assetsRefs<T extends Object>(
    Expression<T> Function($$AssetsTableAnnotationComposer a) f,
  ) {
    final $$AssetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.assets,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AssetsTableAnnotationComposer(
            $db: $db,
            $table: $db.assets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> campaignsRefs<T extends Object>(
    Expression<T> Function($$CampaignsTableAnnotationComposer a) f,
  ) {
    final $$CampaignsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.campaigns,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CampaignsTableAnnotationComposer(
            $db: $db,
            $table: $db.campaigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> announcementsRefs<T extends Object>(
    Expression<T> Function($$AnnouncementsTableAnnotationComposer a) f,
  ) {
    final $$AnnouncementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.announcements,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnnouncementsTableAnnotationComposer(
            $db: $db,
            $table: $db.announcements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coursesRefs<T extends Object>(
    Expression<T> Function($$CoursesTableAnnotationComposer a) f,
  ) {
    final $$CoursesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.courses,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoursesTableAnnotationComposer(
            $db: $db,
            $table: $db.courses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> smallGroupsRefs<T extends Object>(
    Expression<T> Function($$SmallGroupsTableAnnotationComposer a) f,
  ) {
    final $$SmallGroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.smallGroups,
      getReferencedColumn: (t) => t.branchId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SmallGroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.smallGroups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BranchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchesTable,
          BranchRow,
          $$BranchesTableFilterComposer,
          $$BranchesTableOrderingComposer,
          $$BranchesTableAnnotationComposer,
          $$BranchesTableCreateCompanionBuilder,
          $$BranchesTableUpdateCompanionBuilder,
          (BranchRow, $$BranchesTableReferences),
          BranchRow,
          PrefetchHooks Function({
            bool membersRefs,
            bool departmentsRefs,
            bool userAccountsRefs,
            bool attendanceRecordsRefs,
            bool donationsRefs,
            bool expensesRefs,
            bool pledgesRefs,
            bool eventsRefs,
            bool careRequestsRefs,
            bool volunteerSlotsRefs,
            bool assetsRefs,
            bool campaignsRefs,
            bool announcementsRefs,
            bool coursesRefs,
            bool smallGroupsRefs,
          })
        > {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> addressLine = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> establishedAt = const Value.absent(),
                Value<String?> pastorId = const Value.absent(),
                Value<String?> assistantPastorId = const Value.absent(),
                Value<String> accent = const Value.absent(),
                Value<bool> isHeadquarters = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> website = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                code: code,
                addressLine: addressLine,
                city: city,
                state: state,
                country: country,
                status: status,
                establishedAt: establishedAt,
                pastorId: pastorId,
                assistantPastorId: assistantPastorId,
                accent: accent,
                isHeadquarters: isHeadquarters,
                phone: phone,
                email: email,
                website: website,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String code,
                required String addressLine,
                required String city,
                required String state,
                Value<String> country = const Value.absent(),
                required String status,
                required DateTime establishedAt,
                Value<String?> pastorId = const Value.absent(),
                Value<String?> assistantPastorId = const Value.absent(),
                required String accent,
                Value<bool> isHeadquarters = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> website = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BranchesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                code: code,
                addressLine: addressLine,
                city: city,
                state: state,
                country: country,
                status: status,
                establishedAt: establishedAt,
                pastorId: pastorId,
                assistantPastorId: assistantPastorId,
                accent: accent,
                isHeadquarters: isHeadquarters,
                phone: phone,
                email: email,
                website: website,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BranchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                membersRefs = false,
                departmentsRefs = false,
                userAccountsRefs = false,
                attendanceRecordsRefs = false,
                donationsRefs = false,
                expensesRefs = false,
                pledgesRefs = false,
                eventsRefs = false,
                careRequestsRefs = false,
                volunteerSlotsRefs = false,
                assetsRefs = false,
                campaignsRefs = false,
                announcementsRefs = false,
                coursesRefs = false,
                smallGroupsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (membersRefs) db.members,
                    if (departmentsRefs) db.departments,
                    if (userAccountsRefs) db.userAccounts,
                    if (attendanceRecordsRefs) db.attendanceRecords,
                    if (donationsRefs) db.donations,
                    if (expensesRefs) db.expenses,
                    if (pledgesRefs) db.pledges,
                    if (eventsRefs) db.events,
                    if (careRequestsRefs) db.careRequests,
                    if (volunteerSlotsRefs) db.volunteerSlots,
                    if (assetsRefs) db.assets,
                    if (campaignsRefs) db.campaigns,
                    if (announcementsRefs) db.announcements,
                    if (coursesRefs) db.courses,
                    if (smallGroupsRefs) db.smallGroups,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (membersRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          MemberRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._membersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).membersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (departmentsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          DepartmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._departmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).departmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userAccountsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          UserAccountRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._userAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).userAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (attendanceRecordsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          AttendanceRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._attendanceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceRecordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (donationsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          DonationRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._donationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).donationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          ExpenseRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pledgesRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          PledgeRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._pledgesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).pledgesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (eventsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          EventRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._eventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).eventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (careRequestsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          CareRequestRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._careRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).careRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (volunteerSlotsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          VolunteerSlotRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._volunteerSlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).volunteerSlotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (assetsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          AssetRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._assetsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).assetsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (campaignsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          CampaignRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._campaignsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).campaignsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (announcementsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          AnnouncementRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._announcementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).announcementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coursesRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          CourseRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._coursesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).coursesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (smallGroupsRefs)
                        await $_getPrefetchedData<
                          BranchRow,
                          $BranchesTable,
                          SmallGroupRow
                        >(
                          currentTable: table,
                          referencedTable: $$BranchesTableReferences
                              ._smallGroupsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BranchesTableReferences(
                                db,
                                table,
                                p0,
                              ).smallGroupsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.branchId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BranchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchesTable,
      BranchRow,
      $$BranchesTableFilterComposer,
      $$BranchesTableOrderingComposer,
      $$BranchesTableAnnotationComposer,
      $$BranchesTableCreateCompanionBuilder,
      $$BranchesTableUpdateCompanionBuilder,
      (BranchRow, $$BranchesTableReferences),
      BranchRow,
      PrefetchHooks Function({
        bool membersRefs,
        bool departmentsRefs,
        bool userAccountsRefs,
        bool attendanceRecordsRefs,
        bool donationsRefs,
        bool expensesRefs,
        bool pledgesRefs,
        bool eventsRefs,
        bool careRequestsRefs,
        bool volunteerSlotsRefs,
        bool assetsRefs,
        bool campaignsRefs,
        bool announcementsRefs,
        bool coursesRefs,
        bool smallGroupsRefs,
      })
    >;
typedef $$MembersTableCreateCompanionBuilder =
    MembersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String firstName,
      required String lastName,
      Value<String> email,
      Value<String> phone,
      required String gender,
      required DateTime dateOfBirth,
      required String maritalStatus,
      required String status,
      required DateTime joinedAt,
      Value<String> addressLine,
      Value<String> city,
      Value<String> state,
      Value<String> country,
      Value<bool> isBaptized,
      Value<String> title,
      Value<String> photo,
      required String branchId,
      Value<String?> groupId,
      Value<String?> familyId,
      Value<String?> notes,
      Value<String> tags,
      Value<int> rowid,
    });
typedef $$MembersTableUpdateCompanionBuilder =
    MembersCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String> email,
      Value<String> phone,
      Value<String> gender,
      Value<DateTime> dateOfBirth,
      Value<String> maritalStatus,
      Value<String> status,
      Value<DateTime> joinedAt,
      Value<String> addressLine,
      Value<String> city,
      Value<String> state,
      Value<String> country,
      Value<bool> isBaptized,
      Value<String> title,
      Value<String> photo,
      Value<String> branchId,
      Value<String?> groupId,
      Value<String?> familyId,
      Value<String?> notes,
      Value<String> tags,
      Value<int> rowid,
    });

final class $$MembersTableReferences
    extends BaseReferences<_$AppDatabase, $MembersTable, MemberRow> {
  $$MembersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('members__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DepartmentsTable, List<DepartmentRow>>
  _headedDepartmentsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.departments,
    aliasName: 'members__id__departments__head_id',
  );

  $$DepartmentsTableProcessedTableManager get headedDepartments {
    final manager = $$DepartmentsTableTableManager(
      $_db,
      $_db.departments,
    ).filter((f) => f.headId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_headedDepartmentsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DepartmentsTable, List<DepartmentRow>>
  _assistedDepartmentsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.departments,
    aliasName: 'members__id__departments__assistant_head_id',
  );

  $$DepartmentsTableProcessedTableManager get assistedDepartments {
    final manager = $$DepartmentsTableTableManager($_db, $_db.departments)
        .filter(
          (f) => f.assistantHeadId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _assistedDepartmentsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DepartmentMembersTable, List<DepartmentMemberRow>>
  _departmentMembersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.departmentMembers,
        aliasName: 'members__id__department_members__member_id',
      );

  $$DepartmentMembersTableProcessedTableManager get departmentMembersRefs {
    final manager = $$DepartmentMembersTableTableManager(
      $_db,
      $_db.departmentMembers,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _departmentMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserAccountsTable, List<UserAccountRow>>
  _userAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAccounts,
    aliasName: 'members__id__user_accounts__member_id',
  );

  $$UserAccountsTableProcessedTableManager get userAccountsRefs {
    final manager = $$UserAccountsTableTableManager(
      $_db,
      $_db.userAccounts,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userAccountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CheckInsTable, List<CheckInRow>>
  _checkInsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkIns,
    aliasName: 'members__id__check_ins__member_id',
  );

  $$CheckInsTableProcessedTableManager get checkInsRefs {
    final manager = $$CheckInsTableTableManager(
      $_db,
      $_db.checkIns,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DonationsTable, List<DonationRow>>
  _donationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.donations,
    aliasName: 'members__id__donations__member_id',
  );

  $$DonationsTableProcessedTableManager get donationsRefs {
    final manager = $$DonationsTableTableManager(
      $_db,
      $_db.donations,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_donationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PledgesTable, List<PledgeRow>> _pledgesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pledges,
    aliasName: 'members__id__pledges__member_id',
  );

  $$PledgesTableProcessedTableManager get pledgesRefs {
    final manager = $$PledgesTableTableManager(
      $_db,
      $_db.pledges,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pledgesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareRequestsTable, List<CareRequestRow>>
  _careRequestsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.careRequests,
    aliasName: 'members__id__care_requests__member_id',
  );

  $$CareRequestsTableProcessedTableManager get careRequestsRefs {
    final manager = $$CareRequestsTableTableManager(
      $_db,
      $_db.careRequests,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careRequestsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VolunteerSlotsTable, List<VolunteerSlotRow>>
  _volunteerSlotsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.volunteerSlots,
    aliasName: 'members__id__volunteer_slots__member_id',
  );

  $$VolunteerSlotsTableProcessedTableManager get volunteerSlotsRefs {
    final manager = $$VolunteerSlotsTableTableManager(
      $_db,
      $_db.volunteerSlots,
    ).filter((f) => f.memberId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_volunteerSlotsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get maritalStatus => $composableBuilder(
    column: $table.maritalStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
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

  ColumnFilters<bool> get isBaptized => $composableBuilder(
    column: $table.isBaptized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get familyId => $composableBuilder(
    column: $table.familyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> headedDepartments(
    Expression<bool> Function($$DepartmentsTableFilterComposer f) f,
  ) {
    final $$DepartmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.headId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableFilterComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> assistedDepartments(
    Expression<bool> Function($$DepartmentsTableFilterComposer f) f,
  ) {
    final $$DepartmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.assistantHeadId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableFilterComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> departmentMembersRefs(
    Expression<bool> Function($$DepartmentMembersTableFilterComposer f) f,
  ) {
    final $$DepartmentMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departmentMembers,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentMembersTableFilterComposer(
            $db: $db,
            $table: $db.departmentMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userAccountsRefs(
    Expression<bool> Function($$UserAccountsTableFilterComposer f) f,
  ) {
    final $$UserAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAccounts,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAccountsTableFilterComposer(
            $db: $db,
            $table: $db.userAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> checkInsRefs(
    Expression<bool> Function($$CheckInsTableFilterComposer f) f,
  ) {
    final $$CheckInsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableFilterComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> donationsRefs(
    Expression<bool> Function($$DonationsTableFilterComposer f) f,
  ) {
    final $$DonationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donations,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonationsTableFilterComposer(
            $db: $db,
            $table: $db.donations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pledgesRefs(
    Expression<bool> Function($$PledgesTableFilterComposer f) f,
  ) {
    final $$PledgesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pledges,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PledgesTableFilterComposer(
            $db: $db,
            $table: $db.pledges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careRequestsRefs(
    Expression<bool> Function($$CareRequestsTableFilterComposer f) f,
  ) {
    final $$CareRequestsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRequests,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRequestsTableFilterComposer(
            $db: $db,
            $table: $db.careRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> volunteerSlotsRefs(
    Expression<bool> Function($$VolunteerSlotsTableFilterComposer f) f,
  ) {
    final $$VolunteerSlotsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.volunteerSlots,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolunteerSlotsTableFilterComposer(
            $db: $db,
            $table: $db.volunteerSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get maritalStatus => $composableBuilder(
    column: $table.maritalStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
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

  ColumnOrderings<bool> get isBaptized => $composableBuilder(
    column: $table.isBaptized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get familyId => $composableBuilder(
    column: $table.familyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get maritalStatus => $composableBuilder(
    column: $table.maritalStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  GeneratedColumn<String> get addressLine => $composableBuilder(
    column: $table.addressLine,
    builder: (column) => column,
  );

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<bool> get isBaptized => $composableBuilder(
    column: $table.isBaptized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get familyId =>
      $composableBuilder(column: $table.familyId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> headedDepartments<T extends Object>(
    Expression<T> Function($$DepartmentsTableAnnotationComposer a) f,
  ) {
    final $$DepartmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.headId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> assistedDepartments<T extends Object>(
    Expression<T> Function($$DepartmentsTableAnnotationComposer a) f,
  ) {
    final $$DepartmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.assistantHeadId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> departmentMembersRefs<T extends Object>(
    Expression<T> Function($$DepartmentMembersTableAnnotationComposer a) f,
  ) {
    final $$DepartmentMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.departmentMembers,
          getReferencedColumn: (t) => t.memberId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DepartmentMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.departmentMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> userAccountsRefs<T extends Object>(
    Expression<T> Function($$UserAccountsTableAnnotationComposer a) f,
  ) {
    final $$UserAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAccounts,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.userAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> checkInsRefs<T extends Object>(
    Expression<T> Function($$CheckInsTableAnnotationComposer a) f,
  ) {
    final $$CheckInsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> donationsRefs<T extends Object>(
    Expression<T> Function($$DonationsTableAnnotationComposer a) f,
  ) {
    final $$DonationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.donations,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DonationsTableAnnotationComposer(
            $db: $db,
            $table: $db.donations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pledgesRefs<T extends Object>(
    Expression<T> Function($$PledgesTableAnnotationComposer a) f,
  ) {
    final $$PledgesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pledges,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PledgesTableAnnotationComposer(
            $db: $db,
            $table: $db.pledges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careRequestsRefs<T extends Object>(
    Expression<T> Function($$CareRequestsTableAnnotationComposer a) f,
  ) {
    final $$CareRequestsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careRequests,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareRequestsTableAnnotationComposer(
            $db: $db,
            $table: $db.careRequests,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> volunteerSlotsRefs<T extends Object>(
    Expression<T> Function($$VolunteerSlotsTableAnnotationComposer a) f,
  ) {
    final $$VolunteerSlotsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.volunteerSlots,
      getReferencedColumn: (t) => t.memberId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VolunteerSlotsTableAnnotationComposer(
            $db: $db,
            $table: $db.volunteerSlots,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          MemberRow,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (MemberRow, $$MembersTableReferences),
          MemberRow,
          PrefetchHooks Function({
            bool branchId,
            bool headedDepartments,
            bool assistedDepartments,
            bool departmentMembersRefs,
            bool userAccountsRefs,
            bool checkInsRefs,
            bool donationsRefs,
            bool pledgesRefs,
            bool careRequestsRefs,
            bool volunteerSlotsRefs,
          })
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
                Value<String> maritalStatus = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<String> addressLine = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<bool> isBaptized = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> photo = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                Value<String?> familyId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                gender: gender,
                dateOfBirth: dateOfBirth,
                maritalStatus: maritalStatus,
                status: status,
                joinedAt: joinedAt,
                addressLine: addressLine,
                city: city,
                state: state,
                country: country,
                isBaptized: isBaptized,
                title: title,
                photo: photo,
                branchId: branchId,
                groupId: groupId,
                familyId: familyId,
                notes: notes,
                tags: tags,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String firstName,
                required String lastName,
                Value<String> email = const Value.absent(),
                Value<String> phone = const Value.absent(),
                required String gender,
                required DateTime dateOfBirth,
                required String maritalStatus,
                required String status,
                required DateTime joinedAt,
                Value<String> addressLine = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<bool> isBaptized = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> photo = const Value.absent(),
                required String branchId,
                Value<String?> groupId = const Value.absent(),
                Value<String?> familyId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MembersCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                firstName: firstName,
                lastName: lastName,
                email: email,
                phone: phone,
                gender: gender,
                dateOfBirth: dateOfBirth,
                maritalStatus: maritalStatus,
                status: status,
                joinedAt: joinedAt,
                addressLine: addressLine,
                city: city,
                state: state,
                country: country,
                isBaptized: isBaptized,
                title: title,
                photo: photo,
                branchId: branchId,
                groupId: groupId,
                familyId: familyId,
                notes: notes,
                tags: tags,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                branchId = false,
                headedDepartments = false,
                assistedDepartments = false,
                departmentMembersRefs = false,
                userAccountsRefs = false,
                checkInsRefs = false,
                donationsRefs = false,
                pledgesRefs = false,
                careRequestsRefs = false,
                volunteerSlotsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (headedDepartments) db.departments,
                    if (assistedDepartments) db.departments,
                    if (departmentMembersRefs) db.departmentMembers,
                    if (userAccountsRefs) db.userAccounts,
                    if (checkInsRefs) db.checkIns,
                    if (donationsRefs) db.donations,
                    if (pledgesRefs) db.pledges,
                    if (careRequestsRefs) db.careRequests,
                    if (volunteerSlotsRefs) db.volunteerSlots,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (branchId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.branchId,
                                    referencedTable: $$MembersTableReferences
                                        ._branchIdTable(db),
                                    referencedColumn: $$MembersTableReferences
                                        ._branchIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (headedDepartments)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          DepartmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._headedDepartmentsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).headedDepartments,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.headId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (assistedDepartments)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          DepartmentRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._assistedDepartmentsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).assistedDepartments,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.assistantHeadId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (departmentMembersRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          DepartmentMemberRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._departmentMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).departmentMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userAccountsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          UserAccountRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._userAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).userAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (checkInsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          CheckInRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._checkInsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).checkInsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (donationsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          DonationRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._donationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).donationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pledgesRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          PledgeRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._pledgesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).pledgesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (careRequestsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          CareRequestRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._careRequestsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).careRequestsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (volunteerSlotsRefs)
                        await $_getPrefetchedData<
                          MemberRow,
                          $MembersTable,
                          VolunteerSlotRow
                        >(
                          currentTable: table,
                          referencedTable: $$MembersTableReferences
                              ._volunteerSlotsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MembersTableReferences(
                                db,
                                table,
                                p0,
                              ).volunteerSlotsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.memberId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      MemberRow,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (MemberRow, $$MembersTableReferences),
      MemberRow,
      PrefetchHooks Function({
        bool branchId,
        bool headedDepartments,
        bool assistedDepartments,
        bool departmentMembersRefs,
        bool userAccountsRefs,
        bool checkInsRefs,
        bool donationsRefs,
        bool pledgesRefs,
        bool careRequestsRefs,
        bool volunteerSlotsRefs,
      })
    >;
typedef $$DepartmentTypesTableCreateCompanionBuilder =
    DepartmentTypesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      Value<String> description,
      Value<String> icon,
      required String accent,
      Value<bool> isCore,
      Value<int?> minAge,
      Value<int?> maxAge,
      Value<int> rowid,
    });
typedef $$DepartmentTypesTableUpdateCompanionBuilder =
    DepartmentTypesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<String> icon,
      Value<String> accent,
      Value<bool> isCore,
      Value<int?> minAge,
      Value<int?> maxAge,
      Value<int> rowid,
    });

final class $$DepartmentTypesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DepartmentTypesTable,
          DepartmentTypeRow
        > {
  $$DepartmentTypesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DepartmentsTable, List<DepartmentRow>>
  _departmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.departments,
    aliasName: 'department_types__id__departments__type_id',
  );

  $$DepartmentsTableProcessedTableManager get departmentsRefs {
    final manager = $$DepartmentsTableTableManager(
      $_db,
      $_db.departments,
    ).filter((f) => f.typeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_departmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DepartmentTypesTableFilterComposer
    extends Composer<_$AppDatabase, $DepartmentTypesTable> {
  $$DepartmentTypesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCore => $composableBuilder(
    column: $table.isCore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minAge => $composableBuilder(
    column: $table.minAge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxAge => $composableBuilder(
    column: $table.maxAge,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> departmentsRefs(
    Expression<bool> Function($$DepartmentsTableFilterComposer f) f,
  ) {
    final $$DepartmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableFilterComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DepartmentTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $DepartmentTypesTable> {
  $$DepartmentTypesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accent => $composableBuilder(
    column: $table.accent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCore => $composableBuilder(
    column: $table.isCore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minAge => $composableBuilder(
    column: $table.minAge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxAge => $composableBuilder(
    column: $table.maxAge,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DepartmentTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DepartmentTypesTable> {
  $$DepartmentTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get accent =>
      $composableBuilder(column: $table.accent, builder: (column) => column);

  GeneratedColumn<bool> get isCore =>
      $composableBuilder(column: $table.isCore, builder: (column) => column);

  GeneratedColumn<int> get minAge =>
      $composableBuilder(column: $table.minAge, builder: (column) => column);

  GeneratedColumn<int> get maxAge =>
      $composableBuilder(column: $table.maxAge, builder: (column) => column);

  Expression<T> departmentsRefs<T extends Object>(
    Expression<T> Function($$DepartmentsTableAnnotationComposer a) f,
  ) {
    final $$DepartmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.typeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DepartmentTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DepartmentTypesTable,
          DepartmentTypeRow,
          $$DepartmentTypesTableFilterComposer,
          $$DepartmentTypesTableOrderingComposer,
          $$DepartmentTypesTableAnnotationComposer,
          $$DepartmentTypesTableCreateCompanionBuilder,
          $$DepartmentTypesTableUpdateCompanionBuilder,
          (DepartmentTypeRow, $$DepartmentTypesTableReferences),
          DepartmentTypeRow,
          PrefetchHooks Function({bool departmentsRefs})
        > {
  $$DepartmentTypesTableTableManager(
    _$AppDatabase db,
    $DepartmentTypesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DepartmentTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DepartmentTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DepartmentTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<String> accent = const Value.absent(),
                Value<bool> isCore = const Value.absent(),
                Value<int?> minAge = const Value.absent(),
                Value<int?> maxAge = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepartmentTypesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                description: description,
                icon: icon,
                accent: accent,
                isCore: isCore,
                minAge: minAge,
                maxAge: maxAge,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                Value<String> description = const Value.absent(),
                Value<String> icon = const Value.absent(),
                required String accent,
                Value<bool> isCore = const Value.absent(),
                Value<int?> minAge = const Value.absent(),
                Value<int?> maxAge = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepartmentTypesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                description: description,
                icon: icon,
                accent: accent,
                isCore: isCore,
                minAge: minAge,
                maxAge: maxAge,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DepartmentTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({departmentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (departmentsRefs) db.departments],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (departmentsRefs)
                    await $_getPrefetchedData<
                      DepartmentTypeRow,
                      $DepartmentTypesTable,
                      DepartmentRow
                    >(
                      currentTable: table,
                      referencedTable: $$DepartmentTypesTableReferences
                          ._departmentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DepartmentTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).departmentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.typeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DepartmentTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DepartmentTypesTable,
      DepartmentTypeRow,
      $$DepartmentTypesTableFilterComposer,
      $$DepartmentTypesTableOrderingComposer,
      $$DepartmentTypesTableAnnotationComposer,
      $$DepartmentTypesTableCreateCompanionBuilder,
      $$DepartmentTypesTableUpdateCompanionBuilder,
      (DepartmentTypeRow, $$DepartmentTypesTableReferences),
      DepartmentTypeRow,
      PrefetchHooks Function({bool departmentsRefs})
    >;
typedef $$DepartmentsTableCreateCompanionBuilder =
    DepartmentsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String typeId,
      required String branchId,
      Value<String?> headId,
      Value<String?> assistantHeadId,
      required String meetingDay,
      required String meetingTime,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$DepartmentsTableUpdateCompanionBuilder =
    DepartmentsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> typeId,
      Value<String> branchId,
      Value<String?> headId,
      Value<String?> assistantHeadId,
      Value<String> meetingDay,
      Value<String> meetingTime,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$DepartmentsTableReferences
    extends BaseReferences<_$AppDatabase, $DepartmentsTable, DepartmentRow> {
  $$DepartmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DepartmentTypesTable _typeIdTable(_$AppDatabase db) => db
      .departmentTypes
      .createAlias('departments__type_id__department_types__id');

  $$DepartmentTypesTableProcessedTableManager get typeId {
    final $_column = $_itemColumn<String>('type_id')!;

    final manager = $$DepartmentTypesTableTableManager(
      $_db,
      $_db.departmentTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_typeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('departments__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _headIdTable(_$AppDatabase db) =>
      db.members.createAlias('departments__head_id__members__id');

  $$MembersTableProcessedTableManager? get headId {
    final $_column = $_itemColumn<String>('head_id');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_headIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _assistantHeadIdTable(_$AppDatabase db) =>
      db.members.createAlias('departments__assistant_head_id__members__id');

  $$MembersTableProcessedTableManager? get assistantHeadId {
    final $_column = $_itemColumn<String>('assistant_head_id');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_assistantHeadIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DepartmentMembersTable, List<DepartmentMemberRow>>
  _departmentMembersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.departmentMembers,
        aliasName: 'departments__id__department_members__department_id',
      );

  $$DepartmentMembersTableProcessedTableManager get departmentMembersRefs {
    final manager = $$DepartmentMembersTableTableManager(
      $_db,
      $_db.departmentMembers,
    ).filter((f) => f.departmentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _departmentMembersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserAccountsTable, List<UserAccountRow>>
  _userAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userAccounts,
    aliasName: 'departments__id__user_accounts__department_id',
  );

  $$UserAccountsTableProcessedTableManager get userAccountsRefs {
    final manager = $$UserAccountsTableTableManager(
      $_db,
      $_db.userAccounts,
    ).filter((f) => f.departmentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userAccountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DepartmentsTableFilterComposer
    extends Composer<_$AppDatabase, $DepartmentsTable> {
  $$DepartmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meetingDay => $composableBuilder(
    column: $table.meetingDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meetingTime => $composableBuilder(
    column: $table.meetingTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$DepartmentTypesTableFilterComposer get typeId {
    final $$DepartmentTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.departmentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentTypesTableFilterComposer(
            $db: $db,
            $table: $db.departmentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get headId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get assistantHeadId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assistantHeadId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> departmentMembersRefs(
    Expression<bool> Function($$DepartmentMembersTableFilterComposer f) f,
  ) {
    final $$DepartmentMembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.departmentMembers,
      getReferencedColumn: (t) => t.departmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentMembersTableFilterComposer(
            $db: $db,
            $table: $db.departmentMembers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userAccountsRefs(
    Expression<bool> Function($$UserAccountsTableFilterComposer f) f,
  ) {
    final $$UserAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAccounts,
      getReferencedColumn: (t) => t.departmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAccountsTableFilterComposer(
            $db: $db,
            $table: $db.userAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DepartmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DepartmentsTable> {
  $$DepartmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meetingDay => $composableBuilder(
    column: $table.meetingDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meetingTime => $composableBuilder(
    column: $table.meetingTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$DepartmentTypesTableOrderingComposer get typeId {
    final $$DepartmentTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.departmentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentTypesTableOrderingComposer(
            $db: $db,
            $table: $db.departmentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get headId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get assistantHeadId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assistantHeadId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepartmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DepartmentsTable> {
  $$DepartmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get meetingDay => $composableBuilder(
    column: $table.meetingDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meetingTime => $composableBuilder(
    column: $table.meetingTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$DepartmentTypesTableAnnotationComposer get typeId {
    final $$DepartmentTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.typeId,
      referencedTable: $db.departmentTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.departmentTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get headId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.headId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get assistantHeadId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.assistantHeadId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> departmentMembersRefs<T extends Object>(
    Expression<T> Function($$DepartmentMembersTableAnnotationComposer a) f,
  ) {
    final $$DepartmentMembersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.departmentMembers,
          getReferencedColumn: (t) => t.departmentId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DepartmentMembersTableAnnotationComposer(
                $db: $db,
                $table: $db.departmentMembers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> userAccountsRefs<T extends Object>(
    Expression<T> Function($$UserAccountsTableAnnotationComposer a) f,
  ) {
    final $$UserAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userAccounts,
      getReferencedColumn: (t) => t.departmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.userAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DepartmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DepartmentsTable,
          DepartmentRow,
          $$DepartmentsTableFilterComposer,
          $$DepartmentsTableOrderingComposer,
          $$DepartmentsTableAnnotationComposer,
          $$DepartmentsTableCreateCompanionBuilder,
          $$DepartmentsTableUpdateCompanionBuilder,
          (DepartmentRow, $$DepartmentsTableReferences),
          DepartmentRow,
          PrefetchHooks Function({
            bool typeId,
            bool branchId,
            bool headId,
            bool assistantHeadId,
            bool departmentMembersRefs,
            bool userAccountsRefs,
          })
        > {
  $$DepartmentsTableTableManager(_$AppDatabase db, $DepartmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DepartmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DepartmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DepartmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> typeId = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String?> headId = const Value.absent(),
                Value<String?> assistantHeadId = const Value.absent(),
                Value<String> meetingDay = const Value.absent(),
                Value<String> meetingTime = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepartmentsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                typeId: typeId,
                branchId: branchId,
                headId: headId,
                assistantHeadId: assistantHeadId,
                meetingDay: meetingDay,
                meetingTime: meetingTime,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String typeId,
                required String branchId,
                Value<String?> headId = const Value.absent(),
                Value<String?> assistantHeadId = const Value.absent(),
                required String meetingDay,
                required String meetingTime,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepartmentsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                typeId: typeId,
                branchId: branchId,
                headId: headId,
                assistantHeadId: assistantHeadId,
                meetingDay: meetingDay,
                meetingTime: meetingTime,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DepartmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                typeId = false,
                branchId = false,
                headId = false,
                assistantHeadId = false,
                departmentMembersRefs = false,
                userAccountsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (departmentMembersRefs) db.departmentMembers,
                    if (userAccountsRefs) db.userAccounts,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (typeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.typeId,
                                    referencedTable:
                                        $$DepartmentsTableReferences
                                            ._typeIdTable(db),
                                    referencedColumn:
                                        $$DepartmentsTableReferences
                                            ._typeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (branchId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.branchId,
                                    referencedTable:
                                        $$DepartmentsTableReferences
                                            ._branchIdTable(db),
                                    referencedColumn:
                                        $$DepartmentsTableReferences
                                            ._branchIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (headId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.headId,
                                    referencedTable:
                                        $$DepartmentsTableReferences
                                            ._headIdTable(db),
                                    referencedColumn:
                                        $$DepartmentsTableReferences
                                            ._headIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (assistantHeadId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.assistantHeadId,
                                    referencedTable:
                                        $$DepartmentsTableReferences
                                            ._assistantHeadIdTable(db),
                                    referencedColumn:
                                        $$DepartmentsTableReferences
                                            ._assistantHeadIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (departmentMembersRefs)
                        await $_getPrefetchedData<
                          DepartmentRow,
                          $DepartmentsTable,
                          DepartmentMemberRow
                        >(
                          currentTable: table,
                          referencedTable: $$DepartmentsTableReferences
                              ._departmentMembersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DepartmentsTableReferences(
                                db,
                                table,
                                p0,
                              ).departmentMembersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.departmentId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (userAccountsRefs)
                        await $_getPrefetchedData<
                          DepartmentRow,
                          $DepartmentsTable,
                          UserAccountRow
                        >(
                          currentTable: table,
                          referencedTable: $$DepartmentsTableReferences
                              ._userAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DepartmentsTableReferences(
                                db,
                                table,
                                p0,
                              ).userAccountsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.departmentId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DepartmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DepartmentsTable,
      DepartmentRow,
      $$DepartmentsTableFilterComposer,
      $$DepartmentsTableOrderingComposer,
      $$DepartmentsTableAnnotationComposer,
      $$DepartmentsTableCreateCompanionBuilder,
      $$DepartmentsTableUpdateCompanionBuilder,
      (DepartmentRow, $$DepartmentsTableReferences),
      DepartmentRow,
      PrefetchHooks Function({
        bool typeId,
        bool branchId,
        bool headId,
        bool assistantHeadId,
        bool departmentMembersRefs,
        bool userAccountsRefs,
      })
    >;
typedef $$DepartmentMembersTableCreateCompanionBuilder =
    DepartmentMembersCompanion Function({
      required String departmentId,
      required String memberId,
      Value<DateTime> joinedAt,
      Value<int> rowid,
    });
typedef $$DepartmentMembersTableUpdateCompanionBuilder =
    DepartmentMembersCompanion Function({
      Value<String> departmentId,
      Value<String> memberId,
      Value<DateTime> joinedAt,
      Value<int> rowid,
    });

final class $$DepartmentMembersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DepartmentMembersTable,
          DepartmentMemberRow
        > {
  $$DepartmentMembersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DepartmentsTable _departmentIdTable(_$AppDatabase db) => db
      .departments
      .createAlias('department_members__department_id__departments__id');

  $$DepartmentsTableProcessedTableManager get departmentId {
    final $_column = $_itemColumn<String>('department_id')!;

    final manager = $$DepartmentsTableTableManager(
      $_db,
      $_db.departments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_departmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('department_members__member_id__members__id');

  $$MembersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DepartmentMembersTableFilterComposer
    extends Composer<_$AppDatabase, $DepartmentMembersTable> {
  $$DepartmentMembersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DepartmentsTableFilterComposer get departmentId {
    final $$DepartmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.departmentId,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableFilterComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepartmentMembersTableOrderingComposer
    extends Composer<_$AppDatabase, $DepartmentMembersTable> {
  $$DepartmentMembersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get joinedAt => $composableBuilder(
    column: $table.joinedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DepartmentsTableOrderingComposer get departmentId {
    final $$DepartmentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.departmentId,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableOrderingComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepartmentMembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DepartmentMembersTable> {
  $$DepartmentMembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get joinedAt =>
      $composableBuilder(column: $table.joinedAt, builder: (column) => column);

  $$DepartmentsTableAnnotationComposer get departmentId {
    final $$DepartmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.departmentId,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepartmentMembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DepartmentMembersTable,
          DepartmentMemberRow,
          $$DepartmentMembersTableFilterComposer,
          $$DepartmentMembersTableOrderingComposer,
          $$DepartmentMembersTableAnnotationComposer,
          $$DepartmentMembersTableCreateCompanionBuilder,
          $$DepartmentMembersTableUpdateCompanionBuilder,
          (DepartmentMemberRow, $$DepartmentMembersTableReferences),
          DepartmentMemberRow,
          PrefetchHooks Function({bool departmentId, bool memberId})
        > {
  $$DepartmentMembersTableTableManager(
    _$AppDatabase db,
    $DepartmentMembersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DepartmentMembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DepartmentMembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DepartmentMembersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> departmentId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<DateTime> joinedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepartmentMembersCompanion(
                departmentId: departmentId,
                memberId: memberId,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String departmentId,
                required String memberId,
                Value<DateTime> joinedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepartmentMembersCompanion.insert(
                departmentId: departmentId,
                memberId: memberId,
                joinedAt: joinedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DepartmentMembersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({departmentId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (departmentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.departmentId,
                                referencedTable:
                                    $$DepartmentMembersTableReferences
                                        ._departmentIdTable(db),
                                referencedColumn:
                                    $$DepartmentMembersTableReferences
                                        ._departmentIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable:
                                    $$DepartmentMembersTableReferences
                                        ._memberIdTable(db),
                                referencedColumn:
                                    $$DepartmentMembersTableReferences
                                        ._memberIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DepartmentMembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DepartmentMembersTable,
      DepartmentMemberRow,
      $$DepartmentMembersTableFilterComposer,
      $$DepartmentMembersTableOrderingComposer,
      $$DepartmentMembersTableAnnotationComposer,
      $$DepartmentMembersTableCreateCompanionBuilder,
      $$DepartmentMembersTableUpdateCompanionBuilder,
      (DepartmentMemberRow, $$DepartmentMembersTableReferences),
      DepartmentMemberRow,
      PrefetchHooks Function({bool departmentId, bool memberId})
    >;
typedef $$UserAccountsTableCreateCompanionBuilder =
    UserAccountsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String name,
      required String username,
      required String passwordHash,
      required String passwordSalt,
      required String role,
      required String status,
      Value<String?> branchId,
      Value<String?> departmentId,
      Value<String?> memberId,
      Value<bool?> canSeeAllBranches,
      Value<DateTime?> lastActiveAt,
      Value<bool> mustChangePassword,
      Value<int> rowid,
    });
typedef $$UserAccountsTableUpdateCompanionBuilder =
    UserAccountsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> name,
      Value<String> username,
      Value<String> passwordHash,
      Value<String> passwordSalt,
      Value<String> role,
      Value<String> status,
      Value<String?> branchId,
      Value<String?> departmentId,
      Value<String?> memberId,
      Value<bool?> canSeeAllBranches,
      Value<DateTime?> lastActiveAt,
      Value<bool> mustChangePassword,
      Value<int> rowid,
    });

final class $$UserAccountsTableReferences
    extends BaseReferences<_$AppDatabase, $UserAccountsTable, UserAccountRow> {
  $$UserAccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('user_accounts__branch_id__branches__id');

  $$BranchesTableProcessedTableManager? get branchId {
    final $_column = $_itemColumn<String>('branch_id');
    if ($_column == null) return null;
    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $DepartmentsTable _departmentIdTable(_$AppDatabase db) => db
      .departments
      .createAlias('user_accounts__department_id__departments__id');

  $$DepartmentsTableProcessedTableManager? get departmentId {
    final $_column = $_itemColumn<String>('department_id');
    if ($_column == null) return null;
    final manager = $$DepartmentsTableTableManager(
      $_db,
      $_db.departments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_departmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('user_accounts__member_id__members__id');

  $$MembersTableProcessedTableManager? get memberId {
    final $_column = $_itemColumn<String>('member_id');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $UserAccountsTable> {
  $$UserAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get canSeeAllBranches => $composableBuilder(
    column: $table.canSeeAllBranches,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastActiveAt => $composableBuilder(
    column: $table.lastActiveAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mustChangePassword => $composableBuilder(
    column: $table.mustChangePassword,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DepartmentsTableFilterComposer get departmentId {
    final $$DepartmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.departmentId,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableFilterComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserAccountsTable> {
  $$UserAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get canSeeAllBranches => $composableBuilder(
    column: $table.canSeeAllBranches,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastActiveAt => $composableBuilder(
    column: $table.lastActiveAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mustChangePassword => $composableBuilder(
    column: $table.mustChangePassword,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DepartmentsTableOrderingComposer get departmentId {
    final $$DepartmentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.departmentId,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableOrderingComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserAccountsTable> {
  $$UserAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get passwordSalt => $composableBuilder(
    column: $table.passwordSalt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get canSeeAllBranches => $composableBuilder(
    column: $table.canSeeAllBranches,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastActiveAt => $composableBuilder(
    column: $table.lastActiveAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get mustChangePassword => $composableBuilder(
    column: $table.mustChangePassword,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$DepartmentsTableAnnotationComposer get departmentId {
    final $$DepartmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.departmentId,
      referencedTable: $db.departments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepartmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.departments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserAccountsTable,
          UserAccountRow,
          $$UserAccountsTableFilterComposer,
          $$UserAccountsTableOrderingComposer,
          $$UserAccountsTableAnnotationComposer,
          $$UserAccountsTableCreateCompanionBuilder,
          $$UserAccountsTableUpdateCompanionBuilder,
          (UserAccountRow, $$UserAccountsTableReferences),
          UserAccountRow,
          PrefetchHooks Function({
            bool branchId,
            bool departmentId,
            bool memberId,
          })
        > {
  $$UserAccountsTableTableManager(_$AppDatabase db, $UserAccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> passwordSalt = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> branchId = const Value.absent(),
                Value<String?> departmentId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<bool?> canSeeAllBranches = const Value.absent(),
                Value<DateTime?> lastActiveAt = const Value.absent(),
                Value<bool> mustChangePassword = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAccountsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                username: username,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                role: role,
                status: status,
                branchId: branchId,
                departmentId: departmentId,
                memberId: memberId,
                canSeeAllBranches: canSeeAllBranches,
                lastActiveAt: lastActiveAt,
                mustChangePassword: mustChangePassword,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String name,
                required String username,
                required String passwordHash,
                required String passwordSalt,
                required String role,
                required String status,
                Value<String?> branchId = const Value.absent(),
                Value<String?> departmentId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<bool?> canSeeAllBranches = const Value.absent(),
                Value<DateTime?> lastActiveAt = const Value.absent(),
                Value<bool> mustChangePassword = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAccountsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                name: name,
                username: username,
                passwordHash: passwordHash,
                passwordSalt: passwordSalt,
                role: role,
                status: status,
                branchId: branchId,
                departmentId: departmentId,
                memberId: memberId,
                canSeeAllBranches: canSeeAllBranches,
                lastActiveAt: lastActiveAt,
                mustChangePassword: mustChangePassword,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({branchId = false, departmentId = false, memberId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (branchId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.branchId,
                                    referencedTable:
                                        $$UserAccountsTableReferences
                                            ._branchIdTable(db),
                                    referencedColumn:
                                        $$UserAccountsTableReferences
                                            ._branchIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (departmentId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.departmentId,
                                    referencedTable:
                                        $$UserAccountsTableReferences
                                            ._departmentIdTable(db),
                                    referencedColumn:
                                        $$UserAccountsTableReferences
                                            ._departmentIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (memberId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.memberId,
                                    referencedTable:
                                        $$UserAccountsTableReferences
                                            ._memberIdTable(db),
                                    referencedColumn:
                                        $$UserAccountsTableReferences
                                            ._memberIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$UserAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserAccountsTable,
      UserAccountRow,
      $$UserAccountsTableFilterComposer,
      $$UserAccountsTableOrderingComposer,
      $$UserAccountsTableAnnotationComposer,
      $$UserAccountsTableCreateCompanionBuilder,
      $$UserAccountsTableUpdateCompanionBuilder,
      (UserAccountRow, $$UserAccountsTableReferences),
      UserAccountRow,
      PrefetchHooks Function({bool branchId, bool departmentId, bool memberId})
    >;
typedef $$AttendanceRecordsTableCreateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required DateTime date,
      required String serviceName,
      Value<int> adults,
      Value<int> children,
      Value<int> visitors,
      Value<int> online,
      Value<int> rowid,
    });
typedef $$AttendanceRecordsTableUpdateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<DateTime> date,
      Value<String> serviceName,
      Value<int> adults,
      Value<int> children,
      Value<int> visitors,
      Value<int> online,
      Value<int> rowid,
    });

final class $$AttendanceRecordsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AttendanceRecordsTable, AttendanceRow> {
  $$AttendanceRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('attendance_records__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CheckInsTable, List<CheckInRow>>
  _checkInsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checkIns,
    aliasName: 'attendance_records__id__check_ins__attendance_id',
  );

  $$CheckInsTableProcessedTableManager get checkInsRefs {
    final manager = $$CheckInsTableTableManager(
      $_db,
      $_db.checkIns,
    ).filter((f) => f.attendanceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_checkInsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AttendanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceName => $composableBuilder(
    column: $table.serviceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get adults => $composableBuilder(
    column: $table.adults,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get children => $composableBuilder(
    column: $table.children,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get visitors => $composableBuilder(
    column: $table.visitors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get online => $composableBuilder(
    column: $table.online,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> checkInsRefs(
    Expression<bool> Function($$CheckInsTableFilterComposer f) f,
  ) {
    final $$CheckInsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.attendanceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableFilterComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AttendanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceName => $composableBuilder(
    column: $table.serviceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get adults => $composableBuilder(
    column: $table.adults,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get children => $composableBuilder(
    column: $table.children,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visitors => $composableBuilder(
    column: $table.visitors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get online => $composableBuilder(
    column: $table.online,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get serviceName => $composableBuilder(
    column: $table.serviceName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get adults =>
      $composableBuilder(column: $table.adults, builder: (column) => column);

  GeneratedColumn<int> get children =>
      $composableBuilder(column: $table.children, builder: (column) => column);

  GeneratedColumn<int> get visitors =>
      $composableBuilder(column: $table.visitors, builder: (column) => column);

  GeneratedColumn<int> get online =>
      $composableBuilder(column: $table.online, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> checkInsRefs<T extends Object>(
    Expression<T> Function($$CheckInsTableAnnotationComposer a) f,
  ) {
    final $$CheckInsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checkIns,
      getReferencedColumn: (t) => t.attendanceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CheckInsTableAnnotationComposer(
            $db: $db,
            $table: $db.checkIns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AttendanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRow,
          $$AttendanceRecordsTableFilterComposer,
          $$AttendanceRecordsTableOrderingComposer,
          $$AttendanceRecordsTableAnnotationComposer,
          $$AttendanceRecordsTableCreateCompanionBuilder,
          $$AttendanceRecordsTableUpdateCompanionBuilder,
          (AttendanceRow, $$AttendanceRecordsTableReferences),
          AttendanceRow,
          PrefetchHooks Function({bool branchId, bool checkInsRefs})
        > {
  $$AttendanceRecordsTableTableManager(
    _$AppDatabase db,
    $AttendanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> serviceName = const Value.absent(),
                Value<int> adults = const Value.absent(),
                Value<int> children = const Value.absent(),
                Value<int> visitors = const Value.absent(),
                Value<int> online = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceRecordsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                date: date,
                serviceName: serviceName,
                adults: adults,
                children: children,
                visitors: visitors,
                online: online,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required DateTime date,
                required String serviceName,
                Value<int> adults = const Value.absent(),
                Value<int> children = const Value.absent(),
                Value<int> visitors = const Value.absent(),
                Value<int> online = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttendanceRecordsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                date: date,
                serviceName: serviceName,
                adults: adults,
                children: children,
                visitors: visitors,
                online: online,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AttendanceRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false, checkInsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (checkInsRefs) db.checkIns],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable:
                                    $$AttendanceRecordsTableReferences
                                        ._branchIdTable(db),
                                referencedColumn:
                                    $$AttendanceRecordsTableReferences
                                        ._branchIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (checkInsRefs)
                    await $_getPrefetchedData<
                      AttendanceRow,
                      $AttendanceRecordsTable,
                      CheckInRow
                    >(
                      currentTable: table,
                      referencedTable: $$AttendanceRecordsTableReferences
                          ._checkInsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AttendanceRecordsTableReferences(
                            db,
                            table,
                            p0,
                          ).checkInsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.attendanceId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AttendanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceRecordsTable,
      AttendanceRow,
      $$AttendanceRecordsTableFilterComposer,
      $$AttendanceRecordsTableOrderingComposer,
      $$AttendanceRecordsTableAnnotationComposer,
      $$AttendanceRecordsTableCreateCompanionBuilder,
      $$AttendanceRecordsTableUpdateCompanionBuilder,
      (AttendanceRow, $$AttendanceRecordsTableReferences),
      AttendanceRow,
      PrefetchHooks Function({bool branchId, bool checkInsRefs})
    >;
typedef $$CheckInsTableCreateCompanionBuilder =
    CheckInsCompanion Function({
      required String attendanceId,
      required String memberId,
      Value<DateTime> checkedInAt,
      Value<int> rowid,
    });
typedef $$CheckInsTableUpdateCompanionBuilder =
    CheckInsCompanion Function({
      Value<String> attendanceId,
      Value<String> memberId,
      Value<DateTime> checkedInAt,
      Value<int> rowid,
    });

final class $$CheckInsTableReferences
    extends BaseReferences<_$AppDatabase, $CheckInsTable, CheckInRow> {
  $$CheckInsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AttendanceRecordsTable _attendanceIdTable(_$AppDatabase db) => db
      .attendanceRecords
      .createAlias('check_ins__attendance_id__attendance_records__id');

  $$AttendanceRecordsTableProcessedTableManager get attendanceId {
    final $_column = $_itemColumn<String>('attendance_id')!;

    final manager = $$AttendanceRecordsTableTableManager(
      $_db,
      $_db.attendanceRecords,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_attendanceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('check_ins__member_id__members__id');

  $$MembersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get checkedInAt => $composableBuilder(
    column: $table.checkedInAt,
    builder: (column) => ColumnFilters(column),
  );

  $$AttendanceRecordsTableFilterComposer get attendanceId {
    final $$AttendanceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attendanceId,
      referencedTable: $db.attendanceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.attendanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get checkedInAt => $composableBuilder(
    column: $table.checkedInAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$AttendanceRecordsTableOrderingComposer get attendanceId {
    final $$AttendanceRecordsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.attendanceId,
      referencedTable: $db.attendanceRecords,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceRecordsTableOrderingComposer(
            $db: $db,
            $table: $db.attendanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CheckInsTable> {
  $$CheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get checkedInAt => $composableBuilder(
    column: $table.checkedInAt,
    builder: (column) => column,
  );

  $$AttendanceRecordsTableAnnotationComposer get attendanceId {
    final $$AttendanceRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.attendanceId,
          referencedTable: $db.attendanceRecords,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AttendanceRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.attendanceRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CheckInsTable,
          CheckInRow,
          $$CheckInsTableFilterComposer,
          $$CheckInsTableOrderingComposer,
          $$CheckInsTableAnnotationComposer,
          $$CheckInsTableCreateCompanionBuilder,
          $$CheckInsTableUpdateCompanionBuilder,
          (CheckInRow, $$CheckInsTableReferences),
          CheckInRow,
          PrefetchHooks Function({bool attendanceId, bool memberId})
        > {
  $$CheckInsTableTableManager(_$AppDatabase db, $CheckInsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> attendanceId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<DateTime> checkedInAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckInsCompanion(
                attendanceId: attendanceId,
                memberId: memberId,
                checkedInAt: checkedInAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String attendanceId,
                required String memberId,
                Value<DateTime> checkedInAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CheckInsCompanion.insert(
                attendanceId: attendanceId,
                memberId: memberId,
                checkedInAt: checkedInAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CheckInsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({attendanceId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (attendanceId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.attendanceId,
                                referencedTable: $$CheckInsTableReferences
                                    ._attendanceIdTable(db),
                                referencedColumn: $$CheckInsTableReferences
                                    ._attendanceIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable: $$CheckInsTableReferences
                                    ._memberIdTable(db),
                                referencedColumn: $$CheckInsTableReferences
                                    ._memberIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CheckInsTable,
      CheckInRow,
      $$CheckInsTableFilterComposer,
      $$CheckInsTableOrderingComposer,
      $$CheckInsTableAnnotationComposer,
      $$CheckInsTableCreateCompanionBuilder,
      $$CheckInsTableUpdateCompanionBuilder,
      (CheckInRow, $$CheckInsTableReferences),
      CheckInRow,
      PrefetchHooks Function({bool attendanceId, bool memberId})
    >;
typedef $$DonationsTableCreateCompanionBuilder =
    DonationsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      Value<String?> memberId,
      required String donorName,
      required double amount,
      required String fund,
      required String method,
      required DateTime date,
      required String reference,
      Value<bool> isRecurring,
      Value<int> rowid,
    });
typedef $$DonationsTableUpdateCompanionBuilder =
    DonationsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String?> memberId,
      Value<String> donorName,
      Value<double> amount,
      Value<String> fund,
      Value<String> method,
      Value<DateTime> date,
      Value<String> reference,
      Value<bool> isRecurring,
      Value<int> rowid,
    });

final class $$DonationsTableReferences
    extends BaseReferences<_$AppDatabase, $DonationsTable, DonationRow> {
  $$DonationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('donations__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('donations__member_id__members__id');

  $$MembersTableProcessedTableManager? get memberId {
    final $_column = $_itemColumn<String>('member_id');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DonationsTableFilterComposer
    extends Composer<_$AppDatabase, $DonationsTable> {
  $$DonationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get donorName => $composableBuilder(
    column: $table.donorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fund => $composableBuilder(
    column: $table.fund,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DonationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DonationsTable> {
  $$DonationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get donorName => $composableBuilder(
    column: $table.donorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fund => $composableBuilder(
    column: $table.fund,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DonationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DonationsTable> {
  $$DonationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get donorName =>
      $composableBuilder(column: $table.donorName, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get fund =>
      $composableBuilder(column: $table.fund, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DonationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DonationsTable,
          DonationRow,
          $$DonationsTableFilterComposer,
          $$DonationsTableOrderingComposer,
          $$DonationsTableAnnotationComposer,
          $$DonationsTableCreateCompanionBuilder,
          $$DonationsTableUpdateCompanionBuilder,
          (DonationRow, $$DonationsTableReferences),
          DonationRow,
          PrefetchHooks Function({bool branchId, bool memberId})
        > {
  $$DonationsTableTableManager(_$AppDatabase db, $DonationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DonationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DonationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DonationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<String> donorName = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> fund = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> reference = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DonationsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                memberId: memberId,
                donorName: donorName,
                amount: amount,
                fund: fund,
                method: method,
                date: date,
                reference: reference,
                isRecurring: isRecurring,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                Value<String?> memberId = const Value.absent(),
                required String donorName,
                required double amount,
                required String fund,
                required String method,
                required DateTime date,
                required String reference,
                Value<bool> isRecurring = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DonationsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                memberId: memberId,
                donorName: donorName,
                amount: amount,
                fund: fund,
                method: method,
                date: date,
                reference: reference,
                isRecurring: isRecurring,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DonationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$DonationsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$DonationsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable: $$DonationsTableReferences
                                    ._memberIdTable(db),
                                referencedColumn: $$DonationsTableReferences
                                    ._memberIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DonationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DonationsTable,
      DonationRow,
      $$DonationsTableFilterComposer,
      $$DonationsTableOrderingComposer,
      $$DonationsTableAnnotationComposer,
      $$DonationsTableCreateCompanionBuilder,
      $$DonationsTableUpdateCompanionBuilder,
      (DonationRow, $$DonationsTableReferences),
      DonationRow,
      PrefetchHooks Function({bool branchId, bool memberId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String category,
      required String vendor,
      required double amount,
      required DateTime date,
      Value<String?> approvedBy,
      required String status,
      Value<int> rowid,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> category,
      Value<String> vendor,
      Value<double> amount,
      Value<DateTime> date,
      Value<String?> approvedBy,
      Value<String> status,
      Value<int> rowid,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, ExpenseRow> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('expenses__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vendor => $composableBuilder(
    column: $table.vendor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get vendor =>
      $composableBuilder(column: $table.vendor, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get approvedBy => $composableBuilder(
    column: $table.approvedBy,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          ExpenseRow,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (ExpenseRow, $$ExpensesTableReferences),
          ExpenseRow,
          PrefetchHooks Function({bool branchId})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> vendor = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> approvedBy = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                category: category,
                vendor: vendor,
                amount: amount,
                date: date,
                approvedBy: approvedBy,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String category,
                required String vendor,
                required double amount,
                required DateTime date,
                Value<String?> approvedBy = const Value.absent(),
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => ExpensesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                category: category,
                vendor: vendor,
                amount: amount,
                date: date,
                approvedBy: approvedBy,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$ExpensesTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$ExpensesTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      ExpenseRow,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (ExpenseRow, $$ExpensesTableReferences),
      ExpenseRow,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$PledgesTableCreateCompanionBuilder =
    PledgesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String memberId,
      required String campaign,
      required double pledged,
      Value<double> fulfilled,
      required DateTime dueDate,
      Value<int> rowid,
    });
typedef $$PledgesTableUpdateCompanionBuilder =
    PledgesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> memberId,
      Value<String> campaign,
      Value<double> pledged,
      Value<double> fulfilled,
      Value<DateTime> dueDate,
      Value<int> rowid,
    });

final class $$PledgesTableReferences
    extends BaseReferences<_$AppDatabase, $PledgesTable, PledgeRow> {
  $$PledgesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('pledges__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('pledges__member_id__members__id');

  $$MembersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PledgesTableFilterComposer
    extends Composer<_$AppDatabase, $PledgesTable> {
  $$PledgesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campaign => $composableBuilder(
    column: $table.campaign,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pledged => $composableBuilder(
    column: $table.pledged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fulfilled => $composableBuilder(
    column: $table.fulfilled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PledgesTableOrderingComposer
    extends Composer<_$AppDatabase, $PledgesTable> {
  $$PledgesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campaign => $composableBuilder(
    column: $table.campaign,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pledged => $composableBuilder(
    column: $table.pledged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fulfilled => $composableBuilder(
    column: $table.fulfilled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PledgesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PledgesTable> {
  $$PledgesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get campaign =>
      $composableBuilder(column: $table.campaign, builder: (column) => column);

  GeneratedColumn<double> get pledged =>
      $composableBuilder(column: $table.pledged, builder: (column) => column);

  GeneratedColumn<double> get fulfilled =>
      $composableBuilder(column: $table.fulfilled, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PledgesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PledgesTable,
          PledgeRow,
          $$PledgesTableFilterComposer,
          $$PledgesTableOrderingComposer,
          $$PledgesTableAnnotationComposer,
          $$PledgesTableCreateCompanionBuilder,
          $$PledgesTableUpdateCompanionBuilder,
          (PledgeRow, $$PledgesTableReferences),
          PledgeRow,
          PrefetchHooks Function({bool branchId, bool memberId})
        > {
  $$PledgesTableTableManager(_$AppDatabase db, $PledgesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PledgesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PledgesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PledgesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> campaign = const Value.absent(),
                Value<double> pledged = const Value.absent(),
                Value<double> fulfilled = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PledgesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                memberId: memberId,
                campaign: campaign,
                pledged: pledged,
                fulfilled: fulfilled,
                dueDate: dueDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String memberId,
                required String campaign,
                required double pledged,
                Value<double> fulfilled = const Value.absent(),
                required DateTime dueDate,
                Value<int> rowid = const Value.absent(),
              }) => PledgesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                memberId: memberId,
                campaign: campaign,
                pledged: pledged,
                fulfilled: fulfilled,
                dueDate: dueDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PledgesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$PledgesTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$PledgesTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable: $$PledgesTableReferences
                                    ._memberIdTable(db),
                                referencedColumn: $$PledgesTableReferences
                                    ._memberIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PledgesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PledgesTable,
      PledgeRow,
      $$PledgesTableFilterComposer,
      $$PledgesTableOrderingComposer,
      $$PledgesTableAnnotationComposer,
      $$PledgesTableCreateCompanionBuilder,
      $$PledgesTableUpdateCompanionBuilder,
      (PledgeRow, $$PledgesTableReferences),
      PledgeRow,
      PrefetchHooks Function({bool branchId, bool memberId})
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String title,
      Value<String> description,
      required String category,
      required DateTime startsAt,
      required DateTime endsAt,
      Value<String> location,
      Value<String?> organizerId,
      Value<int> expectedAttendance,
      Value<int> registeredCount,
      Value<bool> isRecurring,
      Value<int> rowid,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> title,
      Value<String> description,
      Value<String> category,
      Value<DateTime> startsAt,
      Value<DateTime> endsAt,
      Value<String> location,
      Value<String?> organizerId,
      Value<int> expectedAttendance,
      Value<int> registeredCount,
      Value<bool> isRecurring,
      Value<int> rowid,
    });

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, EventRow> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('events__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get organizerId => $composableBuilder(
    column: $table.organizerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get expectedAttendance => $composableBuilder(
    column: $table.expectedAttendance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get registeredCount => $composableBuilder(
    column: $table.registeredCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
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

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startsAt => $composableBuilder(
    column: $table.startsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endsAt => $composableBuilder(
    column: $table.endsAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get organizerId => $composableBuilder(
    column: $table.organizerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get expectedAttendance => $composableBuilder(
    column: $table.expectedAttendance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get registeredCount => $composableBuilder(
    column: $table.registeredCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get startsAt =>
      $composableBuilder(column: $table.startsAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endsAt =>
      $composableBuilder(column: $table.endsAt, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get organizerId => $composableBuilder(
    column: $table.organizerId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get expectedAttendance => $composableBuilder(
    column: $table.expectedAttendance,
    builder: (column) => column,
  );

  GeneratedColumn<int> get registeredCount => $composableBuilder(
    column: $table.registeredCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
    column: $table.isRecurring,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          EventRow,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (EventRow, $$EventsTableReferences),
          EventRow,
          PrefetchHooks Function({bool branchId})
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<DateTime> startsAt = const Value.absent(),
                Value<DateTime> endsAt = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String?> organizerId = const Value.absent(),
                Value<int> expectedAttendance = const Value.absent(),
                Value<int> registeredCount = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                title: title,
                description: description,
                category: category,
                startsAt: startsAt,
                endsAt: endsAt,
                location: location,
                organizerId: organizerId,
                expectedAttendance: expectedAttendance,
                registeredCount: registeredCount,
                isRecurring: isRecurring,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String title,
                Value<String> description = const Value.absent(),
                required String category,
                required DateTime startsAt,
                required DateTime endsAt,
                Value<String> location = const Value.absent(),
                Value<String?> organizerId = const Value.absent(),
                Value<int> expectedAttendance = const Value.absent(),
                Value<int> registeredCount = const Value.absent(),
                Value<bool> isRecurring = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                title: title,
                description: description,
                category: category,
                startsAt: startsAt,
                endsAt: endsAt,
                location: location,
                organizerId: organizerId,
                expectedAttendance: expectedAttendance,
                registeredCount: registeredCount,
                isRecurring: isRecurring,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$EventsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$EventsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$EventsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      EventRow,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (EventRow, $$EventsTableReferences),
      EventRow,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$CareRequestsTableCreateCompanionBuilder =
    CareRequestsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String memberId,
      required String type,
      required String summary,
      required String status,
      required String priority,
      Value<String?> assignedToId,
      Value<int> rowid,
    });
typedef $$CareRequestsTableUpdateCompanionBuilder =
    CareRequestsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> memberId,
      Value<String> type,
      Value<String> summary,
      Value<String> status,
      Value<String> priority,
      Value<String?> assignedToId,
      Value<int> rowid,
    });

final class $$CareRequestsTableReferences
    extends BaseReferences<_$AppDatabase, $CareRequestsTable, CareRequestRow> {
  $$CareRequestsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('care_requests__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('care_requests__member_id__members__id');

  $$MembersTableProcessedTableManager get memberId {
    final $_column = $_itemColumn<String>('member_id')!;

    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareRequestsTableFilterComposer
    extends Composer<_$AppDatabase, $CareRequestsTable> {
  $$CareRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assignedToId => $composableBuilder(
    column: $table.assignedToId,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRequestsTableOrderingComposer
    extends Composer<_$AppDatabase, $CareRequestsTable> {
  $$CareRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assignedToId => $composableBuilder(
    column: $table.assignedToId,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRequestsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CareRequestsTable> {
  $$CareRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get assignedToId => $composableBuilder(
    column: $table.assignedToId,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareRequestsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CareRequestsTable,
          CareRequestRow,
          $$CareRequestsTableFilterComposer,
          $$CareRequestsTableOrderingComposer,
          $$CareRequestsTableAnnotationComposer,
          $$CareRequestsTableCreateCompanionBuilder,
          $$CareRequestsTableUpdateCompanionBuilder,
          (CareRequestRow, $$CareRequestsTableReferences),
          CareRequestRow,
          PrefetchHooks Function({bool branchId, bool memberId})
        > {
  $$CareRequestsTableTableManager(_$AppDatabase db, $CareRequestsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareRequestsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareRequestsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareRequestsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> memberId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> summary = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<String?> assignedToId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareRequestsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                memberId: memberId,
                type: type,
                summary: summary,
                status: status,
                priority: priority,
                assignedToId: assignedToId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String memberId,
                required String type,
                required String summary,
                required String status,
                required String priority,
                Value<String?> assignedToId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareRequestsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                memberId: memberId,
                type: type,
                summary: summary,
                status: status,
                priority: priority,
                assignedToId: assignedToId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CareRequestsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$CareRequestsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$CareRequestsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable: $$CareRequestsTableReferences
                                    ._memberIdTable(db),
                                referencedColumn: $$CareRequestsTableReferences
                                    ._memberIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CareRequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CareRequestsTable,
      CareRequestRow,
      $$CareRequestsTableFilterComposer,
      $$CareRequestsTableOrderingComposer,
      $$CareRequestsTableAnnotationComposer,
      $$CareRequestsTableCreateCompanionBuilder,
      $$CareRequestsTableUpdateCompanionBuilder,
      (CareRequestRow, $$CareRequestsTableReferences),
      CareRequestRow,
      PrefetchHooks Function({bool branchId, bool memberId})
    >;
typedef $$VolunteerSlotsTableCreateCompanionBuilder =
    VolunteerSlotsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required DateTime date,
      required String serviceName,
      required String role,
      Value<String?> memberId,
      required String status,
      Value<int> rowid,
    });
typedef $$VolunteerSlotsTableUpdateCompanionBuilder =
    VolunteerSlotsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<DateTime> date,
      Value<String> serviceName,
      Value<String> role,
      Value<String?> memberId,
      Value<String> status,
      Value<int> rowid,
    });

final class $$VolunteerSlotsTableReferences
    extends
        BaseReferences<_$AppDatabase, $VolunteerSlotsTable, VolunteerSlotRow> {
  $$VolunteerSlotsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('volunteer_slots__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MembersTable _memberIdTable(_$AppDatabase db) =>
      db.members.createAlias('volunteer_slots__member_id__members__id');

  $$MembersTableProcessedTableManager? get memberId {
    final $_column = $_itemColumn<String>('member_id');
    if ($_column == null) return null;
    final manager = $$MembersTableTableManager(
      $_db,
      $_db.members,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_memberIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VolunteerSlotsTableFilterComposer
    extends Composer<_$AppDatabase, $VolunteerSlotsTable> {
  $$VolunteerSlotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serviceName => $composableBuilder(
    column: $table.serviceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableFilterComposer get memberId {
    final $$MembersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableFilterComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VolunteerSlotsTableOrderingComposer
    extends Composer<_$AppDatabase, $VolunteerSlotsTable> {
  $$VolunteerSlotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serviceName => $composableBuilder(
    column: $table.serviceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableOrderingComposer get memberId {
    final $$MembersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableOrderingComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VolunteerSlotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VolunteerSlotsTable> {
  $$VolunteerSlotsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get serviceName => $composableBuilder(
    column: $table.serviceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MembersTableAnnotationComposer get memberId {
    final $$MembersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.memberId,
      referencedTable: $db.members,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MembersTableAnnotationComposer(
            $db: $db,
            $table: $db.members,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VolunteerSlotsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VolunteerSlotsTable,
          VolunteerSlotRow,
          $$VolunteerSlotsTableFilterComposer,
          $$VolunteerSlotsTableOrderingComposer,
          $$VolunteerSlotsTableAnnotationComposer,
          $$VolunteerSlotsTableCreateCompanionBuilder,
          $$VolunteerSlotsTableUpdateCompanionBuilder,
          (VolunteerSlotRow, $$VolunteerSlotsTableReferences),
          VolunteerSlotRow,
          PrefetchHooks Function({bool branchId, bool memberId})
        > {
  $$VolunteerSlotsTableTableManager(
    _$AppDatabase db,
    $VolunteerSlotsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VolunteerSlotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VolunteerSlotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VolunteerSlotsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> serviceName = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String?> memberId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VolunteerSlotsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                date: date,
                serviceName: serviceName,
                role: role,
                memberId: memberId,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required DateTime date,
                required String serviceName,
                required String role,
                Value<String?> memberId = const Value.absent(),
                required String status,
                Value<int> rowid = const Value.absent(),
              }) => VolunteerSlotsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                date: date,
                serviceName: serviceName,
                role: role,
                memberId: memberId,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VolunteerSlotsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false, memberId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$VolunteerSlotsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn:
                                    $$VolunteerSlotsTableReferences
                                        ._branchIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (memberId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.memberId,
                                referencedTable: $$VolunteerSlotsTableReferences
                                    ._memberIdTable(db),
                                referencedColumn:
                                    $$VolunteerSlotsTableReferences
                                        ._memberIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VolunteerSlotsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VolunteerSlotsTable,
      VolunteerSlotRow,
      $$VolunteerSlotsTableFilterComposer,
      $$VolunteerSlotsTableOrderingComposer,
      $$VolunteerSlotsTableAnnotationComposer,
      $$VolunteerSlotsTableCreateCompanionBuilder,
      $$VolunteerSlotsTableUpdateCompanionBuilder,
      (VolunteerSlotRow, $$VolunteerSlotsTableReferences),
      VolunteerSlotRow,
      PrefetchHooks Function({bool branchId, bool memberId})
    >;
typedef $$AssetsTableCreateCompanionBuilder =
    AssetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String name,
      required String category,
      Value<String> serial,
      required String condition,
      Value<String> location,
      required DateTime purchasedAt,
      Value<double> value,
      Value<int> rowid,
    });
typedef $$AssetsTableUpdateCompanionBuilder =
    AssetsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> name,
      Value<String> category,
      Value<String> serial,
      Value<String> condition,
      Value<String> location,
      Value<DateTime> purchasedAt,
      Value<double> value,
      Value<int> rowid,
    });

final class $$AssetsTableReferences
    extends BaseReferences<_$AppDatabase, $AssetsTable, AssetRow> {
  $$AssetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('assets__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AssetsTableFilterComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get serial => $composableBuilder(
    column: $table.serial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serial => $composableBuilder(
    column: $table.serial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssetsTable> {
  $$AssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get serial =>
      $composableBuilder(column: $table.serial, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get purchasedAt => $composableBuilder(
    column: $table.purchasedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssetsTable,
          AssetRow,
          $$AssetsTableFilterComposer,
          $$AssetsTableOrderingComposer,
          $$AssetsTableAnnotationComposer,
          $$AssetsTableCreateCompanionBuilder,
          $$AssetsTableUpdateCompanionBuilder,
          (AssetRow, $$AssetsTableReferences),
          AssetRow,
          PrefetchHooks Function({bool branchId})
        > {
  $$AssetsTableTableManager(_$AppDatabase db, $AssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> serial = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<DateTime> purchasedAt = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                name: name,
                category: category,
                serial: serial,
                condition: condition,
                location: location,
                purchasedAt: purchasedAt,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String name,
                required String category,
                Value<String> serial = const Value.absent(),
                required String condition,
                Value<String> location = const Value.absent(),
                required DateTime purchasedAt,
                Value<double> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssetsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                name: name,
                category: category,
                serial: serial,
                condition: condition,
                location: location,
                purchasedAt: purchasedAt,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AssetsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$AssetsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$AssetsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssetsTable,
      AssetRow,
      $$AssetsTableFilterComposer,
      $$AssetsTableOrderingComposer,
      $$AssetsTableAnnotationComposer,
      $$AssetsTableCreateCompanionBuilder,
      $$AssetsTableUpdateCompanionBuilder,
      (AssetRow, $$AssetsTableReferences),
      AssetRow,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$CampaignsTableCreateCompanionBuilder =
    CampaignsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String subject,
      Value<String> body,
      required String channel,
      required String status,
      required String audience,
      Value<int> recipients,
      Value<int?> openRate,
      Value<DateTime?> sentAt,
      Value<DateTime?> scheduledFor,
      Value<int> rowid,
    });
typedef $$CampaignsTableUpdateCompanionBuilder =
    CampaignsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> subject,
      Value<String> body,
      Value<String> channel,
      Value<String> status,
      Value<String> audience,
      Value<int> recipients,
      Value<int?> openRate,
      Value<DateTime?> sentAt,
      Value<DateTime?> scheduledFor,
      Value<int> rowid,
    });

final class $$CampaignsTableReferences
    extends BaseReferences<_$AppDatabase, $CampaignsTable, CampaignRow> {
  $$CampaignsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('campaigns__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CampaignsTableFilterComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audience => $composableBuilder(
    column: $table.audience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recipients => $composableBuilder(
    column: $table.recipients,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get openRate => $composableBuilder(
    column: $table.openRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignsTableOrderingComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audience => $composableBuilder(
    column: $table.audience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recipients => $composableBuilder(
    column: $table.recipients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get openRate => $composableBuilder(
    column: $table.openRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get audience =>
      $composableBuilder(column: $table.audience, builder: (column) => column);

  GeneratedColumn<int> get recipients => $composableBuilder(
    column: $table.recipients,
    builder: (column) => column,
  );

  GeneratedColumn<int> get openRate =>
      $composableBuilder(column: $table.openRate, builder: (column) => column);

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CampaignsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampaignsTable,
          CampaignRow,
          $$CampaignsTableFilterComposer,
          $$CampaignsTableOrderingComposer,
          $$CampaignsTableAnnotationComposer,
          $$CampaignsTableCreateCompanionBuilder,
          $$CampaignsTableUpdateCompanionBuilder,
          (CampaignRow, $$CampaignsTableReferences),
          CampaignRow,
          PrefetchHooks Function({bool branchId})
        > {
  $$CampaignsTableTableManager(_$AppDatabase db, $CampaignsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampaignsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CampaignsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CampaignsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> channel = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> audience = const Value.absent(),
                Value<int> recipients = const Value.absent(),
                Value<int?> openRate = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<DateTime?> scheduledFor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CampaignsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                subject: subject,
                body: body,
                channel: channel,
                status: status,
                audience: audience,
                recipients: recipients,
                openRate: openRate,
                sentAt: sentAt,
                scheduledFor: scheduledFor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String subject,
                Value<String> body = const Value.absent(),
                required String channel,
                required String status,
                required String audience,
                Value<int> recipients = const Value.absent(),
                Value<int?> openRate = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<DateTime?> scheduledFor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CampaignsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                subject: subject,
                body: body,
                channel: channel,
                status: status,
                audience: audience,
                recipients: recipients,
                openRate: openRate,
                sentAt: sentAt,
                scheduledFor: scheduledFor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CampaignsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$CampaignsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$CampaignsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CampaignsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampaignsTable,
      CampaignRow,
      $$CampaignsTableFilterComposer,
      $$CampaignsTableOrderingComposer,
      $$CampaignsTableAnnotationComposer,
      $$CampaignsTableCreateCompanionBuilder,
      $$CampaignsTableUpdateCompanionBuilder,
      (CampaignRow, $$CampaignsTableReferences),
      CampaignRow,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$AnnouncementsTableCreateCompanionBuilder =
    AnnouncementsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String title,
      required String body,
      Value<String?> authorId,
      required DateTime postedAt,
      Value<bool> pinned,
      Value<int> rowid,
    });
typedef $$AnnouncementsTableUpdateCompanionBuilder =
    AnnouncementsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> title,
      Value<String> body,
      Value<String?> authorId,
      Value<DateTime> postedAt,
      Value<bool> pinned,
      Value<int> rowid,
    });

final class $$AnnouncementsTableReferences
    extends
        BaseReferences<_$AppDatabase, $AnnouncementsTable, AnnouncementRow> {
  $$AnnouncementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('announcements__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AnnouncementsTableFilterComposer
    extends Composer<_$AppDatabase, $AnnouncementsTable> {
  $$AnnouncementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get postedAt => $composableBuilder(
    column: $table.postedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnnouncementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnnouncementsTable> {
  $$AnnouncementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authorId => $composableBuilder(
    column: $table.authorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get postedAt => $composableBuilder(
    column: $table.postedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pinned => $composableBuilder(
    column: $table.pinned,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnnouncementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnnouncementsTable> {
  $$AnnouncementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get authorId =>
      $composableBuilder(column: $table.authorId, builder: (column) => column);

  GeneratedColumn<DateTime> get postedAt =>
      $composableBuilder(column: $table.postedAt, builder: (column) => column);

  GeneratedColumn<bool> get pinned =>
      $composableBuilder(column: $table.pinned, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnnouncementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnnouncementsTable,
          AnnouncementRow,
          $$AnnouncementsTableFilterComposer,
          $$AnnouncementsTableOrderingComposer,
          $$AnnouncementsTableAnnotationComposer,
          $$AnnouncementsTableCreateCompanionBuilder,
          $$AnnouncementsTableUpdateCompanionBuilder,
          (AnnouncementRow, $$AnnouncementsTableReferences),
          AnnouncementRow,
          PrefetchHooks Function({bool branchId})
        > {
  $$AnnouncementsTableTableManager(_$AppDatabase db, $AnnouncementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnnouncementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnnouncementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnnouncementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String?> authorId = const Value.absent(),
                Value<DateTime> postedAt = const Value.absent(),
                Value<bool> pinned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnouncementsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                title: title,
                body: body,
                authorId: authorId,
                postedAt: postedAt,
                pinned: pinned,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String title,
                required String body,
                Value<String?> authorId = const Value.absent(),
                required DateTime postedAt,
                Value<bool> pinned = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnnouncementsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                title: title,
                body: body,
                authorId: authorId,
                postedAt: postedAt,
                pinned: pinned,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnnouncementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$AnnouncementsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$AnnouncementsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AnnouncementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnnouncementsTable,
      AnnouncementRow,
      $$AnnouncementsTableFilterComposer,
      $$AnnouncementsTableOrderingComposer,
      $$AnnouncementsTableAnnotationComposer,
      $$AnnouncementsTableCreateCompanionBuilder,
      $$AnnouncementsTableUpdateCompanionBuilder,
      (AnnouncementRow, $$AnnouncementsTableReferences),
      AnnouncementRow,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$CoursesTableCreateCompanionBuilder =
    CoursesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String name,
      Value<String> description,
      Value<int> lessons,
      Value<int> enrolled,
      Value<int> completed,
      Value<String?> facilitatorId,
      Value<int> rowid,
    });
typedef $$CoursesTableUpdateCompanionBuilder =
    CoursesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> name,
      Value<String> description,
      Value<int> lessons,
      Value<int> enrolled,
      Value<int> completed,
      Value<String?> facilitatorId,
      Value<int> rowid,
    });

final class $$CoursesTableReferences
    extends BaseReferences<_$AppDatabase, $CoursesTable, CourseRow> {
  $$CoursesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('courses__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoursesTableFilterComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lessons => $composableBuilder(
    column: $table.lessons,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get enrolled => $composableBuilder(
    column: $table.enrolled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get facilitatorId => $composableBuilder(
    column: $table.facilitatorId,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoursesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lessons => $composableBuilder(
    column: $table.lessons,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get enrolled => $composableBuilder(
    column: $table.enrolled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facilitatorId => $composableBuilder(
    column: $table.facilitatorId,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoursesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoursesTable> {
  $$CoursesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lessons =>
      $composableBuilder(column: $table.lessons, builder: (column) => column);

  GeneratedColumn<int> get enrolled =>
      $composableBuilder(column: $table.enrolled, builder: (column) => column);

  GeneratedColumn<int> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<String> get facilitatorId => $composableBuilder(
    column: $table.facilitatorId,
    builder: (column) => column,
  );

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoursesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoursesTable,
          CourseRow,
          $$CoursesTableFilterComposer,
          $$CoursesTableOrderingComposer,
          $$CoursesTableAnnotationComposer,
          $$CoursesTableCreateCompanionBuilder,
          $$CoursesTableUpdateCompanionBuilder,
          (CourseRow, $$CoursesTableReferences),
          CourseRow,
          PrefetchHooks Function({bool branchId})
        > {
  $$CoursesTableTableManager(_$AppDatabase db, $CoursesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoursesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoursesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoursesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> lessons = const Value.absent(),
                Value<int> enrolled = const Value.absent(),
                Value<int> completed = const Value.absent(),
                Value<String?> facilitatorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                name: name,
                description: description,
                lessons: lessons,
                enrolled: enrolled,
                completed: completed,
                facilitatorId: facilitatorId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String name,
                Value<String> description = const Value.absent(),
                Value<int> lessons = const Value.absent(),
                Value<int> enrolled = const Value.absent(),
                Value<int> completed = const Value.absent(),
                Value<String?> facilitatorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoursesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                name: name,
                description: description,
                lessons: lessons,
                enrolled: enrolled,
                completed: completed,
                facilitatorId: facilitatorId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoursesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$CoursesTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$CoursesTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CoursesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoursesTable,
      CourseRow,
      $$CoursesTableFilterComposer,
      $$CoursesTableOrderingComposer,
      $$CoursesTableAnnotationComposer,
      $$CoursesTableCreateCompanionBuilder,
      $$CoursesTableUpdateCompanionBuilder,
      (CourseRow, $$CoursesTableReferences),
      CourseRow,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$SmallGroupsTableCreateCompanionBuilder =
    SmallGroupsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String id,
      required String branchId,
      required String name,
      Value<String?> leaderId,
      Value<String> location,
      required String meetingDay,
      required String meetingTime,
      Value<int> capacity,
      Value<int> rowid,
    });
typedef $$SmallGroupsTableUpdateCompanionBuilder =
    SmallGroupsCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> id,
      Value<String> branchId,
      Value<String> name,
      Value<String?> leaderId,
      Value<String> location,
      Value<String> meetingDay,
      Value<String> meetingTime,
      Value<int> capacity,
      Value<int> rowid,
    });

final class $$SmallGroupsTableReferences
    extends BaseReferences<_$AppDatabase, $SmallGroupsTable, SmallGroupRow> {
  $$SmallGroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BranchesTable _branchIdTable(_$AppDatabase db) =>
      db.branches.createAlias('small_groups__branch_id__branches__id');

  $$BranchesTableProcessedTableManager get branchId {
    final $_column = $_itemColumn<String>('branch_id')!;

    final manager = $$BranchesTableTableManager(
      $_db,
      $_db.branches,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_branchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SmallGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $SmallGroupsTable> {
  $$SmallGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leaderId => $composableBuilder(
    column: $table.leaderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meetingDay => $composableBuilder(
    column: $table.meetingDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meetingTime => $composableBuilder(
    column: $table.meetingTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnFilters(column),
  );

  $$BranchesTableFilterComposer get branchId {
    final $$BranchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableFilterComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmallGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $SmallGroupsTable> {
  $$SmallGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leaderId => $composableBuilder(
    column: $table.leaderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meetingDay => $composableBuilder(
    column: $table.meetingDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meetingTime => $composableBuilder(
    column: $table.meetingTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnOrderings(column),
  );

  $$BranchesTableOrderingComposer get branchId {
    final $$BranchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableOrderingComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmallGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SmallGroupsTable> {
  $$SmallGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get leaderId =>
      $composableBuilder(column: $table.leaderId, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get meetingDay => $composableBuilder(
    column: $table.meetingDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get meetingTime => $composableBuilder(
    column: $table.meetingTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get capacity =>
      $composableBuilder(column: $table.capacity, builder: (column) => column);

  $$BranchesTableAnnotationComposer get branchId {
    final $$BranchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.branchId,
      referencedTable: $db.branches,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BranchesTableAnnotationComposer(
            $db: $db,
            $table: $db.branches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SmallGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SmallGroupsTable,
          SmallGroupRow,
          $$SmallGroupsTableFilterComposer,
          $$SmallGroupsTableOrderingComposer,
          $$SmallGroupsTableAnnotationComposer,
          $$SmallGroupsTableCreateCompanionBuilder,
          $$SmallGroupsTableUpdateCompanionBuilder,
          (SmallGroupRow, $$SmallGroupsTableReferences),
          SmallGroupRow,
          PrefetchHooks Function({bool branchId})
        > {
  $$SmallGroupsTableTableManager(_$AppDatabase db, $SmallGroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SmallGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SmallGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SmallGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> leaderId = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> meetingDay = const Value.absent(),
                Value<String> meetingTime = const Value.absent(),
                Value<int> capacity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmallGroupsCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                name: name,
                leaderId: leaderId,
                location: location,
                meetingDay: meetingDay,
                meetingTime: meetingTime,
                capacity: capacity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String id,
                required String branchId,
                required String name,
                Value<String?> leaderId = const Value.absent(),
                Value<String> location = const Value.absent(),
                required String meetingDay,
                required String meetingTime,
                Value<int> capacity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SmallGroupsCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                id: id,
                branchId: branchId,
                name: name,
                leaderId: leaderId,
                location: location,
                meetingDay: meetingDay,
                meetingTime: meetingTime,
                capacity: capacity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SmallGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({branchId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (branchId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.branchId,
                                referencedTable: $$SmallGroupsTableReferences
                                    ._branchIdTable(db),
                                referencedColumn: $$SmallGroupsTableReferences
                                    ._branchIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SmallGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SmallGroupsTable,
      SmallGroupRow,
      $$SmallGroupsTableFilterComposer,
      $$SmallGroupsTableOrderingComposer,
      $$SmallGroupsTableAnnotationComposer,
      $$SmallGroupsTableCreateCompanionBuilder,
      $$SmallGroupsTableUpdateCompanionBuilder,
      (SmallGroupRow, $$SmallGroupsTableReferences),
      SmallGroupRow,
      PrefetchHooks Function({bool branchId})
    >;
typedef $$PermissionOverridesTableCreateCompanionBuilder =
    PermissionOverridesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String module,
      required String role,
      required String level,
      Value<int> rowid,
    });
typedef $$PermissionOverridesTableUpdateCompanionBuilder =
    PermissionOverridesCompanion Function({
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> module,
      Value<String> role,
      Value<String> level,
      Value<int> rowid,
    });

class $$PermissionOverridesTableFilterComposer
    extends Composer<_$AppDatabase, $PermissionOverridesTable> {
  $$PermissionOverridesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get module => $composableBuilder(
    column: $table.module,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PermissionOverridesTableOrderingComposer
    extends Composer<_$AppDatabase, $PermissionOverridesTable> {
  $$PermissionOverridesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get module => $composableBuilder(
    column: $table.module,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PermissionOverridesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PermissionOverridesTable> {
  $$PermissionOverridesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get module =>
      $composableBuilder(column: $table.module, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);
}

class $$PermissionOverridesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PermissionOverridesTable,
          PermissionOverrideRow,
          $$PermissionOverridesTableFilterComposer,
          $$PermissionOverridesTableOrderingComposer,
          $$PermissionOverridesTableAnnotationComposer,
          $$PermissionOverridesTableCreateCompanionBuilder,
          $$PermissionOverridesTableUpdateCompanionBuilder,
          (
            PermissionOverrideRow,
            BaseReferences<
              _$AppDatabase,
              $PermissionOverridesTable,
              PermissionOverrideRow
            >,
          ),
          PermissionOverrideRow,
          PrefetchHooks Function()
        > {
  $$PermissionOverridesTableTableManager(
    _$AppDatabase db,
    $PermissionOverridesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PermissionOverridesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PermissionOverridesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PermissionOverridesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> module = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> level = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PermissionOverridesCompanion(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                module: module,
                role: role,
                level: level,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String module,
                required String role,
                required String level,
                Value<int> rowid = const Value.absent(),
              }) => PermissionOverridesCompanion.insert(
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                module: module,
                role: role,
                level: level,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PermissionOverridesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PermissionOverridesTable,
      PermissionOverrideRow,
      $$PermissionOverridesTableFilterComposer,
      $$PermissionOverridesTableOrderingComposer,
      $$PermissionOverridesTableAnnotationComposer,
      $$PermissionOverridesTableCreateCompanionBuilder,
      $$PermissionOverridesTableUpdateCompanionBuilder,
      (
        PermissionOverrideRow,
        BaseReferences<
          _$AppDatabase,
          $PermissionOverridesTable,
          PermissionOverrideRow
        >,
      ),
      PermissionOverrideRow,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingRow,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingRow,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>,
          ),
          SettingRow,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => SettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingRow,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (SettingRow, BaseReferences<_$AppDatabase, $SettingsTable, SettingRow>),
      SettingRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$DepartmentTypesTableTableManager get departmentTypes =>
      $$DepartmentTypesTableTableManager(_db, _db.departmentTypes);
  $$DepartmentsTableTableManager get departments =>
      $$DepartmentsTableTableManager(_db, _db.departments);
  $$DepartmentMembersTableTableManager get departmentMembers =>
      $$DepartmentMembersTableTableManager(_db, _db.departmentMembers);
  $$UserAccountsTableTableManager get userAccounts =>
      $$UserAccountsTableTableManager(_db, _db.userAccounts);
  $$AttendanceRecordsTableTableManager get attendanceRecords =>
      $$AttendanceRecordsTableTableManager(_db, _db.attendanceRecords);
  $$CheckInsTableTableManager get checkIns =>
      $$CheckInsTableTableManager(_db, _db.checkIns);
  $$DonationsTableTableManager get donations =>
      $$DonationsTableTableManager(_db, _db.donations);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$PledgesTableTableManager get pledges =>
      $$PledgesTableTableManager(_db, _db.pledges);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$CareRequestsTableTableManager get careRequests =>
      $$CareRequestsTableTableManager(_db, _db.careRequests);
  $$VolunteerSlotsTableTableManager get volunteerSlots =>
      $$VolunteerSlotsTableTableManager(_db, _db.volunteerSlots);
  $$AssetsTableTableManager get assets =>
      $$AssetsTableTableManager(_db, _db.assets);
  $$CampaignsTableTableManager get campaigns =>
      $$CampaignsTableTableManager(_db, _db.campaigns);
  $$AnnouncementsTableTableManager get announcements =>
      $$AnnouncementsTableTableManager(_db, _db.announcements);
  $$CoursesTableTableManager get courses =>
      $$CoursesTableTableManager(_db, _db.courses);
  $$SmallGroupsTableTableManager get smallGroups =>
      $$SmallGroupsTableTableManager(_db, _db.smallGroups);
  $$PermissionOverridesTableTableManager get permissionOverrides =>
      $$PermissionOverridesTableTableManager(_db, _db.permissionOverrides);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_value.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<StaticBucketValue> _$staticBucketValueSerializer =
    new _$StaticBucketValueSerializer();
Serializer<IncomeBucketValue> _$incomeBucketValueSerializer =
    new _$IncomeBucketValueSerializer();
Serializer<TableBucketValue> _$tableBucketValueSerializer =
    new _$TableBucketValueSerializer();
Serializer<TableBucketValueEntry> _$tableBucketValueEntrySerializer =
    new _$TableBucketValueEntrySerializer();
Serializer<ExtraBucketValue> _$extraBucketValueSerializer =
    new _$ExtraBucketValueSerializer();

class _$StaticBucketValueSerializer
    implements StructuredSerializer<StaticBucketValue> {
  @override
  final Iterable<Type> types = const [StaticBucketValue, _$StaticBucketValue];
  @override
  final String wireName = 'StaticBucketValue';

  @override
  Iterable<Object?> serialize(Serializers serializers, StaticBucketValue object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  StaticBucketValue deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StaticBucketValueBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$IncomeBucketValueSerializer
    implements StructuredSerializer<IncomeBucketValue> {
  @override
  final Iterable<Type> types = const [IncomeBucketValue, _$IncomeBucketValue];
  @override
  final String wireName = 'IncomeBucketValue';

  @override
  Iterable<Object?> serialize(Serializers serializers, IncomeBucketValue object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  IncomeBucketValue deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new IncomeBucketValueBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$TableBucketValueSerializer
    implements StructuredSerializer<TableBucketValue> {
  @override
  final Iterable<Type> types = const [TableBucketValue, _$TableBucketValue];
  @override
  final String wireName = 'TableBucketValue';

  @override
  Iterable<Object?> serialize(Serializers serializers, TableBucketValue object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'entries',
      serializers.serialize(object.entries,
          specifiedType: const FullType(
              BuiltList, const [const FullType(TableBucketValueEntry)])),
    ];

    return result;
  }

  @override
  TableBucketValue deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TableBucketValueBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'entries':
          result.entries.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(TableBucketValueEntry)
              ]))! as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$TableBucketValueEntrySerializer
    implements StructuredSerializer<TableBucketValueEntry> {
  @override
  final Iterable<Type> types = const [
    TableBucketValueEntry,
    _$TableBucketValueEntry
  ];
  @override
  final String wireName = 'TableBucketValueEntry';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, TableBucketValueEntry object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  TableBucketValueEntry deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TableBucketValueEntryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$ExtraBucketValueSerializer
    implements StructuredSerializer<ExtraBucketValue> {
  @override
  final Iterable<Type> types = const [ExtraBucketValue, _$ExtraBucketValue];
  @override
  final String wireName = 'ExtraBucketValue';

  @override
  Iterable<Object?> serialize(Serializers serializers, ExtraBucketValue object,
      {FullType specifiedType = FullType.unspecified}) {
    return <Object?>[];
  }

  @override
  ExtraBucketValue deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    return new ExtraBucketValueBuilder().build();
  }
}

class _$StaticBucketValue extends StaticBucketValue {
  @override
  final double amount;

  factory _$StaticBucketValue(
          [void Function(StaticBucketValueBuilder)? updates]) =>
      (new StaticBucketValueBuilder()..update(updates)).build();

  _$StaticBucketValue._({required this.amount}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        amount, 'StaticBucketValue', 'amount');
  }

  @override
  StaticBucketValue rebuild(void Function(StaticBucketValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StaticBucketValueBuilder toBuilder() =>
      new StaticBucketValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StaticBucketValue && amount == other.amount;
  }

  @override
  int get hashCode {
    return $jf($jc(0, amount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StaticBucketValue')
          ..add('amount', amount))
        .toString();
  }
}

class StaticBucketValueBuilder
    implements Builder<StaticBucketValue, StaticBucketValueBuilder> {
  _$StaticBucketValue? _$v;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  StaticBucketValueBuilder() {
    StaticBucketValue._initializeBuilder(this);
  }

  StaticBucketValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StaticBucketValue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$StaticBucketValue;
  }

  @override
  void update(void Function(StaticBucketValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StaticBucketValue build() {
    final _$result = _$v ??
        new _$StaticBucketValue._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, 'StaticBucketValue', 'amount'));
    replace(_$result);
    return _$result;
  }
}

class _$IncomeBucketValue extends IncomeBucketValue {
  @override
  final double amount;

  factory _$IncomeBucketValue(
          [void Function(IncomeBucketValueBuilder)? updates]) =>
      (new IncomeBucketValueBuilder()..update(updates)).build();

  _$IncomeBucketValue._({required this.amount}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        amount, 'IncomeBucketValue', 'amount');
  }

  @override
  IncomeBucketValue rebuild(void Function(IncomeBucketValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IncomeBucketValueBuilder toBuilder() =>
      new IncomeBucketValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IncomeBucketValue && amount == other.amount;
  }

  @override
  int get hashCode {
    return $jf($jc(0, amount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('IncomeBucketValue')
          ..add('amount', amount))
        .toString();
  }
}

class IncomeBucketValueBuilder
    implements Builder<IncomeBucketValue, IncomeBucketValueBuilder> {
  _$IncomeBucketValue? _$v;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  IncomeBucketValueBuilder() {
    IncomeBucketValue._initializeBuilder(this);
  }

  IncomeBucketValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IncomeBucketValue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$IncomeBucketValue;
  }

  @override
  void update(void Function(IncomeBucketValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$IncomeBucketValue build() {
    final _$result = _$v ??
        new _$IncomeBucketValue._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, 'IncomeBucketValue', 'amount'));
    replace(_$result);
    return _$result;
  }
}

class _$TableBucketValue extends TableBucketValue {
  @override
  final BuiltList<TableBucketValueEntry> entries;

  factory _$TableBucketValue(
          [void Function(TableBucketValueBuilder)? updates]) =>
      (new TableBucketValueBuilder()..update(updates)).build();

  _$TableBucketValue._({required this.entries}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        entries, 'TableBucketValue', 'entries');
  }

  @override
  TableBucketValue rebuild(void Function(TableBucketValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TableBucketValueBuilder toBuilder() =>
      new TableBucketValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TableBucketValue && entries == other.entries;
  }

  @override
  int get hashCode {
    return $jf($jc(0, entries.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TableBucketValue')
          ..add('entries', entries))
        .toString();
  }
}

class TableBucketValueBuilder
    implements Builder<TableBucketValue, TableBucketValueBuilder> {
  _$TableBucketValue? _$v;

  ListBuilder<TableBucketValueEntry>? _entries;
  ListBuilder<TableBucketValueEntry> get entries =>
      _$this._entries ??= new ListBuilder<TableBucketValueEntry>();
  set entries(ListBuilder<TableBucketValueEntry>? entries) =>
      _$this._entries = entries;

  TableBucketValueBuilder();

  TableBucketValueBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entries = $v.entries.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TableBucketValue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TableBucketValue;
  }

  @override
  void update(void Function(TableBucketValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TableBucketValue build() {
    _$TableBucketValue _$result;
    try {
      _$result = _$v ?? new _$TableBucketValue._(entries: entries.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'entries';
        entries.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TableBucketValue', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$TableBucketValueEntry extends TableBucketValueEntry {
  @override
  final double amount;

  factory _$TableBucketValueEntry(
          [void Function(TableBucketValueEntryBuilder)? updates]) =>
      (new TableBucketValueEntryBuilder()..update(updates)).build();

  _$TableBucketValueEntry._({required this.amount}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        amount, 'TableBucketValueEntry', 'amount');
  }

  @override
  TableBucketValueEntry rebuild(
          void Function(TableBucketValueEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TableBucketValueEntryBuilder toBuilder() =>
      new TableBucketValueEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TableBucketValueEntry && amount == other.amount;
  }

  @override
  int get hashCode {
    return $jf($jc(0, amount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TableBucketValueEntry')
          ..add('amount', amount))
        .toString();
  }
}

class TableBucketValueEntryBuilder
    implements Builder<TableBucketValueEntry, TableBucketValueEntryBuilder> {
  _$TableBucketValueEntry? _$v;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  TableBucketValueEntryBuilder() {
    TableBucketValueEntry._initializeBuilder(this);
  }

  TableBucketValueEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TableBucketValueEntry other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TableBucketValueEntry;
  }

  @override
  void update(void Function(TableBucketValueEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TableBucketValueEntry build() {
    final _$result = _$v ??
        new _$TableBucketValueEntry._(
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, 'TableBucketValueEntry', 'amount'));
    replace(_$result);
    return _$result;
  }
}

class _$ExtraBucketValue extends ExtraBucketValue {
  factory _$ExtraBucketValue(
          [void Function(ExtraBucketValueBuilder)? updates]) =>
      (new ExtraBucketValueBuilder()..update(updates)).build();

  _$ExtraBucketValue._() : super._();

  @override
  ExtraBucketValue rebuild(void Function(ExtraBucketValueBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExtraBucketValueBuilder toBuilder() =>
      new ExtraBucketValueBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExtraBucketValue;
  }

  @override
  int get hashCode {
    return 177246388;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('ExtraBucketValue').toString();
  }
}

class ExtraBucketValueBuilder
    implements Builder<ExtraBucketValue, ExtraBucketValueBuilder> {
  _$ExtraBucketValue? _$v;

  ExtraBucketValueBuilder() {
    ExtraBucketValue._initializeBuilder(this);
  }

  @override
  void replace(ExtraBucketValue other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ExtraBucketValue;
  }

  @override
  void update(void Function(ExtraBucketValueBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ExtraBucketValue build() {
    final _$result = _$v ?? new _$ExtraBucketValue._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

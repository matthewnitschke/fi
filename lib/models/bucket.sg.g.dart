// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Bucket> _$bucketSerializer = new _$BucketSerializer();

class _$BucketSerializer implements StructuredSerializer<Bucket> {
  @override
  final Iterable<Type> types = const [Bucket, _$Bucket];
  @override
  final String wireName = 'Bucket';

  @override
  Iterable<Object?> serialize(Serializers serializers, Bucket object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'value',
      serializers.serialize(object.value,
          specifiedType: const FullType(BucketValue)),
      'transactions',
      serializers.serialize(object.transactions,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
    ];
    Object? value;
    value = object.label;
    if (value != null) {
      result
        ..add('label')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Bucket deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BucketBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(BucketValue)) as BucketValue;
          break;
        case 'transactions':
          result.transactions.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'label':
          result.label = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Bucket extends Bucket {
  @override
  final BucketValue value;
  @override
  final BuiltList<String> transactions;
  @override
  final String? label;

  factory _$Bucket([void Function(BucketBuilder)? updates]) =>
      (new BucketBuilder()..update(updates)).build();

  _$Bucket._({required this.value, required this.transactions, this.label})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(value, 'Bucket', 'value');
    BuiltValueNullFieldError.checkNotNull(
        transactions, 'Bucket', 'transactions');
  }

  @override
  Bucket rebuild(void Function(BucketBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BucketBuilder toBuilder() => new BucketBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Bucket &&
        value == other.value &&
        transactions == other.transactions &&
        label == other.label;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, value.hashCode), transactions.hashCode), label.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Bucket')
          ..add('value', value)
          ..add('transactions', transactions)
          ..add('label', label))
        .toString();
  }
}

class BucketBuilder implements Builder<Bucket, BucketBuilder>, ItemBuilder {
  _$Bucket? _$v;

  BucketValue? _value;
  BucketValue? get value => _$this._value;
  set value(covariant BucketValue? value) => _$this._value = value;

  ListBuilder<String>? _transactions;
  ListBuilder<String> get transactions =>
      _$this._transactions ??= new ListBuilder<String>();
  set transactions(covariant ListBuilder<String>? transactions) =>
      _$this._transactions = transactions;

  String? _label;
  String? get label => _$this._label;
  set label(covariant String? label) => _$this._label = label;

  BucketBuilder();

  BucketBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _value = $v.value;
      _transactions = $v.transactions.toBuilder();
      _label = $v.label;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(covariant Bucket other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Bucket;
  }

  @override
  void update(void Function(BucketBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Bucket build() {
    _$Bucket _$result;
    try {
      _$result = _$v ??
          new _$Bucket._(
              value: BuiltValueNullFieldError.checkNotNull(
                  value, 'Bucket', 'value'),
              transactions: transactions.build(),
              label: label);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'transactions';
        transactions.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Bucket', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

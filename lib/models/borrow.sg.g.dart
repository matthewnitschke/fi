// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Borrow> _$borrowSerializer = new _$BorrowSerializer();

class _$BorrowSerializer implements StructuredSerializer<Borrow> {
  @override
  final Iterable<Type> types = const [Borrow, _$Borrow];
  @override
  final String wireName = 'Borrow';

  @override
  Iterable<Object?> serialize(Serializers serializers, Borrow object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'toId',
      serializers.serialize(object.toId, specifiedType: const FullType(String)),
      'fromId',
      serializers.serialize(object.fromId,
          specifiedType: const FullType(String)),
      'amount',
      serializers.serialize(object.amount,
          specifiedType: const FullType(double)),
    ];

    return result;
  }

  @override
  Borrow deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BorrowBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'toId':
          result.toId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'fromId':
          result.fromId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$Borrow extends Borrow {
  @override
  final String toId;
  @override
  final String fromId;
  @override
  final double amount;

  factory _$Borrow([void Function(BorrowBuilder)? updates]) =>
      (new BorrowBuilder()..update(updates)).build();

  _$Borrow._({required this.toId, required this.fromId, required this.amount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(toId, 'Borrow', 'toId');
    BuiltValueNullFieldError.checkNotNull(fromId, 'Borrow', 'fromId');
    BuiltValueNullFieldError.checkNotNull(amount, 'Borrow', 'amount');
  }

  @override
  Borrow rebuild(void Function(BorrowBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BorrowBuilder toBuilder() => new BorrowBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Borrow &&
        toId == other.toId &&
        fromId == other.fromId &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, toId.hashCode), fromId.hashCode), amount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Borrow')
          ..add('toId', toId)
          ..add('fromId', fromId)
          ..add('amount', amount))
        .toString();
  }
}

class BorrowBuilder implements Builder<Borrow, BorrowBuilder> {
  _$Borrow? _$v;

  String? _toId;
  String? get toId => _$this._toId;
  set toId(String? toId) => _$this._toId = toId;

  String? _fromId;
  String? get fromId => _$this._fromId;
  set fromId(String? fromId) => _$this._fromId = fromId;

  double? _amount;
  double? get amount => _$this._amount;
  set amount(double? amount) => _$this._amount = amount;

  BorrowBuilder();

  BorrowBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _toId = $v.toId;
      _fromId = $v.fromId;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Borrow other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Borrow;
  }

  @override
  void update(void Function(BorrowBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Borrow build() {
    final _$result = _$v ??
        new _$Borrow._(
            toId: BuiltValueNullFieldError.checkNotNull(toId, 'Borrow', 'toId'),
            fromId: BuiltValueNullFieldError.checkNotNull(
                fromId, 'Borrow', 'fromId'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, 'Borrow', 'amount'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

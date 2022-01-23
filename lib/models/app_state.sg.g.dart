// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.sg.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AppState> _$appStateSerializer = new _$AppStateSerializer();

class _$AppStateSerializer implements StructuredSerializer<AppState> {
  @override
  final Iterable<Type> types = const [AppState, _$AppState];
  @override
  final String wireName = 'AppState';

  @override
  Iterable<Object?> serialize(Serializers serializers, AppState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'status',
      serializers.serialize(object.status,
          specifiedType: const FullType(AppStatus)),
      'selectedMonth',
      serializers.serialize(object.selectedMonth,
          specifiedType: const FullType(DateTime)),
      'isDraggingTransaction',
      serializers.serialize(object.isDraggingTransaction,
          specifiedType: const FullType(bool)),
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(
              BuiltMap, const [const FullType(String), const FullType(Item)])),
      'rootItemIds',
      serializers.serialize(object.rootItemIds,
          specifiedType:
              const FullType(BuiltList, const [const FullType(String)])),
      'transactions',
      serializers.serialize(object.transactions,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(Transaction)])),
      'ignoredTransactions',
      serializers.serialize(object.ignoredTransactions,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(String)])),
      'borrows',
      serializers.serialize(object.borrows,
          specifiedType: const FullType(BuiltMap,
              const [const FullType(String), const FullType(Borrow)])),
    ];
    Object? value;
    value = object.selectedItemId;
    if (value != null) {
      result
        ..add('selectedItemId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  AppState deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AppStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(AppStatus)) as AppStatus;
          break;
        case 'selectedMonth':
          result.selectedMonth = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'isDraggingTransaction':
          result.isDraggingTransaction = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'selectedItemId':
          result.selectedItemId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(Item)]))!);
          break;
        case 'rootItemIds':
          result.rootItemIds.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'transactions':
          result.transactions.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(Transaction)
              ]))!);
          break;
        case 'ignoredTransactions':
          result.ignoredTransactions.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltSet, const [const FullType(String)]))!
              as BuiltSet<Object?>);
          break;
        case 'borrows':
          result.borrows.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(Borrow)]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$AppState extends AppState {
  @override
  final AppStatus status;
  @override
  final DateTime selectedMonth;
  @override
  final bool isDraggingTransaction;
  @override
  final String? selectedItemId;
  @override
  final BuiltMap<String, Item> items;
  @override
  final BuiltList<String> rootItemIds;
  @override
  final BuiltMap<String, Transaction> transactions;
  @override
  final BuiltSet<String> ignoredTransactions;
  @override
  final BuiltMap<String, Borrow> borrows;

  factory _$AppState([void Function(AppStateBuilder)? updates]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._(
      {required this.status,
      required this.selectedMonth,
      required this.isDraggingTransaction,
      this.selectedItemId,
      required this.items,
      required this.rootItemIds,
      required this.transactions,
      required this.ignoredTransactions,
      required this.borrows})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(status, 'AppState', 'status');
    BuiltValueNullFieldError.checkNotNull(
        selectedMonth, 'AppState', 'selectedMonth');
    BuiltValueNullFieldError.checkNotNull(
        isDraggingTransaction, 'AppState', 'isDraggingTransaction');
    BuiltValueNullFieldError.checkNotNull(items, 'AppState', 'items');
    BuiltValueNullFieldError.checkNotNull(
        rootItemIds, 'AppState', 'rootItemIds');
    BuiltValueNullFieldError.checkNotNull(
        transactions, 'AppState', 'transactions');
    BuiltValueNullFieldError.checkNotNull(
        ignoredTransactions, 'AppState', 'ignoredTransactions');
    BuiltValueNullFieldError.checkNotNull(borrows, 'AppState', 'borrows');
  }

  @override
  AppState rebuild(void Function(AppStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AppState &&
        status == other.status &&
        selectedMonth == other.selectedMonth &&
        isDraggingTransaction == other.isDraggingTransaction &&
        selectedItemId == other.selectedItemId &&
        items == other.items &&
        rootItemIds == other.rootItemIds &&
        transactions == other.transactions &&
        ignoredTransactions == other.ignoredTransactions &&
        borrows == other.borrows;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, status.hashCode),
                                    selectedMonth.hashCode),
                                isDraggingTransaction.hashCode),
                            selectedItemId.hashCode),
                        items.hashCode),
                    rootItemIds.hashCode),
                transactions.hashCode),
            ignoredTransactions.hashCode),
        borrows.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')
          ..add('status', status)
          ..add('selectedMonth', selectedMonth)
          ..add('isDraggingTransaction', isDraggingTransaction)
          ..add('selectedItemId', selectedItemId)
          ..add('items', items)
          ..add('rootItemIds', rootItemIds)
          ..add('transactions', transactions)
          ..add('ignoredTransactions', ignoredTransactions)
          ..add('borrows', borrows))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState? _$v;

  AppStatus? _status;
  AppStatus? get status => _$this._status;
  set status(AppStatus? status) => _$this._status = status;

  DateTime? _selectedMonth;
  DateTime? get selectedMonth => _$this._selectedMonth;
  set selectedMonth(DateTime? selectedMonth) =>
      _$this._selectedMonth = selectedMonth;

  bool? _isDraggingTransaction;
  bool? get isDraggingTransaction => _$this._isDraggingTransaction;
  set isDraggingTransaction(bool? isDraggingTransaction) =>
      _$this._isDraggingTransaction = isDraggingTransaction;

  String? _selectedItemId;
  String? get selectedItemId => _$this._selectedItemId;
  set selectedItemId(String? selectedItemId) =>
      _$this._selectedItemId = selectedItemId;

  MapBuilder<String, Item>? _items;
  MapBuilder<String, Item> get items =>
      _$this._items ??= new MapBuilder<String, Item>();
  set items(MapBuilder<String, Item>? items) => _$this._items = items;

  ListBuilder<String>? _rootItemIds;
  ListBuilder<String> get rootItemIds =>
      _$this._rootItemIds ??= new ListBuilder<String>();
  set rootItemIds(ListBuilder<String>? rootItemIds) =>
      _$this._rootItemIds = rootItemIds;

  MapBuilder<String, Transaction>? _transactions;
  MapBuilder<String, Transaction> get transactions =>
      _$this._transactions ??= new MapBuilder<String, Transaction>();
  set transactions(MapBuilder<String, Transaction>? transactions) =>
      _$this._transactions = transactions;

  SetBuilder<String>? _ignoredTransactions;
  SetBuilder<String> get ignoredTransactions =>
      _$this._ignoredTransactions ??= new SetBuilder<String>();
  set ignoredTransactions(SetBuilder<String>? ignoredTransactions) =>
      _$this._ignoredTransactions = ignoredTransactions;

  MapBuilder<String, Borrow>? _borrows;
  MapBuilder<String, Borrow> get borrows =>
      _$this._borrows ??= new MapBuilder<String, Borrow>();
  set borrows(MapBuilder<String, Borrow>? borrows) => _$this._borrows = borrows;

  AppStateBuilder() {
    AppState._initializeBuilder(this);
  }

  AppStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _selectedMonth = $v.selectedMonth;
      _isDraggingTransaction = $v.isDraggingTransaction;
      _selectedItemId = $v.selectedItemId;
      _items = $v.items.toBuilder();
      _rootItemIds = $v.rootItemIds.toBuilder();
      _transactions = $v.transactions.toBuilder();
      _ignoredTransactions = $v.ignoredTransactions.toBuilder();
      _borrows = $v.borrows.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AppState;
  }

  @override
  void update(void Function(AppStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    _$AppState _$result;
    try {
      _$result = _$v ??
          new _$AppState._(
              status: BuiltValueNullFieldError.checkNotNull(
                  status, 'AppState', 'status'),
              selectedMonth: BuiltValueNullFieldError.checkNotNull(
                  selectedMonth, 'AppState', 'selectedMonth'),
              isDraggingTransaction: BuiltValueNullFieldError.checkNotNull(
                  isDraggingTransaction, 'AppState', 'isDraggingTransaction'),
              selectedItemId: selectedItemId,
              items: items.build(),
              rootItemIds: rootItemIds.build(),
              transactions: transactions.build(),
              ignoredTransactions: ignoredTransactions.build(),
              borrows: borrows.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
        _$failedField = 'rootItemIds';
        rootItemIds.build();
        _$failedField = 'transactions';
        transactions.build();
        _$failedField = 'ignoredTransactions';
        ignoredTransactions.build();
        _$failedField = 'borrows';
        borrows.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'AppState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/models/transaction.sg.dart';

part 'app_state.sg.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  @BuiltValueField(serialize: false)
  DateTime get selectedMonth;

  @BuiltValueField(serialize: false)
  String? get budgetId;

  @BuiltValueField(serialize: false)
  String? get selectedItemId;

  BuiltMap<String, Item> get items;
  
  BuiltList<String> get rootItemIds;

  @BuiltValueField(serialize: false)
  BuiltMap<String, Transaction> get transactions;

  BuiltSet<String> get ignoredTransactions;

  BuiltMap<String, Borrow> get borrows;

  static Serializer<AppState> get serializer => _$appStateSerializer;

  static void _initializeBuilder(AppStateBuilder b) => b
    ..selectedMonth = DateTime.now();

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
}
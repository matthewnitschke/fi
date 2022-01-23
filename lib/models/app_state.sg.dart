import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/models/transaction.sg.dart';

part 'app_state.sg.g.dart';

enum AppStatus { loading, errored, success }

abstract class AppState implements Built<AppState, AppStateBuilder> {
  AppStatus get status;

  DateTime get selectedMonth;

  bool get isDraggingTransaction;

  String? get selectedItemId;

  BuiltMap<String, Item> get items;
  
  BuiltList<String> get rootItemIds;

  BuiltMap<String, Transaction> get transactions;

  BuiltSet<String> get ignoredTransactions;

  BuiltMap<String, Borrow> get borrows;

  static Serializer<AppState> get serializer => _$appStateSerializer;

  static void _initializeBuilder(AppStateBuilder b) => b
    ..selectedMonth = DateTime.now()
    ..isDraggingTransaction = false;

  AppState._();
  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
}
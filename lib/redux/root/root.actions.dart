import 'package:built_collection/built_collection.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/models/transaction.sg.dart';

class LoadStateAction {
  final String? budgetId;
  final BuiltMap<String, Item> items;
  final BuiltList<String> rootItemIds;
  final BuiltMap<String, Borrow> borrows;
  final BuiltMap<String, Transaction> transactions;

  LoadStateAction({
    required this.budgetId,
    required this.items,
    required this.rootItemIds,
    required this.borrows,
    required this.transactions,
  });
}

class SelectItemAction {
  final String itemId;
  
  SelectItemAction(this.itemId);
}

class IgnoreTransactionAction {
  final String transactionId;
  
  IgnoreTransactionAction(this.transactionId);
}
import 'package:built_collection/built_collection.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/models/transaction.sg.dart';

class LoadStateAction {
  final BuiltMap<String, Item> items;
  final BuiltList<String> rootItemIds;
  final BuiltMap<String, Borrow> borrows;
  final BuiltMap<String, Transaction> transactions;
  final BuiltSet<String> ignoredTransactions;

  LoadStateAction({
    required this.items,
    required this.rootItemIds,
    required this.borrows,
    required this.transactions,
    required this.ignoredTransactions,
  });
}

class SelectItemAction {
  final String itemId;
  
  SelectItemAction(this.itemId);
}

class SetIsDraggingTransactionAction {
  final bool isDragging;
  
  SetIsDraggingTransactionAction(this.isDragging);
}

class IgnoreTransactionAction {
  final String transactionId;
  
  IgnoreTransactionAction(this.transactionId);
}